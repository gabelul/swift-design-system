# リリースプロセス

このドキュメントでは、swift-design-systemの新しいバージョンをリリースする手順を説明します。

## 概要

このプロジェクトは完全自動化されたリリースフローを採用しています：

1. **開発中**: CHANGELOG.mdの「未リリース」セクションに変更を記録
2. **リリース準備**: 手動でバージョンセクションを作成し、タグをプッシュ
3. **自動化**: GitHub Releaseの作成と次回リリース準備が自動実行

## 前提条件

- リポジトリへの書き込み権限
- ローカル環境にGitがインストールされている
- mainブランチが最新の状態

## リリース手順

### 1. 最新のmainブランチを取得

```bash
git checkout main
git pull origin main
```

### 2. CHANGELOG.mdを更新

#### 2.1 「未リリース」セクションをバージョンセクションに変換

`CHANGELOG.md`を開き、以下の変更を行います：

**変更前:**
```markdown
## [未リリース]

### 追加
- 新機能Aを追加
- 新機能Bを追加

### 修正
- バグXを修正
```

**変更後:**
```markdown
## [1.0.X] - 2025-11-08

### 追加
- 新機能Aを追加
- 新機能Bを追加

### 修正
- バグXを修正
```

**重要**:
- バージョン番号は[セマンティックバージョニング](https://semver.org/lang/ja/)に従ってください
  - MAJOR: 破壊的変更
  - MINOR: 後方互換性のある機能追加
  - PATCH: 後方互換性のあるバグ修正
- 日付は`YYYY-MM-DD`形式で記載

#### 2.2 比較リンクセクションを更新

ファイルの末尾にある比較リンクセクションを更新します：

**変更前:**
```markdown
[未リリース]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.9...HEAD
[1.0.9]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.8...v1.0.9
```

**変更後:**
```markdown
[未リリース]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.10...HEAD
[1.0.10]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.9...v1.0.10
[1.0.9]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.8...v1.0.9
```

**注意**:
- `[未リリース]`のリンクは新バージョンを基準に更新
- 新バージョンの比較リンクを追加

### 3. 変更をコミット

```bash
git add CHANGELOG.md
git commit -m "chore: vX.Y.Zリリース準備"
git push origin main
```

### 4. タグを作成してプッシュ

```bash
git tag vX.Y.Z
git push origin vX.Y.Z
```

**例:**
```bash
git tag v1.0.10
git push origin v1.0.10
```

### 5. 自動化の確認

タグをプッシュすると、以下のGitHub Actionsワークフローが自動的に実行されます：

#### 5.1 release.ymlワークフロー

**実行内容:**
- CHANGELOG.mdから該当バージョンのセクションを抽出
- 整形されたリリースノートを生成（タイトル、インストール方法、リンク付き）
- GitHub Releaseを作成

**確認方法:**
```bash
gh run list --workflow=release.yml --limit 1
```

または、GitHubのWebページで確認:
https://github.com/no-problem-dev/swift-design-system/actions/workflows/release.yml

**完了後の確認:**
- https://github.com/no-problem-dev/swift-design-system/releases にアクセス
- 新しいリリースが正しく作成されていることを確認

#### 5.2 prepare-next-release.ymlワークフロー

**実行内容:**
- mainブランチから`chore/prepare-next-release`ブランチを作成
- CHANGELOG.mdに新しい「未リリース」セクションを追加
- 比較リンクを最新バージョンに自動更新
- ドラフトPRを自動作成

**確認方法:**
```bash
gh run list --workflow=prepare-next-release.yml --limit 1
```

**完了後の確認:**
```bash
gh pr list --state all --limit 1
```

または、GitHubのWebページで確認:
https://github.com/no-problem-dev/swift-design-system/pulls

**ドラフトPRの内容:**
- タイトル: "chore: prepare for next release"
- ステータス: DRAFT（ドラフト状態）
- 変更内容: CHANGELOG.mdに「未リリース」セクションと更新された比較リンク

### 6. ドラフトPRをマージ

次の開発サイクルを開始するため、自動作成されたドラフトPRをマージします：

#### 6.1 PRをReady for reviewに変更

```bash
gh pr ready <PR番号>
```

#### 6.2 PRをマージ

```bash
gh pr merge <PR番号> --squash
```

または、GitHubのWebページからマージ:
https://github.com/no-problem-dev/swift-design-system/pulls

### 7. ローカルブランチを更新

```bash
git pull origin main
```

## トラブルシューティング

### ワークフローが失敗した場合

#### release.ymlの失敗

**原因**: CHANGELOG.mdに該当バージョンのセクションが見つからない

**対処法**:
1. CHANGELOG.mdに正しいバージョンセクションが存在するか確認
2. フォーマットが`## [X.Y.Z] - YYYY-MM-DD`になっているか確認
3. 修正後、タグを削除して再プッシュ:
```bash
git tag -d vX.Y.Z
git push origin :refs/tags/vX.Y.Z
git push origin vX.Y.Z
```

#### prepare-next-release.ymlの失敗

**原因1**: 既に「未リリース」セクションが存在する

**対処法**: これは正常な動作です。ワークフローは自動的にスキップされます。

**原因2**: PRの作成権限エラー

**対処法**: 組織の設定で「Allow GitHub Actions to create and approve pull requests」が有効になっているか確認
- https://github.com/organizations/no-problem-dev/settings/actions

### バージョン番号を間違えた場合

**タグプッシュ前の場合:**
```bash
# ローカルのタグを削除
git tag -d vX.Y.Z

# 正しいバージョンで再作成
git tag vX.Y.Z
git push origin vX.Y.Z
```

**タグプッシュ後の場合:**
```bash
# リモートのタグを削除
git push origin :refs/tags/vX.Y.Z

# GitHubのReleaseを手動で削除（Webページから）

# 正しいバージョンで再実行
git tag vX.Y.Z
git push origin vX.Y.Z
```

## ベストプラクティス

### CHANGELOG.mdの記述

- **明確な見出し**: 「追加」「変更」「非推奨」「削除」「修正」「セキュリティ」を使用
- **ユーザー視点**: 技術的詳細よりも、ユーザーへの影響を記述
- **簡潔に**: 各項目は1-2文で説明
- **リンク**: 関連するPRやIssueがあれば記載

**良い例:**
```markdown
### 追加
- **新しいテーマ**: Ocean、Forest、Sunset など7種類のビルトインテーマを追加
- **タイポグラフィシステム**: 一貫したテキストスタイルを提供する Typography modifier を追加
```

**悪い例:**
```markdown
### 追加
- 新機能を追加した
- いろいろ修正
```

### リリースタイミング

- **重大なバグ修正**: 即座にPATCHバージョンをリリース
- **機能追加**: 複数の機能をまとめてMINORバージョンでリリース
- **破壊的変更**: 十分な告知期間を設けてMAJORバージョンでリリース

### リリースノート

GitHub Releaseには以下が自動的に含まれます：
- リリースタイトル（例: "🎉 v1.0.10 リリース"）
- リリース告知文
- CHANGELOG.mdからの変更内容
- インストール方法
- ドキュメントへのリンク

## 参考情報

- [Keep a Changelog](https://keepachangelog.com/ja/1.0.0/) - CHANGELOGのベストプラクティス
- [セマンティックバージョニング](https://semver.org/lang/ja/) - バージョン番号の付け方
- [GitHub Releases](https://docs.github.com/ja/repositories/releasing-projects-on-github/about-releases) - GitHubのリリース機能
- [GitHub Actions](https://docs.github.com/ja/actions) - 自動化ワークフローの詳細

## ワークフローファイル

自動化の詳細は以下のファイルを参照してください：
- [.github/workflows/release.yml](.github/workflows/release.yml) - GitHub Release作成
- [.github/workflows/prepare-next-release.yml](.github/workflows/prepare-next-release.yml) - 次回リリース準備
