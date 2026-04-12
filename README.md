# Minecraft NeoForge 1.21.1 Nix Server

[![Nix CI](https://github.com/T4D4-IU/Minecraft-server-flake/actions/workflows/nix.yml/badge.svg)](https://github.com/T4D4-IU/Minecraft-server-flake/actions/workflows/nix.yml)

Nix Flakes を使用して宣言的に構築された、工業化 Mod 中心の中規模 Minecraft サーバーです。
Nixが動くなら動作する筈。

---

## 🎮 プレイヤー向けセットアップ

サーバーに参加するために、以下の手順で Mod を導入してください。

### 1. クライアントの準備

- **Minecraft バージョン**: 1.21.1
- **NeoForge**: **必須**。最新の 1.21.1 対応版をインストールしてください。  
  → [NeoForge ダウンロードページ](https://neoforged.net/)

> ⚠️ Forge / Fabric / Quilt など他のローダーでは接続できません。必ず **NeoForge** をご使用ください。

### 2. Mod パックのダウンロード

サーバーと同期した専用の Mod セットは、GitHub Actions から自動配布されています。

1. このリポジトリの [Actions](https://github.com/T4D4-IU/Minecraft-server-flake/actions) タブを開く
2. 一番上の最新の実行（✅ 緑色のもの）をクリック
3. ページ下部の **Artifacts** セクションにある `mods-bundle` をクリックして ZIP をダウンロード

### 3. Mod の導入

1. ダウンロードした ZIP を解凍します。
2. 中にある `mods` フォルダ内のすべての `.jar` ファイルを、自身の Minecraft プロファイルの `mods` フォルダにコピーします。

### 4. クライアント専用 Mod（任意）

上記の Mod セットはサーバー・クライアント共通の Mod のみを含んでいます。  
以下のようなクライアント専用 Mod はお好みで追加できます（サーバー側には影響しません）。

- **[Sodium](https://modrinth.com/mod/sodium)**: 描画最適化（NeoForge版: Embeddium など）
- **[Iris Shaders](https://modrinth.com/mod/iris)**: シェーダーサポート
- **[minimap 系 Mod](https://modrinth.com/mod/journeymap)**: JourneyMap など

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

## 🏗 導入 Mod 一覧

`flake.nix` で管理されている全 Mod の一覧です。

### 工業 / 自動化
| Mod | 説明 |
|-----|------|
| [Mekanism](https://modrinth.com/mod/mekanism) | 高度な精錬・輸送・エネルギーシステム |
| [Mekanism: Additions](https://modrinth.com/mod/mekanism-additions) | Mekanism の追加要素 |
| [Mekanism: Generators](https://modrinth.com/mod/mekanism-generators) | Mekanism 用各種発電機 |
| [Mekanism: Tools](https://modrinth.com/mod/mekanism-tools) | Mekanism 素材の防具・ツール |
| [Create](https://modrinth.com/mod/create) | 歯車と回転エネルギーによる機械式自動化 |
| [Applied Energistics 2 (AE2)](https://modrinth.com/mod/ae2) | デジタルストレージとネットワーク管理 |
| [AppliedE](https://modrinth.com/mod/appliede) | AE2 × ProjectE の連携 Mod |
| [ProjectE](https://www.curseforge.com/minecraft/mc-mods/projecte) | 等価交換（EE2 の再実装） |
| [EMC Schematic Cannon](https://modrinth.com/mod/emc-schematic-cannon) | ProjectE EMC を消費して設計図を建設 |
| [FTB Ultimine](https://www.curseforge.com/minecraft/mc-mods/ftb-ultimine-forge) | 一括採掘 |

### 便利 / サバイバル
| Mod | 説明 |
|-----|------|
| [JEI (Just Enough Items)](https://modrinth.com/mod/jei) | レシピ・アイテム検索 |
| [Jade](https://modrinth.com/mod/jade) | ホバー時にブロック・エンティティ情報を表示 |
| [Gravestone Mod](https://modrinth.com/mod/gravestone-mod) | 死亡時に墓石を生成してアイテムを保護 |
| [Uncrafting Table](https://modrinth.com/mod/uncrafting-table) | クラフトを逆順に分解できるテーブル |
| [TofuCraft Reload](https://modrinth.com/mod/tofucraft-reload) | お豆腐クラフト |
| [Clumps](https://modrinth.com/mod/clumps) | 経験値オーブをまとめてラグ軽減 |

### 最適化 / パフォーマンス
| Mod | 説明 |
|-----|------|
| [Lithium](https://modrinth.com/mod/lithium) | サーバーのゲームロジック最適化 |
| [FerriteCore](https://modrinth.com/mod/ferrite-core) | メモリ使用量の削減 |
| [ModernFix](https://modrinth.com/mod/modernfix) | 起動時間・メモリ・パフォーマンスの総合改善 |

### ライブラリ / 依存 Mod
| Mod | 説明 |
|-----|------|
| [Architectury API](https://modrinth.com/mod/architectury-api) | マルチローダー向けライブラリ |
| [Bagus Lib](https://modrinth.com/mod/bagus-lib) | TofuCraft 依存ライブラリ |
| [Bookshelf](https://modrinth.com/mod/bookshelf) | 汎用ライブラリ |
| [Cloth Config API](https://modrinth.com/mod/cloth-config) | 設定画面ライブラリ |
| [FTB Library](https://www.curseforge.com/minecraft/mc-mods/ftb-library-forge) | FTB Mod 共通ライブラリ |
| [GuideME](https://modrinth.com/mod/guideme) | AE2 向けガイドブックライブラリ |
| [MCPitan Lib](https://modrinth.com/mod/mcpitanlib) | TofuCraft 依存ライブラリ |
| [Prickle](https://modrinth.com/mod/prickle) | TofuCraft 依存ライブラリ |
| [Sinytra Connector](https://modrinth.com/mod/connector) + [Forgified Fabric API](https://modrinth.com/mod/forgified-fabric-api) | Fabric MOD を NeoForge で動かす互換レイヤー |

---

## 💬 Mod のリクエスト

追加してほしい Mod がある場合は、[Issue を作成](https://github.com/T4D4-IU/Minecraft-server-flake/issues/new?template=mod_request.yml)してください。  
テンプレートに沿って Mod 名・用途・理由をご記入ください。

---

## 📄 開発ログ
詳細な変更履歴は [docs/changed_log.md](./docs/changed_log.md) を参照してください。
