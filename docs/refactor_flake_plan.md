# 提案：flake.nix のリファクタリング

現在、`flake.nix` 内で MOD のリスト（`mods`）とそれらをまとめるディレクトリ定義（`modsDir`）が、`apps`（実行用）と `packages`（ZIP配布用）の2箇所に重複して記述されています。
これを一箇所にまとめ、保守性を向上させます。

## Definition of Done (DoD)
- [x] `flake.nix` 内の MOD リストの定義が一箇所に集約されている。
- [x] `nix run .` でサーバー起動スクリプトが正しく生成されることを確認する。
- [x] `nix build .#mods-zip` が成功し、生成される ZIP の内容が以前と変わらないことを確認する。
- [x] `nix flake check` を実行し、すべてのチェック（フォーマット、静的解析）がパスする。
- [x] `docs/changed_log.md` を作成（更新）し、変更内容を記録する。

## Proposed Changes

### Minecraft Server Flake

#### [MODIFY] [flake.nix](file:///Users/t4d4/Develop/Minecraft-server-flake/flake.nix)

- `outputs` の `let ... in` ブロックの中に、各システムごとの MOD 定義を生成する共通ロジックを配置します。
- 具体的には、`apps` と `packages` の両方で `nixpkgsFor.${system}` を取得した直後に、共通の定義を読み込むようにします。

```nix
# 変更イメージ
let
  # システム共通のMOD定義
  allMods = pkgs: {
    mekanism = pkgs.fetchurl { ... };
    # ...
  };
in
{
  apps = forAllSystems (system: let
    pkgs = nixpkgsFor.${system};
    mods = allMods pkgs;
    modsDir = pkgs.linkFarm "minecraft-mods" ...;
    # ...
  });
}
```

## Open Questions
> [!IMPORTANT]
> **jj (Jujutsu) の利用について**
> 作業開始前に `jj new` を試みましたが、現在のターミナル環境で `jj` コマンドが見つかりませんでした。
> 1. `jj` は特定のパス（例: `/opt/homebrew/bin/jj` など）にありますか？
> 2. `nix shell` 等を通じて利用する必要がありますか？
> 3. もし利用できない場合、通常の `git` で代用してもよろしいでしょうか？

## Verification Plan

### Automated Tests
- `nix flake check`: フォーマットと構文のチェック。
- `nix build .#mods-zip`: パッケージが正しくビルドできるか。

### Manual Verification
- ビルドされた `mods.zip` の内容を `unzip -l` 等で確認し、主要なMODが含まれているか確認します。
