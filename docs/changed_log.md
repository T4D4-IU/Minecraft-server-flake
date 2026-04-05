# Changed Log

## 2026-04-05 (MOD追加)

### 1. 何処を (Where)
`./flake.nix`

### 2. 何故 (Why)
PrismLauncher にて管理しているクライアントMODリストをもとに、サーバー側に必要なMODを追加するため。

### 3. どのように (How)
- 以下のMODを `commonMods` に追加しました (Modrinth CDNから自動取得)：
    - AppliedE (1.0.8-beta)
    - Architectury (13.0.8)
    - Bagus Lib (1.21.1-13.25.1)
    - Bookshelf (21.1.81)
    - Cloth Config v15 API (15.0.140)
    - Clumps (19.0.0.1)
    - EMC Schematic Cannon (1.1.0)
    - Gravestone Mod (1.0.35)
    - Jade (15.10.5)
    - MCPitanLib (3.6.3)
    - Mekanism: Additions (10.7.18.84)
    - Mekanism: Generators (10.7.18.84)
    - Mekanism: Tools (10.7.18.84)
    - ModernFix (5.26.1)
    - PrickleMC (21.1.11)
    - TofuCraftReload (1.21.1-12.20.2.0)
    - Uncrafting Table (1.5.4)
    - Sinytra Connector (2.0.0-beta.14)
    - Forgified Fabric API (0.116.7+2.2.4)
- 以下のMODはCurseForge専用だが、`mediafilez.forgecdn.net` CDNの直接URLを利用して `pkgs.fetchurl` で追加：
    - ProjectE (1.1.0)
    - FTB Library (2101.1.31)
    - FTB Ultimine (2101.1.13)
- 以下のMODは対応リリースが見つからず導入を断念：
    - Buildcraft-Legacy
    - Porting Dead Libs
- クライアント専用MOD（Iris, Sodium, AppleSkin等）はサーバー不要のため追加していません。


### 1. 何処を (Where)
`./flake.nix`

### 2. 何故 (Why)
`flake.nix` 内にて、`apps` (実行用) と `packages` (配布用) に定義されていた MOD のリストが重複しており、追加時の記載漏れなどの原因となり得るため、保守性向上のために集約しました。

### 3. どのように (How)
- 共通の関数 `commonMods` と `commonModsDir` を `let` 句に定義しました。
- `apps` および `packages` のブロック内で当該定義を参照するように再構築し、重複を排除しました。

## 2026-04-04

### 1. 何処を (Where)
`/Users/t4d4/Develop/Minecraft-server-flake/flake.nix`

### 2. 何故 (Why)
M4 Mac (Darwin) 上で NeoForge 1.21.1 サーバーを動作させ、指定された工業系・便利系 Mod を自動的に導入するため。

### 3. どのように (How)
- `nix-minecraft` のオーバーレイを使用するように構成を更新。
- Minecraft 1.21.1 およびそれに対応する NeoForge サーバーパッケージ (`neoforgeServers.neoforge-1_21_1`) を指定。
- 以下の Mod を Modrinth から `fetchurl` で取得するように定義：
    - Mekanism (10.7.18.84)
    - Create (mc1.21.1-6.0.9)
    - Applied Energistics 2 (19.2.17)
    - Just Enough Items (19.27.0.340)
    - FerriteCore (7.0.3)
    - Lithium (0.15.3 for 1.21.1)
    - GuideMe (21.1.15) ※AE2の依存関係として追加
- `linkFarm` を使用して Mod を集約し、起動時に `./data/mods` へシンボリックリンクを貼るラッパースクリプトを実装。
- Java 21 を明示的に使用し、メモリ割り当て（4GB〜6GB）を設定。
- NeoForge のライセンス（`unfreeRedistributable`）を許可するため、`config.allowUnfree = true` を追加。
- サーバー起動時に生じていた「Invalid or corrupt jarfile」エラーを解消するため、`java -jar` を介さず直接ラッパースクリプトを呼び出すように修正。
- メモリ設定を `user_jvm_args.txt` 経由で適用するように変更。
- NeoForge の起動に必要なライブラリ群（`libraries` ディレクトリ等）を `serverPkg` から実行ディレクトリにシンボリックリンクする処理を追加。
- 標準ラッパーをバイパスし、`unix_args.txt` を直接 `java` に渡すことで起動を安定化させるロジックに変更。
- `eula.txt` や `user_jvm_args.txt` が読み取り専用のリンクになっていた場合、上書き前に削除するように修正。
- `formatter` として `pkgs.alejandra` を導入し、`nix fmt` による自動整形をサポート。
- `statix`, `deadnix` を含む `checks` を定義し、Nix コードの品質チェックを可能に。
- GitHub Actions (`.github/workflows/nix.yml`) を追加し、プッシュ時に自動で `nix flake check` が走るように構成。
- GitHub Actions のトリガーに `paths` フィルターを追加。`docs/` などのドキュメントのみの変更時は CI をスキップするように最適化。
- `deadnix` および `statix` による指摘内容を修正し、全ての自動チェックをパスするように調整。
- `README.md` を追加。ご友人や他のプレイヤーが GitHub Actions から最新の Mod パックを入手するためのガイドを整備。
- `packages.mods-zip` を追加し、サーバーで使用している Mod を一括で ZIP 圧縮してクライアント向けに配布可能に。
- GitHub Actions で `mods.zip` をビルドし、成果物（Artifact）としてアップロードするステップを追加。
