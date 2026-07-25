---
unit: FIT2004
week: 1
parent: "[[Big-O Notation]]"
tags:
  - CS/Algorithms
  - CS/Complexity
  - Math/Analysis
aliases:
  - solving recurrences
  - telescoping
  - repeated substitution
  - recurrence analysis
  - T(n) recurrence
  - recursion tree
  - master theorem
---
# [[Solving Recurrences (Telescoping)]]

**Context:** [[FIT2004_MOC]] · turning a recursive algorithm's cost recurrence $T(n)$ into a [[Big-O Notation|Big-O]] bound · the analysis half of [[Divide and Conquer]] (the maths of [[Recurrence Relation]] applied to running time)

> [!abstract] Quick Revision
> - **🎯 Objective:** a recursive algorithm's running time obeys a **recurrence** ($T(N)=T(N-1)+c$, $T(N)=T(N/2)+c$, $T(n)=aT(n/b)+f(n)$, …) ➔ solve it for a closed-form growth class by **telescoping**.
> - **⚡ Key Constraint:** the method the unit uses is **repeated substitution (telescoping)**: expand a few steps, spot the **general form** in $k$, then fix $k$ from the **base case** and back-substitute. The Master Theorem below is a shortcut, **not** part of the Week 1 lecture.

## 📝 Telescoping — the lecture method (5 steps)
1. **Write** the recurrence and its base case (e.g. $T(N)=T(N-1)+c$, $T(1)=b$).
2. **Expand** two or three steps by substituting the recurrence into itself.
3. **Spot the general form** after $k$ steps (a formula in $N$ and $k$).
4. **Fix $k$** from the base case (choose $k$ so the argument reaches the base, e.g. $N-k=1$).
5. **Back-substitute** $k$ to get the closed form, then read off the Big-O.

## 📊 Worked example 1 — linear `power` ($T(N)=T(N-1)+c$)
Algorithm: `power(x, N)` returns `x * power(x, N-1)`, base `power(x,1)=x`.
$$
\begin{aligned}
T(N) &= T(N-1)+c \\
&= T(N-2)+c+c \\
&= T(N-3)+c+c+c \\
&\;\;\vdots \\
&= T(N-k)+k c && \text{(general form)} \\
\text{base: } N-k=1 &\Rightarrow k=N-1 && \text{(fix } k\text{)} \\
T(N) &= T(1)+(N-1)c = b+Nc-c = O(N) && \text{(back-substitute)}
\end{aligned}
$$

## 📊 Worked example 2 — logarithmic `power_better` ($T(N)=T(N/2)+c$)
Algorithm: repeatedly squares the base and halves $N$ — `power_better(x*x, N/2)`.
$$
\begin{aligned}
T(N) &= T(N/2)+c = T(N/4)+2c = T(N/8)+3c \\
&= T(N/2^{k})+k c && \text{(general form)} \\
\text{base: } N/2^{k}=1 &\Rightarrow 2^{k}=N \Rightarrow k=\log_2 N \\
T(N) &= T(1)+c\log_2 N = O(\log N)
\end{aligned}
$$
- **The lesson** ➔ *subtracting* from $N$ each step (Example 1) gives $O(N)$; *dividing* $N$ each step (Example 2) gives $O(\log N)$ — the halving is exactly why `power_better` beats `power`.

## 📊 Worked example 3 — divide-and-conquer ($T(n)=2T(n/2)+\Theta(n)$, [[Merge Sort]])
Telescoping still works when there is more than one recursive call — expand and sum the per-level work:
$$
\begin{aligned}
T(n) &= 2T(n/2)+cn = 2\big(2T(n/4)+c\tfrac{n}{2}\big)+cn = 4T(n/4)+2cn \\
&= 2^{k}T(n/2^{k}) + k\,cn && \text{(general form: } k\,cn \text{ work total per level)} \\
\text{base: } n/2^{k}=1 &\Rightarrow k=\log_2 n \\
T(n) &= n\,T(1) + cn\log_2 n = \Theta(n\log n)
\end{aligned}
$$
- **Karatsuba** ($T(n)=3T(n/2)+\Theta(n)$) telescopes the same way but the level-sum is **geometric** (ratio $3/2$), dominated by the $3^{\log_2 n}=n^{\log_2 3}$ leaves ⟹ $\Theta(n^{\log_2 3})$. See [[Karatsuba Integer Multiplication]].

