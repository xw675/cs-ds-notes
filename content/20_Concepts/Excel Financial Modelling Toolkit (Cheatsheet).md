---
unit: MUIG-AAP
parent: "[[MUIG_AAP_MOC]]"
tags: [Tool/Excel, Finance/Modelling]
type: cheatsheet
aliases: [Excel Modelling Toolkit, Financial Modelling Excel Formulas]
---
# [[Excel Financial Modelling Toolkit (Cheatsheet)]]

**Context:** [[MUIG_AAP_MOC]] · enough to rebuild the Company A model from a blank workbook · depth in [[Financial Model Conventions (Excel)]], [[Forecasting Drivers (Revenue and Cost)]], [[Depreciation Schedule (Existing and New PPE)]], [[Working Capital Schedule (Days Method)]], [[Debt and Interest Schedule]], [[DCF Valuation (FCFF)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** inputs → schedules → P&L → BS → CF → check → DCF, one formula per row copied across years.
> - **⚠️ Key Constraint:** anchors (`$`) and column alignment — most model bugs are a reference that drifted (spacer column, wrong row) rather than wrong finance.

## 🧩 Workflow Anatomy (execution order)
1. **Load actuals** (hardcodes from the AFS, costs negative, RM'000) ➔ P&L, BS, CF, detailed opex with category tags.
2. **Ratios on history** ➔ growth, margins, % of revenue / staff cost, days, implied unit price & salary.
3. **Choose drivers** (assumption inputs) ➔ growth rates, % ratios, days, tax rate, capex %, life.
4. **Schedules** ➔ depreciation · working capital · debt & interest · minimum cash / equity injection.
5. **P&L forecast** ➔ revenue → COGS → GP → opex → EBIT → interest → PBT → tax → PAT; EBITDA & core lines.
6. **BS forecast** ➔ PPE corkscrew, AR/AP from days, debt from schedule, RE corkscrew, cash ← CF.
7. **CF forecast** ➔ PBT + D&A ± WC − tax → CFI capex → CFF dividends/debt/equity → closing cash.
8. **Check row** `=ROUND(TA-(TL+TE),3)` ➔ 0 in every column.
9. **DCF block** ➔ NOPAT + D&A ± ΔNWC − capex → TV → discount → EV → net debt → equity → implied multiples.

## 🔧 Formula Table
| Tool | Micro-syntax | Job / gotcha |
| :--- | :--- | :--- |
| Growth | `=M9/L9-1` | YoY %; returns `#DIV/0!` on empty forecast cells — fine until filled |
| Roll forward | `=L38*(1+M39)` | prior year × (1+g) |
| 3-yr average | `=AVERAGE(J41:L41)` | relative range slides with the column — check dispersion first |
| % of driver | `=M9*M47` | variable costs, capex, D&A |
| Margin | `=M11/M$9` | row-locked denominator |
| Category mapping | `=SUMIFS(H$167:H$218,$S$167:$S$218,$C46)` | tag column + label; totals must reconcile |
| Tax floor | `=IF(M20<0,0,-M20*M63)` | no tax credit on losses (simplification) |
| Run-off depreciation | `=-MIN(M19,$G20)` | never below zero NBV |
| Vintage waterfall | `=IF(M$5>=$D32,MIN($E32-SUM($L32:L32),$E32/$G$31),0)` | expanding `SUM($L32:L32)` = cumulative charged |
| Balance from days | `=L104*L164/365` | AR on revenue, AP on COGS |
| Repayment cap | `=-MIN(ABS($J$180),L176-L178)` | stop at zero balance |
| Average-balance interest | `=AVERAGE(M106,M108)*$G110` | circular if repayment depends on cash |
| Equity injection | `=IF(M158<M160,MAX(M160,M160-M158),0)` | funds cash below 2 months' opex |
| Discount factor | `=1/(1+$G$263)^(SUM($M259:M259))` | cumulative year counter; 0.5 for stubs |
| Terminal value | `=Q253*(1+$G$264)/($G$263-$G$264)` | lock both rates |
| Balance check | `=ROUND(H97-H78,3)` | rounding avoids 1E-13 noise |
| Days in year | row 4: 365 / 366 | leap years (FY24, FY28) in the days formulas |

## ⚠️ Top Traps (found in the workshop answer files)
- 💡 **Wrong link target** ➔ DCF capex `=M145` (financing total) instead of `=M136` (purchases of PPE).
- 💡 **Sign in the bridge** ➔ `=SUM(EV, NetDebt)` instead of `=EV-NetDebt`.
- 💡 **CAPM typed as `=Rf+Beta*Rf`** ➔ should be `=Rf+Beta*(Rm-Rf)`.
- 💡 **Spacer column** ➔ FY27 working-capital change referencing blank column K.
- 💡 **Unlinked schedule** ➔ depreciation schedule built but P&L still on % of revenue.

## ✏️ Integration Exercises
> [!QUESTION]- Exercise 1: Starting from FY25 actuals, wire revenue (volume × price), COGS %, capex %, D&A schedule and a constant-NWC balance sheet for FY26, and prove the check row is 0.
> > [!SUCCESS]- Reference solution
> > - Revenue `=M38*M40` → COGS `=M9*M43` → … → PAT; PPE `=L70+M102+M57`; RE `=L95+M24+M142`; cash `=M150`.
> > - CF: PBT + D&A (`=-M57`) + WC (0) − tax (`=M23`) − capex (`=-M102`).
> > - **Key move:** D&A appears three times (P&L, CF add-back, PPE corkscrew) from **one** source cell — that's what keeps the check at 0.

> [!QUESTION]- Exercise 2: Audit a DCF block whose EV/EBITDA comes out at 37x. List the four cells you check first.
> > [!SUCCESS]- Reference solution
> > - Capex link in FCFF · $K_e$ formula · TV denominator `WACC−g` · EV→equity sign.
> > - **Key move:** implausible implied multiples are an audit signal, not a valuation result ([[DCF Valuation (FCFF)]]).
