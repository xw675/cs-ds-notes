---
unit: MUIG-AAP
week: 2
source: [applied]
parent: "[[Three-Statement Model (Linkages)]]"
tags: [Finance/Modelling, Tool/Excel]
aliases: [Working Capital Schedule, DSO, DPO, Cash Conversion Cycle, NWC]
type: pattern
---
# [[Working Capital Schedule (Days Method)]]

**Context:** [[MUIG_AAP_MOC]] · forecast receivables/payables from turnover days so they scale with activity · feeds CFO and $\Delta\text{NWC}$ in [[DCF Valuation (FCFF)]]
**Problem it solves:** a growing business ties up cash in receivables; "hold balances constant" (v2 answer) silently assumes that cost away.

> [!abstract] Quick Revision
> - **🎯 Trigger:** forecasting trade receivables / payables ➔ compute historical days → assume forecast days → balance $=$ flow $\times$ days $/ 365$ → cash impact $=$ change in balance.
> - **⚠️ Key Constraint:** sign — **rising receivables consume cash, rising payables provide cash**: $\Delta\text{cash} = (\text{AR}_{t-1} - \text{AR}_t) - (\text{AP}_{t-1} - \text{AP}_t)$.

## 🔧 Minimal Working Example
$$\text{Receivable days} = \frac{\text{Trade receivables}}{\text{Revenue}} \times 365 \qquad \text{Payable days} = \frac{\text{Trade payables}}{\text{COGS}} \times 365$$
$$\text{Cash conversion cycle} = \text{Inventory days} + \text{Receivable days} - \text{Payable days}$$
```excel
L164: =AVERAGE(H164:J164)          ' forecast DSO = 3-yr avg (5.39 days)
L168: =L104*L164/365               ' AR = Revenue × DSO / 365
L169: =-L115*L165/365              ' AP = COGS × DPO / 365  (COGS stored negative)
L167: =(J168-L168)-(J169-L169)     ' cash impact of NWC change
```
**Expected output (Lesson 2 answer, FY26):** AR $594.8 \to 454.9$ (+139.9 cash) · AP $298.2 \to 129.1$ (−169.2 cash) ➔ $\Delta$NWC cash impact $= -29.25$.

**Company A history:** receivable days 15.5 → 11.3 → 3.6 → 3.0 → 9.7; payable days 12.4 → 17.5 → 0 → 0 → 5.7; CCC ≈ 3–4 days ➔ almost cash-on-delivery, so NWC is a small lever here.

## ✏️ Practice
> [!QUESTION]- Practice 1: FY27 revenue 42,109.6, COGS −34,044.8, DSO 5.39, DPO 1.89, FY26 AR 454.9, AP 129.1. Compute FY27 AR, AP and the cash impact.
> > [!SUCCESS]- Reference solution
> > ```text
> > AR27 = 42,109.6 × 5.39/365 = 622.3
> > AP27 = 34,044.8 × 1.89/365 = 176.6
> > Cash impact = (454.9 − 622.3) − (129.1 − 176.6) = −167.5 + 47.5 = −120.0
> > ```
> > - **Key move:** compare with the **previous forecast year**, not a blank column.

## ⚠️ Common Mistakes
- 💡 **Spacer-column bug (Lesson 2 sample answer)** ➔ FY27's formula `=(K168-M168)-(K169-M169)` points at the empty separator column K instead of FY26 (L) ➔ shows −445.8 instead of −120.0. Copying the FY26 formula right across a gap shifts references into the gap.
- 💡 **Wrong denominator** ➔ payable days use **COGS** (what you buy), receivable days use **revenue** — the v2 Schedule sheet divides payables by revenue despite its "cost of sales × days" note.
- 💡 **Constant balances under growth** ➔ zero $\Delta$NWC flatters FCFF whenever revenue grows.
