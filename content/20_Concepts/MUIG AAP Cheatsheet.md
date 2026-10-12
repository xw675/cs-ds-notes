---
unit: MUIG-AAP
parent: "[[MUIG_AAP_MOC]]"
tags: [Finance/Valuation, Finance/Modelling, Finance/Ratios]
type: cheatsheet
aliases: [AAP Crib, Valuation Cheatsheet, Equity Research Crib]
---
# [[MUIG AAP Cheatsheet]]

**Context:** [[MUIG_AAP_MOC]] · the WHOLE programme in one re-read — research process → ratios → business & moat → three-statement model → schedules → DCF/WACC/TV → multiples & target price → risk → report. Every line is a formula or rule with its **precondition**; links for depth.

> [!abstract] Quick Revision
> - **🎯 Objective:** match the question's shape to a formula or rule ➔ apply only when its precondition holds ➔ land it on a line item.
> - **⚠️ Key Constraint:** most valuation errors are **consistency** errors — cash flow ↔ discount rate, EV ↔ equity, multiple ↔ metric, growth ↔ reinvestment.

## 1️⃣ Research process
- **[[Equity Research Process (Story to Line Item)]]** ➔ judgement → assumption → 3-statement forecast → valuation → TP & call **· precondition:** every claim names its line item (margin, WACC, growth period), else drop it.
- **Edge** ➔ informational (weak, decays) · **analytical (primary)** · behavioural.
- **[[Price vs Value (Mr Market)]]** ➔ short run voting, long run weighing **· research edge only on the fundamental side.**

## 2️⃣ Ratios
- **Two jobs** ➔ shortlisting (uses price: PE, EV/EBITDA, P/B, yield) vs evaluating (ignores price: ROIC, DuPont, FCF) **· a low PE is a reason to look, never to buy.** ➔ [[Ratios for Shortlisting vs Evaluating]]
- **ROIC** ➔ $\dfrac{\text{EBIT}(1-t)}{\text{Debt}+\text{Equity}}$ **· growth creates value only if** $\text{ROIC} > \text{WACC}$. ➔ [[ROIC vs Cost of Capital]]
- **DuPont** ➔ $\text{ROE} = \frac{\text{NP}}{\text{Rev}} \times \frac{\text{Rev}}{\text{TA}} \times \frac{\text{TA}}{\text{E}}$ **· leverage term = risk, not quality.** ➔ [[DuPont Decomposition (ROE)]]
- **FCF** ➔ $\text{CFO} - \text{Capex}$ **· judge over ~5 years; negative FCF can be growth (regulated RAB).** ➔ [[Free Cash Flow (Cash vs Profit)]]
- **Core earnings** ➔ $\text{Core PAT} = \text{PAT} + \text{NRI add-backs}$ **· only genuinely non-recurring items.** ➔ [[Core Earnings (Normalising Non-recurring Items)]]

## 3️⃣ Business, industry, moat
- **Description ≠ model** ➔ model = core ops (segments, value chain) + target market (industry, geography) + revenue mechanics/cost management. ➔ [[Business Model Analysis]]
- **Industry** ➔ definition · headwinds/tailwinds · key players **· PESTLE/Five Forces/SWOT are tools, not output.** ➔ [[Industry Analysis (Headwinds and Tailwinds)]]
- **Moat test** ➔ uniqueness · relative advantage · durability **· peer list also sets the WACC risk profile.** ➔ [[Competitive Positioning and Economic Moat]]

## 4️⃣ Three-statement mechanics
- **Corkscrews** ➔ $\text{PPE}_t = \text{PPE}_{t-1} + \text{Capex} - \text{Dep}$ · $\text{RE}_t = \text{RE}_{t-1} + \text{PAT} - \text{Div}$ · $\text{Cash}_t = \text{Cash}_{t-1} + \text{CFO} + \text{CFI} + \text{CFF}$ **· cash from CF only, never plugged; check = 0.** ➔ [[Three-Statement Model (Linkages)]]
- **Revenue** ➔ $\text{Volume} \times \text{ASP}$, each grown at its own rate **· averages only when history is stable.** ➔ [[Forecasting Drivers (Revenue and Cost)]]
- **Costs** ➔ variable = % of driver · fixed = inflation · staff = headcount × salary × 12 / 1000 · tax = `IF(PBT<0,0,PBT·t)`.
- **Depreciation** ➔ life $= \frac{\text{Cost}}{\text{Annual dep}}$; existing `-MIN(NBV, dep)`; new vintage `IF(yr>=vintage, MIN(remaining, cost/life), 0)`. ➔ [[Depreciation Schedule (Existing and New PPE)]]
- **Working capital** ➔ DSO $= \frac{\text{AR}}{\text{Rev}} \cdot 365$, DPO $= \frac{\text{AP}}{\text{COGS}} \cdot 365$; cash impact $= (\text{AR}_{t-1}-\text{AR}_t) - (\text{AP}_{t-1}-\text{AP}_t)$ **· compare with the previous forecast column, not a spacer.** ➔ [[Working Capital Schedule (Days Method)]]
- **Debt** ➔ $\text{EOP} = \text{BOP} + \text{adds} - \text{principal}$; interest $= r \times$ BOP (or average) **· cap repayment with `MIN`.** ➔ [[Debt and Interest Schedule]]

