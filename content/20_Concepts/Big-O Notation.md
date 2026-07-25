---
unit: [FIT1008, FIT1058, FIT2004]
week: [1, 6]
parent: "[[Algorithmic Complexity]]"
tags: [CS/Complexity, Math/Analysis, CS/Algorithms, Math/Sequences]
---
# [[Big-O Notation]]

**Context:** [[FIT1008_MOC]], [[FIT1058_MOC]] · backbone clustering the **asymptotic-analysis toolkit** — the $O/\Omega/\Theta$ bounds, the dominance method, the combining algebra, and the growth-rate ladder

> [!abstract] Quick Revision
> - **🎯 Objective:** describe order of growth as $n\to\infty$ ➔ keep the dominant term, drop constants, compare by scalability.
> - **📦 Core Components:** **$O$/$\Omega$/$\Theta$** ➔ upper/lower/tight | **dominance** ➔ limit test | **algebra** ➔ sum/product | **class ladder**.
> - **⚡ Key Constraint:** $\Theta=O\cap\Omega$; the **polynomial vs exponential** line is the tractability frontier (P vs NP).

## 📝 Core
### 1. Big-O (Asymptotic Upper Bound)
- **Definition** ➔ $f=O(g) \iff \exists\,c,n_0>0:\ 0\le f(n)\le c\,g(n)\ \forall n\ge n_0$.
- **Set membership** ➔ $O(g)$ is a **set**; "$f=O(g)$" abuses "=" for $f\in O(g)$.
- **Sequence form (FIT1058)** ➔ $a_n=O(f) \iff \exists c,N\ \forall n\ge N:\ a_n\le c\,f(n)$.

### 2. Big-Omega & Big-Theta (Lower / Tight)
- **$\Omega$ / $\Theta$** ➔ $\Omega$ = lower bound; $\Theta$ = tight (upper *and* lower) ➔ $\Theta=O\cap\Omega$.
- **Strict versions** ➔ **little-o** ($\lim f/g=0$), **little-omega** ($\lim f/g=\infty$).
- **Who they describe** ➔ **$\Omega$ = problems** (intrinsic difficulty); **$\Theta$ = algorithms** (exact rate); $O$ meets $\Omega$ ⟹ **optimal**.

### 3. Asymptotic Analysis (Dominance Method)
- **Mechanism** ➔ keep the single **dominating** term, discard constants + lower-order terms.
- **Limit test** ➔ $L=\lim f/g$: $0\Rightarrow o(g)$ | $0<L<\infty\Rightarrow\Theta(g)$ | $\infty\Rightarrow\omega(g)$.
- **Boundary** ➔ dangerous when $n$ stays small or constants are enormous (pair with benchmarking).

### 4. Properties (Combining Algebra)
- **Sum** ➔ $O(g_1)+O(g_2)=O(\max(g_1,g_2))$ (sequential code / branches).
- **Product** ➔ $O(g_1)\cdot O(g_2)=O(g_1g_2)$ (nested loops); $O(g)\cdot O(1)=O(g)$.
- **One-sided** ➔ manipulate **upper** bounds only; transitivity chains through helpers (no lower bound — use $\Theta$).

### 5. Complexity Classes (Growth Ladder)
- **Ladder** ➔ $1\prec\log n\prec\sqrt n\prec n\prec n\log n\prec n^2\prec n^3\prec 2^n\prec n!\prec n^n$.
- **Tractability line** ➔ **polynomial vs exponential** = tractable vs intractable (P-vs-NP frontier).
- **Doubling $n$** ➔ $O(n^2)\to4T$ (scalable); $O(2^n)\to T^2$ (catastrophic); class jumps need a new idea, not micro-optimisation.

## ⚙️ Core Implementation
### 🔹 Dominant-term reasoning + log rules
> [!code]- worked $O$ judgements
> ```text
> 4n^2 + 1000n + 100 = O(n^2)?   YES (c=20, n_0=63)
> n^3 + n^2 log^2 n  = O(n^2 log^2 n)?  NO -> n^3 dominates => O(n^3)
> t_n = 100n + 10n^2 + 2^n + log n  =>  O(2^n)   (n>=10: each other term <= 2^n, so t_n <= 4*2^n)
> log(n^2) = 2 log n = O(log n);   log(3^n) = n log 3 = O(n)
> ```
> 💡 **Common Mistake:** **Constant factors absorbed, base is not** ➔ write $O(2^n)$ not $O(4\cdot2^n)$, but $t_n\ne O(1.9^n)$ since $2^n/1.9^n\to\infty$; prefer the **tightest** valid bound.

### 🔹 The combining algebra on real code
> [!code]- nested-loop cost via Sum/Product
> ```python
> def func0(n):
>     for i in range(n):          # O(n) * (...)
>         a = b + 2               # O(1)
>         for j in range(100):    # fixed -> O(1) factor
>             res += func1(res)   # func1 is O(n)
>         res -= func2(res)       # func2 is O(2^n)
> # body = O(1) + O(1)*O(n) + O(2^n) = O(2^n)   [Sum keeps dominant]
> # total = O(n) * O(2^n) = O(n 2^n)            [Product]
> ```
> 💡 **Common Mistake:** **Sum keeps the max, not the sum** ➔ Product multiplies; these manipulate **upper bounds only** and cannot yield a lower bound.

