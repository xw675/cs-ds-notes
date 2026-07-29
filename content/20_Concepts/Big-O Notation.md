---
unit: [FIT1008, FIT1058, FIT2004]
domain: [A, D]
week: [1, 6]
source: [applied]
parent: "[[Algorithmic Complexity]]"
tags: [CS/Complexity, Math/Analysis, CS/Algorithms, Math/Sequences]
---
# [[Big-O Notation]]

**Context:** [[FIT1008_MOC]], [[FIT1058_MOC]], [[FIT2004_MOC]] · backbone clustering the **asymptotic-analysis toolkit** — the $O/\Omega/\Theta$ bounds, the dominance method, the combining algebra, and the growth-rate ladder
**FIT2004 emphasis:** all three bounds stated **formally with witnesses**; a bound is judged **valid or invalid**, separately from whether it is **tight**; the notation is **orthogonal to the case** (best/worst) — fixing one does not fix the other.

> [!abstract] Quick Revision
> - **🎯 Objective:** describe order of growth as $n\to\infty$ ➔ keep the dominant term, drop constants, compare by scalability.
> - **📦 Core Components:** **$O$/$\Omega$/$\Theta$** ➔ upper/lower/tight | **dominance** ➔ limit test | **algebra** ➔ sum/product | **class ladder**.
> - **⚡ Key Constraint:** $\Theta=O\cap\Omega$; a **valid** bound need not be **tight** ($3n^2+100n=O(n^3)$ is TRUE); the **polynomial vs exponential** line is the tractability frontier (P vs NP).

## 📝 Core
### 1. Big-O (Asymptotic Upper Bound)
- **Definition** ➔ $f=O(g) \iff \exists\,c,n_0>0:\ 0\le f(n)\le c\,g(n)\ \forall n\ge n_0$.
- **Set membership** ➔ $O(g)$ is a **set**; "$f=O(g)$" abuses "=" for $f\in O(g)$.
- **Sequence form (FIT1058)** ➔ $a_n=O(f) \iff \exists c,N\ \forall n\ge N:\ a_n\le c\,f(n)$.

### 2. Big-Omega & Big-Theta (Lower / Tight)
**All three formally — what must EXIST, and for which $n$ the inequality must hold:**

| Claim | There exist | Such that, $\forall n\ge n_0$ |
| :--- | :--- | :--- |
| $f=O(g)$ | $c>0,\ n_0>0$ | $0\le f(n)\le c\,g(n)$ |
| $f=\Omega(g)$ | $c>0,\ n_0>0$ | $0\le c\,g(n)\le f(n)$ |
| $f=\Theta(g)$ | $c_1,c_2>0,\ n_0>0$ | $0\le c_1g(n)\le f(n)\le c_2g(n)$ |

- **$\Theta=O\cap\Omega$** ➔ to disprove a $\Theta$ claim it suffices to break **either** side; to prove one you must exhibit **both** constants.
- **Strict versions** ➔ **little-o** ($\lim f/g=0$), **little-omega** ($\lim f/g=\infty$).
- **Typical usage, not a law** ➔ $\Omega$ is *usually* how a **problem's** intrinsic difficulty is stated (no algorithm beats it) and $\Theta$ how an **algorithm's** exact rate is stated; $O$ meeting $\Omega$ ⟹ **optimal**. But all three apply to any function — $\Omega$ is applied to a single algorithm's cheapest case throughout the W1 applied sheet.

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

### 6. Validity vs Tightness, and Case-Independence
- **Valid ≠ tight** ➔ $O$ is *an* upper bound, not *the* upper bound ➔ $3n^2+15\log n+100n=O(n^3)$ is **TRUE** (witness $c=118,n_0=1$), merely loose. "Quote the tightest bound" is **style advice**, not a truth condition — on a true/false question, answer the definition.
- **$\Theta$ is where looseness becomes falsity** ➔ the same function is **not** $\Theta(n^3)$, because $\Omega(n^3)$ fails: $T(n)/n^3\to0$, so no $c>0$ survives.
- **Notation ⊥ case** ➔ $O/\Omega/\Theta$ bound a *function*; best/worst select *which* function. Both must be named — "insertion is $O(\log n)$" is meaningless until you say **which** case.
- **"Any operation is …" quantifies over ALL inputs** ➔ so $O(g)$ must bound the **dearest** case and $\Omega(g)$ must bound the **cheapest** ➔ a $\Theta$ claim over "any operation" holds only if cheapest and dearest share an order.
- **Fixing the case restores $\Theta$** ➔ BST insertion admits **no** $\Theta$ over all insertions (cheapest $\Theta(1)$, dearest $\Theta(n)$), yet **worst-case** insertion is cleanly $\Theta(n)$.

