---
unit: FIT1058
domain: D
week: 6
parent: "[[Sequence (Mathematics)]]"
tags: [Math/Discrete, Math/Sequences]
---
# [[Arithmetic, Geometric, and Harmonic Sequences]]

**Context:** [[FIT1058_MOC]] · the three classic number-[[Sequence (Mathematics)|sequence]] families · each a one-line [[Recurrence Relation|recurrence]] with a clean closed form · summed by [[Arithmetic Series]] / [[Geometric Series]]

> [!abstract] Quick Revision
> - **🎯 Objective:** three standard sequence families ➔ arithmetic (diff $d$), geometric (ratio $r$), harmonic (reciprocals arithmetic).
> - **📦 Core Components:** closed forms $a+(n-1)d$, $ar^{n-1}$, $\frac1{a+(n-1)d}$.
> - **⚡ Key Constraint:** arithmetic grows linearly, geometric exponentially; harmonic defined via reciprocals.

## 📝 Core
### 1. The Three Families
- **Arithmetic** ➔ constant **difference** $d$ ➔ $f_n=a+(n-1)d$.
- **Geometric** ➔ constant **ratio** $r$ ➔ $f_n=ar^{n-1}$.
- **Harmonic** ➔ reciprocals are arithmetic ➔ $f_n=\frac1{a+(n-1)d}$.

### 2. Reading Off Parameters
- **Arithmetic** ➔ evens $0,2,4$ ($a{=}0,d{=}2$); countdown $10,\dots,0$ ($a{=}10,d{=}-1$).
- **Geometric** ➔ powers of 2 ($a{=}1,r{=}2$).
- **Harmonic** ➔ canonical $(\tfrac1n)$ (integers are arithmetic).

## ⚖️ Core Decision Matrix
| Family            | Growth                     | Sum                   |
| :---------------- | :------------------------- | :-------------------- |
| arithmetic        | linear $\Theta(n)$         | [[Arithmetic Series]] |
| geometric ($r>1$) | exponential                | [[Geometric Series]]  |
| geometric ($r<1$) | decays to 0                | converges             |
| harmonic          | $\sim\ln n$ (partial sums) | harmonic number       |

> [!NOTE] **When It Flips:** the constant *difference* vs constant *ratio* is exactly why arithmetic is linear and geometric exponential — the same gap that makes geometric series converge while arithmetic ones diverge. Degenerate: $d=0$ or $r=1$ gives a constant sequence.

## 📊 Exam Execution Trace

### Manual Execution Trace
Identify families:

| Step / State | Sequence | Family | Params |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | $3,7,11,15$ | arithmetic | $a{=}3,d{=}4$ |
| 2 | $2,6,18,54$ | geometric | $a{=}2,r{=}3$ |
| 3 | $3,4,6,12$ | harmonic | recip. $d{=}-\tfrac1{12}$ |

## ⚠️ Common Mistakes
- 💡 **Harmonic is indirect** ➔ it is not itself arithmetic/geometric; prove harmonic facts by passing to reciprocals ($3,4,6,12$ → $\tfrac{4}{12},\tfrac{3}{12},\tfrac{2}{12},\tfrac{1}{12}$).

## 🧠 Active Recall
> [!FAQ]- Give the recurrence and closed form for arithmetic and geometric sequences, and contrast their growth.
> - **Hint:** Difference vs ratio.
> > [!SUCCESS]- Answer
> > - **Short answer:** Arithmetic $f_n=a+(n-1)d$ (linear); geometric $f_n=ar^{n-1}$ (exponential/decaying).
> > - **Why:** **Constant $d$ vs $r$** ➔ additive step → linear, multiplicative step → exponential.

> [!FAQ]- What makes a sequence harmonic, and why is $3,4,6,12$ one?
> - **Hint:** Reciprocals arithmetic.
> > [!SUCCESS]- Answer
> > - **Short answer:** Reciprocals form an arithmetic sequence; $\tfrac13,\tfrac14,\tfrac16,\tfrac1{12}$ have common difference $-\tfrac1{12}$.
> > - **Why:** **Canonical $(\tfrac1n)$** ➔ integers are arithmetic.
