---
unit: FIT1058
week: 1
parent: "[[Set (Mathematics)]]"
tags: [Math/SetTheory, Math/Discrete]
---
# [[Sets of Numbers]]

**Context:** [[FIT1058_MOC]] · the named standard [[Set (Mathematics)|sets]] used throughout computing · restricted by sign/zero · refined into intervals

> [!abstract] Quick Revision
> - **🎯 Objective:** reserved symbols for common number sets ➔ each carries its usual operations.
> - **📦 Core Components:** $\mathbb N\subset\mathbb Z\subset\mathbb Q\subset\mathbb R$ ➔ sign/zero restrictions ➔ interval notation.
> - **⚡ Key Constraint:** $\mathbb N$ vs $\mathbb N_0$ differ only by **zero**; bracket type fixes interval endpoints.

## 📝 Core
### 1. The Named Sets
- **$\mathbb N=\{1,2,3,\dots\}$** ➔ positive integers; **$\mathbb N_0$** ➔ adds $0$.
- **$\mathbb Z$** ➔ all integers; **$\mathbb Q=\{p/q:p,q\in\mathbb Z,q\neq0\}$** ➔ rationals; **$\mathbb R$** ➔ reals.
- **Chain** ➔ $\mathbb N\subset\mathbb Z\subset\mathbb Q\subset\mathbb R$ (proper subsets).

### 2. Sign/Zero Restrictions
- **Superscript = sign** ➔ $\mathbb Z^+=\mathbb N$, $\mathbb R^-=\{x<0\}$.
- **Subscript $0$ = "and zero"** ➔ $\mathbb R^+_0=\{x\ge0\}$, $\mathbb Q^-_0=\{x\le0\}$.

### 3. Interval Notation
- **Square = includes** endpoint; **round = excludes**.
- **Forms** ➔ $[a,b]$ closed, $[a,b)$/$(a,b]$ half-open, $(a,b)$ open.
- **Subscript** ➔ $[a,b]_{\mathbb Z}$ = integers between $a,b$ inclusive.

**Key identities:**

$$\mathbb N=\{1,2,\dots\},\ \mathbb N_0=\{0,1,\dots\},\ \mathbb Z,\ \mathbb Q=\{p/q:q\neq0\},\ \mathbb R$$
$$[a,b]=\{x\in\mathbb R:a\le x\le b\},\quad [a,b)=\{a\le x<b\},\quad (a,b)=\{a<x<b\}$$

## ⚖️ Core Decision Matrix
| Symbol | Set | Note |
| :--- | :--- | :--- |
| $\mathbb N$ | $\{1,2,3,\dots\}$ | positive integers |
| $\mathbb N_0$ | $\{0,1,2,\dots\}$ | adds zero |
| $\mathbb Z^+$ | $\mathbb N$ | superscript = sign |
| $\mathbb R^+_0$ | $\{x\ge0\}$ | positives + zero |

> [!NOTE] **When It Flips:** each name denotes the set *and* its operations — context decides whether "$\mathbb Z$" means the elements or the system $(\mathbb Z,+,\times)$. A number set (e.g. $\mathbb Z$) often serves as the universal set $U$ for a numeric problem.

## 📊 Exam Execution Trace

### Manual Execution Trace
Smallest standard set each value belongs to:

| Step / State | Value | Smallest set |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | $-3$ | $\mathbb Z$ |
| 2 | $0$ | $\mathbb N_0$ |
| 3 | $\tfrac25$ | $\mathbb Q$ |
| 4 | $\sqrt2,\pi$ | $\mathbb R$ (irrational) |

## ⚠️ Common Mistakes
- 💡 **$\mathbb N$ vs $\mathbb N_0$** ➔ differ only by $0$ ($0\in\mathbb N_0$, $0\notin\mathbb N$ in this unit); a square bracket includes its endpoint, a round bracket excludes it.

## 🧠 Active Recall
> [!FAQ]- Distinguish $\mathbb N$, $\mathbb N_0$, $\mathbb Z^+$, and $\mathbb R^+_0$.
> - **Hint:** Sign superscript, zero subscript.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\mathbb N=\{1,2,\dots\}$; $\mathbb N_0$ adds $0$; $\mathbb Z^+=\mathbb N$; $\mathbb R^+_0=\{x\ge0\}$.
> > - **Why:** **Notation** ➔ superscript sets the sign, subscript $0$ re-admits zero.

> [!FAQ]- Write $[a,b)$ and $(a,b)$ as set-builder and say which endpoints are members; what is $[a,b]_{\mathbb Z}$?
> - **Hint:** Bracket = membership.
> > [!SUCCESS]- Answer
> > - **Short answer:** $[a,b)=\{a\le x<b\}$ (includes $a$); $(a,b)=\{a<x<b\}$ (open); $[a,b]_{\mathbb Z}=\{x\in\mathbb Z:a\le x\le b\}$.
> > - **Why:** **Square includes, round excludes** ➔ the subscript restricts to integers.
