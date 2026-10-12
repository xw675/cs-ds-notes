---
unit: MUIG-AAP
week: 2
source: [applied]
parent: "[[Three-Statement Model (Linkages)]]"
tags: [Finance/Modelling, Tool/Excel]
aliases: [Asset Schedule, PPE Schedule, Depreciation Waterfall, D&A Schedule]
type: pattern
---
# [[Depreciation Schedule (Existing and New PPE)]]

**Context:** [[MUIG_AAP_MOC]] · replaces "D&A = % of revenue" with an asset-level build · feeds the PPE corkscrew in [[Three-Statement Model (Linkages)]]
**Problem it solves:** forecast depreciation that (a) runs off existing assets until fully written down and (b) layers in each year's new capex over its useful life.

> [!abstract] Quick Revision
> - **🎯 Trigger:** need D&A tied to capex ➔ two parts: **existing PPE run-off** + **new-PPE waterfall** (one row per capex vintage).
> - **⚠️ Key Constraint:** depreciation can never exceed remaining NBV ➔ every charge is wrapped in `MIN(...)`.

## 🔧 Minimal Working Example
**Step 0 — implied useful life (from the AFS PPE note):** $\text{Useful life} = \dfrac{\text{Cost}}{\text{Annual depreciation}}$

| FY25 asset | Cost | Annual dep. | Life (yrs) | NBV |
| :--- | :--- | :--- | :--- | :--- |
| Computer | 10.8 | 1.69 | 6.39 | 4.36 |
| Motor vehicles | 643.1 | 125.29 | 5.13 | 336.42 |
| Office equipment | 4.5 | 0.89 | 5.00 | 1.94 |
| **Total** | 658.4 | 127.87 | **5.15** (weighted) | 342.72 |

**Step 1 — existing assets: straight-line until NBV hits 0**
```excel
NBV_BOP:  M19: =G19            (FY25 NBV)     N19: =M21
Dep:      M20: =-MIN(M19, $G20)               ' G20 = annual charge
NBV_EOP:  M21: =SUM(M19:M20)
```
**Step 2 — new PPE: one row per capex year (vintage in col D, amount in col E)**
```excel
M32: =IF(M$5>=$D32, MIN($E32-SUM($L32:L32), $E32/$G$31), 0)
```
- `M$5>=$D32` ➔ start depreciating in the vintage year.
- `$E32/$G$31` ➔ cost ÷ weighted-average life (5.15 yrs).
- `$E32-SUM($L32:L32)` ➔ remaining undepreciated cost (expanding range) caps the final year.

**Step 3** ➔ total D&A $=$ existing run-off $+ \sum$ vintage rows.

### Trace — motor vehicles (RM'000)
| Year | NBV BOP | Depreciation | NBV EOP |
| :--- | :--- | :--- | :--- |
| FY26 | 336.42 | −125.29 | 211.14 |
| FY27 | 211.14 | −125.29 | 85.85 |
| FY28 | 85.85 | **−85.85** (MIN binds) | 0 |
| FY29 | 0 | 0 | 0 |

**Expected output (v2 Schedule):** existing D&A 127.9 → 127.9 → 87.0 → 0 → 0; new-PPE D&A 51.6 → 108.1 → 169.8 → 237.2 → 311.0 (e.g. FY26 vintage $265.8 / 5.149 = 51.6$ per year).

## ✏️ Practice
> [!QUESTION]- Practice 1: FY27 capex is 290.6, life 5.149 yrs. What does the FY27 vintage row show in FY26, FY27 and FY32?
> > [!SUCCESS]- Reference solution
> > - **FY26:** 0 (`M$5 < $D33`, not yet bought).
> > - **FY27–FY31:** $290.6 / 5.149 = 56.44$ each ➔ five charges $= 282.2$.
> > - **FY32:** stub $= 290.6 - 282.2 = 8.4$ (the `MIN` picks remaining cost over the full annual charge).
> > - **Key move:** a non-integer life creates a stub final year; `MIN(remaining, annual)` handles it with no special case.

## ⚠️ Common Mistakes
- 💡 **Schedule not linked** ➔ in the v2 answer the P&L still uses D&A $= 0.55\%$ of revenue (135.3 in FY26) while the Schedule computes $127.9 + 51.6 = 179.5$ ➔ link `Model!M57` to the schedule total or the PPE balance drifts from reality.
- 💡 **Dropping the `$`** ➔ `$E32`, `$D32`, `M$5`, `$G$31` anchors are what let one formula fill the whole triangle.
- 💡 **Depreciating below zero** ➔ forgetting `MIN` makes NBV negative after the asset's life ends.
