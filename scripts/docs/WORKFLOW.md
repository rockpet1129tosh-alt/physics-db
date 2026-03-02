# science-db ワークフローガイド

**作成日**: 2026年3月3日  
**更新日**: 2026年3月3日

このドキュメントは、science-db リポジトリにおける日常的な作業フローを解説します。

---

## 全体フロー

```
編集 → コンパイル確認 → フィギュア更新確認 → Git 追加・コミット → Push
```

### 原則
- **問題・解答の編集後は、必ず親ファイルと個別ファイルの両方でコンパイルテスト**
- **PDF は Git 管理対象（変更点が明確）**
- **中間ファイルは .gitignore で自動除外（.log, .aux, .synctex.gz など）**

---

## 編集ワークフロー

### 1. 問題・解答の編集

#### 個別問題ファイルを編集する
```
university_exam/physics-standard/em_electromagnetism/circuit-basics/01_kirchhoff/ps_em_cb_01_q.tex
```

- `\documentclass[../../../ps_q.tex]{subfiles}` を使用
- `\subsection{キルヒホッフの法則}` で見出し定義
- 問題文を執筆

#### 図版を追加する
```
university_exam/physics-standard/em_electromagnetism/circuit-basics/01_kirchhoff/fig_em_cb_01/fig_em_cb_01_01_q.tex
```

- `standalone` documentclass を使用
- TikZ / CircuiTikZ で図形描画
- 個別コンパイルでPDF生成: `lualatex fig_em_cb_01_01_q.tex`

### 2. コンパイル

#### 個別コンパイル（開発時）
```powershell
cd university_exam/physics-standard/em_electromagnetism/circuit-basics/01_kirchhoff
lualatex ps_em_cb_01_q.tex
```

- **利点**: 高速、該当部分だけテスト
- **注意**: 親ファイルのプリアンブルを継承

#### 一括コンパイル（最終確認）
```powershell
cd c:\Users\selec\Documents\tex_all\science-db
.\scripts\compile\compile_all.ps1
```

- **内容**: 全親ファイル・全分野ファイル・全中項目ファイルをコンパイル
- **所要時間**: 約3〜5分
- **用途**: 全体整合性確認、PDF一括生成

#### 図形一括コンパイル
```powershell
.\scripts\compile\compile_all_standalone.ps1
```

- **内容**: `figures/` 配下の全てのスタンドアロン図形を一括コンパイル
- **用途**: ロゴ・共通図版の一括PDF化

---

## Git ワークフロー

### 通常の編集後（推奨手順）

```powershell
# 1. 状態確認
git status

# 2. 変更ファイル追加（PDF含む）
git add university_exam/physics-standard/em_electromagnetism/circuit-basics/01_kirchhoff/ps_em_cb_01_q.tex
git add university_exam/physics-standard/em_electromagnetism/circuit-basics/01_kirchhoff/ps_em_cb_01_q.pdf

# 3. コミット（メッセージ規約に従う）
git commit -m "Add: 電磁気・回路の基本・キルヒホッフの法則（問題）"

# 4. プッシュ
git push origin main
```

### コミットメッセージ規約

| プレフィックス | 用途 | 例 |
|-------------|------|-----|
| `Add:` | 新規問題・解答追加 | `Add: 力学・円運動・第03問` |
| `Fix:` | 誤記修正 | `Fix: 電磁気・電場・計算誤り修正` |
| `Update:` | 問題文整備 | `Update: 熱力学・用語統一` |
| `Refactor:` | 構造変更 | `Refactor: 分野マスターに\part追加` |
| `Chore:` | 環境・ドキュメント更新 | `Chore: .gitignore更新` |
| `Doc:` | ドキュメント専用 | `Doc: WORKFLOW.md作成` |

**日本語推奨**: 内容が分野・項目を含む場合は日本語で明記

### 中間ファイルの扱い

#### .gitignore に登録済み（自動除外）
```
*.aux
*.log
*.synctex.gz
*.fls
*.fdb_latexmk
*.out
*.toc
*.nav
*.snm
*.vrb
```

#### 万一追跡されている場合（削除手順）
```powershell
# 追跡から除外（ファイルは残る）
git rm --cached -r university_exam/**/*.aux
git rm --cached -r university_exam/**/*.log
git rm --cached -r university_exam/**/*.synctex.gz

# コミット
git commit -m "Chore: Remove LaTeX intermediate files from tracking"
git push
```

---

## トラブルシューティング

### コンパイルエラー

#### 症状: `! LaTeX Error: File '...tex' not found.`
**原因**: 相対パスの階層数が不一致

