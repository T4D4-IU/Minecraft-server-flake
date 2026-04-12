# Changed Log

## 2026-04-12

### GitHub Actions ワークフローの更新

1.  **何処を**: `.github/workflows/nix.yml`
2.  **何故**:
    *   Node.js 20 の非推奨警告（GitHub Actions ランナー）に対応するため。
    *   FlakeHub 認証エラー（統計情報送信失敗）を解消するため。
    *   キャッシュサービスのエラー対策と、設定の簡素化のため。
3.  **どのように**:
    *   `DeterminateSystems/nix-installer-action` と `DeterminateSystems/magic-nix-cache-action` を廃止し、後継の統合アクション `DeterminateSystems/determinate-nix-action@v4` に置き換え。
    *   `DeterminateSystems/flake-checker-action` を `v12` に更新し、`send-statistics: false` を設定して FlakeHub への報告を無効化。
    *   全体的なアクションのバージョンを見直し。
