---
unit: MUIG-AAP
week: 2
source: [applied]
parent: "[[Three-Statement Model (Linkages)]]"
tags: [Finance/Modelling, Tool/Excel]
aliases: [Debt Schedule, Interest Schedule, Lease Schedule, Debt Corkscrew]
type: pattern
---
# [[Debt and Interest Schedule]]

**Context:** [[MUIG_AAP_MOC]] · the financing corkscrew · Company A's only debt is finance-lease payables (motor vehicles) · also supplies $K_d$ for [[WACC and CAPM]]
**Problem it solves:** forecast debt balances, interest (P&L + CF) and repayments (CFF) consistently.

> [!abstract] Quick Revision
> - **🎯 Trigger:** any borrowing on the balance sheet ➔ corkscrew $\text{EOP} = \text{BOP} + \text{additions} - \text{principal repaid}$; interest $=$ rate $\times$ balance.
> - **⚠️ Key Constraint:** repayment can't exceed what's owed ➔ cap with `MIN`; and pick BOP vs average-balance interest consciously (average + cash-funded repayment creates circularity).

## 🔧 Minimal Working Example
**Rate** ➔ midpoint of the AFS lease rates: `=AVERAGE(4.16%, 7.09%)` $= 5.625\%$.
```excel
BOP:        L176: =J181                         ' last actual EOP (518.64)
Interest:   L178: =L176*-$C$178                 ' rate × BOP
Total pmt:  L180: =-MIN(ABS($J$180), L176-L178) ' keep FY25 instalment, capped
Principal:  L179: =L180-L178                    ' instalment − interest
EOP:        L181: =L176+L177+L179
```
- **Historical principal backed out** ➔ `=-(BOP + additions - EOP)`.
- **Current vs non-current split** ➔ current portion $=$ next year's principal; non-current $=$ EOP $-$ current.
- **Alternative (v2 Model)** ➔ interest $=$ `AVERAGE(BOP, EOP) * rate`, repayment set to 0 ➔ flat 518.6 balance, 29.2 interest/yr (but finance cost then removed from the P&L — an inconsistency to flag).

### Trace — Lesson 2 answer (RM'000)
| Year | BOP | Interest | Total payment | Principal | EOP |
| :--- | :--- | :--- | :--- | :--- | :--- |
| FY26 | 518.64 | −29.04 | −220.41 | −191.37 | 327.27 |
| FY27 | 327.27 | −18.33 | −220.41 | −202.09 | 125.18 |
| FY28 | 125.18 | −7.01 | **−132.19** (cap) | −125.18 | 0 |
| FY29 | 0 | 0 | 0 | 0 | 0 |

**Expected output:** leases fully repaid in FY28; interest falls as the balance amortises (annuity-like profile).

## ✏️ Practice
> [!QUESTION]- Practice 1: Why does FY28's total payment drop to 132.19 rather than 220.41?
> > [!SUCCESS]- Reference solution
> > - `L176-L178` $= 125.18 - (-7.01) = 132.19$ = remaining balance + this year's interest; `MIN(220.41, 132.19)` picks the smaller.
> > - **Key move:** the cap stops the model repaying more than exists and pushing debt negative.

## ⚠️ Common Mistakes
- 💡 **Interest in P&L ≠ interest in CF** ➔ link both to the schedule; v2 zeroes finance costs while the lease (518.6) stays on the balance sheet.
- 💡 **Sign of `L176-L178`** ➔ interest is stored negative, so `BOP − interest` adds it back ➔ total owed this year.
