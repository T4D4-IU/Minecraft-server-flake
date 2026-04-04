# Minecraft NeoForge 1.21.1 Nix Server

[![Nix CI](https://github.com/T4D4-IU/Minecraft-server-flake/actions/workflows/nix.yml/badge.svg)](https://github.com/T4D4-IU/Minecraft-server-flake/actions/workflows/nix.yml)

Nix Flakes を使用して宣言的に構築された、工業化 Mod 中心の中規模 Minecraft サーバーです。
Nixが動くなら動作する筈。

---

## 🎮 プレイヤー向けセットアップ 

サーバーに参加するために、以下の手順で Mod を導入してください。

### 1. クライアントの準備
- **Minecraft バージョン**: 1.21.1
- **NeoForge バージョン**: 最新の 1.21.1 対応版をインストールしてください。

### 2. Mod パックのダウンロード
サーバーと同期した専用の Mod セットは、GitHub Actions から自動配布されています。
1. このリポジトリの [Actions](https://github.com/T4D4-IU/Minecraft-server-flake/actions) タブを開く
2. 一番上の最新の実行（✅ 緑色のもの）をクリック
3. ページ下部の **Artifacts** セクションにある `mods-bundle` をクリックして ZIP をダウンロード

### 3. Mod の導入
1. ダウンロードした ZIP を解凍します。
2. 中にある `mods` フォルダ内のすべての `.jar` ファイルを、自身の Minecraft プロファイルの `mods` フォルダにコピーします。

---

## 🛠 サーバー管理者（自分）向け操作

### Nix 環境での起動
```bash
nix run .
```
※ 初回起動時に `data/` ディレクトリが作成され、サーバーデータが保持されます。

### Nix コードの整形
```bash
nix fmt
```

### 品質チェック (リント)
```bash
nix flake check
```

---

## 🏗 主要導入 Mod

このサーバーには、以下の主要な工業・便利 Mod が導入されています。

- **工業 / 輸送**:
  - **Mekanism**: 加速器や高度な精錬システム。
  - **Create**: 歯車と回転エネルギーによる自動化。
  - **Applied Energistics 2 (AE2)**: デジタルストレージとネットワーク。
- **最適化 / ユーティリティ**:
  - **Lithium**: サーバーのパフォーマンス向上。
  - **FerriteCore**: メモリ使用量の最適化。
  - **JEI (Just Enough Items)**: レシピ確認。

---

## 📄 開発ログ
詳細な変更履歴は [docs/changed_log.md](./docs/changed_log.md) を参照してください。
