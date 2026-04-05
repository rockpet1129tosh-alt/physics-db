# science-db フォルダ構造ガイド

**作成日**: 2026年3月3日  
**更新日**: 2026年4月5日

## 概要

このリポジトリは、大学入試物理の問題・解答データベースです。  
`math-db` の設計理念を踏襲し、階層的な subfiles 構造を採用しています。

### 運用ルール（重要）
- 一括処理で自動生成される作業用ファイル（ログ、一覧、移行補助ファイル、臨時出力など）は、原則としてすべて `scripts/` 配下に配置する。
- 問題・解答の本体ソース（TeX）は `university_exam/` に配置し、`scripts/` には置かない。
- ドキュメント・ポリシー・ワークフローは `scripts/docs/` に集約する。

---

## フォルダ構造

```
science-db/
├── README.md                         # 【入口】リポジトリ概要・クイックリンク
│
├── figures/                          # TikZ図形・ロゴ
│   ├── logo_miyoshi_1~5/            # 三好ロゴ（5種類）
│   └── logo_physics_1~6/            # 物理ロゴ（6種類）
│
├── university_exam/
│   ├── physics-standard/             # 現行の物理標準問題集（段階的に再編予定）
│   │   │
│       ├── ps_q.tex                  # 【全体マスター】全分野・全問題
│       ├── ps_a.tex                  # 【全体マスター】全分野・全解答
│       │
│       ├── me_mechanics/             # 力学
│       │   ├── ps_me_q.tex           # 【分野マスター】力学・全問題
│       │   ├── ps_me_a.tex           # 【分野マスター】力学・全解答
│       │   ├── eom-constraints/      # 運動方程式・束縛条件
│       │   │   ├── ps_me_ec_q.tex    # 【中項目】問題
│       │   │   ├── ps_me_ec_a.tex    # 【中項目】解答
│       │   │   └── XX_topic/         # 【細目】個別問題
│       │   │       ├── ps_me_ec_XX_q.tex
│       │   │       ├── ps_me_ec_XX_a.tex
│       │   │       └── fig_me_ec_XX/ # 図版
│       │   ├── time-tracking/        # 時間追跡
│       │   ├── mechanical-energy/    # 力学的エネルギー
│       │   ├── circular-motion/      # 円運動
│       │   ├── multibody/            # 多体問題
│       │   ├── collision/            # 衝突
│       │   ├── celestial-mechanics/  # 天体力学
│       │   ├── cog/                  # 重心
│       │   ├── rigid-body/           # 剛体
│       │   └── moving-coordinate-system/ # 移動座標系
│       │
│       ├── th_thermodynamics/        # 熱力学
│       │   ├── ps_th_q.tex           # 【分野マスター】熱力学・全問題
│       │   ├── ps_th_a.tex           # 【分野マスター】熱力学・全解答
│       │   ├── thermodynamics-basic/
│       │   ├── thermodynamics-exception/
│       │   └── thermodynamics-extent/
│       │
│       ├── em_electromagnetism/      # 電磁気
│       │   ├── ps_em_q.tex           # 【分野マスター】電磁気・全問題
│       │   ├── ps_em_a.tex           # 【分野マスター】電磁気・全解答
│       │   ├── electric-field/       # 電場
│       │   │   ├── ps_em_ef_q.tex
│       │   │   ├── ps_em_ef_a.tex
│       │   │   └── XX_topic/
│       │   ├── circuit-basics/       # 回路の基本（12項目）
│       │   ├── circuit-extent/       # 回路の応用
│       │   ├── circuit-energy/       # 回路とエネルギー
│       │   ├── magnetic-field/       # 磁場
│       │   ├── emf/                  # 起電力
│       │   ├── emi/                  # 電磁誘導
│       │   └── coil/                 # コイル
│       │
│       ├── wa_wave/                  # 波
│       │   ├── ps_wa_q.tex
│       │   ├── ps_wa_a.tex
│       │   └── wave-mechanics/
│       │
│       └── mp_modernphysics/         # 原子物理
│           ├── ps_mp_q.tex
│           ├── ps_mp_a.tex
│           └── quantum-mechanics/
│
│   └── physics/                      # 大学入試DB（教科 → 大学）
│       └── okayama-u/
│           ├── uem_phy_oka_0master.tex
│           ├── uem_phy_oka_q.tex
│           ├── uem_phy_oka_a.tex
│           └── 2025/
│               └── oka_2025_uni/
│
└── scripts/                          # 運用ハブ
    ├── README.md                     # 【HUB】運用ハブ・入口
    ├── compile/                      # コンパイルスクリプト
    │   ├── compile_all.ps1
    │   ├── compile_all_standalone.ps1
    │   └── compile_all_tikz.ps1
    │
    ├── migration/                    # 移行・最適化スクリプト
    │   ├── *.ps1                     # 各種マイグレーションツール
    │   └── reports/                  # 作業レポート・生成物
    │       ├── *.md
    │       └── deleted_tikz_files.txt
    │
    └── docs/                         # ドキュメント集約
        ├── README.md                 # docs 索引
        ├── README_STRUCTURE.md       # 構造ガイド（このファイル）
        ├── UNIVERSITY-EXAM-DB.md     # 大学入試DBの構成・命名規則
        ├── POLICIES.md               # Git管理・運用ポリシー
        ├── WORKFLOW.md               # ワークフロー規則
        ├── SUBFILES-GUIDE.md         # subfiles 詳細ガイド
        └── history/
            ├── HANDOVER_2026-03-01.md
            ├── PROGRESS-2026-03-03.md
            └── STRUCTURE.md
```

