---
unit: MUIG-AAP
week: [2, 3]
source: [applied, reading]
parent: "[[DCF Valuation (FCFF)]]"
tags: [Finance/Valuation]
aliases: [Terminal Value, TV, Gordon Growth, Exit Multiple, Terminal Growth Rate, Key Value Driver]
---
# [[Terminal Value and Terminal Growth]]

**Context:** [[MUIG_AAP_MOC]] · the value of everything after the explicit forecast · usually the largest block of [[DCF Valuation (FCFF)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** capture post-forecast value by **Gordon growth** $\text{TV} = \dfrac{\text{FCF}_N(1+g)}{\text{WACC}-g}$ or an **exit multiple** $\text{TV} = \text{EBITDA}_N \times \text{EV/EBITDA}$.
> - **⚠️ Key Constraint:** $g < \text{WACC}$ and $g \lesssim$ long-run nominal GDP growth — as $g \to \text{WACC}$ the TV blows up.

## 📝 Core
| Method | Formula | Used by | Watch |
| :--- | :--- | :--- | :--- |
| Gordon growth (perpetuity) | $\dfrac{\text{FCF}_N(1+g)}{\text{WACC}-g}$ | Company A model ($g = 3\%$), TNB, Sonic ($g = 2.5\%$), DOM | sensitivity to $\text{WACC}-g$ |
| Exit multiple | $\text{EBITDA}_N \times$ multiple | P&G (base 19.1x, bear 15.5x, bull 25x) | imports today's market mood into the far future |
| Key value driver | $g = \text{reinvestment rate} \times \text{RONIC}$ | DOM: $6.5\% \times 15\% = 0.97\%$ | ties growth to the capital needed to fund it |

- **Anchoring $g$ (TNB)** ➔ group $g = 1.5\%$, below Malaysia's ~2% long-run GDP (World Bank LTG) for conservatism; the regulated-business DCF used 2.0% (more stable cash flows).
- **RONIC < historical ROIC** ➔ DOM used 15% vs 20% historical ➔ assumes advantages fade ([[ROIC vs Cost of Capital]]).
- **Cross-check both ways** ➔ print $\text{TV}/\text{EBITDA}_N$ from a Gordon TV (Company A: 24.7x) and the implied $g$ from an exit multiple.
- **Weight check** ➔ Company A: discounted TV $= 50{,}158$ of EV $57{,}518$ ➔ 87%.

## ⚠️ Common Mistakes
- 💡 **$g$ above the economy** ➔ a perpetual growth rate above long-run GDP implies the company eventually becomes larger than the economy.
- 💡 **Discounting TV by $N+1$ periods or forgetting to discount it** ➔ TV sits at the end of year $N$, so discount by $(1+\text{WACC})^N$.
- 💡 **Free growth** ➔ high $g$ with low reinvestment is inconsistent; the key-value-driver formula exposes it.

## 🧠 Active Recall
> [!FAQ]- Company A (answer-file FCFF): $\text{FCF}_{30} = 2{,}138.3$, WACC 6.24%, $g = 3\%$. Compute TV and explain why moving $g$ to 4% matters so much.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\text{TV} = 2{,}138.3 \times 1.03 / 0.0324 = 67{,}898$; at $g = 4\%$ it becomes $2{,}138.3 \times 1.04 / 0.0224 \approx 99{,}110$ (+46%).
> > - **Why:** **Denominator effect** ➔ TV $\propto 1/(\text{WACC}-g)$; cutting a 3.24-pt spread to 2.24 pts lifts TV by almost half — and TV is ~87% of EV.
