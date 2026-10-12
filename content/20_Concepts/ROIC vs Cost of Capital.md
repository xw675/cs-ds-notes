---
unit: MUIG-AAP
week: [0, 2]
source: [slides, applied]
parent: "[[Ratios for Shortlisting vs Evaluating]]"
tags: [Finance/Ratios]
aliases: [ROIC, Return on Invested Capital, NOPAT]
---
# [[ROIC vs Cost of Capital]]

**Context:** [[MUIG_AAP_MOC]] · "the number that tells you if a business deserves to exist" · the hurdle is [[WACC and CAPM]]; the ROE cousin is [[DuPont Decomposition (ROE)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** sen of operating profit per ringgit of capital from **both** shareholders and lenders ➔ compare to the cost of that capital to decide whether growth creates or destroys value.
> - **⚠️ Key Constraint:** growth is only good when $\text{ROIC} > \text{cost of capital}$ — below it, **faster growth is worse**.

## 📝 Core
- **Definition (slides)** ➔
$$\text{ROIC} = \frac{\text{NOPAT}}{\text{Total debt} + \text{Equity}}, \qquad \text{NOPAT} = \text{EBIT} \times (1 - t)$$
- **Model implementation (Company A)** ➔ `=EBIT*(1-0.24)/(Equity + current lease + non-current lease)` ➔ lease liabilities are the only debt; $t = 24\%$ hard-coded.
- **Three regimes** ➔

| Regime | What reinvestment does | Implication |
| :--- | :--- | :--- |
| $\text{ROIC} > \text{CoC}$ | each ringgit reinvested creates **more than** a ringgit of value | growth genuinely valuable ➔ reinvest everything it can |
| $\text{ROIC} = \text{CoC}$ | value-neutral — "growth is just motion" | should return cash rather than expand |
| $\text{ROIC} < \text{CoC}$ | each ringgit reinvested **destroys** value | growth makes shareholders poorer |

- **Worked example — Company A FY25 (RM'000)** ➔ $\text{EBIT} = 1{,}411.9$; capital $= 1{,}090.6 + 97.1 + 421.6 = 1{,}609.2$ ➔ $\text{ROIC} = \dfrac{1{,}411.9 \times 0.76}{1{,}609.2} = 66.7\%$ vs model WACC $\approx 6.2\%$ ➔ deep value-creating regime. Forecast ROIC falls to ~20% by FY30 only because cash piles up in equity (no dividends assumed) ➔ see [[Three-Statement Model (Linkages)]].
- **Terminal link** ➔ return on *new* capital (RONIC) sets sustainable growth: $g = \text{reinvestment rate} \times \text{RONIC}$ ➔ [[Terminal Value and Terminal Growth]].

## ⚠️ Common Mistakes
- 💡 **Equity-only denominator** ➔ that's ROE; ROIC counts lenders' capital too, so leverage can't flatter it.
- 💡 **Celebrating growth blindly** ➔ revenue growth at $\text{ROIC} < \text{CoC}$ is value destruction.

## 🧠 Active Recall
> [!FAQ]- Why can faster growth make shareholders poorer?
> > [!SUCCESS]- Answer
> > - **Short answer:** when ROIC is below the cost of capital, every extra ringgit invested earns less than investors require.
> > - **Why:** **Value spread** ➔ value created per ringgit $\propto (\text{ROIC} - \text{CoC})$; growth scales the spread — negative spread × more capital = more value destroyed.