## ⚙️ Core Implementation
### 🔹 Dominant-term reasoning + log rules
> [!code]- worked $O$ judgements
> ```text
> 4n^2 + 1000n + 100 = O(n^2)?   YES (c=20, n_0=63)
> n^3 + n^2 log^2 n  = O(n^2 log^2 n)?  NO -> n^3 dominates => O(n^3)
> t_n = 100n + 10n^2 + 2^n + log n  =>  O(2^n)   (n>=10: each other term <= 2^n, so t_n <= 4*2^n)
> log(n^2) = 2 log n = O(log n);   log(3^n) = n log 3 = O(n)
> ```
> 💡 **Common Mistake:** **Constant factors absorbed, base is not** ➔ write $O(2^n)$ not $O(4\cdot2^n)$, but $t_n\ne O(1.9^n)$ since $2^n/1.9^n\to\infty$; prefer the **tightest** valid bound *when asked to characterise*, but never call a loose bound false.

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
| $O(g)$ | upper | $f\le c\,g$ | $\lim f/g <\infty$ | ceiling — bounds the **dearest** case |
| $\Omega(g)$ | lower | $f\ge c\,g$ | $\lim f/g >0$ | floor — bounds the **cheapest** case |
| $\Theta(g)$ | tight | $c_1g\le f\le c_2g$ | $0<\lim f/g<\infty$ | exact rate — needs both to agree |
| $o(g)$ | strict upper | — | $\lim f/g=0$ | strictly slower |
| $\omega(g)$ | strict lower | — | $\lim f/g=\infty$ | strictly faster |

> [!NOTE] **When It Flips:** growth ladder on doubling $n$ — $O(1)$ unchanged · $O(\log n)$ $+1$ · $O(n)$ $\times2$ · $O(n^2)$ $\times4$ · $O(2^n)$ **squared**. $\Theta$ exists when best=worst ([[Merge Sort]] $\Theta(n\log n)$); **quicksort has no single $\Theta$** ($\Theta(n\log n)$ avg, $\Theta(n^2)$ worst) — the same reason "any BST insertion" has none.

## ⚠️ Common Mistakes
- 💡 **Marking a loose bound FALSE** ➔ $T(n)=O(n^3)$ for a quadratic $T$ is **true**; the definition asks only that *some* $c,n_0$ exist, not that the bound be tight.
- 💡 **Upgrading $O$ to $\Theta$ for free** ➔ $\Theta$ needs the matching $\Omega$; check the limit $f/g$ is bounded **away from $0$**, not merely finite.
- 💡 **Quantifier slip on "any"** ➔ "any operation is $\Omega(\log n)$" is a claim about the **cheapest** operation, not the typical one — one $O(1)$ input falsifies it.
- 💡 **Naming a bound without naming a case** ➔ always pair them ("worst-case $\Theta(n)$"); an unqualified $\Theta$ over all inputs asserts cheapest and dearest agree.

## ✍️ Practice
> [!QUESTION]- Practice 1: Prove the Sum rule $O(g_1)+O(g_2)=O(\max(g_1,g_2))$.
> - **Hint:** Add the two witness inequalities, then bound both $g$'s by their max.
> > [!SUCCESS]- Answer
> > $$\begin{aligned} f_1\le c_1 g_1\ (n\ge n_1),\; f_2\le c_2 g_2\ (n\ge n_2) \Rightarrow\; & f_1+f_2 \le c_1 g_1 + c_2 g_2 \\ \le (c_1+c_2)\max(g_1,g_2) \Rightarrow\; & f_1+f_2 = O(\max(g_1,g_2))\end{aligned}$$
> > - **Short answer:** with $c=c_1+c_2$, $n_0=\max(n_1,n_2)$ the definition holds ⟹ the sum keeps the dominant term.

> [!QUESTION]- Practice 2: For $T(n)=3n^{2}+15\log n+100n$, decide TRUE/FALSE with proof: (b) $T=O(n^3)$ · (c) $T=\Theta(n^3)$ · (d) $T=\Omega(n)$.
> - **Hint:** Answer from the definition each time; do not substitute "is it the tightest?".
> > [!SUCCESS]- Answer
> > - **(b) TRUE.** For $n\ge1$: $\log n\le n^3$ and $n\le n^3$ and $n^2\le n^3$, so $T(n)\le(3{+}15{+}100)n^{3}=118n^{3}$. Witnesses $c=118,\ n_0=1$. **Loose, but valid.**
> > - **(c) FALSE.** $\Theta$ needs $\Omega(n^3)$ too: $\dfrac{T(n)}{n^{3}}=\dfrac{3}{n}+\dfrac{15\log n}{n^{3}}+\dfrac{100}{n^{2}}\to0$, so for **any** $c>0$ the inequality $T(n)\ge cn^{3}$ fails for all large $n$. No $c_1$ exists.
> > - **(d) TRUE.** All terms are non-negative for $n\ge1$, so $T(n)\ge100n$. Witnesses $c=100,\ n_0=1$.
> > - **Why:** **Validity is decided by the definition, tightness is a separate question** ➔ the tight characterisation is $T(n)=\Theta(n^{2})$, yet (b) and (d) remain true because $O$ and $\Omega$ only demand *some* surviving constant.

