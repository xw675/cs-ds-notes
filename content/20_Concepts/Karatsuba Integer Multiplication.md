---
unit: FIT2004
week: 1
parent: "[[Divide and Conquer]]"
tags: [CS/Algorithms, CS/Complexity, CS/DivideConquer, Monash/CS_DS]
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
| Method | Recursive mults $a$ | Recurrence | Time | Beats schoolbook? |
| :--- | :--- | :--- | :--- | :--- |
| Schoolbook | — | — | $\Theta(n^2)$ | baseline |
| Naive D&C | 4 | $4T(n/2)+\Theta(n)$ | $\Theta(n^{2})$ | ❌ (same) |
| **Karatsuba** | 3 | $3T(n/2)+\Theta(n)$ | $\Theta(n^{\log_2 3})\approx\Theta(n^{1.585})$ | ✅ |

> [!NOTE] **When It Flips:** Karatsuba's constant factors are larger, so for **small $n$** schoolbook is faster; real implementations switch to schoolbook below a threshold. Karatsuba wins **asymptotically**, as $n\to\infty$.

## 📈 Complexity (mandatory table)
| Measure | Best | Average | Worst | Note |
| :--- | :--- | :--- | :--- | :--- |
| **Time** | $\Theta(n^{\log_2 3})$ | $\Theta(n^{\log_2 3})$ | $\Theta(n^{\log_2 3})$ | $\approx n^{1.585}$; no input-dependent branching, so all cases equal |
| **Space (auxiliary)** | $\Theta(n)$ | $\Theta(n)$ | $\Theta(n)$ | recursion depth $\log_2 n$ × operands whose sizes halve ⟹ $\Theta(n)$ total |
| **Recursive calls / level** | $3^{i}$ at level $i$ | — | — | $n^{\log_2 3}$ leaves |

- **Derivation (telescoping)** ➔ $T(n)=3T(n/2)+\Theta(n)$ expands to a **geometric** level-sum with ratio $3/2$, dominated by the $3^{\log_2 n}=n^{\log_2 3}$ **leaves** ⟹ $\Theta(n^{\log_2 3})$. *(The Master Theorem gives the same in one line, but is a supplementary shortcut — see [[Solving Recurrences (Telescoping)]].)*

## ⚠️ Common Mistakes
- 💡 **Shifts are not multiplications** ➔ multiplying by $B^m$ appends zeros ($\Theta(n)$ work); only the three recursive calls count toward $a$.
- 💡 **The trick needs 2 reused products** ➔ $(x_L{+}x_R)(y_L{+}y_R)$ alone is useless; the subtraction $-A-C$ is what isolates the cross term, so $A$ and $C$ must be computed first.
- 💡 **Asymptotic, not universal, speedup** ➔ larger hidden constants mean schoolbook wins for small $n$ — quote $\Theta(n^{1.585})$ as an $n\to\infty$ claim.
- 💡 **$(x_L+x_R)$ can carry an extra digit** ➔ the sums may be $m{+}1$ digits; a correct implementation handles the carry (the recurrence bound is unaffected).

## 🧠 Active Recall
> [!FAQ]- Karatsuba and naive divide-and-conquer both split the numbers in half — why is only one sub-quadratic?
> > [!SUCCESS]- Answer
> > - **Short answer:** naive D&C computes **four** half-size products, giving $T(n)=4T(n/2)+\Theta(n)=\Theta(n^2)$ — no gain. Karatsuba computes only **three** (recovering the cross term by $(x_L{+}x_R)(y_L{+}y_R)-A-C$), giving $T(n)=3T(n/2)+\Theta(n)=\Theta(n^{\log_2 3})$.
> > - **Why:** **The exponent is $\log_2 a$** ➔ telescoping the recurrence gives a geometric level-sum dominated by the $a^{\log_2 n}=n^{\log_2 a}$ leaves (combine work is only $\Theta(n)$); dropping $a$ from $4$ to $3$ moves the exponent from $2$ to $\approx1.585$ — the entire speedup.

> [!FAQ]- In the Karatsuba recurrence, why does multiplying by $10^{m}$ not count as one of the recursive multiplications?
> > [!SUCCESS]- Answer
> > - **Short answer:** multiplying an integer by $10^{m}$ (base power) just **appends $m$ zero digits** — a linear-time shift, part of the $\Theta(n)$ combine cost, not a general multiplication of two $n$-digit numbers.
> > - **Why:** **Only same-size products recurse** ➔ the recurrence counts sub-multiplications of two $\sim n/2$-digit operands ($a=3$ of them); shifts and additions are the $f(n)=\Theta(n)$ term, so treating a shift as a fourth "multiply" would wrongly inflate $a$ back to $4$ and re-derive $\Theta(n^2)$.
