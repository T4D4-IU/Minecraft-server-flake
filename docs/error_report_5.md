# Error Report 5

## エラー内容
`org.spongepowered.asm.mixin.injection.throwables.InjectionError: Critical injection failure: Redirector removeOldMapAlloc()Ljava/util/HashMap; in lithium.mixins.json:alloc.nbt.CompoundTagMixin from mod lithium failed injection check`

## エラーの意味
パフォーマンス改善 Mod である `lithium` が、Minecraft 本体のコードを書き換えようとして失敗しました。これは、現在 `flake.nix` に設定されている Lithium のバージョン（0.23.0）が Minecraft 1.21.4 以降向けのものであり、1.21.1 の内部コード構造と一致していないことが原因です。

## 修正計画
### 何を
`flake.nix` 内の `lithium` Mod の URL とハッシュを修正します。

### 何故
Minecraft 1.21.1 (NeoForge) に完全に対応した正しいバージョン（0.15.3）を使用する必要があるためです。

### どのように
以下の設定に差し替えます：
- **Version**: 0.15.3+mc1.21.1
- **URL**: `https://cdn.modrinth.com/data/gvQqBUqZ/versions/RXHf27Wv/lithium-neoforge-0.15.3%2Bmc1.21.1.jar`

## 承認のお願い
この修正（Lithium のバージョン適正化）を適用してよろしいでしょうか？承認いただければ `flake.nix` を更新いたします。
