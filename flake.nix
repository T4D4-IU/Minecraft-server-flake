{
  description = "NeoForge 1.21.1 Minecraft Server with Industrial Mods";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = {
    nixpkgs,
    nix-minecraft,
    ...
  }: let
    supportedSystems = ["aarch64-darwin" "x86_64-linux" "aarch64-linux" "x86_64-darwin"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    nixpkgsFor = forAllSystems (system:
      import nixpkgs {
        inherit system;
        overlays = [nix-minecraft.overlay];
        config.allowUnfree = true;
      });

    commonMods = pkgs: {
      mekanism = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Ce6I4WUE/versions/yY7vZB47/Mekanism-1.21.1-10.7.18.84.jar";
        sha512 = "79f21464197f9d9237f09a2ff12c15a86e073a141a9abbf50a295fe91ee41b618148e10f5b7a550a8bfd8f6ed529f157ba163e413b2d8d792a4355b0ca04e584";
      };
      create = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/LNytGWDc/versions/n7NADxiG/create-1.21.1-6.0.9.jar";
        sha512 = "8b3b3d9b6874f31a538add81390dff26b5f9475da6349dc52fc20dbde802edfc32ead511e12291198591574d42605f916f1acbadc2437056eea615d8586bf7cf";
      };
      ae2 = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/XxWD5pD3/versions/kfyIqgJ6/appliedenergistics2-19.2.17.jar";
        sha512 = "55edfd948366aff620881e0625e48c333a2cb847e73249bc0b588efbc4b86709992a8ffbca97ea387e270df4186fe7f74ee2f27b739f1c952e932becfb9dea33";
      };
      jei = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/u6dRKJwZ/versions/YAcQ6elZ/jei-1.21.1-neoforge-19.27.0.340.jar";
        sha512 = "8bad8eb3c8e974f867e23e4d74598f603c5fbf03eb5356a386dd37cb9fa23e08ad1f58be6b7be50d2fbf9d3fbfaeac8584c70ced736df4b8f82c7c75be242998";
      };
      ferrite-core = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/uXXizFIs/versions/x7kQWVju/ferritecore-7.0.3-neoforge.jar";
        sha512 = "19af89a2075bb10a63884fa853ebf84b02c79dc3242430ecdad056fd764fdcde367a7303276b329df01b0736e2ef264c5d80c7dc92c6aebd244f556a230bb417";
      };
      lithium = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/RXHf27Wv/lithium-neoforge-0.15.3%2Bmc1.21.1.jar";
        sha512 = "65568e6c7e41684ad20e58db8766813840c0c8406eed9edc3f7a2514da7250ac46bde2bfb0936984cc5516c2782f86387ad0ed3d1b804b8bdddc7f7048759df4";
      };
      guideme = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Ck4E7v7R/versions/ILW6vM7o/guideme-21.1.15.jar";
        sha512 = "4a35b2d9ae3958cb9e152757223b0fc0f85ed2c55da2c3bb773b9a353cf5db15e4294ac2b6d897c0d7c82674dd86c084dd2e35fb80b5bcf92067735c03288edc";
      };
    };

    commonModsDir = pkgs: pkgs.linkFarm "minecraft-mods" (pkgs.lib.mapAttrsToList (name: path: {
        name = "${name}.jar";
        inherit path;
      })
      (commonMods pkgs));
  in {
    apps = forAllSystems (
      system: let
        pkgs = nixpkgsFor.${system};
        # NeoForge server package
        serverPkg = pkgs.neoforgeServers.neoforge-1_21_1;
        # Combine mods via common definition
        modsDir = commonModsDir pkgs;
        # Memory settings
        maxMem = "6G";
        minMem = "4G";
      in {
        default = {
          type = "app";
          program = toString (pkgs.writeShellScript "run-minecraft-server" ''
                          set -euo pipefail
                          DATA_DIR="$PWD/data"
                          mkdir -p "$DATA_DIR"
                          echo "Linking server libraries and files..."
                          SRC_DIR="${serverPkg}/lib/minecraft"
                          if [ ! -d "$SRC_DIR" ]; then SRC_DIR="${serverPkg}"; fi
                          if [ -d "$SRC_DIR/libraries" ]; then ln -sf "$SRC_DIR/libraries" "$DATA_DIR/"; fi
                          find "$SRC_DIR" -maxdepth 1 -type f -exec ln -sf {} "$DATA_DIR/" \;
                          ARGS_FILE=$(find "$SRC_DIR" -name "unix_args.txt" | head -n 1)
                          rm -f "$DATA_DIR/eula.txt"
                          if [ ! -f "$DATA_DIR/eula.txt" ]; then echo "eula=true" > "$DATA_DIR/eula.txt"; fi
                          echo "Updating mods..."
                          mkdir -p "$DATA_DIR/mods"
                          rm -rf "$DATA_DIR/mods"/*
                          find "${modsDir}" -name "*.jar" -exec ln -sf {} "$DATA_DIR/mods/" \;
                          rm -f "$DATA_DIR/user_jvm_args.txt"
                          cat > "$DATA_DIR/user_jvm_args.txt" <<EOF
            -Xms${minMem}
            -Xmx${maxMem}
            -Djava.awt.headless=true
            EOF
                          echo "Starting NeoForge 1.21.1 server..."
                          if [ -n "$ARGS_FILE" ]; then echo "Using args file: $ARGS_FILE"; fi
                          cd "$DATA_DIR"
                          if [ -n "$ARGS_FILE" ]; then
                            exec ${pkgs.jdk21}/bin/java @user_jvm_args.txt "@$ARGS_FILE" nogui
                          else
                            exec "${serverPkg}/bin/minecraft-server" nogui
                          fi
          '');
        };
      }
    );

    packages = forAllSystems (
      system: let
        pkgs = nixpkgsFor.${system};
        modsDir = commonModsDir pkgs;
      in {
        mods-zip = pkgs.runCommand "mods-zip" {buildInputs = [pkgs.zip];} ''
          mkdir -p $out
          mkdir mods
          cp -L ${modsDir}/*.jar mods/
          zip -r $out/mods.zip mods
        '';
      }
    );

    devShells = forAllSystems (system: let
      pkgs = nixpkgsFor.${system};
    in {
      default = pkgs.mkShell {
        buildInputs = [pkgs.jdk21];
      };
    });

    formatter = forAllSystems (system: let
      pkgs = nixpkgsFor.${system};
    in
      pkgs.writeShellScriptBin "format" ''
        if [ $# -eq 0 ]; then
          ${pkgs.alejandra}/bin/alejandra .
        else
          ${pkgs.alejandra}/bin/alejandra "$@"
        fi
      '');

    checks = forAllSystems (system: let
      pkgs = nixpkgsFor.${system};
    in {
      format = pkgs.runCommand "check-format" {buildInputs = [pkgs.alejandra];} ''
        alejandra --check ${./.}
        touch $out
      '';
      statix = pkgs.runCommand "statix" {buildInputs = [pkgs.statix];} ''
        statix check ${./.}
        touch $out
      '';
      deadnix = pkgs.runCommand "deadnix" {buildInputs = [pkgs.deadnix];} ''
        deadnix --fail ${./.}
        touch $out
      '';
    });
  };
}
