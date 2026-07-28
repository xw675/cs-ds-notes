---
unit: FIT2004
domain: A
week: 1
parent: "[[Divide and Conquer]]"
tags: [CS/Algorithms, CS/Complexity, CS/DivideConquer]
aliases: [Karatsuba, fast multiplication, integer multiplication, Gauss trick, big-integer multiply]
---
# [[Karatsuba Integer Multiplication]]

**Context:** [[FIT2004_MOC]] · the flagship Week 1 [[Divide and Conquer]] algorithm · beats schoolbook $O(n^2)$ by trading one multiplication for cheap additions · analysed by [[Solving Recurrences (Telescoping)|solving its recurrence]]

> [!abstract] Quick Revision
> - **🎯 Objective:** multiply two $n$-digit integers in **sub-quadratic** time by splitting each in half and doing only **3** (not 4) half-size multiplications ➔ $\Theta\!\big(n^{\log_2 3}\big)\approx\Theta(n^{1.585})$.
> - **📦 Core Components:** split $x=x_L\,B^{m}+x_R$ ➔ naive needs $x_Ly_L,\,x_Ry_R,\,x_Ly_R,\,x_Ry_L$ (4 mults) ➔ **Gauss trick** recovers the cross term as $(x_L{+}x_R)(y_L{+}y_R)-x_Ly_L-x_Ry_R$ (1 extra mult, reusing 2).
> - **⚡ Key Constraint:** the win is entirely in **$a=3$ vs $a=4$** in the recurrence — it drops the exponent from $\log_2 4=2$ to $\log_2 3\approx1.585$; the combine work (adds/shifts) stays $\Theta(n)$.

## 📝 Why $n$ is the input size that matters
- **Input size = number of digits/bits**, not the numeric value ➔ multiplying two $n$-digit numbers, the cost is a function of $n$ (see [[Algorithmic Complexity]], where "input size is often **bit-length**").
- **Schoolbook (long) multiplication** ➔ every digit of $x$ times every digit of $y$ ⟹ $\Theta(n^2)$ digit-multiplications.

## ➗ The divide-and-conquer split
Write both numbers in base $B$ (e.g. $B=10$) with a half-split $m=n/2$:
$$x = x_L\,B^{m} + x_R, \qquad y = y_L\,B^{m} + y_R$$
$$x\cdot y = \underbrace{x_L y_L}_{A}\,B^{2m} + \underbrace{(x_L y_R + x_R y_L)}_{\text{middle}}\,B^{m} + \underbrace{x_R y_R}_{C}$$
- **Naive** ➔ compute $A, C$ and **both** cross products ⟹ **4** half-size multiplications ⟹ $T(n)=4T(n/2)+\Theta(n)=\Theta(n^2)$ — no better than schoolbook.

## ⭐ The Karatsuba (Gauss) trick — 4 → 3
Compute the middle term **without** a third and fourth multiplication:
$$\text{middle} = x_L y_R + x_R y_L = (x_L+x_R)(y_L+y_R) - A - C$$
**The identity, expanded** — the one line that justifies the trick if asked to prove it:
$$
\begin{aligned}
(x_L+x_R)(y_L+y_R) &= \underbrace{x_Ly_L}_{A} + x_Ly_R + x_Ry_L + \underbrace{x_Ry_R}_{C} \\
\Rightarrow\; (x_L+x_R)(y_L+y_R) - A - C &= x_Ly_R + x_Ry_L = \text{middle} \quad\checkmark
\end{aligned}
$$
- We already have $A=x_Ly_L$ and $C=x_Ry_R$; the single product $(x_L{+}x_R)(y_L{+}y_R)$ gives the rest by **subtraction** ⟹ **3** multiplications $+$ a few $\Theta(n)$ additions/shifts.

## ⚙️ Core Implementation
> [!code]- Raw recursive Karatsuba (no built-in big-int multiply for the recursion)
> ```python
> def karatsuba(x, y, n):
>     # x, y are n-digit non-negative integers (n a power of 2)
>     if n == 1:                      # base case: one-digit multiply
>         return x * y
>     m = n // 2
>     Bm = 10 ** m                    # base^(n/2) — a shift, not a multiply
>     xl, xr = x // Bm, x % Bm        # high / low halves
>     yl, yr = y // Bm, y % Bm
>     A = karatsuba(xl, yl, m)                 # 1st recursive mult
>     C = karatsuba(xr, yr, m)                 # 2nd recursive mult
>     mid = karatsuba(xl + xr, yl + yr, m)     # 3rd recursive mult
>     mid = mid - A - C                        # Gauss trick: recover cross term
>     return A * (Bm * Bm) + mid * Bm + C      # shifts + adds are Θ(n)
> ```
> 💡 **Common Mistake:** the $\times 10^{m}$ / $\times 10^{2m}$ are **digit shifts** ($\Theta(n)$), **not** counted as multiplications — only the **three `karatsuba(...)` calls** drive the recurrence. Miscounting them as multiplications re-derives $O(n^2)$.