## ⚖️ Core Decision Matrix
| Notation | Bound | Condition | Limit | Describes |
| :--- | :--- | :--- | :--- | :--- |
| $O(g)$ | upper | $f\le c\,g$ | $\lim f/g <\infty$ | algorithm worst-case ceiling |
| $\Omega(g)$ | lower | $f\ge c\,g$ | $\lim f/g >0$ | **problem** difficulty |
| $\Theta(g)$ | tight | $c_1g\le f\le c_2g$ | $0<\lim f/g<\infty$ | **algorithm** exact rate |
| $o(g)$ | strict upper | — | $\lim f/g=0$ | strictly slower |
| $\omega(g)$ | strict lower | — | $\lim f/g=\infty$ | strictly faster |

> [!NOTE] **When It Flips:** growth ladder on doubling $n$ — $O(1)$ unchanged · $O(\log n)$ $+1$ · $O(n)$ $\times2$ · $O(n^2)$ $\times4$ · $O(2^n)$ **squared**. $\Theta$ exists when best=worst ([[Merge Sort]] $\Theta(n\log n)$); **quicksort has no single $\Theta$** ($\Theta(n\log n)$ avg, $\Theta(n^2)$ worst).

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Prove the Sum rule $O(g_1)+O(g_2)=O(\max(g_1,g_2))$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
f_1\le c_1 g_1\ (n\ge n_1),\; f_2\le c_2 g_2\ (n\ge n_2) \Rightarrow\; & f_1+f_2 \le c_1 g_1 + c_2 g_2 \\
\le (c_1+c_2)\max(g_1,g_2) \Rightarrow\; & f_1+f_2 = O(\max(g_1,g_2))
\end{aligned}
$$
**Final Extracted Output:** with $c=c_1+c_2$, $n_0=\max(n_1,n_2)$ the definition holds ⟹ the sum keeps the dominant term.

## 🧠 Active Recall
> [!FAQ]- State the formal definition of $O$ and prove $4n^2 + 1000n + 100 = O(n^2)$.
> - **Hint:** Exhibit witnesses $c, n_0$.
> > [!SUCCESS]- Answer
> > - **Short answer:** $f=O(g) \iff \exists c,n_0>0:\ 0\le f\le c\,g\ \forall n\ge n_0$.
> > - **Why:** **Witnesses** ➔ $c=20,\ n_0=63$: for $n\ge63$, $1000n+100\le16n^2$ ⟹ $4n^2+1000n+100\le20n^2$.

> [!FAQ]- Why do we prove $\Omega$ bounds for *problems* and $\Theta$ bounds for *algorithms*?
> - **Hint:** Lower bound = property of the problem.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\Omega$ asserts **no** algorithm beats it (problem); $\Theta$ states an algorithm's exact rate.
> > - **Why:** **Optimality** ➔ when an algorithm's $O$ matches the problem's $\Omega$, the two meet ⟹ provably optimal.

> [!FAQ]- For $t_n=100n+10n^2+2^n+\log n$, justify $O(2^n)$ — and why is $O(1.9^n)$ false while $O(4\cdot2^n)$ is poor style?
> - **Hint:** Constant factor vs exponential base.
> > [!SUCCESS]- Answer
> > - **Short answer:** For $n\ge10$ each other term $\le2^n$ ⟹ $t_n\le4\cdot2^n=O(2^n)$.
> > - **Why:** **Base ≠ constant** ➔ Big-O absorbs the $4$; $O(1.9^n)$ is false since $2^n/1.9^n=(2/1.9)^n\to\infty$.

> [!FAQ]- Where is the practical "tractability" line, and what happens to $O(N^2)$ vs $O(2^N)$ when $N$ doubles?
> - **Hint:** Polynomial vs super-polynomial scaling.
> > [!SUCCESS]- Answer
> > - **Short answer:** Between **polynomial** ($n^c$) and **exponential** ($2^n$, $n!$).
> > - **Why:** **Scaling** ➔ $O(N^2)$ → $4T$ (constant factor, scalable); $O(2^N)$ → $T^2$ (squared, catastrophic) — the P-vs-intractable divide.

> [!FAQ]- Distinguish $f=O(g)$ from $f=o(g)$ with the limit criterion.
> - **Hint:** Same-order allowed vs strictly slower.
> > [!SUCCESS]- Answer
> > - **Short answer:** $O$ permits $\lim f/g$ to be a positive constant; $o$ requires $\lim f/g=0$.
> > - **Why:** **Examples** ➔ $n=O(n)$ but $n\ne o(n)$; $n=o(n^2)$ and $n=O(n^2)$ both hold.
