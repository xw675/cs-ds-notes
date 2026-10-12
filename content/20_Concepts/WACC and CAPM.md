---
unit: MUIG-AAP
week: [2, 3]
source: [applied, reading]
parent: "[[DCF Valuation (FCFF)]]"
tags: [Finance/Valuation]
aliases: [WACC, CAPM, Cost of Equity, Cost of Debt, Discount Rate, Beta]
---
# [[WACC and CAPM]]

**Context:** [[MUIG_AAP_MOC]] · the discount rate in [[DCF Valuation (FCFF)]] and the hurdle in [[ROIC vs Cost of Capital]]

> [!abstract] Quick Revision
> - **🎯 Objective:** blend the required returns of equity and debt by their capital weights ➔ $\text{WACC} = W_e K_e + W_d K_d (1-t)$, with $K_e = R_f + \beta (R_m - R_f)$.
> - **⚠️ Key Constraint:** CAPM multiplies beta by the **risk premium** $(R_m - R_f)$, not by $R_f$ — the Company A answer file's `=Rf + Beta*Rf` is a bug (7.18% instead of 5.78%).

## 📝 Core
$$\text{WACC} = \frac{E}{D+E} K_e + \frac{D}{D+E} K_d (1 - t), \qquad K_e = R_f + \beta (R_m - R_f)$$

| Input | Company A model | TNB report (Monash Team B) | DOM report (2025 winner) |
| :--- | :--- | :--- | :--- |
| $R_f$ | 3.59% | 3.55% — 10-yr MGS | — |
| $\beta$ | 1.0 (assumed) | 1.20 — bottom-up re-levered | 0.62 — **max** of regression, bottom-up, Damodaran sector |
| ERP $(R_m - R_f)$ | $5.78\% - 3.59\% = 2.19\%$ | 5.98% (Damodaran 2025) | — |
| $K_e$ | 5.78% correct (file: 7.18%) | 10.76% | 9.4% |
| $K_d$ (pre-tax) | 5.625% — avg of lease rates 4.16–7.09% | 4.74% — BNM avg lending rate, vs 4.47–4.76% historical | 7.2% — own bond issue + YTM of traded bonds |
| $t$ | 24% | 24% (post-tax $K_d$ 3.60%) | 19% |
| Weights | **book**: E 67.8% / D 32.2% | **market**, target D/E 0.92 | E 88.2% / D 11.8% |
| WACC | 6.24% (file) | **7.33%** ≈ allowed regulated return 7.3% | 9.01% |

- **Bottom-up beta (3 steps, TNB)** ➔ pick comparable peers ➔ **un-lever** each peer's beta with its D/E and tax rate ➔ **re-lever** at the target (market-average) D/E and marginal tax rate.
- **Market vs book weights** ➔ reports use market-value capital structure; the workshop model uses book equity (1,090.6) + lease debt (518.6) as a simplification.
- **Extra premia** ➔ TI report added a **1% company-specific premium** (geopolitics); FedEx added a 1% risk factor to $K_e$ and used the **default-spread** method for $K_d$ (Moody's B3).
- **Reasonableness anchor** ➔ TNB's WACC landing on the regulator's allowed return (7.3%) is cited as evidence the estimate is sane.
- **Peer list does double duty** ➔ the same peers drive multiples and beta/D/E ➔ [[Competitive Positioning and Economic Moat]].

## ⚠️ Common Mistakes
- 💡 **`Rf + β·Rf`** ➔ with $\beta = 1$, correct CAPM gives $K_e = R_m$ exactly; any other answer is a formula error.
- 💡 **Forgetting the tax shield** ➔ only debt gets $(1-t)$; interest is deductible, dividends are not.
- 💡 **ERP sanity** ➔ an implied ERP near 2% (Company A inputs) undercuts the discount rate and inflates TV ➔ cite a source (e.g. Damodaran) for ERP.

## 🧠 Active Recall
> [!FAQ]- Why re-lever peer betas instead of using each peer's raw beta?
> > [!SUCCESS]- Answer
> > - **Short answer:** raw betas mix business risk with each peer's own leverage.
> > - **Why:** **Un-lever → asset beta** strips financing risk so peers are comparable; **re-lever at the target D/E** adds back the leverage the subject company will actually carry.

> [!FAQ]- Compute Company A's correct $K_e$ and WACC from the model inputs.
> > [!SUCCESS]- Answer
> > - **Short answer:** $K_e = 5.78\%$, WACC $\approx 5.29\%$.
> > - **Why:** $K_e = 3.59\% + 1.0 \times (5.78\% - 3.59\%) = 5.78\%$; $\text{WACC} = 0.678 \times 5.78\% + 0.322 \times 5.625\% \times 0.76 = 3.92\% + 1.38\% = 5.29\%$.
