# Final Walkthrough - Minecraft Server Project

M4 Mac (aarch64-darwin) 上で、工業化 Mod やパフォーマンス最適化 Mod を含んだ NeoForge 1.21.1 サーバーの構築に成功しました。

## 構築した環境の特長

### 1. サーバー構成 (Nix Flakes)
- **NeoForge 1.21.1**: 最新のサーバーローダーを M4 Mac で安定動作するように調整。
- **Java 21**: Apple Silicon に最適化された実行環境。
- **自動ラッパースクリプト**: 権限問題やライブラリパスの問題を自動で解決し、`nix run .` だけで起動可能。

### 2. Mod 構成 (工業・便利系)
- **Mekanism / Create / AE2**: 本格的な工業化を楽しめる構成。
- **Lithium / FerriteCore**: パフォーマンスとメモリ使用量を最適化。
- **JEI**: レシピ確認を容易に。
- **GuideMe**: AE2 の前提 Mod も解決済み。

### 3. CI/CD & 自動化 (GitHub Actions)
- **自動チェック**: `alejandra` (フォーマット), `statix` (リント), `deadnix` (未使用変数) が GitHub へのプッシュ時に自動実行。
- **クライアント Mod 配布**: サーバーと同じ Mod 群をまとめた `mods.zip` を自動でビルドし、GitHub の成果物 (Artifact) として提供。

## 使い方

### サーバーの起動
```bash
nix run .
```

### クライアント用 Mod パックの作成 (ローカル)
```bash
nix build .#mods-zip
# result/mods.zip に生成されます
```

### コードの整形
```bash
nix fmt
```

### 品質チェックの実行 (ローカル)
```bash
nix flake check
```

---
> [!IMPORTANT]
> **GitHub Actions での Mod ダウンロード**:
> GitHub リポジトリの "Actions" タブから、各実行結果のページ最下部にある `mods-bundle` をダウンロードしてください。解凍して `mods` フォルダ（JAR 群）をそのままクライアント側の `mods` ディレクトリにコピーすれば、サーバーと同じ Mod 環境を構築できます。