## 🔭 Beyond Week 1 — the Master Theorem *(shortcut, not in the lecture slides)*
> [!NOTE] The Week 1 deck solves everything by **telescoping**; the Master Theorem is a standard lookup that gives the same answers for the divide-and-conquer family without the algebra. Included here as a revision aid — **cite telescoping in assessments unless the Master Theorem has been formally introduced.**

For $T(n)=a\,T(n/b)+\Theta(n^{d})$ compare $d$ with the critical exponent $\log_b a$:

| Case | Condition | Result | Dominated by |
| :--- | :--- | :--- | :--- |
| 1 | $d<\log_b a$ | $\Theta\!\big(n^{\log_b a}\big)$ | the leaves |
| 2 | $d=\log_b a$ | $\Theta\!\big(n^{d}\log n\big)$ | every level equally |
| 3 | $d>\log_b a$ | $\Theta\!\big(n^{d}\big)$ | the root (combine) |

Quick checks: merge sort $a{=}2,b{=}2,d{=}1\Rightarrow\log_2 2{=}1$ = Case 2 ⟹ $\Theta(n\log n)$; Karatsuba $a{=}3,b{=}2,d{=}1$, $\log_2 3\approx1.585{>}1$ = Case 1 ⟹ $\Theta(n^{1.585})$ — matching the telescoping results above.

## ⚠️ Common Mistakes
- 💡 **Fix $k$ from the base case** ➔ the general form has an unknown depth $k$; you must set it so the recursion reaches the base (e.g. $N-k=1$ or $n/2^{k}=1$) before reading off the complexity.
- 💡 **Subtract vs divide changes the class** ➔ $T(N)=T(N-1)+c\Rightarrow O(N)$ but $T(N)=T(N/2)+c\Rightarrow O(\log N)$; check whether the argument shrinks additively or multiplicatively.
- 💡 **With ≥2 calls, sum the level totals** ➔ don't forget the $2^{i}$ (or $a^{i}$) multiplier on each level's work when telescoping a divide-and-conquer recurrence.
- 💡 **Master Theorem is supplementary here** ➔ it only fits the $a\,T(n/b)+f(n)$ shape and was **not** taught in Week 1 — use telescoping as the primary method.

## 🧠 Active Recall
> [!FAQ]- Solve $T(N)=T(N/2)+c$ by telescoping and give the complexity.
> > [!SUCCESS]- Answer
> > - **Short answer:** expanding gives $T(N)=T(N/2^{k})+kc$; the base case $N/2^{k}=1$ fixes $k=\log_2 N$, so $T(N)=T(1)+c\log_2 N=O(\log N)$.
> > - **Why:** **Halving depth is logarithmic** ➔ each step divides the argument by $2$ and adds constant work, so it takes $\log_2 N$ steps to reach the base and the total is $\Theta(\log N)$ — this is why `power_better` is exponentially faster than the $O(N)$ `power`.

> [!FAQ]- Why does `power` cost $O(N)$ but `power_better` only $O(\log N)$, in terms of their recurrences?
> > [!SUCCESS]- Answer
> > - **Short answer:** `power` recurses on $N-1$ ($T(N)=T(N-1)+c$), telescoping to $T(N)=T(1)+(N-1)c=O(N)$; `power_better` recurses on $N/2$ ($T(N)=T(N/2)+c$), telescoping to $O(\log N)$.
> > - **Why:** **Additive vs multiplicative shrink** ➔ subtracting $1$ needs $\sim N$ steps to reach the base, while halving needs only $\sim\log_2 N$; the constant per-step work then sums to $O(N)$ vs $O(\log N)$.
