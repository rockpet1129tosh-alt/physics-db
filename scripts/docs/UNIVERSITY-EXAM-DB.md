# 大学入試DBの確定構成メモ

**最終更新**: 2026年4月5日

この文書は、science-db における **大学入試向け理科DB** の最終的な構成方針をまとめたメモです。

---

## 1. 管理対象

このリポジトリでは、大学入試向けの理科3科目を扱います。

- `physics/`
- `chemistry/`
- `biology/`

フォルダ順は **教科 → 大学 → 年度 → 試験セット → 大問** を採用します。

---

## 2. 推奨フォルダ構成

```text
university_exam/
├── physics/
│   ├── standard/
│   │   ├── uem_phy_std_0master.tex
│   │   ├── uem_phy_std_q.tex
│   │   ├── uem_phy_std_a.tex
│   │   └── ...
│   ├── okayama-u/
│   │   ├── uem_phy_oka_0master.tex
│   │   ├── uem_phy_oka_q.tex
│   │   ├── uem_phy_oka_a.tex
│   │   └── 2025/
│   │       ├── uem_phy_oka_2025_q.tex
│   │       ├── uem_phy_oka_2025_a.tex
│   │       ├── oka_2025_uni/
│   │       │   ├── uem_phy_oka_2025_uni_q.tex
│   │       │   ├── uem_phy_oka_2025_uni_a.tex
│   │       │   ├── 01/
│   │       │   └── _original/
│   │       └── meta/
│   └── tokyo-u/
├── chemistry/
└── biology/
```

---

## 3. シリーズ識別子

- `uem` = **大学入試向け**
- `hsm` = **高校入試向け**

この区別を明示するため、オリジナル標準演習にも `uem` を残します。

例:
- `uem_phy_std_q.tex` = 大学入試向け・物理・標準演習・問題編
- `uem_phy_oka_q.tex` = 大学入試向け・物理・岡山大・問題編

---

## 4. 命名規則

基本形:

```text
[series]_[subject]_[target]_[year]_[set]_[problem]_[mode].tex
```

### コード

| 区分 | 例 | 意味 |
|---|---|---|
| `series` | `uem` | 大学入試向け |
| `subject` | `phy`, `che`, `bio` | 物理・化学・生物 |
| `target` | `std`, `oka`, `tok` | 標準演習・大学コード |
| `year` | `2025` | 年度 |
| `set` | `uni` | 試験セット |
| `problem` | `01`, `02` | 大問番号 |
| `mode` | `q`, `a` | 問題・解答 |

### 例

- `uem_phy_std_0master.tex`
- `uem_phy_std_q.tex`
- `uem_phy_std_me_q.tex`
- `uem_phy_std_em_cb_01_q.tex`
- `uem_phy_oka_2025_uni_01_q.tex`

---

## 5. `0master` / `q-a` 運用

- `uem_*_0master.tex` は **共通プリアンブル断片**
- 実際に直接ビルドする親は `uem_*_q.tex` / `uem_*_a.tex`
- 子ファイルは `subfiles` で **必ずルートの `q/a` 親**を参照する
- `*_0master.tex` は単体コンパイルしない

---

## 6. 試験セット名

既定の試験セット名は **`uni`** を使います。

例:
- `oka_2025_uni/`
- `uem_phy_oka_2025_uni_q.tex`
- `uem_phy_oka_2025_uni_01_q.tex`

将来必要になれば `med`, `sci`, `agr` などを追加できます。
