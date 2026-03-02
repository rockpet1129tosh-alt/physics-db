# science-db 運用ハブ

**最終更新**: 2026年3月3日

このフォルダ（`scripts/`）は **science-db の運用センター**です。  
コンパイル、移行、ドキュメント、進捗管理を集約しています。

---

## 📖 ナビゲーション

### 初めての方へ
1. [README_STRUCTURE.md](README_STRUCTURE.md) - フォルダ構造・命名規則・subfiles階層
2. [docs/WORKFLOW.md](docs/WORKFLOW.md) - 編集・コンパイル・Git操作フロー
3. [docs/POLICIES.md](docs/POLICIES.md) - 運用ポリシー・Git管理方針

### 日常作業
- [docs/WORKFLOW.md](docs/WORKFLOW.md) - 問題追加・図版編集・コミット手順
- [compile/](compile/) - 一括コンパイルスクリプト
- [PROGRESS-2026-03-03.md](PROGRESS-2026-03-03.md) - 最新の進捗ログ

### 技術資料
- [README_STRUCTURE.md](README_STRUCTURE.md) - 詳細構造ガイド（243行）
- [docs/STRUCTURE.md](docs/STRUCTURE.md) - 技術仕様（旧版・統合予定）
- [docs/HANDOVER_2026-03-01.md](docs/HANDOVER_2026-03-01.md) - 引き継ぎメモ

---

## 🚀 クイックスタート

### コンパイル

```powershell
# 全てのマスターファイルをコンパイル
.\scripts\compile\compile_all.ps1

# スタンドアロン図版を一括コンパイル
.\scripts\compile\compile_all_standalone.ps1
```

### Git操作

```powershell
# 状態確認
git status

# 問題・解答・PDF追加
git add university_exam/physics-standard/em_electromagnetism/circuit-basics/01_kirchhoff/ps_em_cb_01_q.tex
git add university_exam/physics-standard/em_electromagnetism/circuit-basics/01_kirchhoff/ps_em_cb_01_q.pdf

# コミット（日本語推奨）
git commit -m "Add: 電磁気・回路の基本・キルヒホッフの法則（問題）"

# プッシュ
git push origin main
```

---

## 📁 フォルダ構造

```
scripts/
├── README.md                     # このファイル（運用ハブ）
├── README_STRUCTURE.md           # 詳細構造ガイド（243行）
├── PROGRESS-2026-03-03.md        # 進捗ログ
│
├── compile/                      # コンパイル自動化
│   ├── compile_all.ps1           # 全親ファイル・分野ファイル・中項目ファイル
│   ├── compile_all_standalone.ps1 # スタンドアロン図形
│   └── compile_all_tikz.ps1      # TikZ図形（廃止予定）
│
├── migration/                    # 移行・最適化ツール
│   ├── analyze_tex_packages.ps1  # パッケージ使用状況解析
│   ├── cleanup_tikzlibraries.ps1 # TikZ ライブラリ最適化
│   ├── list_tikzlibraries.ps1    # ライブラリ一覧出力
│   ├── migrate_*.ps1             # 各種マイグレーションツール
│   ├── *.md                      # 作業レポート（自動生成）
│   └── deleted_tikz_files.txt    # 削除ファイル記録
│
└── docs/                         # ドキュメント集約
    ├── POLICIES.md               # 運用ポリシー（190行）
    ├── WORKFLOW.md               # ワークフロー規則（270行）
    ├── STRUCTURE.md              # 技術仕様（旧版・統合予定）
    └── HANDOVER_2026-03-01.md    # 引き継ぎメモ
```

---

## ⚙️ 運用ルール

### 1. ファイル配置原則
- **問題・解答の本体（TeX）**: `university_exam/` に配置
- **自動生成の作業ファイル（ログ、レポート、一覧）**: `scripts/` に配置
- **ドキュメント・ポリシー**: `scripts/docs/` に集約

### 2. TeX 規約
- **エンジン**: `lualatex`
- **ドキュメントクラス**: `jlreq`（日本語組版）
- **階層管理**: subfiles パッケージ（親→分野→中項目→細目）

### 3. Git 運用
- **PDF**: 必ずコミット（配布・プレビュー用）
- **中間ファイル**: .gitignore で自動除外（*.aux, *.log, *.synctex.gz）
- **コミットメッセージ**: `Add:`, `Fix:`, `Update:`, `Refactor:`, `Chore:`, `Doc:` プレフィックス使用

詳細は [docs/POLICIES.md](docs/POLICIES.md) を参照。

---

## 🔧 スクリプト詳細

### compile/

#### `compile_all.ps1`
全てのマスターファイルを一括コンパイル

**用途**:
- 親ファイル（`ps_q.tex`, `ps_a.tex`）
- 分野ファイル（`ps_me_q.tex`, `ps_em_q.tex`, ...）
- 中項目ファイル（`ps_em_cb_q.tex`, ...）

**実行**: `.\scripts\compile\compile_all.ps1`

#### `compile_all_standalone.ps1`
スタンドアロン図版を一括コンパイル

**用途**: `figures/` 配下の全独立図形をPDF化

**実行**: `.\scripts\compile\compile_all_standalone.ps1`

### migration/

#### `analyze_tex_packages.ps1`
全 TeX ファイルの `\usepackage` 使用状況を解析

**出力**: `scripts/migration/package_cleanup_report.md`

#### `cleanup_tikzlibraries.ps1`
TikZ ライブラリの使用状況を分析し、不要なライブラリを削除

**出力**: `scripts/migration/tikzlibrary_cleanup_details.md`

---

## 📚 ドキュメント一覧

| ファイル | 目的 | 行数 |
|---------|------|------|
| [README_STRUCTURE.md](README_STRUCTURE.md) | 構造ガイド | 243 |
| [docs/WORKFLOW.md](docs/WORKFLOW.md) | ワークフロー規則 | 270+ |
| [docs/POLICIES.md](docs/POLICIES.md) | 運用ポリシー | 190+ |
| [docs/STRUCTURE.md](docs/STRUCTURE.md) | 技術仕様（旧版） | - |
| [docs/HANDOVER_2026-03-01.md](docs/HANDOVER_2026-03-01.md) | 引き継ぎメモ | - |
| [PROGRESS-2026-03-03.md](PROGRESS-2026-03-03.md) | 進捗ログ | - |

---

## 🎯 今後の展望

### science-db リポジトリ統合計画
- **Phase 1** (2026年Q1): physics-standard 充実 ✅
- **Phase 2** (2026年Q2-Q3): chemistry-standard 追加
- **Phase 3** (2026年Q3-Q4): biology/earth-science 追加
- **Phase 4** (2026年Q4-): 統合リポジトリ完成

詳細は [README_STRUCTURE.md](README_STRUCTURE.md) を参照。

---

**このファイルは運用ハブです。迷ったらここに戻ってください。**
