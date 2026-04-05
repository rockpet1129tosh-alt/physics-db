# science-db scripts ハブ

**最終更新**: 2026年4月5日

`scripts/` は、science-db の自動化・移行・運用文書を集約するハブです。  
大きく分けて **`compile/`**, **`migration/`**, **`docs/`** の3系統で管理します。

---

## 📁 現在の整理方針

```text
scripts/
├── README.md              # このファイル（運用ハブ）
├── compile/               # 一括コンパイル系スクリプト
├── migration/             # 移行・最適化ツールと生成レポート
└── docs/                  # 人が読む運用文書
    ├── README.md
    ├── README_STRUCTURE.md
    ├── UNIVERSITY-EXAM-DB.md
    ├── WORKFLOW.md
    ├── POLICIES.md
    ├── SUBFILES-GUIDE.md
    └── history/
        ├── HANDOVER_2026-03-01.md
        ├── PROGRESS-2026-03-03.md
        └── STRUCTURE.md
```

---

## 📖 まず読む順番

1. [docs/README.md](docs/README.md) — `docs/` 全体の索引
2. [docs/README_STRUCTURE.md](docs/README_STRUCTURE.md) — リポジトリ構造ガイド
3. [docs/WORKFLOW.md](docs/WORKFLOW.md) — 日常作業フロー
4. [docs/POLICIES.md](docs/POLICIES.md) — 運用ポリシー
5. [docs/UNIVERSITY-EXAM-DB.md](docs/UNIVERSITY-EXAM-DB.md) — 大学入試DBの構成・命名規則

---

## 🚀 よく使うコマンド

### コンパイル

```powershell
# 全体コンパイル
.\scripts\compile\compile_all.ps1

# スタンドアロン図版を一括コンパイル
.\scripts\compile\compile_all_standalone.ps1
```

### Git 作業

```powershell
# 状態確認
git status

# 変更を追加
git add <files>

# コミット
git commit -m "Update: 変更内容"

# プッシュ
git push origin main
```

---

## 🧭 各フォルダの役割

### `compile/`
- LaTeX の一括コンパイル用スクリプト
- 直接実行する日常作業の入口

### `migration/`
- 名前変更・構造変更・ライブラリ整理などの補助ツール
- 自動生成レポートは `migration/reports/` に分離して保管する

### `docs/`
- 運用ルール、構造設計、命名規則、引き継ぎメモを集約
- 履歴資料は `docs/history/` に分離して保管

---

## 📌 運用メモ

- 問題・解答の本体 `.tex` は `university_exam/` に置く
- `.aux`, `.log`, `.synctex.gz` などの中間ファイルは Git で追跡しない
- `*_0master.tex` は共通プリアンブル断片として扱い、直接ビルドしない
- 大学入試DBは **教科 → 大学 → 年度 → 試験セット → 大問** の順で整理する

---

迷ったら、まず [docs/README.md](docs/README.md) を開いてください。
