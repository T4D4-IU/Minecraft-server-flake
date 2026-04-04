# Error Report 2

## エラー内容
`Error: Invalid or corrupt jarfile /nix/store/...-neoforge-1.21.1-21.1.222/bin/minecraft-server`

## エラーの意味
`nix-minecraft` のサーバーパッケージ（`${serverPkg}`）が提供する `bin/minecraft-server` は、サーバーを起動するための構成済みのシェルスクリプトです。しかし、現在の `flake.nix` ではこれを `java -jar` コマンドに渡して実行しようとしていました。`java -jar` は JAR ファイルのみを受け付けるため、「無効または破損した jar ファイル」としてエラーになりました。

## 修正計画
### 何を
`flake.nix` 内の `apps.${system}.default.program` の起動ロジックを修正します。

### 何故
パッケージがあらかじめ用意しているラッパースクリプトを直接実行することで、NeoForge が必要とする複雑なクラスパスや引数の設定を正しく適用するためです。

### どのように
`java -jar ${serverPkg}/bin/minecraft-server` の箇所を `${serverPkg}/bin/minecraft-server` の直接実行に書き換えます。

```nix
          # 修正案
          exec ${serverPkg}/bin/minecraft-server nogui
```

※メモリ設定 (`-Xmx`, `-Xms`) については、NeoForge のラッパーが自動的に設定ファイル（`user_jvm_args.txt` 等）を参照するか、あるいは環境変数経由での指定となります。今回のポータブル構成では、一旦ラッパーをそのまま実行する形に修正し、必要であれば後ほど `user_jvm_args.txt` の生成ロジックを追加します。

## 承認のお願い
この修正を適用してよろしいでしょうか？承認いただければ `flake.nix` を更新いたします。