## 5️⃣ DCF, WACC, terminal value
- **FCFF** ➔ $\text{EBIT}(1-t) + \text{D\&A} - \Delta\text{NWC} - \text{Capex}$ **· pre-financing ➔ discount at WACC ➔ gives EV.** ➔ [[DCF Valuation (FCFF)]]
- **PV** ➔ $\sum \frac{\text{FCFF}_t}{(1+\text{WACC})^t} + \frac{\text{TV}_N}{(1+\text{WACC})^N}$ **· end-year convention unless stub periods.**
- **Bridge** ➔ $\text{Equity} = \text{EV} - (\text{Debt} - \text{Cash})$ [− minorities] **· subtract net debt; net cash adds.**
- **WACC** ➔ $W_e K_e + W_d K_d (1-t)$ **· tax shield on debt only; market weights preferred.** ➔ [[WACC and CAPM]]
- **CAPM** ➔ $K_e = R_f + \beta(R_m - R_f)$ **· β multiplies the premium; with β = 1, $K_e = R_m$.**
- **Bottom-up β** ➔ un-lever peers → re-lever at target D/E **· peers must share risk profile.**
- **Gordon TV** ➔ $\frac{\text{FCF}_N(1+g)}{\text{WACC}-g}$ **· requires $g < \text{WACC}$, $g \lesssim$ long-run GDP.** ➔ [[Terminal Value and Terminal Growth]]
- **Exit-multiple TV** ➔ $\text{EBITDA}_N \times$ multiple **· cross-check implied $g$.**
- **Key value driver** ➔ $g = \text{reinvestment rate} \times \text{RONIC}$ **· growth must be funded.**
- **DDM** ➔ dividends discounted at $K_e$ ➔ equity value directly.

## 6️⃣ Multiples & target price
- **Comps** ➔ peer avg/median forward multiple × subject metric **· EV multiple ➔ EV ➔ bridge; P/E ➔ equity directly.** ➔ [[Relative Valuation (Trading Multiples)]]
- **Upside** ➔ $\frac{\text{TP}}{\text{Price}} - 1$, 12-month TP **· state price date.** ➔ [[Target Price and Valuation Triangulation]]
- **Triangulate** ➔ primary method + cross-checks on a football field **· justify weights.**

## 7️⃣ Risk & robustness
- **Sensitivity** ➔ one input at a time ➔ which matters most · **scenario** ➔ coherent set ➔ range **· report the break-even that flips the call.** ➔ [[Sensitivity and Scenario Analysis]]
- **Risk matrix** ➔ probability × impact + mitigation **· quantify impact on value.** ➔ [[Investment Risks (Risk Matrix)]]
- **Red flags** ➔ qualified audit opinion; material weakness in internal control.

## 8️⃣ Report & competition
- **Sections** ➔ business description · industry & positioning · investment summary · valuation · financial analysis · risks · ESG. ➔ [[Equity Research Report Structure]]
- **Marks** ➔ BD 5 · industry 10 · summary 15 · **valuation 20 · financial analysis 20** · risks 15 · ESG 15; ≤10 pages + 10 appendix. ➔ [[CFA Institute Research Challenge (Rules and Scoring)]]
- **Thesis** ➔ 5–6 forward-looking bullets + call; mispricing + catalyst + what proves you wrong. ➔ [[Investment Thesis]]
- **ESG** ➔ model it (cash flow, β, multiple) or argue "priced in". ➔ [[ESG in Equity Research]]
