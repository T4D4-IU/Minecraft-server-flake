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

      # --- 追加MOD ---
      appliede = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/SyKS54UY/versions/R5MXisky/appliede-1.0.8-beta.jar";
        sha512 = "a80c6c3fbff9589d0f5e086b737f29ba9136ecf659c03457fe580d8e62803ee3e9dc6a7d6338570fb09c686e50205898eba8964ed7b0ebeaa9ebfecf3b2b7469";
      };
      architectury = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/lhGA9TYQ/versions/ZxYGwlk0/architectury-13.0.8-neoforge.jar";
        sha512 = "65e3664953385d880320dd6bb818bcb96d361c07c53e2a7f65e64c6a47720ee26b233224ae9cad465ef0b2bbaefdaf30fb0175a983cecd91de058817d6fcf57e";
      };
      bagus-lib = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/95nSN4Rd/versions/tHQKeGug/bagus_lib-1.21.1-13.25.1.jar";
        sha512 = "57fbb61a1b1cc24f7b39a8c843dc7862ecfb82dd66e12e448a80519114ee94ecc4babbc1ebfedd2d68ca3e14cc1e03015a8a84dc3fc5b5c8513ae52b4802ae71";
      };
      bookshelf = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/uy4Cnpcm/versions/1sdJl7J1/bookshelf-neoforge-1.21.1-21.1.81.jar";
        sha512 = "78d4577a8e8fbb241216968475dd73f5b9e5efeb7da802b18a4e6c290e49af6cb4a5676e9855d0d8ff3613f967812e4bd363bbb9196c17c954d19454f84b2214";
      };
      cloth-config = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/9s6osm5g/versions/izKINKFg/cloth-config-15.0.140-neoforge.jar";
        sha512 = "aaf9b010955b8cd294e5a92f069985b18729fd5e2cf22d351f1dff9680f15488688803ec41e77e941cbde130ceb535014ca4c868047d80ab69c2d508e216654d";
      };
      clumps = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Wnxd13zP/versions/jo7lDoK4/Clumps-neoforge-1.21.1-19.0.0.1.jar";
        sha512 = "314d8d8e640d73041f27e0f3f2cad7aad8b4c77dbd7fb31700ef7760362261f77085eed5289555c725d99c3f47a114e7290cd608f39c9f0f12ef74958463bdcc";
      };
      emc-schematic-cannon = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Pxbip2zg/versions/mvUBSvgj/emcschematicannon-1.1.0.jar";
        sha512 = "d1525fb8acc6464ef7796281d3c3bccf71b2eb3614b1461603c36d01fda73f7694d4ab9c147a0b52ba22b9a6a90a63d17a714116d511fd3ba03570d10f477258";
      };
      gravestone-mod = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/RYtXKJPr/versions/AZm51eX1/gravestone-neoforge-1.21.1-1.0.35.jar";
        sha512 = "4fac4b141df81161177fb0882335e27d1259d05ffd3f3795a0258e3471f4e72840cfa5b73fb1bc1ad8cdca255b83dc46f713f81fea533e4fb1e72834e1724886";
      };
      jade = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/nvQzSEkH/versions/yd8FKCmx/Jade-1.21.1-NeoForge-15.10.5.jar";
        sha512 = "678b998677a3d73f98f82dac4093893bfc8a3c2335ec627b4147811c381a040475decdb8db31cc3cbe600abb5a7a6dedcd356eed0ba471af0becdcf49bf5b137";
      };
      mcpitan-lib = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/uNRoUnGT/versions/9feHsfP9/mcpitanlib-3.6.3-1.21.1-neoforge.jar";
        sha512 = "22de66382d1df339f9ccb10068ecfe07c4837b10f5c0b122587fed8d50c72d7f9f4fb4ccb39884ee6815c39102f085bd0c256b804e9461a9616267a1c946413a";
      };
      mekanism-additions = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/a6F3uASn/versions/y4y04JfC/MekanismAdditions-1.21.1-10.7.18.84.jar";
        sha512 = "a81146e78372c1c720c6d54b1717afbb8d693e91b6cbfac575b8adb925a851d0a0e54537224cca384120064b36af46b0a22fed464126f570b6263c172e58a436";
      };
      mekanism-generators = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/OFVYKsAk/versions/5XsSoiIJ/MekanismGenerators-1.21.1-10.7.18.84.jar";
        sha512 = "b1224530b1d18fd833806f49dce3d2a01019f1f91c0ab6d059ac7774325245ac4edccc4edd7e395274bfe4370541ec64fc9f0651fed0eb107167f32372f32f93";
      };
      mekanism-tools = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/tqQpq1lt/versions/JJOd94IZ/MekanismTools-1.21.1-10.7.18.84.jar";
        sha512 = "62c4b078eff787736d0cbcbeea1dd9ce6acfd4c7e1671c80607d1ab08c276133fb1d85ba467c44d1d203bd9893d8de514a3faa39afbed208397fcc263981d6ea";
      };
      modernfix = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/nmDcB62a/versions/c759JLsq/modernfix-neoforge-5.26.1%2Bmc1.21.1.jar";
        sha512 = "d6df16e21c454b86b07991408dd0eb0f611942ee01d9598375a6b0907167aaf29e2906c8ad11c5f0971979e68ea8267d9a8deb82ba638bd85ccd4265d2448a1d";
      };
      pricklemc = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/aaRl8GiW/versions/EE1FHDyD/prickle-neoforge-1.21.1-21.1.11.jar";
        sha512 = "154d42795ccf1f3e07714775cdb82fd5db17574319286ced13d86b0456b64e4cf5bb89ffbcbfcefce67b73ed0b83e4e2944e493d79d9a385ff9de23006ee7bf5";
      };
      tofucraft-reload = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/69rMY8bC/versions/MMBdfHA3/tofucraft-1.21.1-12.20.2.0.jar";
        sha512 = "5199527f2c0cd9bd1cbfca414a534772f84768d85604140b1c746fd9ef52f00ef199c3f0a4e0410a718b6ec855834b1b8e0820cc3eb8e0e3ae32ec14210d719b";
      };
      uncrafting-table = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/d0f1a75r/versions/NhIBTWNp/UncraftingTable-neoforge-1.5.4.jar";
        sha512 = "9f90b3c84533e01c6834053e92b02680f5a4d5a5d337e424e72bfa234310bca4278a2b02ad71f85668b128494e200153e72afa74de320659c7baac3b25218d15";
      };
      # Sinytra Connector + Forgified Fabric API (Fabric MODをNeoForgeで動かす互換レイヤー)
      # サーバー不要であれば以下２ブロックを削除してください
      sinytra-connector = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/u58R1TMW/versions/1i8teo7m/connector-2.0.0-beta.14%2B1.21.1-full.jar";
        sha512 = "6ed3168c2c7dad2606ada1fdf63ee412bb8bb5620718a702f6ac51310e671f2f93ab46fc96400e258f4433e51b96f9dd21441e1a8963d8b356c75b578e156dcc";
      };
      forgified-fabric-api = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Aqlf1Shp/versions/7nHK7hMg/forgified-fabric-api-0.116.7%2B2.2.4%2B1.21.1.jar";
        sha512 = "858acb32a79e7ed1f37472bd7c50e3d2f47c7d7f6e734a8cece3800eb30d565a09580c261778ea73a0ae25e10e9eb9b16866012fe61d24f671b0ffe3ae2377dd";
      };
      # --- CurseForge MOD (CDN直接取得) ---
      projecte = pkgs.fetchurl {
        url = "https://mediafilez.forgecdn.net/files/6611/984/ProjectE-1.21.1-PE1.1.0.jar";
        sha512 = "d8bd0e707c66df4e8dc40fbdd8454b41e78b6354302dcd52a277091e004ef8432fffa9a33f5da40c09ec80d8b4bb3f15ddc594cf891a026d6ba775677864fb58";
      };
      ftb-library = pkgs.fetchurl {
        url = "https://mediafilez.forgecdn.net/files/7746/959/ftb-library-neoforge-2101.1.31.jar";
        sha512 = "af7674d2d12b129b3841df1be8272606d480a6f707cd0b3b112f56068279e286fc5b4cc67e7f7c984d09e54bc5f7dde3fc55c15ff5fd901ad60f14ee9eb9eb01";
      };
      ftb-ultimine = pkgs.fetchurl {
        url = "https://mediafilez.forgecdn.net/files/7570/482/ftb-ultimine-neoforge-2101.1.13.jar";
        sha512 = "3d493d3f48f98a0973ff701e0d2e4ec85d5312b8f4273624dcef0475022bcc9b54d52876faaa6b4f2bb8699ea1da0f6f03716e865e89ea3813f88c16e5fbbe72";
      };
      # Note: Buildcraft-Legacy と Porting Dead Libs はリリースが見つからず導入を断念
    };

    commonModsDir = pkgs:
      pkgs.linkFarm "minecraft-mods" (pkgs.lib.mapAttrsToList (name: path: {
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
