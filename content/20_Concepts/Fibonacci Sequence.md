---
unit: FIT1058
domain: D
week: 6
parent: "[[Recurrence Relation]]"
tags: [Math/Discrete, Math/Sequences]
---
# [[Fibonacci Sequence]]

**Context:** [[FIT1058_MOC]] · a two-term [[Recurrence Relation|recurrence]] with no obvious closed form · bounded by [[Mathematical Induction]] · closed form built from a quadratic's roots

> [!abstract] Quick Revision
> - **🎯 Objective:** $f_1=f_2=1,\ f_n=f_{n-1}+f_{n-2}$ ➔ $1,1,2,3,5,8,13,\dots$.
> - **📦 Core Components:** two base cases ➔ strong induction bounds ➔ Binet closed form.
> - **⚡ Key Constraint:** $f_n=\Theta(r_1^n)$, $r_1=\frac{1+\sqrt5}2$; exact formula needs **both** roots of $r^2=r+1$.

## 📝 Core
### 1. The Recurrence
- **Definition** ➔ $f_1=f_2=1$, $f_n=f_{n-1}+f_{n-2}$ ($n\ge3$).
- **Two base cases** ➔ the rule only applies for $n\ge3$.
- **Standard example** ➔ bounding a sequence before/instead of an exact formula.

### 2. Bounding by Induction
- **Upper** ➔ $f_n\le2^n$ (basis $f_1,f_2$; step $2^k+2^{k-1}<2^{k+1}$).
- **Lower** ➔ $f_n\ge\tfrac49\cdot1.5^n$ ($\tfrac49$ chosen so both bases hold).
- **Sharp** ➔ $r_1^{n-2}\le f_n\le r_1^n$, $r_1=\frac{1+\sqrt5}2$.

### 3. Exact (Binet) Formula
- **Characteristic** ➔ roots of $r^2-r-1=0$: $r_1=\frac{1+\sqrt5}2$, $r_2=\frac{1-\sqrt5}2$.
- **Form** ➔ $f_n=\alpha_1r_1^n+\alpha_2r_2^n$, matched by $\alpha_1=-\alpha_2=\tfrac1{\sqrt5}$.

**Key identities:**

$$f_n\le2^n \text{ (induction)},\qquad r^2=r+1 \Rightarrow r_1=\tfrac{1+\sqrt5}2,\ r_2=\tfrac{1-\sqrt5}2$$
$$f_n=\frac1{\sqrt5}\left(\tfrac{1+\sqrt5}2\right)^n-\frac1{\sqrt5}\left(\tfrac{1-\sqrt5}2\right)^n \text{ (Binet)}$$

## ⚖️ Core Decision Matrix
| Goal | Roots used | Base cases matched |
| :--- | :--- | :--- |
| upper bound $r_1^n$ | $r_1$ only | one (inequality) |
| lower bound | $r_1$ only | one |
| exact Binet | $r_1$ **and** $r_2$ | two (equality) |
| growth | $r_1$ | $\Theta(r_1^n)$ |

> [!NOTE] **When It Flips:** a bound of form $r^n$ needs $r^2\ge r+1$ (one free constant, one base case); an exact formula needs equality $r^2=r+1$ and both roots (two constants, two base cases). $r_2<0$ can't be a bound but is essential in Binet. Ratio $f_{n+1}/f_n\to r_1$ (golden ratio).

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Compute $f_1..f_7$ and verify Binet at $n=7$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
f_1..f_7 &= 1,1,2,3,5,8,13 \\
f_7 &= \tfrac1{\sqrt5}(r_1^7-r_2^7) = \tfrac1{\sqrt5}(29.03\ldots+0.03\ldots) = 13\ \checkmark
\end{aligned}
$$
**Final Extracted Output:** $f_7=13$ from both recurrence and Binet.

## ⚠️ Common Mistakes
- 💡 **Two base cases required** ➔ the step uses the hypothesis at $k$ *and* $k-1$ (strong induction), so $n=1,2$ must be checked separately.

## 🧠 Active Recall
> [!FAQ]- Why does proving $f_n\le2^n$ require *two* base cases?
> - **Hint:** Strong induction.
> > [!SUCCESS]- Answer
> > - **Short answer:** The rule holds only for $n\ge3$; $f_1,f_2$ checked directly, and the step uses $k$ and $k-1$.
> > - **Why:** **Two predecessors** ➔ needs two consecutive base cases.

> [!FAQ]- Why do bounds need only one root but Binet needs both?
> - **Hint:** Inequality vs equality.
> > [!SUCCESS]- Answer
> > - **Short answer:** A bound $r^n$ has one free constant (one base case, inequality); an exact formula matches two base cases with equality, needing both roots.
> > - **Why:** **$r_2<0$** ➔ breaks the basis as a bound but is indispensable in Binet.