> [!QUESTION]- Practice 3: A BST holds $n$ keys. TRUE/FALSE for insertion: $\Omega(1)$ · $\Omega(\log n)$ · $\Omega(n)$ · $O(1)$ · $O(\log n)$ · $O(n)$ · $\Theta(1)$ · $\Theta(\log n)$ · $\Theta(n)$ · worst case $\Theta(\log n)$ · worst case $\Theta(n)$.
> - **Hint:** "Any insertion" ranges over every tree shape AND every key — so cost spans $\Theta(1)$ to $\Theta(n)$.
> > [!SUCCESS]- Answer
> > - **Cost span** ➔ an insertion walks to its position, costing $\Theta(\text{depth})$: as low as $\Theta(1)$ (key lands beside the root — e.g. a descending chain and a key smaller than all) and as high as $\Theta(n)$ (degenerate chain, key at the far end).
> > - **TRUE: $\Omega(1)$, $O(n)$, worst case $\Theta(n)$.** $\Omega(1)$ floors the cheapest insertion; $O(n)$ ceilings the dearest; fixing the worst case pins a single function, which is $\Theta(n)$.
> > - **FALSE: everything else.** $\Omega(\log n)$/$\Omega(n)$ die on the $\Theta(1)$ insertion · $O(1)$/$O(\log n)$ die on the $\Theta(n)$ insertion · every unqualified $\Theta$ dies because cheapest $\Theta(1)$ and dearest $\Theta(n)$ disagree · worst case $\Theta(\log n)$ is false since the worst case is $\Theta(n)$, not $\Theta(\log n)$.
> > - **Why:** **Quantifier before notation** ➔ "any insertion" forces $O$ to cover the max and $\Omega$ to cover the min; only once a **case is fixed** does the cost become one function that $\Theta$ can describe. Balance is the discriminator — see [[Binary Search Tree (BST)]].

## 🧠 Active Recall
> [!FAQ]- State the formal definition of $O$ and prove $4n^2 + 1000n + 100 = O(n^2)$.
> - **Hint:** Exhibit witnesses $c, n_0$.
> > [!SUCCESS]- Answer
> > - **Short answer:** $f=O(g) \iff \exists c,n_0>0:\ 0\le f\le c\,g\ \forall n\ge n_0$.
> > - **Why:** **Witnesses** ➔ $c=20,\ n_0=63$: for $n\ge63$, $1000n+100\le16n^2$ ⟹ $4n^2+1000n+100\le20n^2$.

> [!FAQ]- Why do we *usually* prove $\Omega$ bounds for problems and $\Theta$ bounds for algorithms — and why is that a convention rather than a rule?
> - **Hint:** Lower bound = property of the problem; but $\Omega$ is just a function relation.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\Omega$ on a *problem* asserts **no** algorithm beats it; $\Theta$ on an *algorithm* states its exact rate. But $\Omega$ is defined for any function, so it applies equally to one algorithm's cheapest case ("any BST insertion is $\Omega(1)$").
> > - **Why:** **Optimality framing** ➔ the convention exists because matching an algorithm's $O$ to a problem's $\Omega$ proves optimality; reading it as a restriction makes true statements like "any insertion is $\Omega(1)$" look ill-formed.

> [!FAQ]- $T(n)=3n^2+15\log n+100n$. Is $T(n)=O(n^3)$ true? Is $T(n)=\Theta(n^3)$? Why do these differ?
> - **Hint:** One bound is one-sided, the other needs both sides.
> > [!SUCCESS]- Answer
> > - **Short answer:** $O(n^3)$ **TRUE** ($c=118,n_0=1$); $\Theta(n^3)$ **FALSE** — the $\Omega(n^3)$ half fails since $T(n)/n^3\to0$.
> > - **Why:** **Overshoot is legal upward only** ➔ $O$ tolerates any amount of slack, so every function is $O$ of anything that grows faster; $\Theta$ forbids slack in either direction, which is why it, not $O$, carries information.

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
