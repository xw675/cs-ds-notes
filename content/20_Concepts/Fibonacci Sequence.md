---
unit: [FIT1058, FIT2004]
domain: D
week: [2, 6]
parent: "[[Recurrence Relation]]"
tags: [Math/Discrete, Math/Sequences, CS/Algorithms]
aliases: [fast doubling, Fibonacci matrix identity]
---
# [[Fibonacci Sequence]]

**Context:** [[FIT1058_MOC]], [[FIT2004_MOC]] · a two-term [[Recurrence Relation|recurrence]] with no obvious closed form · bounded by [[Mathematical Induction]] · closed form built from a quadratic's roots
**FIT2004 use:** §4 and the Proof Blueprint (Applied 2 P7) — the **matrix identity** and the **doubling identities** that turn the naive $O(2^{n})$ recursion into a halving one ➔ [[Analysing Recursive Algorithms (Time and Auxiliary Space)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $f_1=f_2=1,\ f_n=f_{n-1}+f_{n-2}$ ➔ $1,1,2,3,5,8,13,\dots$.
> - **📦 Core Components:** two base cases ➔ strong induction bounds ➔ Binet closed form ➔ matrix/doubling identities.
> - **⚡ Key Constraint:** $f_n=\Theta(r_1^n)$, $r_1=\frac{1+\sqrt5}2$; the exact formula needs **both** roots of $r^2=r+1$.

## 📝 Core
### 1. The Recurrence
- **Definition** ➔ $f_1=f_2=1$, $f_n=f_{n-1}+f_{n-2}$ ($n\ge3$); **two base cases** because the rule only applies for $n\ge3$.

### 2. Bounding by Induction
- **Upper** ➔ $f_n\le2^n$ (basis $f_1,f_2$; step $2^k+2^{k-1}<2^{k+1}$).
- **Lower** ➔ $f_n\ge\tfrac49\cdot1.5^n$ ($\tfrac49$ chosen so both bases hold).
- **Sharp** ➔ $r_1^{n-2}\le f_n\le r_1^n$, $r_1=\frac{1+\sqrt5}2$.

### 3. Exact (Binet) Formula
- **Characteristic** ➔ roots of $r^2-r-1=0$: $r_1=\frac{1+\sqrt5}2$, $r_2=\frac{1-\sqrt5}2$.
- **Form** ➔ $f_n=\alpha_1r_1^n+\alpha_2r_2^n$, matched by $\alpha_1=-\alpha_2=\tfrac1{\sqrt5}$:
$$f_n=\frac1{\sqrt5}\left(\tfrac{1+\sqrt5}2\right)^n-\frac1{\sqrt5}\left(\tfrac{1-\sqrt5}2\right)^n$$

### 4. Matrix Form and the Doubling Identities *(FIT2004)*
- **⚠️ Indexing shifts here** ➔ FIT2004 uses $F(0)=0$, $F(1)=1$; FIT1058 starts at $f_1=f_2=1$. They agree for $n\ge1$, but a proof written in the wrong convention fails its own base case.
- **The matrix identity** ➔ one matrix power encodes two consecutive Fibonacci numbers:
$$
\begin{bmatrix} 1 & 1 \\ 1 & 0 \end{bmatrix}^{n}
= \begin{bmatrix} F(n+1) & F(n) \\ F(n) & F(n-1) \end{bmatrix}, \qquad n\ge1
$$
- **Doubling falls out of $M^{2k}=(M^{k})^{2}$** ➔ squaring the RHS and reading off entries:
$$
\begin{aligned}
F(2k+1) &= F(k+1)^{2}+F(k)^{2} && \text{(top-left entry)} \\
F(2k) &= F(k)F(k+1)+F(k-1)F(k) && \text{(top-right entry)} \\
&= F(k)\big[2F(k+1)-F(k)\big] && \text{(substitute } F(k-1)=F(k+1)-F(k))
\end{aligned}
$$
- **The elimination step is the marked one** ➔ the required identity contains no $F(k-1)$, so rearranging the defining recurrence and substituting is what closes the derivation.
- **Why an algorithms unit cares** ➔ both identities express index $2k$ via index $k$, **halving the index** each step ⟹ depth $\Theta(\log n)$ against the naive recurrence's $\Theta(n)$ depth and $O(2^{n})$ time. Same move as `power_fast`: *divide the parameter instead of decrementing it*.
- **$F(k)$ appears twice in each identity** ➔ compute it once and reuse it, or the halving is spent on a binary call tree and the win evaporates ➔ the duplicate-call trap in [[Analysing Recursive Algorithms (Time and Auxiliary Space)]].

## 🧮 Proof Blueprint — the matrix identity by induction
**Theorem.** $L(n)=R(n)$ for all $n\ge1$, where $L(n)=\begin{bmatrix}1&1\\1&0\end{bmatrix}^{n}$ and $R(n)=\begin{bmatrix}F(n+1)&F(n)\\F(n)&F(n-1)\end{bmatrix}$.
**Strategy.** Induction on $n$; peel one factor off the power, invoke the hypothesis, let the defining recurrence re-fold the entries.

**Base case** ($n=1$):
$$
L(1)=\begin{bmatrix} 1 & 1 \\ 1 & 0 \end{bmatrix}
= \begin{bmatrix} F(2) & F(1) \\ F(1) & F(0) \end{bmatrix}=R(1)\ \checkmark
$$

**Inductive step.** Assume $L(k)=R(k)$ for some $k\ge1$:
$$
\begin{aligned}
L(k+1) &= L(k)\begin{bmatrix} 1 & 1 \\ 1 & 0 \end{bmatrix} = R(k)\begin{bmatrix} 1 & 1 \\ 1 & 0 \end{bmatrix} && \text{(inductive hypothesis)} \\
&= \begin{bmatrix} F(k+1)+F(k) & F(k+1) \\ F(k)+F(k-1) & F(k) \end{bmatrix}
= \begin{bmatrix} F(k+2) & F(k+1) \\ F(k+1) & F(k) \end{bmatrix} = R(k+1) && \blacksquare
\end{aligned}
$$
- **The whole proof is one factorisation** ➔ writing $L(k+1)=L(k)\cdot L(1)$ creates the place for the hypothesis; expanding $L(k+1)$ directly leaves nothing to substitute into.
- **The recurrence does the re-folding** ➔ every product entry is a sum of two consecutive Fibonacci numbers, so $F(a)+F(a-1)=F(a+1)$ converts it back to $R$-shape.

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
$$f_1..f_7 = 1,1,2,3,5,8,13; \qquad f_7 = \tfrac1{\sqrt5}(r_1^7-r_2^7) = \tfrac1{\sqrt5}(29.03\ldots+0.03\ldots) = 13\ \checkmark$$
**Final Extracted Output:** $f_7=13$ from both recurrence and Binet.

## ⚠️ Common Mistakes
- 💡 **Two base cases required** ➔ the step uses the hypothesis at $k$ *and* $k-1$ (strong induction), so $n=1,2$ must be checked separately.
- 💡 **Mixing the two indexing conventions** ➔ the matrix identity's base case reads $F(0)=0$ in the bottom-right corner; carrying $f_1=f_2=1$ into it makes $R(1)$ wrong and the induction unprovable.
- 💡 **Expanding $L(k+1)$ instead of factorising it** ➔ the hypothesis can only be invoked once $L(k)$ appears literally.

## 🧠 Active Recall
> [!FAQ]- The doubling identities express $F(2k)$ and $F(2k+1)$ via $F(k)$ and $F(k+1)$. Why is that an *algorithmic* result, not just an algebraic curiosity?
> - **Hint:** Compare how the index moves against the naive recurrence.
> > [!SUCCESS]- Answer
> > - **Short answer:** the naive recurrence decrements the index and branches, giving depth $\Theta(n)$ and $O(2^{n})$ time; the doubling identities **halve** it, so depth drops to $\Theta(\log n)$.
> > - **Why:** **Divide the parameter, don't decrement it** ➔ the same shift that separates `power` from `power_fast`, and it only pays off if the repeated $F(k)$ term is computed **once** and reused — otherwise the halved depth is refilled by a binary call tree.

> [!FAQ]- Why do bounds need only one root but Binet needs both — and why does $f_n\le2^n$ require *two* base cases?
> - **Hint:** Inequality vs equality; strong induction.
> > [!SUCCESS]- Answer
> > - **Short answer:** a bound $r^n$ has one free constant matched by one base case (inequality); an exact formula matches two base cases with equality, needing both roots. The induction itself uses the hypothesis at $k$ *and* $k-1$, so $f_1,f_2$ are both checked.
> > - **Why:** **$r_2<0$** ➔ breaks the basis as a bound but is indispensable in Binet; and a two-predecessor recurrence needs two anchors before the step can fire.
