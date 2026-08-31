---
unit: FIT2004
domain: A
week: 1
parent: "[[Divide and Conquer]]"
tags: [CS/Algorithms, CS/Complexity, CS/DivideConquer]
aliases: [Karatsuba, fast multiplication, integer multiplication, Gauss trick, big-integer multiply]
---
# [[Karatsuba Integer Multiplication]]

**Context:** [[FIT2004_MOC]] · a Week 1 [[Divide and Conquer]] algorithm · beats schoolbook $O(n^2)$ by trading one multiplication for cheap additions

> [!warning] **NOT EXAMINABLE**
> A **motivating hook** for Divide & Conquer, not assessed content — stripped from [[FIT2004 Unit Cheatsheet]]. The transferable skill that *is* examinable is reading $a$ and $b$ off a recurrence and classifying by $r=a/b$ ➔ [[Solving Recurrences (Telescoping)]]. Read for intuition; do not drill it in SWOTVAC.

> [!abstract] Quick Revision
> - **🎯 Objective:** multiply two $n$-digit integers **sub-quadratically** by splitting each in half and doing **3** (not 4) half-size multiplications ➔ $\Theta\!\big(n^{\log_2 3}\big)\approx\Theta(n^{1.585})$.
> - **📦 Core Components:** split $x=x_L B^{m}+x_R$ ➔ naive needs 4 products ➔ **Gauss trick** recovers the cross term as $(x_L{+}x_R)(y_L{+}y_R)-x_Ly_L-x_Ry_R$.
> - **⚡ Key Constraint:** the win is entirely **$a=3$ vs $a=4$** — the exponent drops from $\log_2 4=2$ to $\log_2 3$; the combine (adds/shifts) stays $\Theta(n)$. Input size is **digit count**, not value ➔ [[Algorithmic Complexity]].

## ➗ The split and the Gauss trick
With $m=n/2$ in base $B$:
$$x = x_L B^{m} + x_R,\quad y = y_L B^{m} + y_R \;\Rightarrow\; xy = \underbrace{x_Ly_L}_{A}B^{2m} + \underbrace{(x_Ly_R{+}x_Ry_L)}_{\text{middle}}B^{m} + \underbrace{x_Ry_R}_{C}$$
- **Naive** ➔ 4 half-size products ⟹ $T(n)=4T(n/2)+\Theta(n)=\Theta(n^2)$ — no better than schoolbook.
- **The trick** ➔ $(x_L{+}x_R)(y_L{+}y_R) = A + x_Ly_R + x_Ry_L + C \;\Rightarrow\; \text{middle} = (x_L{+}x_R)(y_L{+}y_R) - A - C$, so **3** products plus $\Theta(n)$ additions/shifts. $A$ and $C$ must be computed first — the subtraction is what isolates the cross term.

## ⚙️ Core Implementation
> [!code]- recursive Karatsuba
> ```python
> def karatsuba(x, y, n):
>     if n == 1:                      # base case: one-digit multiply
>         return x * y
>     m = n // 2
>     Bm = 10 ** m                    # base^(n/2) — a shift, not a multiply
>     xl, xr = x // Bm, x % Bm
>     yl, yr = y // Bm, y % Bm
>     A = karatsuba(xl, yl, m)                 # 1st recursive mult
>     C = karatsuba(xr, yr, m)                 # 2nd recursive mult
>     mid = karatsuba(xl + xr, yl + yr, m)     # 3rd recursive mult
>     mid = mid - A - C                        # Gauss trick: recover cross term
>     return A * (Bm * Bm) + mid * Bm + C      # shifts + adds are Theta(n)
> ```
> 💡 **Common Mistake:** the $\times B^{m}$ / $\times B^{2m}$ are **digit shifts** ($\Theta(n)$), **not** multiplications — only the three `karatsuba(...)` calls drive the recurrence. Miscounting them re-derives $O(n^2)$. Note $(x_L{+}x_R)$ may carry an extra digit ($46\cdot\mathbf{134}$), and the high term shifts by $2m$, not $m^2$.

