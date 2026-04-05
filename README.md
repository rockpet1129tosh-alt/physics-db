# science-db

理科系の大学入試・標準演習データを TeX で体系管理するリポジトリです。  
詳細な運用ルールと構造設計は `scripts/` 配下に集約しています。

---

## まず最初に読む

1. リポジトリ概要（このページ）
2. 運用ハブ: [scripts/README.md](scripts/README.md)
3. docs 索引: [scripts/docs/README.md](scripts/docs/README.md)
4. 構造詳細: [scripts/docs/README_STRUCTURE.md](scripts/docs/README_STRUCTURE.md)

---

## リポジトリの目的

- 大学入試向け理科問題を、再利用しやすい TeX データベースとして管理する
- 問題（`_q.tex`）と解答（`_a.tex`）を分離し、編集効率を高める
- 図版（TikZ / standalone）と本文を分離し、差分管理と再生成を容易にする

---

## 主要ディレクトリ

- `university_exam/physics/standard/`  
  現行の物理標準演習データ（`uem_phy_std_*` 系列）
- `university_exam/physics/okayama-u/`  
  岡山大学の大学入試DB雛形
- `figures/`  
  共通ロゴ・図版アセット
- `scripts/`  
  一括処理、移行ツール、運用ドキュメント

---

## クイックリンク

- 運用ガイド: [scripts/README.md](scripts/README.md)
- docs 索引: [scripts/docs/README.md](scripts/docs/README.md)
- 構造ガイド: [scripts/docs/README_STRUCTURE.md](scripts/docs/README_STRUCTURE.md)
- 大学入試DBの確定メモ: [scripts/docs/UNIVERSITY-EXAM-DB.md](scripts/docs/UNIVERSITY-EXAM-DB.md)
- ポリシー: [scripts/docs/POLICIES.md](scripts/docs/POLICIES.md)
- ワークフロー: [scripts/docs/WORKFLOW.md](scripts/docs/WORKFLOW.md)

---

## 運用ポリシー（要点）

- 本体 TeX（問題・解答）は `university_exam/` に置く
- 自動生成の補助ファイル・移行レポートは `scripts/` に置く
- 入口情報は `README.md` と `scripts/README.md` に集約し、詳細文書は `scripts/docs/` にまとめる

---

詳細作業に入る場合は、まず [scripts/README.md](scripts/README.md) から開始してください。