---

## 命名規則

### プロジェクト識別子
- `ps` = **physics-standard**（物理標準問題集）

### 分野コード（2文字）

| コード | 分野名 | 英語名 |
|--------|--------|--------|
| `me` | 力学 | Mechanics |
| `th` | 熱力学 | Thermodynamics |
| `em` | 電磁気 | Electromagnetism |
| `wa` | 波 | Wave |
| `mp` | 原子物理 | Modern Physics |

### 中項目略称（2文字）

**力学（me）の例：**
- `ec` = eom-constraints（運動方程式・束縛条件）
- `tt` = time-tracking（時間追跡）
- `en` = mechanical-energy（力学的エネルギー）
- `cm` = circular-motion（円運動）
- `mb` = multibody（多体問題）
- `cl` = collision（衝突）
- `ct` = celestial-mechanics（天体力学）
- `cg` = cog（重心）
- `rb` = rigid-body（剛体）
- `mc` = moving-coordinate-system（移動座標系）

**電磁気（em）の例：**
- `ef` = electric-field（電場）
- `cb` = circuit-basics（回路の基本）
- `cx` = circuit-extent（回路の応用）
- `ce` = circuit-energy（回路とエネルギー）
- `mf` = magnetic-field（磁場）
- `eg` = emf（起電力）
- `ei` = emi（電磁誘導）
- `co` = coil（コイル）

### 図版命名規則

```
fig_[分野コード]_[中項目略称]_[問題番号]_[図番号]_[q/a].tex

例：
fig_em_ef_04_03_a.tex  # 電磁気・電場・第04問・図03・解答版
fig_me_cm_01_01_q.tex  # 力学・円運動・第01問・図01・問題版
```

---

## subfiles 構造

問題・解答は **3～4階層の subfiles 構造** になっています：

### 階層1: 全体マスター（最上位）
**ファイル**: `ps_q.tex`, `ps_a.tex`

- 全分野を一括編集・コンパイル
- ヘッダー・フッター・パッケージ設定を一元管理
- 5つの分野ファイルを subfile で参照

```tex
\documentclass[jlreq]{...}
% パッケージ・設定

\begin{document}
    \subfile{me_mechanics/ps_me_q.tex}
    \subfile{th_thermodynamics/ps_th_q.tex}
    \subfile{em_electromagnetism/ps_em_q.tex}
    \subfile{wa_wave/ps_wa_q.tex}
    \subfile{mp_modernphysics/ps_mp_q.tex}
\end{document}
```

### 階層2: 分野マスター
**ファイル**: `ps_me_q.tex`, `ps_em_q.tex`, ...

- 各分野（力学、電磁気など）の全問題・解答
- `\part{分野名}` で大見出し定義
- 中項目ファイルを subfile で参照

```tex
\documentclass[../ps_q.tex]{subfiles}

\begin{document}

\part{力学}

\subfile{eom-constraints/ps_me_ec_q.tex}
\subfile{circular-motion/ps_me_cm_q.tex}
...

\end{document}
```

### 階層3: 中項目マスター
**ファイル**: `ps_em_cb_q.tex`, `ps_me_ec_q.tex`, ...

- 各中項目（回路の基本、電場など）の全問題・解答
- `\section{中項目名}` で見出し定義
- 細目ファイルを subfile で参照（または直接記述）

```tex
\documentclass[../../ps_q.tex]{subfiles}

\begin{document}

\section{回路の基本}

\subfile{01_kirchhoff/ps_em_cb_01_q.tex}
\subfile{02_charge-conservation-1/ps_em_cb_02_q.tex}
...

\end{document}
```

### 階層4: 細目ファイル（最下層）
**ファイル**: `ps_em_cb_01_q.tex`, ...

- 実際の問題文・解答が記述されているファイル
- subfiles document class で独立コンパイル可能
- 図版は問題ごとのフォルダ（`fig_em_cb_01/`）に配置

```tex
\documentclass[../../../ps_q.tex]{subfiles}

\begin{document}

\subsection{キルヒホッフの法則}

% 問題文
...

\end{document}
```

---

## 図版管理

