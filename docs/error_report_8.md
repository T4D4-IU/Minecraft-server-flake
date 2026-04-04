# Error Report 8

## エラー内容
`❌ checks.x86_64-linux.deadnix`
`error: hash '...' has wrong length for hash algorithm 'sha512'` (前回の修正漏れ？と思われましたが、ログを見ると `self` の未使用エラーです)
`>  10 │    self,`
`>     │      ╰── Unused lambda pattern: self`

## エラーの意味
`flake.nix` の `outputs` 関数の受取口に `self` が指定されていますが、その後の定義内で `self` が一度も参照されていません。CI に導入した `deadnix` は、未使用の変数があるとエラーを出す設定（`--fail`）にしているため、チェックに失敗しました。

## 修正計画
### 何を
`flake.nix` の `outputs` の引数リストを修正します。

### 何故
コードの品質（未使用変数の排除）を確保し、CI を正常にパスさせるためです。

### どのように
`self,` を削除します。

## 承認のお願い
この修正（未使用変数の削除）を適用してよろしいでしょうか？承認いただければ `flake.nix` を更新します。