**解決策**:
1. コンパイル実行ディレクトリを確認
2. `\documentclass[../../../ps_q.tex]{subfiles}` の階層が正しいか確認
3. 親ファイルからの相対パスで subfile が正しく指定されているか確認

#### 症状: `! Undefined control sequence. \usetikzlibrary`
**原因**: スタンドアロン図版に TikZ ライブラリが不足

**解決策**:
1. 図形ファイルに `\usetikzlibrary{arrows.meta,calc}` を追加
2. 円弧・角度記法を使う場合は `angles,quotes` も追加
3. 交点計算を使う場合は `intersections` も追加

#### 症状: `! Package circuitikz Error: Unknown component 'american inductors'`
**原因**: `circuitikz` の設定不備

**解決策**:
```tex
\usepackage[american inductors]{circuitikz}
```

### Git 操作

#### 症状: 中間ファイルが `git status` に表示される
**原因**: .gitignore に未登録

**解決策**:
```powershell
# ルートの .gitignore に追加
echo "*.aux" >> .gitignore
git add .gitignore
git commit -m "Chore: Update .gitignore"
```

#### 症状: 大量のファイルが `Changes not staged for commit` に表示
**原因**: 不要なファイルがまだ追跡されている

**解決策**:
```powershell
# 全中間ファイルを一括削除
git rm --cached -r **/*.aux **/*.log **/*.synctex.gz
git commit -m "Chore: Remove all intermediate files"
git push
```

---

## 自動化スクリプト

### コンパイル系

#### `scripts/compile/compile_all.ps1`
**用途**: 全てのマスターファイルを一括コンパイル

**実行**:
```powershell
.\scripts\compile\compile_all.ps1
```

**説明**:
- `ps_q.tex`, `ps_a.tex`（全体マスター）
- 各分野マスター（`ps_me_q.tex`, `ps_em_q.tex`, ...）
- 各中項目マスター（`ps_em_cb_q.tex`, ...）

#### `scripts/compile/compile_all_standalone.ps1`
**用途**: 全てのスタンドアロン図形を一括コンパイル

**実行**:
```powershell
.\scripts\compile\compile_all_standalone.ps1
```

**説明**: `figures/**/*.tex` を探索し、全図版をPDF化

### 移行・最適化系

#### `scripts/migration/analyze_tex_packages.ps1`
**用途**: 全 TeX ファイルの使用パッケージ一覧作成

**実行**:
```powershell
.\scripts\migration\analyze_tex_packages.ps1
```

**出力**: `scripts/migration/package_cleanup_report.md`

#### `scripts/migration/cleanup_tikzlibraries.ps1`
**用途**: TikZ ライブラリの使用状況を分析し、不要なものを削除

**実行**:
```powershell
.\scripts\migration\cleanup_tikzlibraries.ps1
```

**出力**: `scripts/migration/tikzlibrary_cleanup_details.md`

---

## 日常作業パターン

### 新規問題追加
1. `university_exam/physics-standard/[分野]/[中項目]/[問題番号]_topic/` フォルダ作成
2. `ps_[分野]_[中項目]_[番号]_q.tex` 作成（問題文）
3. `ps_[分野]_[中項目]_[番号]_a.tex` 作成（解答）
4. 図版フォルダ `fig_[分野]_[中項目]_[番号]/` 作成（必要なら）
5. 親ファイル（中項目マスター）に `\subfile{...}` 追加
6. コンパイル確認
7. Git 追加・コミット・プッシュ

### 図版追加・更新
1. 図版フォルダ内に `fig_[分野]_[中項目]_[番号]_[図番]_[q/a].tex` 作成
2. スタンドアロンでコンパイル確認
3. 本文から `\includegraphics{fig_[分野]_[中項目]_[番号]/fig_[分野]_[中項目]_[番号]_[図番]_q.pdf}` で参照
4. Git 追加（`.tex` と `.pdf` 両方）

### 分野横断的な変更
1. 親ファイル（`ps_q.tex`, `ps_a.tex`）のプリアンブル修正
2. `.\scripts\compile\compile_all.ps1` で全体コンパイル
3. エラー確認
4. Git コミット（`Refactor: パッケージ設定変更`）

---

## サブモジュール運用（将来）

将来の science-db 統合時には、各科目をサブモジュールとして管理する可能性があります：

```powershell
# physics-standard を科目サブモジュールとして登録
git submodule add https://github.com/user/physics-standard.git university_exam/physics-standard

# 更新
git submodule update --remote
```

詳細は統合時に改めて定義します。

---

**次のステップ**: [scripts/docs/POLICIES.md](docs/POLICIES.md) で運用ポリシーを確認  
**困ったら**: [scripts/docs/HANDOVER_2026-03-01.md](docs/HANDOVER_2026-03-01.md) の経緯を参照
