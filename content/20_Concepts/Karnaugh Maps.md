---
unit: FIT1047
domain: [D, F]
week: 2
parent: "[[Sum-of-Products (Functions to Circuits)]]"
tags: [CS/Systems, Math/Logic]
aliases: [K-Maps, K-Map Simplification]
---
# [[Karnaugh Maps]]

**Context:** [[FIT1047_MOC]] · systematic minimisation of a truth table into the **simplest SOP** · replaces ad-hoc law-chasing ([[Boolean Algebra Laws]]) · **the Assignment 1 circuit-simplification skill**

> [!abstract] Quick Revision
> - **🎯 Objective:** plot the truth table on a grid whose neighbours differ in ONE variable ➔ circle maximal power-of-2 groups of 1s ➔ read each group as a product dropping every variable that varies inside it.
> - **📦 Core Components:** Gray-code column order ($00,01,\mathbf{11},\mathbf{10}$) ➔ grouping rules ➔ read-off.
> - **⚡ Key Constraint:** column order is NOT binary counting — $11$ before $10$; wrap-around groups are legal.

## 📝 Core
- **Layout** ➔ variables split across axes; adjacent cells (including **wrap-around** edges) differ in exactly one variable — that's what makes grouping = simplification.
- **Why it works** ➔ a group covering $B{=}0$ and $B{=}1$ with everything else fixed means $B$ is irrelevant there: $A\overline{B}+AB = A$ — the map makes this VISUAL.
- **Read-off** ➔ per group, keep only variables constant across the group (complemented if constantly $0$); OR the group-terms.
- **Scope** ➔ best for ≤6 variables; produces the minimal SOP; larger functions use automated tools.

## ⚖️ Core Decision Matrix — grouping rules (the marker's checklist)
| Rule | Correct | Wrong |
| :-- | :-- | :-- |
| contents | only 1s | any 0 inside a group |
| shape | rectangular | diagonal / L-shaped |
| size | power of 2 ($1,2,4,8$) | groups of 3, 5, 6 |
| extent | as LARGE as possible | splitting a 4-block into two 2-blocks |
| coverage | every 1 in ≥1 group | any orphan 1 |
| overlap | allowed and often needed | — |
| edges | wrap-around allowed (left–right, top–bottom) | treating edges as walls |

## 📊 Exam Execution Trace — lecture 3-variable example
Truth table ($F=1$ on $010,011,100,110,111$) plotted with columns $XY = 00,01,11,10$ and rows $Z = 0,1$:

| $Z \backslash XY$ | $00$ | $01$ | $11$ | $10$ |
| :-- | :-- | :-- | :-- | :-- |
| $0$ | $0$ | $1$ | $1$ | $1$ |
| $1$ | $0$ | $1$ | $1$ | $0$ |

| Step | Group | Constant vars | Term |
| :-- | :-- | :-- | :-- |
| 1 | $2{\times}2$ block (columns $01,11$, both rows) | $Y{=}1$ only ($X,Z$ both vary) | $Y$ |
| 2 | pair (columns $11,10$, row $Z{=}0$) | $X{=}1$, $Z{=}0$ ($Y$ varies) | $X\overline{Z}$ |
**Result:** $F = Y + X\overline{Z}$ — versus the 5-term raw SOP from [[Sum-of-Products (Functions to Circuits)]].

## ✍️ Practice
> [!QUESTION]- Plot $F(X,Y,Z)$ with 1s at $000, 010, 100, 110$ (i.e. all rows with $Z=0$)… but draw the map first without reading ahead. Group and simplify.
> > [!SUCCESS]- Answer
> > - Map: entire $Z{=}0$ row is 1s ➔ one group of 4 (wrapping across all columns).
> > - $X,Y$ both vary ⟹ dropped; $Z$ constantly $0$ ⟹ $F = \overline{Z}$.
> > - **Key move:** the bigger the group, the fewer the surviving variables — a 4-group in a 3-var map leaves exactly one.

## ⚠️ Common Mistakes
- 💡 **$00,01,11,10$ — not $00,01,10,11$** ➔ binary-counting order breaks single-bit adjacency and every grouping after it.
- 💡 **Maximal beats multiple** ➔ two 2-groups where one 4-group fits gives a correct but NON-minimal answer — marked down.
- 💡 **Forgetting wrap-around** ➔ leftmost and rightmost columns are neighbours; missing edge groups leaves redundant terms.