## ⚖️ Core Decision Matrix
| Method | Recursive mults $a$ | Recurrence | Level-sum ratio $a/b$ | Time | Beats schoolbook? |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Schoolbook | — | — | — | $\Theta(n^2)$ | baseline |
| Naive D&C | 4 | $4T(n/2)+\Theta(n)$ | $2$ | $\Theta(n^{\log_2 4})=\Theta(n^{2})$ | ❌ (same) |
| **Karatsuba** | 3 | $3T(n/2)+\Theta(n)$ | $3/2$ | $\Theta(n^{\log_2 3})\approx\Theta(n^{1.585})$ | ✅ |
| [[Merge Sort]] *(contrast)* | 2 | $2T(n/2)+\Theta(n)$ | $1$ | $\Theta(n\log n)$ | — |

> [!NOTE] **When It Flips:** Karatsuba's constant factors are larger, so for **small $n$** schoolbook is faster; real implementations switch to schoolbook below a threshold. Karatsuba wins **asymptotically**, as $n\to\infty$.

## 📈 Complexity

| Measure | Best | Average | Worst | Note |
| :--- | :--- | :--- | :--- | :--- |
| **Time** | $\Theta(n^{\log_2 3})$ | $\Theta(n^{\log_2 3})$ | $\Theta(n^{\log_2 3})$ | $\approx n^{1.585}$; no input-dependent branching, so all cases equal |
| **Space (auxiliary)** | $\Theta(n)$ | $\Theta(n)$ | $\Theta(n)$ | one root-to-leaf path of live frames — derived below |
| **Recursion depth** | $\log_2 n$ | $\log_2 n$ | $\log_2 n$ | halving to a 1-digit base |
| **Recursive calls / level** | $3^{i}$ at level $i$ | — | — | $3^{\log_2 n}=n^{\log_2 3}$ leaves |

### Time — the level-sum written out
Level $i$ holds $3^{i}$ subproblems of size $n/2^{i}$, each doing $\Theta(\text{size})$ combine work:
$$T(n)=\sum_{i=0}^{\log_2 n} 3^{i}\cdot c\,\frac{n}{2^{i}} = c\,n\sum_{i=0}^{\log_2 n}\left(\frac{3}{2}\right)^{i}$$
Ratio $r=\tfrac32>1$ ⟹ **geometric, dominated by its last term** (the leaves), so
$$T(n)=\Theta\!\left(n\left(\tfrac{3}{2}\right)^{\log_2 n}\right)=\Theta\!\left(n\cdot\frac{3^{\log_2 n}}{2^{\log_2 n}}\right)=\Theta\!\left(n\cdot\frac{n^{\log_2 3}}{n}\right)=\Theta\!\big(n^{\log_2 3}\big)$$
- **Contrast** ➔ merge sort's $a{=}2,b{=}2$ gives $r=1$, every level costs $cn$ equally ⟹ the extra $\log n$ factor instead of an exponent bump. Full machinery in [[Solving Recurrences (Telescoping)]].

### Space — why $\Theta(n)$, not $\Theta(n\log n)$
- **Only one path is live at a time** ➔ the three calls run **sequentially**, so the stack holds one root-to-leaf chain: frames of size $n, n/2, n/4,\dots,1$.
- **Halving sum converges** ➔ $\sum_{i=0}^{\log_2 n} c\,n/2^{i} < 2cn=\Theta(n)$ — counting $\log_2 n$ frames of size $n$ each (⟹ $\Theta(n\log n)$) is the standard over-estimate.

## ⚠️ Common Mistakes
- 💡 **Shifts are not multiplications** ➔ multiplying by $B^m$ appends zeros ($\Theta(n)$ work); only the three recursive calls count toward $a$.
- 💡 **The trick needs 2 reused products** ➔ $(x_L{+}x_R)(y_L{+}y_R)$ alone is useless; the subtraction $-A-C$ is what isolates the cross term, so $A$ and $C$ must be computed first.
- 💡 **Asymptotic, not universal, speedup** ➔ larger hidden constants mean schoolbook wins for small $n$ — quote $\Theta(n^{1.585})$ as an $n\to\infty$ claim.
- 💡 **$(x_L+x_R)$ can carry an extra digit** ➔ the sums may be $m{+}1$ digits; a correct implementation handles the carry (the recurrence bound is unaffected).
- 💡 **$B^{2m}$, not $B^{m^2}$** ➔ the high term is shifted by $2m$ digits; an off-by-one in the shift silently corrupts the product while the complexity argument still "looks" right.

## 📊 Exam Execution Trace

