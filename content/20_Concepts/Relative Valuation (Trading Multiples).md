---
unit: MUIG-AAP
week: [0, 3]
source: [slides, reading]
parent: "[[Target Price and Valuation Triangulation]]"
tags: [Finance/Valuation]
aliases: [Relative Valuation, Trading Comps, Comparable Companies, Multiples, EV/EBITDA, PE Ratio]
type: pattern
---
# [[Relative Valuation (Trading Multiples)]]

**Context:** [[MUIG_AAP_MOC]] · value a stock off what the market pays for peers · usually a cross-check on the DCF, never the thesis itself ([[Ratios for Shortlisting vs Evaluating]])
**Problem it solves:** a market-based price target to test whether the DCF is in a sane range.

> [!abstract] Quick Revision
> - **🎯 Trigger:** need a market cross-check ➔ clean peer set → choose multiple → peer average/median (forward) × subject's metric → bridge to equity → per share.
> - **⚠️ Key Constraint:** **numerator matches denominator** — EV multiples (EV/EBITDA) give EV and need the EV→equity bridge; equity multiples (P/E, P/B) give equity value directly.

## 🔧 Minimal Working Example
**TNB — forward EV/EBITDA (Monash Team B report, RM m)**
| Step | Value |
| :--- | :--- |
| Peer set (Asia, market-structure relevant, outliers excluded) | Aboitiz Power, Malakoff, MER, PetroVietnam Power, YTL Power |
| Peer average forward EV/EBITDA | 7.87x (median 8.20x) |
| × Normalised FY26 EBITDA | 22,092 |
| = Enterprise value | 173,835 |
| − Total debt − minority interest + cash | −88,265 − 2,223 + 14,466 |
| = Equity value | 97,813 |
| ÷ 5,829m shares | **RM16.78** (+23.9% vs RM13.54) |

**Expected output:** RM16.78 vs DCF RM16.09 ➔ "broadly consistent", reaffirms BUY. TNB itself trades at 7.22x forward — a discount despite higher EBITDA margin (25.1% vs peer avg 19.8%), attributed to market preference for growth and perceived regulatory risk.

## 🔀 Variations
| Multiple | Captures | When reports used it |
| :--- | :--- | :--- |
| EV/EBITDA | operating cash generation, capital-structure neutral | TNB (utilities), DOM, P&G exit multiple |
| P/E | equity-specific earnings incl. leverage | DOM (avg with EV/EBITDA) |
| P/B (vs ROE regression) | balance-sheet value | DOM — asset-heavy real-estate developer |
| Dividend yield, P/S, P/CF | screening / sector-specific | listed in CFA guide & Fundamentals |

- **Forward vs trailing** ➔ forward multiples reflect market expectations (TNB: 2-year weekly average of forward EV/EBITDA).
- **Two peer groups** ➔ DOM benchmarked Polish developers **and** Western European developers (convergence argument).

## ✏️ Practice
> [!QUESTION]- Practice 1: Press Metal trades on ~24x PE, A-Rank ~7x. A classmate values A-Rank at 24x its earnings "because they're peers". What's wrong?
> > [!SUCCESS]- Reference solution
> > - **Peer test fails:** different business models (integrated smelter with cost moat vs pass-through remelter) and risk profiles ➔ not comparable.
> > - **Key move:** peers must share segments **and** risk ([[Competitive Positioning and Economic Moat]]); a multiple carries the business quality of the companies it comes from.

## ⚠️ Common Mistakes
- 💡 **Mismatched pair** ➔ applying an EV/EBITDA to EBITDA and calling the result equity value (skipping the bridge).
- 💡 **Average swallowed by outliers** ➔ check the median; exclude outliers with a stated reason.
- 💡 **Relative ≠ intrinsic** ➔ if the whole sector is overpriced, comps say "fair" — the DCF is the anchor.
