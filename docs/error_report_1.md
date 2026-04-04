# Error Report 1

## エラー内容
`error: Refusing to evaluate package 'neoforge-1.21.1-21.1.222' because it has an unfree license ('unfreeRedistributable')`

## エラーの意味
NeoForge は「unfreeRedistributable（再配布可能な非自由ライセンス）」として定義されています。Nix のデフォルト設定では、オープンソースではない、あるいは自由なライセンスではないソフトウェアのインストールや評価を制限しており、今回の NeoForge サーバーパッケージがこれに該当したためエラーとなりました。

## 修正計画
### 何を
`flake.nix` 内の `nixpkgs` のインポート設定を修正します。

### 何故
Nixpkgs の設定で `allowUnfree = true` を明示的に設定することで、NeoForge のようなライセンスを持つパッケージの評価を許可するためです。

### どのように
`flake.nix` の `pkgs` を定義している箇所を以下のように変更します：

```nix
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nix-minecraft.overlay ];
        config.allowUnfree = true; # この行を追加
      };
```

## 承認のお願い
この修正を行ってよろしいでしょうか？承認をいただければ、ファイルを更新いたします。