## ⚖️ Core Decision Matrix
| Method | Recursive mults $a$ | Recurrence | Ratio $a/b$ | Time |
| :--- | :--- | :--- | :--- | :--- |
| Schoolbook | — | — | — | $\Theta(n^2)$ |
| Naive D&C | 4 | $4T(n/2)+\Theta(n)$ | $2$ | $\Theta(n^{\log_2 4})=\Theta(n^{2})$ ❌ no gain |
| **Karatsuba** | 3 | $3T(n/2)+\Theta(n)$ | $3/2$ | $\Theta(n^{\log_2 3})\approx\Theta(n^{1.585})$ ✅ |
| [[Merge Sort]] *(contrast)* | 2 | $2T(n/2)+\Theta(n)$ | $1$ | $\Theta(n\log n)$ |

> [!NOTE] **When It Flips:** Karatsuba's constants are larger, so schoolbook wins for **small $n$**; libraries switch below a threshold. The $\Theta(n^{1.585})$ claim is about $n\to\infty$ — the same cut-over reasoning as merge sort's insertion-sort tail.

## 📈 Complexity — the level-sum written out
Level $i$ holds $3^{i}$ subproblems of size $n/2^{i}$ with $\Theta(\text{size})$ combine:
$$T(n)=\sum_{i=0}^{\log_2 n} 3^{i}\cdot c\,\frac{n}{2^{i}} = c\,n\sum_{i=0}^{\log_2 n}\left(\frac{3}{2}\right)^{i} \;\Rightarrow\; r=\tfrac32>1 \;\Rightarrow\; \Theta\!\left(n\cdot\frac{n^{\log_2 3}}{n}\right)=\Theta\!\big(n^{\log_2 3}\big)$$
- **Leaf-dominated** ➔ branching (×3) outruns shrinking (÷2), so the $n^{\log_2 3}$ leaves, not the root combine, are the whole cost. Merge sort's $r=1$ gives an extra $\log n$ factor instead of an exponent bump.
- **Auxiliary space $\Theta(n)$, not $\Theta(n\log n)$** ➔ the three calls run **sequentially**, so one root-to-leaf chain of frames of sizes $n,n/2,n/4,\dots$ is live, summing to $<2cn$.

## 📊 Manual Execution Trace
$x=1234,\ y=5678,\ n=4,\ m=2$ ⟹ $x_L{=}12,\ x_R{=}34,\ y_L{=}56,\ y_R{=}78$:

| Step | Operation | Computed | Value |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | split at $m=2$ | $x_L,x_R,y_L,y_R$ | $12,\,34,\,56,\,78$ |
| 1 | recurse ① | $A=12\cdot56$ | $672$ |
| 2 | recurse ② | $C=34\cdot78$ | $2652$ |
| 3 | form sums | $x_L{+}x_R,\ y_L{+}y_R$ | $46,\ \mathbf{134}$ *(carry ⟹ 3 digits)* |
| 4 | recurse ③ | $P=46\cdot134$ | $6164$ |
| 5 | Gauss subtract | $\text{mid}=P-A-C$ | $2840$ |
| 6 | shift + add | $A\cdot10^{4}+\text{mid}\cdot10^{2}+C$ | $\mathbf{7{,}006{,}652}$ |

**What it proves:** steps 1–2 are **reused** by step 5, so only one extra product is needed; step 3 realises the carry pitfall live.

## 🧠 Active Recall
> [!FAQ]- Karatsuba and naive divide-and-conquer both split the numbers in half — why is only one sub-quadratic?
> > [!SUCCESS]- Answer
> > - **Short answer:** naive D&C computes **four** half-size products ⟹ $4T(n/2)+\Theta(n)=\Theta(n^2)$; Karatsuba computes **three** ⟹ $3T(n/2)+\Theta(n)=\Theta(n^{\log_2 3})$.
> > - **Why:** **The exponent is $\log_2 a$** ➔ the level-sum has ratio $a/2$ and is dominated by its $a^{\log_2 n}=n^{\log_2 a}$ leaves, so dropping $a$ from $4$ to $3$ moves the exponent from $2$ to $\approx1.585$ — the entire speedup.
