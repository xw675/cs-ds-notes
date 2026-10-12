---
unit: MUIG-AAP
week: 2
source: [applied]
parent: "[[Equity Research Process (Story to Line Item)]]"
tags: [Finance/Modelling, Finance/Accounting, Tool/Excel]
aliases: [3 Statement Model, Three Statement Model, Integrated Financial Model]
---
# [[Three-Statement Model (Linkages)]]

**Context:** [[MUIG_AAP_MOC]]
**Parent Framework:** [[Equity Research Process (Story to Line Item)]] — stage 3, "turning a view into numbers"

> [!abstract] Quick Revision
> - **🎯 Objective:** forecast P&L → roll the balance sheet with corkscrews → derive cash from the cash-flow statement ➔ cash closes the balance sheet ➔ check = 0.
> - **📦 Core Components:** [[Forecasting Drivers (Revenue and Cost)]] ➔ P&L | [[Depreciation Schedule (Existing and New PPE)]] ➔ PPE & D&A | [[Working Capital Schedule (Days Method)]] ➔ receivables/payables | [[Debt and Interest Schedule]] ➔ leases & interest.
> - **⚠️ Key Constraint:** cash must come **from the CF statement**, never be plugged; if the check row isn't 0, a flow is missing on one side.

## 📝 How It Works
### 1. The three corkscrews (Prelude sheet rules)
$$\text{PPE}_t = \text{PPE}_{t-1} + \text{Capex}_t - \text{Depreciation}_t$$
$$\text{RE}_t = \text{RE}_{t-1} + \text{PAT}_t - \text{Dividend}_t$$
$$\text{Cash}_t = \text{Cash}_{t-1} + \text{CFO}_t + \text{CFI}_t + \text{CFF}_t$$
- **Share capital** ➔ prior year + share issuance.

### 2. Link map (Company A model)
| From | Line | To |
| :--- | :--- | :--- |
| P&L | PBT | top of CFO |
| P&L | D&A (opex category) | CFO add-back **and** PPE corkscrew |
| P&L | income tax | CFO tax paid (assumed paid same year) |
| P&L | PAT | retained earnings |
| Assumptions | capex = % revenue | CFI purchase of PPE **and** PPE corkscrew |
| BS | change in receivables / payables | CFO working-capital lines: $\text{AR}_{t-1} - \text{AR}_t$, $\text{AP}_t - \text{AP}_{t-1}$ |
| CF | dividends, share issuance, lease repayment | RE, share capital, lease liability |
| CF | closing cash | BS cash ➔ balance check |

### 3. Funding guard — minimum cash & equity injection
- **Minimum working capital** ➔ $2 \text{ months of opex} = -\text{Opex}/12 \times 2$.
- **Injection** ➔ `=IF(cash_before < min, MAX(min, min - cash_before), 0)` flows to share issuance in CFF.

### 4. Company A v2 answer — simplifying assumptions (state them in a report!)
- **Finance costs removed** from FY26 and **no lease repayment** (lease balance flat at 518.6) ➔ NOPAT = PAT.
- **Receivables, payables, other items held constant** ➔ zero working-capital change.
- **No dividends** ➔ cash and equity compound; ROE falls from 94.6% (FY25) to 21.2% (FY30) purely from cash build-up.
- **Tax** ➔ `=IF(PBT<0, 0, -PBT*24%)`.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace — FY25A → FY26F (RM'000, v2 answer)
| Step | Line | FY25A | FY26F | How |
| :--- | :--- | :--- | :--- | :--- |
| 1 | Revenue | 22,496.0 | 24,593.6 | volume +4.6% × price +4.6% |
| 2 | EBIT | 1,411.9 | 1,733.0 | GP 14.8% − opex 1,905.9 |
| 3 | PAT | 1,022.8 | 1,317.0 | $1{,}733.0 \times (1-0.24)$ |
| 4 | PPE | 342.7 | 473.3 | $342.7 + 265.8 - 135.3$ |
| 5 | CFO | 736.1 | 1,452.3 | $1{,}733.0 + 135.3 + 0 - 415.9$ |
| 6 | Cash | 717.6 | 1,904.1 | $717.6 + 1{,}452.3 - 265.8 + 0$ |
| 7 | RE | 1,090.5 | 2,407.5 | $1{,}090.5 + 1{,}317.0 - 0$ |
| 8 | Check | 0 | 0 | assets 3,335.0 = L + E 3,335.0 |

### Applied Exercise
**Problem:** FY26 the company pays a RM500k dividend. Which cells change and does the model still balance?
$$
\begin{aligned}
\text{CFF} &= -500 \Rightarrow \text{Cash}_{26} = 1{,}904.1 - 500 = 1{,}404.1 \\
\text{RE}_{26} &= 1{,}090.5 + 1{,}317.0 - 500 = 1{,}907.5 \\
\Delta\text{Assets} &= -500 = \Delta\text{Equity}
\end{aligned}
$$
**Final Extracted Output:** both sides fall by 500 ➔ check stays 0 (if only one side were linked, check = ±500).

## 🧠 Active Recall
> [!FAQ]- The check row shows +127.9 in FY26 only. What's the first thing you suspect?
> > [!SUCCESS]- Answer
> > - **Short answer:** a flow hitting one statement but not the other — 127.9 ≈ FY26 D&A from existing PPE, so depreciation is probably in the P&L but not in the PPE corkscrew (or vice-versa).
> > - **Why:** **Double-entry** ➔ every forecast flow must touch two places (P&L/CF and BS); an imbalance equal to a known line item names the broken link.

> [!FAQ]- Why does ROE in the v2 answer collapse from 94.6% to 21% even though margins rise?
> > [!SUCCESS]- Answer
> > - **Short answer:** no dividends ➔ retained cash swells equity, the denominator.
> > - **Why:** **DuPont leverage + turnover** ➔ idle cash inflates assets and equity, cutting turnover; payout policy is a modelling assumption that moves ratios ([[DuPont Decomposition (ROE)]]).
