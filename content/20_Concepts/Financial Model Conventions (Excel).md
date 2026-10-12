---
unit: MUIG-AAP
week: 2
source: [applied]
parent: "[[Three-Statement Model (Linkages)]]"
tags: [Finance/Modelling, Tool/Excel]
aliases: [Model Layout, Hardcode vs Formula, SUMIFS Mapping]
type: pattern
---
# [[Financial Model Conventions (Excel)]]

**Context:** [[MUIG_AAP_MOC]] · the house rules of the Company A workbook (Prelude sheet) · reach for these before writing a single forecast formula
**Problem it solves:** a model others (and future-you) can audit — every number is visibly a hardcode, an assumption, a formula, or a link.

> [!abstract] Quick Revision
> - **🎯 Trigger:** building or auditing any sheet ➔ separate **inputs** from **calculations**, keep years in columns, end every statement with a **check row**.
> - **⚠️ Key Constraint:** **"3 Statement MUST balance"** — $\text{Total assets} - (\text{Liabilities} + \text{Equity}) = 0$ every year, or something upstream is wrong.

## 🔧 Minimal Working Example
**Cell types (colour-coded in the Prelude):**
| Type | Meaning | Example |
| :--- | :--- | :--- |
| Hardcode | historical figure typed from the AFS | FY25 revenue `22495.994` |
| Assumption input | a forecast driver you choose and must defend | tax rate `0.24`, terminal growth `0.03` |
| Formula | calculated in-sheet | `=SUM(M9:M10)` |
| Linkage | pulled from another sheet | `=Model!H10` |

**Layout:** units `RM'000 unless otherwise stated` · FYE June · FY21–FY25 actuals, FY26–FY30 forecast in columns · each statement followed by an *Assumptions & Calculations* block · a `Source:` column (S) explaining each driver in words.

**Mapping 50+ detailed opex lines into 6 categories (tag column S, then SUMIFS):**
```excel
=SUMIFS(H$167:H$218, $S$167:$S$218, $C46)
```
- `H$167:H$218` ➔ the year's detailed opex lines (row-locked, column floats across years).
- `$S$167:$S$218` ➔ category tag per line, e.g. *Staff & Employee Costs*.
- `$C46` ➔ the category label on the summary row.

**Balance check:**
```excel
=ROUND(H97-H78, 3)     → 0 every year
```
**Expected output:** category totals reconcile to *TOTAL OPERATING EXPENSES* (`=SUM(H167:H218)`), check row = 0.

## ✏️ Practice
> [!QUESTION]- Practice 1: Row 9 holds revenue, row 10 cost of sales (negative). Write gross profit and gross margin for column M so they copy right across FY26–FY30.
> > [!SUCCESS]- Reference solution
> > ```excel
> > M11: =SUM(M9:M10)
> > M12: =M11/M$9
> > ```
> > - **Key move:** costs stored **negative** so profit lines are plain `SUM`s; `$9` row-lock lets the margin row copy down to other subtotals.

## ⚠️ Common Mistakes
- 💡 **Hardcoding inside forecasts** ➔ typing a number into a formula row hides an assumption; put it in an input cell.
- 💡 **Sign drift** ➔ the AFS shows costs positive; the model stores them negative — flip once, at entry.
- 💡 **Silent spacer columns** ➔ a blank separator column between actuals and forecasts breaks "previous year" references (see [[Working Capital Schedule (Days Method)]]).
