---
unit: MUIG-AAP
week: [2, 3]
source: [applied, reading]
parent: "[[Target Price and Valuation Triangulation]]"
tags: [Finance/Valuation, Finance/Modelling, Tool/Excel]
aliases: [DCF, Discounted Cash Flow, FCFF, Enterprise Value Bridge, Intrinsic Value]
---
# [[DCF Valuation (FCFF)]]

**Context:** [[MUIG_AAP_MOC]] (DCF block of the Company A model; the method behind every example report's target price)
**Parent Framework:** [[Target Price and Valuation Triangulation]]

> [!abstract] Quick Revision
> - **🎯 Objective:** forecast free cash flow to the firm ➔ discount at WACC ➔ add discounted terminal value ➔ **EV** ➔ minus net debt ➔ **equity value** ➔ ÷ shares ➔ intrinsic value per share.
> - **📦 Core Components:** FCFF build ➔ this note | discount rate ➔ [[WACC and CAPM]] | perpetuity ➔ [[Terminal Value and Terminal Growth]] | robustness ➔ [[Sensitivity and Scenario Analysis]].
> - **⚠️ Key Constraint:** terminal value is typically **most of EV** (Company A: 87%) ➔ the answer is only as good as WACC and $g$; always show the TV share and an implied multiple.

## 📝 How It Works
### 1. Free cash flow to the firm (before any financing flows)
$$\text{FCFF} = \underbrace{\text{EBIT}(1-t)}_{\text{NOPAT}} + \text{D\&A} - \Delta\text{NWC} - \text{Capex}$$
- **Why NOPAT, not PAT** ➔ FCFF belongs to **all** capital providers, so it is discounted at **WACC** and yields **EV**; interest is captured in $K_d$ inside WACC, not in the cash flow.

### 2. Discount and sum
$$\text{EV} = \sum_{t=1}^{N} \frac{\text{FCFF}_t}{(1+\text{WACC})^t} + \frac{\text{TV}_N}{(1+\text{WACC})^N}, \qquad \text{TV}_N = \frac{\text{FCFF}_N (1+g)}{\text{WACC} - g}$$
- **Excel discount factor** ➔ `=1/(1+$G$263)^(SUM($M259:M259))` ➔ the "Year" row (all 1s) summed cumulatively gives $t = 1, 2, \dots$ ➔ end-of-year convention; changing a 1 to 0.5 gives a stub period.

### 3. EV → equity bridge
$$\text{Equity value} = \text{EV} - \text{Net debt}, \qquad \text{Net debt} = \text{Debt (incl. leases)} - \text{Cash}$$
- **Fuller bridge (TNB report)** ➔ EV − total debt − minority interest + cash & equivalents.
- **Per share** ➔ equity value ÷ shares outstanding ➔ compare to price ➔ upside $= \text{TP}/\text{Price} - 1$.

### 4. Sanity checks the model prints
- **TV % of EV** ➔ `=Disc.TV / EV`.
- **Implied multiples** ➔ EV / Core EBITDA, Equity / Core PAT, TV / final-year EBITDA ➔ compare with peers ([[Relative Valuation (Trading Multiples)]]).

## ⚙️ Core Implementation
### 🔹 Company A DCF block (RM'000, v2 answer)
> [!code]- Excel rows
> ```excel
> M247 EBIT            =M16
> M248 (-) Tax         =-M247*M63
> M249 NOPAT           =SUM(M247:M248)
> M250 D&A             =-M57
> M251 WC changes      =SUM(M127:M129)
> M252 CAPEX           =M136          ' answer file has =M145 (financing total!) ✗
> M253 FCFF            =SUM(M249:M252)
> Q255 Terminal value  =Q253*(1+$G$264)/(G263-G264)
> M260 Disc. factor    =1/(1+$G$263)^(SUM($M259:M259))
> G277 EV              =SUM(M261:Q261)
> G278 Net debt        =L88+L82-L76   ' = -198.9 (net cash)
> G279 Equity value    =G277-G278     ' answer file has =SUM(G277:G278) ✗
> ```
> 💡 **Common Mistake:** **two link errors in the answer file** ➔ capex points at net financing cash flow (0 in v2), so FCFF omits capex; and the bridge *adds* net debt — with net cash that understates equity by $2 \times 198.9$.

## ⚖️ Core Decision Matrix
| Version | WACC | FCFF FY26 | TV | EV | TV % EV | EV / FY25 Core EBITDA |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| Answer file as built | 6.24% | 1,452.3 | 67,898 | 57,518 | 87.2% | 37.1x |
| + capex fixed | 6.24% | 1,186.5 | 55,841 | 47,286 | 87.2% | 30.5x |
| + capex fixed + CAPM fixed ($K_e = 5.78\%$) | 5.29% | 1,186.5 | 78,927 | 67,184 | 90.8% | 43.4x |

> [!NOTE] **When It Flips:** fixing CAPM *raises* value because the inputs give an equity risk premium of only $5.78\% - 3.59\% = 2.19\%$ (the TNB report used 5.98%) ➔ WACC − g shrinks to 2.3% and TV explodes. Every version implies 30–43x EBITDA for a 7%-margin cake distributor ➔ the inputs, not the arithmetic, are the problem.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace — corrected FCFF (capex fixed, WACC 6.24%)
| Year | NOPAT | + D&A | − Capex | FCFF | DF | PV |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| FY26 | 1,317.0 | 135.3 | 265.8 | 1,186.5 | 0.941 | 1,116.8 |
| FY27 | 1,452.7 | 147.9 | 290.6 | 1,309.9 | 0.886 | 1,160.5 |
| FY28 | 1,603.9 | 161.7 | 317.7 | 1,447.8 | 0.834 | 1,207.3 |
| FY29 | 1,764.8 | 176.7 | 347.3 | 1,594.2 | 0.785 | 1,251.2 |
| FY30 | 1,945.1 | 193.2 | 379.7 | 1,758.6 | 0.739 | 1,299.1 |

### Applied Exercise
**Problem:** finish the valuation from the trace.
$$
\begin{aligned}
\text{TV}_{30} &= \frac{1{,}758.6 \times 1.03}{0.0624 - 0.03} = 55{,}841 \\
\text{PV(TV)} &= 55{,}841 \times 0.739 = 41{,}251 \\
\text{EV} &= 6{,}035 + 41{,}251 = 47{,}286 \\
\text{Equity} &= 47{,}286 - (-198.9) = 47{,}485
\end{aligned}
$$
**Final Extracted Output:** equity value ≈ RM47.5m; TV = 87% of EV. (No share count in the workbook, so no per-share price.) Cross-check: with no financing flows, FCFF equals the CF statement's net change in cash (1,186.5 in FY26) ✓.

## 🧠 Active Recall
> [!FAQ]- Why discount FCFF at WACC but dividends (DDM) at the cost of equity?
> > [!SUCCESS]- Answer
> > - **Short answer:** match the cash flow to whose money it is.
> > - **Why:** **Claimholder consistency** ➔ FCFF is pre-financing cash available to debt **and** equity ➔ WACC ➔ EV; dividends belong only to shareholders ➔ $K_e$ ➔ equity value directly (the winner report's DDM used $K_e = 9.4\%$).

> [!FAQ]- The model shows EV/EBITDA of 37x for Company A. What does that tell you?
> > [!SUCCESS]- Answer
> > - **Short answer:** the DCF inputs are implausible — a low-margin distributor shouldn't price like a hyper-growth franchise.
> > - **Why:** **Implied-multiple check** ➔ TV ≈ 87% of EV and $\text{WACC} - g \approx 3.2\%$; revisit ERP/beta (WACC) and whether 3% perpetual growth is defensible.
