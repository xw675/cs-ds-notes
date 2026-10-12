---
unit: MUIG-AAP
week: [0, 3]
source: [slides, reading]
parent: "[[Target Price and Valuation Triangulation]]"
tags: [Finance/Valuation, Finance/Risk]
aliases: [Sensitivity Analysis, Scenario Analysis, Bull Base Bear, Monte Carlo, WACC TGR Grid]
---
# [[Sensitivity and Scenario Analysis]]

**Context:** [[MUIG_AAP_MOC]] · "a model is only as good as the assumptions inside it" — precision is not accuracy · Session 6 of the IAP arc ("what breaks")

> [!abstract] Quick Revision
> - **🎯 Objective:** **sensitivity** = move **one** input at a time ➔ *which input matters most?* · **scenario** = move a **coherent set** together (bull/base/bear) ➔ *what is the range, and how bad is bad?*
> - **⚠️ Key Constraint:** state the **break-even** — how far an input must move to flip the call (e.g. TNB needs WACC 8.3% or TGR 0.5% for a HOLD).

## 📝 Core
### 1. One-way sensitivity (Fundamentals, illustrative only)
| Aluminium price (USD/t) | 2,800 | 3,000 | 3,200 | 3,400 | 3,600 |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Press Metal fair value (RM) | 6.20 | 7.40 | 8.60 | 9.80 | 11.00 |
- **Read** ➔ every USD200/t moves value RM1.20 (~14% of the 8.60 base) ➔ LME price is the largest swing factor.

### 2. Two-way grid — WACC × terminal growth (TNB report, RM per share)
| WACC \ TGR | 0.5% | 1.0% | 1.5% | 2.0% | 2.5% |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 6.33% | 17.10 | 19.37 | 22.11 | 25.49 | 29.74 |
| 6.83% | 14.71 | 16.59 | 18.82 | 21.51 | 24.82 |
| **7.33%** | 12.67 | 14.25 | **16.09** | 18.27 | 20.91 |
| 7.83% | 10.91 | 12.25 | 13.79 | 15.60 | 17.74 |
| 8.33% | 9.38 | 10.52 | 11.83 | 13.34 | 15.12 |
- **Argument** ➔ HOLD needs WACC → 8.3% **or** TGR → 0.5%; SELL needs both ➔ judged remote for a regulated monopoly with stable borrowing costs (4.47–4.76%) ➔ call is robust.
- **DOM** ➔ +1 pt WACC cuts price ~15%.

### 3. Scenarios
- **Coherent sets** ➔ DOM bear/base/bull: TGR 0.6 / 1.0 / 1.7%, 2030 gross margin 24 / 27 / 30%, deliveries −3% / base / +2% — **WACC held at 9.0%** in all three (scenarios move operations, not the discount rate).
- **Probability weighting** ➔ P&G: base 50%, bear 35%, bull 15% (bear > bull: already rated above peers + recession fears).
- **Range reporting** ➔ FedEx target range bear–bull USD225–361, base 292.
- **Monte Carlo** ➔ DOM: 10,000 iterations varying margins, WACC, growth, deliveries simultaneously ➔ distribution of values.

## ⚠️ Common Mistakes
- 💡 **Incoherent scenarios** ➔ a "bull" case with high growth *and* low capex *and* low WACC that couldn't co-occur.
- 💡 **Grid without a verdict** ➔ the table is evidence; the marks are for "what would have to be true to change the call".

## 🧠 Active Recall
> [!FAQ]- Sensitivity vs scenario — which answers "which input matters most?" and which answers "how bad is bad?"
> > [!SUCCESS]- Answer
> > - **Short answer:** sensitivity → which input matters; scenario → range / downside.
> > - **Why:** **One-at-a-time vs joint** ➔ isolating one variable ranks inputs by impact; moving a consistent set of assumptions together (bear economy ➔ lower volume *and* margin) shows the realistic range.
