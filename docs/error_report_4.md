# Error Report 4

## エラー内容
`/Users/t4d4/Develop/Minecraft-server-flake/data/user_jvm_args.txt: Permission denied`

## エラーの意味
`data/user_jvm_args.txt` というファイルが、Nix Store 内の読み取り専用ファイルを指すシンボリックリンクになっているため、実行スクリプトによる上書き（`cat > ...`）が失敗しました。これは以前のステップで `serverPkg` 内の全ファイルを `data/` にリンクした際に、設定ファイルの雛形までリンクされてしまったことが原因です。

## 修正計画
### 何を
`flake.nix` の起動スクリプトを修正します。

### 何故
実行時に動的に生成・変更する必要があるファイル（`user_jvm_args.txt` や `eula.txt` など）がシンボリックリンクになっている場合、それを削除してから実体ファイルとして作成し直す必要があるためです。

### どのように
ファイルを書き出す直前に `rm -f` を追加して、既存の（読み取り専用の）リンクを解除するようにします。

```bash
          # 修正案
          rm -f "$DATA_DIR/user_jvm_args.txt"
          cat > "$DATA_DIR/user_jvm_args.txt" <<EOF
          ...
```

## 承認のお願い
この修正を適用してよろしいでしょうか？承認いただければ `flake.nix` を更新いたします。
