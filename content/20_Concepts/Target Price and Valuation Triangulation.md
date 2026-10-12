---
unit: MUIG-AAP
week: [0, 3]
source: [slides, reading]
parent: "[[Equity Research Process (Story to Line Item)]]"
tags: [Finance/Valuation]
aliases: [Target Price, Football Field, Valuation Summary, Recommendation, SOTP, DDM]
---
# [[Target Price and Valuation Triangulation]]

**Context:** [[MUIG_AAP_MOC]] · last stage of the pipeline — fair value vs market price ➔ Buy / Hold / Sell · CFA guide: "because model outputs can vary, more than one valuation model should be used"

> [!abstract] Quick Revision
> - **🎯 Objective:** pick a **primary** method (usually DCF) for the target price, run **cross-checks** (multiples, DDM, SOTP, CGU-DCF), show them on a **football field**, then state upside $= \dfrac{\text{TP}}{\text{Price}} - 1$.
> - **⚠️ Key Constraint:** justify the **weighting** — "100% DCF" is fine if you say why and show the others agree.

## 📝 Core
### 1. Method menu
| Method | Type | What it values | Example |
| :--- | :--- | :--- | :--- |
| DCF (FCFF) | absolute | firm ➔ EV ➔ equity | [[DCF Valuation (FCFF)]] — every example report's primary |
| Trading multiples | relative | vs peers | [[Relative Valuation (Trading Multiples)]] |
| DDM | absolute | equity via dividends at $K_e$ | DOM: 80% payout, $g = 2\%$ (long-run ROE × retention), $K_e = 9.4\%$ ➔ PLN236 |
| SOTP | absolute | each part separately | DOM: pipeline projects + land bank + TV ➔ PLN246 |
| CGU DCF | absolute | one business unit | TNB regulated business: RAB +5.72% CAGR, 7.3% return, $g = 2\%$ ➔ RM15.08 "conservative floor" |

### 2. How the example reports set the target
| Report | Call | Price → TP | Weighting |
| :--- | :--- | :--- | :--- |
| TNB (Monash Team B, Bursa) | BUY | RM13.54 → RM16.09 (+18.8%) | group DCF; EV/EBITDA (RM16.78) and CGU DCF as cross-checks |
| DOM Development (2025 global winner, WSE) | BUY | PLN213 → PLN260 (+22%) | **100% DCF**; comps 224, DDM 236, SOTP 246 confirm |
| P&G (MSMF) | BUY | USD146.34 → 158.98 (+9%) | DCF scenarios weighted 50/35/15; comps excluded from weighting |
| FedEx (MSMF) | BUY | 266 → base 292 | range 225–361 bear–bull |

### 3. Football field
- **What it is** ➔ horizontal bars of each method's value range (+ consensus, 52-week range) with the current price and TP marked ➔ one-glance view of agreement.
- **12-month horizon** ➔ target prices are stated as 12-month targets.

## ⚠️ Common Mistakes
- 💡 **Averaging everything** ➔ blending a weak method into the TP dilutes the best one; weight by reliability and say why.
- 💡 **TP with no bridge** ➔ always show EV → equity → per share, with share count and price date.

## 🧠 Active Recall
> [!FAQ]- The 2025 winner put 100% weight on DCF. How did it still satisfy "use more than one model"?
> > [!SUCCESS]- Answer
> > - **Short answer:** it ran comps, DDM and SOTP as cross-checks and showed them on the football field.
> > - **Why:** **Primary + corroboration** ➔ DCF captures long-term intrinsic value through detailed forecasts; the other methods (PLN224–246) all signalled upside, so they validate rather than set the TP.
