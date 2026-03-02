# science-db

大学入試の物理問題を TeX で体系管理するリポジトリです。  
GitHub 上で迷わないよう、**入口はこの README に一本化**し、詳細仕様は `scripts/` 配下に集約しています。

## まず最初に読む

1. リポジトリ概要（このページ）
2. 運用ハブ: [scripts/README.md](scripts/README.md)
3. 構造詳細: [scripts/README_STRUCTURE.md](scripts/README_STRUCTURE.md)

## リポジトリの目的

- 大学入試の物理標準問題を、分野横断で編集・再利用できる形で管理する
- 問題（`_q.tex`）と解答（`_a.tex`）を分離し、編集効率を向上させる
- 図版（TikZ/CircuiTikZ/standalone）と本文を分離し、差分管理・再生成を容易にする

## 主要ディレクトリ

- `university_exam/physics-standard/` : 大学入試物理標準問題（5分野）の問題・解答データ
- `figures/` : 共通ロゴ・図版アセット
- `scripts/` : 一括処理、移行補助、運用ドキュメント

## クイックリンク

- 運用ガイド: [scripts/README.md](scripts/README.md)
- 構成ガイド: [scripts/README_STRUCTURE.md](scripts/README_STRUCTURE.md)
- ポリシー: [scripts/docs/POLICIES.md](scripts/docs/POLICIES.md)
- ワークフロー: [scripts/docs/WORKFLOW.md](scripts/docs/WORKFLOW.md)
- 進捗ログ: [scripts/PROGRESS-2026-03-03.md](scripts/PROGRESS-2026-03-03.md)
- 引き継ぎメモ: [scripts/docs/HANDOVER_2026-03-01.md](scripts/docs/HANDOVER_2026-03-01.md)

## 現在の進捗（要約）

- 5分野（力学、熱力学、電磁気、波、原子物理）の階層構造確立
- 39個のスタンドアロン図形最適化完了
- `\part{分野名}` による見出し階層構築完了

## 運用ポリシー（重要）

- 本体 TeX（問題・解答）は `university_exam/` に置く
- 自動生成の補助ファイル（移行メモ・作業ログ・レポート）は `scripts/` に置く
- ルートには「入口情報」を置き、詳細仕様は `scripts/` に集約する

## 将来計画: science-db への統合

このプロジェクト（physics-standard）は、最終的に **science-db** の一部として以下の科目を含む予定：
- physics-standard（現在）
- chemistry-standard（将来）
- biology-standard（将来）
- earth-science-standard（将来）

詳細は [scripts/README_STRUCTURE.md](scripts/README_STRUCTURE.md) を参照。

---

詳細作業に入る場合は [scripts/README.md](scripts/README.md) から開始してください。