### Manual Execution Trace
$x=1234$, $y=5678$, $n=4$, $B=10$, $m=2$ ⟹ $x_L{=}12,\ x_R{=}34,\ y_L{=}56,\ y_R{=}78$:

| Step / State | Operation | Computed | Value |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | split at $m=2$ | $x_L,x_R,y_L,y_R$ | $12,\,34,\,56,\,78$ |
| 1 | recurse ①| $A=x_Ly_L=12\cdot56$ | $672$ |
| 2 | recurse ② | $C=x_Ry_R=34\cdot78$ | $2652$ |
| 3 | form sums | $x_L{+}x_R,\ y_L{+}y_R$ | $46,\ \mathbf{134}$ *(carry ⟹ 3 digits)* |
| 4 | recurse ③ | $P=46\cdot134$ | $6164$ |
| 5 | Gauss subtract | $\text{mid}=P-A-C$ | $6164-672-2652=2840$ |
| 6 | shift + add | $A\cdot10^{4}+\text{mid}\cdot10^{2}+C$ | $6720000+284000+2652$ |

**Final Extracted Output:** $1234\times5678 = 7{,}006{,}652$ using **3** multiplications of 2-digit operands, not 4.
- **What the trace proves** ➔ step 3 realises the carry pitfall live ($y_L{+}y_R=134$ needs $m{+}1=3$ digits); steps 1–2 are **reused** by step 5, which is why only one extra product is needed.

## 🧠 Active Recall
> [!FAQ]- Karatsuba and naive divide-and-conquer both split the numbers in half — why is only one sub-quadratic?
> > [!SUCCESS]- Answer
> > - **Short answer:** naive D&C computes **four** half-size products, giving $T(n)=4T(n/2)+\Theta(n)=\Theta(n^2)$ — no gain. Karatsuba computes only **three** (recovering the cross term by $(x_L{+}x_R)(y_L{+}y_R)-A-C$), giving $T(n)=3T(n/2)+\Theta(n)=\Theta(n^{\log_2 3})$.
> > - **Why:** **The exponent is $\log_2 a$** ➔ telescoping the recurrence gives a geometric level-sum with ratio $a/2$ dominated by the $a^{\log_2 n}=n^{\log_2 a}$ leaves (combine work is only $\Theta(n)$); dropping $a$ from $4$ to $3$ moves the exponent from $2$ to $\approx1.585$ — the entire speedup.

> [!FAQ]- In the Karatsuba recurrence, why does multiplying by $10^{m}$ not count as one of the recursive multiplications?
> > [!SUCCESS]- Answer
> > - **Short answer:** multiplying an integer by $10^{m}$ (base power) just **appends $m$ zero digits** — a linear-time shift, part of the $\Theta(n)$ combine cost, not a general multiplication of two $n$-digit numbers.
> > - **Why:** **Only same-size products recurse** ➔ the recurrence counts sub-multiplications of two $\sim n/2$-digit operands ($a=3$ of them); shifts and additions are the $f(n)=\Theta(n)$ term, so treating a shift as a fourth "multiply" would wrongly inflate $a$ back to $4$ and re-derive $\Theta(n^2)$.

> [!FAQ]- Derive $\Theta(n^{\log_2 3})$ from $T(n)=3T(n/2)+cn$ by summing the recursion tree, without quoting the Master Theorem.
> > [!SUCCESS]- Answer
> > - **Short answer:** level $i$ costs $3^{i}\cdot c\,n/2^{i}=cn(3/2)^{i}$; summing $i=0\ldots\log_2 n$ gives $cn\sum(3/2)^{i}$, a geometric series with $r=\tfrac32>1$, so the last term dominates: $\Theta\!\big(n(3/2)^{\log_2 n}\big)=\Theta\!\big(n^{\log_2 3}\big)$.
> > - **Why:** **Branching outruns shrinking** ➔ each level triples the subproblem count while only halving their size, so work *grows* downward and the $n^{\log_2 3}$ leaves — not the root combine — are the entire cost.

> [!FAQ]- Karatsuba is asymptotically faster than schoolbook, yet production big-integer libraries still call schoolbook. Reconcile this.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\Theta$ hides constants. Karatsuba pays three recursive calls plus several $\Theta(n)$ additions, subtractions and shifts per level; below a threshold $n_0$ (typically tens of digits) schoolbook's tiny constant wins, so libraries recurse only until $n\le n_0$ then switch.
> > - **Why:** **Asymptotic ≠ always** ➔ $\Theta(n^{1.585})$ is a claim about $n\to\infty$; the crossover is where $c_K n^{1.585}=c_S n^{2}$, i.e. $n_0=(c_K/c_S)^{1/0.415}$ — a large constant ratio pushes $n_0$ high. Same reasoning as merge/quick sort cutting over to insertion sort on small slices.
