---
unit: MUIG-AAP
week: 2
source: [applied]
parent: "[[Three-Statement Model (Linkages)]]"
tags: [Finance/Modelling, Tool/Excel]
aliases: [Revenue Build, Volume x Price, Cost Drivers, Operating Drivers]
type: pattern
---
# [[Forecasting Drivers (Revenue and Cost)]]

**Context:** [[MUIG_AAP_MOC]] · first block of any forecast · where the [[Business Model Analysis]] becomes numbers
**Problem it solves:** forecast each line from the **driver that actually causes it**, not from a blanket growth rate.

> [!abstract] Quick Revision
> - **🎯 Trigger:** forecasting a P&L line ➔ ask *what causes this cost/revenue?* ➔ volume × price for revenue; % of revenue for variable costs; headcount × salary for staff; % of staff cost for staff-linked overheads.
> - **⚠️ Key Constraint:** a 3-year average is a **starting point, not an answer** — the workbook itself notes *"average of last 3 years inconclusive, to search for alternative data"*.

## 🔧 Minimal Working Example
**Revenue = Quantity × Average Selling Price (ASP derived as revenue ÷ volume)**
```excel
Volume_t   = Volume_{t-1} * (1 + g_vol)      ' M38: =L38*(1+M39)
ASP_t      = ASP_{t-1}    * (1 + g_price)    ' M40: =L40*(1+M41)
g_price    = AVERAGE(J41:L41)                 ' last 3 years YoY
Revenue_t  = Volume_t * ASP_t                 ' M9:  =M38*M40
```
**Cost drivers used in the Company A model:**
| Line | Driver | Formula shape |
| :--- | :--- | :--- |
| Cost of sales | % of revenue (held at FY25 85.2%) | `=M9*M43` |
| Selling, marketing & advertising | % of revenue ("more marketing, more sales") | `=M9*M47` |
| Staff & employee costs | headcount × monthly salary × 12 / 1000 | `=-M51*M53*12/1000` |
| Professional fees · office & admin · travel | % of **staff cost** | `=M49*M$50` |
| D&A | % of revenue (or the schedule) | `=M58*M9` |
| Capex | % of revenue ("more capex, more sales") | `=M9*M103` |
| Tax | % of PBT, floored at 0 | `=IF(M20<0, 0, -M20*M63)` |

**Cost behaviour (Prelude):** fixed ➔ grow with inflation · variable ➔ % of a driver · **not everything is either** ➔ semi-fixed (tiered) costs and schedule-driven items.

**Expected output (v2 answer):** revenue FY26 24,593.6 → FY30 35,130.6 (+9.3% p.a.), GP margin flat 14.8%, EBIT margin 7.0% → 7.3%.

## 🔀 Variations — same data, two answer files
| | Lesson 2 sample answer | 3-Statement v2 answer |
| :--- | :--- | :--- |
| Volume growth | 3-yr avg = **31.0%** p.a. | set = price growth **4.6%** |
| Price growth | 3-yr avg 4.6% | 3-yr avg 4.6% |
| Revenue FY30 | **107,843** (≈4.8× FY25) | 35,131 (≈1.6× FY25) |
| COGS % | 3-yr avg 80.8% | FY25 level 85.2% |

> [!NOTE] **When It Flips:** a mechanical average is defensible only when history is **stable**; Company A's volume swung +14% → +46% → +51% → −5%, so averaging FY23–25 bakes a start-up growth spurt into five forecast years ➔ find alternative data (capacity, distribution, management guidance) or justify a fade.

## ✏️ Practice
> [!QUESTION]- Practice 1: FY25 headcount 24, implied monthly salary RM4,370.18, staff cost FY25 −1,258.6 (RM'000). Headcount grows 4.6%, salary 3.7%. Write the FY26 staff cost formula and value.
> > [!SUCCESS]- Reference solution
> > ```excel
> > M51: =L51*(1+M52)            → 25.09
> > M53: =L53*(1+M54)            → 4,532.31
> > M50: =-M51*M53*12/1000       → -1,364.8
> > ```
> > - **Key move:** derive the implied salary from history first (`=-L50*1000/L51/12`), then grow both legs; `/1000` converts RM to RM'000.

> [!QUESTION]- Practice 2: Why is "average of the last 3 years" weaker for Company A's volume than for its price?
> > [!SUCCESS]- Reference solution
> > - **Price** YoY 4.8%, 3.0%, 5.9% ➔ tight band, average is representative.
> > - **Volume** YoY 46%, 51%, −5% ➔ wide, regime-changing; the average (31%) describes no actual year.
> > - **Key move:** check dispersion before averaging; defend the number ([[Equity Research Process (Story to Line Item)]] rule 2).

## ⚠️ Common Mistakes
- 💡 **Growth-rate everything** ➔ a single revenue growth % hides whether volume or price is doing the work — and they carry different risks.
- 💡 **Normalise first** ➔ forecast from core figures; one-offs inflate the base ([[Core Earnings (Normalising Non-recurring Items)]]).
- 💡 **Cyclical base year** ➔ extrapolating from a peak/trough year (CFA guide).