### スタンドアロン図版
- **配置**: 各問題フォルダ内に `fig_[分野]_[中項目]_[問題]_[図番]/` を作成
- **ファイル**: `fig_em_cb_01_01_q.tex` など（独立したstandalone）
- **コンパイル**: 個別にPDF生成可能

### 共通図版（ロゴ）
- **配置**: `figures/logo_miyoshi_*/`, `figures/logo_physics_*/`
- **参照**: 親ファイルから相対パス `../../figures/logo_miyoshi_1/logo_miyoshi_1.pdf`

---

## TeX コンパイル規約

### エンジン・ドキュメントクラス
- **エンジン**: `lualatex`（日本語対応、フォント管理効率化）
- **ドキュメントクラス**: `jlreq`（日本語組版標準）
- **図形スタイル**: `standalone`（TikZ図の独立コンパイル用）

### 親ファイルのパッケージ構成

```tex
\documentclass[fleqn,head_space=14mm,foot_space=14mm,...]{jlreq}

% 日本語処理
\usepackage[deluxe,match,jfm_yoko=jlreq,jfm_tate=jlreqv]{luatexja-preset}
\usepackage{luatexja-otf}

% 図形
\usepackage{tikz}
\usetikzlibrary{patterns,arrows.meta,calc}

% 数学
\usepackage{amsmath,amssymb}
\usepackage[italicdiff]{physics}

% レイアウト
\usepackage{enumitem}
\usepackage{caption}
\usepackage{graphicx}
\usepackage{needspace}
\usepackage{ulem}

% マルチファイル
\usepackage{subfiles}

% ページスタイル
\usepackage{titleps}
```

**注**: このルールは `math-db` と共通です。

### スタンドアロン図版のパッケージ

```tex
\documentclass[lualatex]{standalone}
\usepackage{tikz}
\usetikzlibrary{angles,quotes,arrows.meta,calc,intersections}
\usepackage{circuitikz}  % 回路図の場合
\usepackage{amsmath}
\usepackage{luatexja}

\begin{document}
\begin{tikzpicture}
% 図形描画
\end{tikzpicture}
\end{document}
```

---

## 統計情報

### 現在の実装状況

| 分野 | 中項目数 | 細目フォルダ数 | スタンドアロン図数 | 状態 |
|------|---------|--------------|-----------------|------|
| 力学 | 10 | - | - | 🔄 整備中 |
| 熱力学 | 3 | - | - | 🔄 整備中 |
| 電磁気 | 8 | 12+（circuit-basics内） | 39+ | ✅ 高度最適化済 |
| 波 | 1 | - | - | 🔄 整備中 |
| 原子物理 | 1 | - | - | 🔄 整備中 |

### PDFコンパイル実績
- **親ファイル**: `ps_q.pdf`, `ps_a.pdf` ✅
- **分野別**: 各分野のPDFコンパイル成功 ✅
- **スタンドアロン図**: 39/39図形コンパイル成功 ✅

---

## 最適化履歴

### 2026-03-01
- 不要な LaTeX パッケージ削除（4個）
- TikZ ライブラリ最適化（31ファイル）
- `calc` ライブラリ追加（`let...in` 構文対応）

### 2026-03-03
- `\part{分野名}` による階層構築
- 分野名表記統一（電磁気学→電磁気、現代物理→原子物理）
- GitHub運用最適化（ドキュメント構造整備）

---

## 将来の拡張: science-db への統合

### 長期ビジョン

このプロジェクトは、最終的に **science-db** リポジトリの一部となります。

```
science-db/
├── university_exam/
│   ├── physics-standard/         ← このプロジェクト（既存）
│   │   ├── em_electromagnetism/
│   │   ├── me_mechanics/
│   │   ├── wa_wave/
│   │   ├── th_thermodynamics/
│   │   └── mp_modernphysics/
│   │
│   ├── chemistry-standard/       ← 将来追加（Phase 2）
│   │   ├── or_organic-chemistry/
│   │   ├── in_inorganic-chemistry/
│   │   └── ...
│   │
│   ├── biology-standard/         ← 将来追加（Phase 3）
│   └── earth-science-standard/   ← 将来追加（Phase 3）
│
└── high-school-exam/
    ├── physics-chemistry/        ← 物理・化学混在（Phase 3）
    ├── biology-earth-science/    ← 生物・地学混在（Phase 4）
    └── integrated-science/       ← 全科目統合問題（Phase 4）
```

### マイルストーン

| フェーズ | タイムライン | 内容 |
|---------|------------|------|
| **Phase 1** | 2026年Q1 | physics-standard 充実（電磁気・力学）✅ |
| **Phase 2** | 2026年Q2-Q3 | chemistry-standard 追加 |
| **Phase 3** | 2026年Q3-Q4 | high-school-exam/physics-chemistry 統合問題 |
| **Phase 4** | 2026年Q4- | science-db リポジトリ統合完了 |

---

**最終更新**: 2026年3月3日  
**管理者**: science-db チャット（Copilot）
