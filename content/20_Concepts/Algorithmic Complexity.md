---
unit: [FIT1008, FIT2004]
week: 1
parent: "[[Algorithm]]"
tags: [CS/Algorithms, CS/Complexity, CS/Foundations]
---
# [[Algorithmic Complexity]]

**Context:** [[FIT1008_MOC]], [[FIT2004_MOC]] · backbone clustering the **measurement foundation** — input size, the RAM cost model, time complexity, per-operation cost, and best/worst/average cases
**FIT2004 emphasis:** distinguish **total** space from **auxiliary** space (extra beyond the input — an in-place algorithm uses $O(1)$ auxiliary); and always quote the **tightest** ($\Theta$) bound available, not just an $O$ upper bound. Input size is often **bit-length** (e.g. $n$ digits in [[Karatsuba Integer Multiplication]]).

> [!abstract] Quick Revision
> - **🎯 Objective:** measure the resource (time/space) as a function of input size $n$ ➔ the question is scalability as $n\to\infty$.
> - **📦 Core Components:** **input size** $n$ (often bit-length!) | **RAM** unit-cost steps | **time complexity** $T(n)$ | **case** (best/worst/avg/amortised).
> - **⚡ Key Constraint:** unqualified "complexity" = **worst case**; the RAM unit-cost assumption breaks for variable-size keys ($\times\text{CompEq}$).

## 📝 Core
### 1. The Resource Question
- **What it measures** ➔ how cost grows with input size — **time** (elementary ops) or **space** (peak memory); FIT1008 focuses on time.
- **Function of $n$** ➔ stated as $T(n)$, not a single number, because we care how it *scales*.
- **Time–space trade-off** ➔ extra memory buys speed (memoisation, hash tables) and vice-versa.

### 2. Input Size $n$ ("Big" Defined)
- **Type-dependent** ➔ collection's element count | string's chars | graph's $|V|$ **and** $|E|$.
- **Bit-length trap** ➔ a **number** $k$ has size $\lceil\log_2(k+1)\rceil\approx\log_2 k$, **not** $k$.
- **Pseudo-polynomial** ➔ a loop running $k$ times is $O(2^n)$ in true size (Knapsack $O(nW)$, still NP-hard).

### 3. Running Time & RAM Model
- **Abstraction** ➔ **Random-Access Machine** — each elementary op = 1 unit, $O(1)$ random access (ignores compiler/machine).
- **Portability** ➔ step count $T(n)$ is machine-independent ⟹ "$\Theta(n^2)$" portable, "3 ms" not.
- **Boundary** ➔ breaks for arbitrary-precision arithmetic / external-memory effects.

### 4. Time Complexity $T(n)$ & Step Cost
- **Counting rules** ➔ statement $=1$ | sequence sums | if = test + branch | loop = body × iters | recursion = **recurrence**.
- **CompEq factor** ➔ a step is $O(1)$ only for fixed-size keys; length-$m$ strings ⟹ $O(n\log n)\cdot\text{CompEq}$.
- **`swap` is $O(1)$** ➔ 3 copies; choose a sort minimising the **expensive** op.

### 5. Best / Worst / Average Case
- **Definitions** ➔ at fixed $n$: $W=\max$, $B=\min$, $A=\mathbb{E}_{\mathcal D}[\text{cost}]$, with $B\le A\le W$.
- **Best ≠ worst only on short-circuit** ➔ requires an `if`/`break`/early return, else best=worst (selection sort).
- **Average ≠ amortised** ➔ average needs a **distribution**; amortised is a worst-case-sequence guarantee with **no probability**.

## ⚙️ Core Implementation
### 🔹 Step-counting & the input-size gotcha
> [!code]- counting rules + bit-length trap
> ```python
> # T(n) counting (RAM model):
> def bubble_sort(the_list):
>     n = len(the_list)                       # 2 steps
>     for _ in range(n-1):                    # outer: n-1
>         for i in range(n-1):                # inner: n-1
>             if the_list[i] > the_list[i+1]: # 3 steps
>                 swap(the_list, i, i+1)      # 7 steps
> # T(n) = 13n^2 - 22n + 12  ->  O(n^2)
>
> size = k.bit_length()      # == ceil(log2(k+1)) ~ log2 k   (a NUMBER's size)
> len([1,2,3,5,8])           # 5   (a collection's size = element count)
> ```
> 💡 **Common Mistake:** **Exact polynomial is accurate but useless** ➔ report $O(n^2)$; a loop running $k$ times on number $k$ is **$O(2^n)$** (since $n\approx\log_2 k$), not $O(n)$.

### 🔹 Cost of a step & best/worst short-circuit
> [!code]- `swap` $O(1)$ + insertion-sort's best/worst gap
> ```python
> def swap(a, i, j):
>     tmp = a[i]; a[i] = a[j]; a[j] = tmp      # always 3 copies => O(1)
>
> # Insertion sort inner loop — the source of the best/worst split:
> while i >= 0 and a[i] > temp:   # sorted -> stops at once (BEST, O(n) total)
>     a[i + 1] = a[i]             # reverse -> runs k times (WORST, O(n^2))
>     i -= 1
> ```
> 💡 **Common Mistake:** **Best case ≠ "small input"** ➔ both fix size $n$ and differ by **arrangement**; if comparison costs $O(m)$, multiply every bound by $m$ ($O(n^2)\to O(n^2m)$).

## ⚖️ Core Decision Matrix
*(Best / Average / Worst time, with the worst-case trigger.)*

| Algorithm | Best | Average | Worst | Trigger of worst |
| :--- | :--- | :--- | :--- | :--- |
| Bubble Sort II | $O(n)$ | $O(n^2)$ | $O(n^2)$ | reverse-sorted |
| [[Sorting Problem|Selection Sort]] | $O(n^2)$ | $O(n^2)$ | $O(n^2)$ | **always** (no short-circuit) |
| [[Sorting Problem|Insertion Sort]] | $O(n)$ | $O(n^2)$ | $O(n^2)$ | reverse-sorted |
| [[Quick Sort]] | $O(n\log n)$ | $O(n\log n)$ | $O(n^2)$ | min/max pivot |
| [[Hash Table]] | $O(1)$ | $O(1)$ | $O(n)$ | all keys collide |

> [!NOTE] **When It Flips:** quote **worst** for guarantees (real-time/adversarial), **average** for typical (quicksort, hashing), best rarely. **Average ≠ amortised** — average assumes a distribution (fails on skewed inputs); amortised is a hard worst-case-sequence guarantee with no probability.

## 📊 Exam Execution Trace

### Manual Execution Trace
Costing code shapes to a closed form:

| Step / State | Code Shape | Contribution to $T(n)$ |
| :--- | :--- | :--- |
| **0 (Init)** | simple statement | $+1$ |
| 1 | sequence | sum of costs |
| 2 | loop $\times n$ | $n\times$ body |
| 3 | fixed loop $\times100$ | $O(1)$ factor |
| 4 | recursive call | a term in a recurrence |

### Applied Exercise
**Problem:** Show why an $O(nW)$ Knapsack DP is pseudo-polynomial, not polynomial.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{size of capacity } W &= \log_2 W \text{ bits} \Rightarrow W = 2^{\log_2 W} \\
O(nW) &= O\!\big(n\,2^{\log_2 W}\big) = \textbf{exponential in the encoding length of } W
\end{aligned}
$$
**Final Extracted Output:** polynomial in the *value* $W$ but exponential in its *bit-length* ⟹ pseudo-polynomial (why Knapsack stays NP-hard).

## 🧠 Active Recall
> [!FAQ]- Distinguish worst-case, average-case, and amortised complexity, stressing each assumption.
> - **Hint:** Each makes a different assumption.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Worst** = max, no assumption; **average** = expectation over a distribution; **amortised** = worst-case sequence ÷ length, no probability.
> > - **Why:** **Guarantee vs model** ➔ amortised $O(1)$ append is a guarantee; average $O(1)$ hash lookup assumes good hashing.

> [!FAQ]- A DP algorithm runs in $O(nW)$ for numeric capacity $W$ — why is it pseudo-polynomial, not polynomial?
> - **Hint:** Polynomial means in the *bit-length*.
> > [!SUCCESS]- Answer
> > - **Short answer:** $W$ contributes $\log_2 W$ bits ⟹ $O(nW)=O(n\,2^{\log_2 W})$ is exponential in the encoding length.
> > - **Why:** **Value vs size** ➔ polynomial in the *value* $W$ only — hence *pseudo*-polynomial, and why Knapsack stays NP-hard.

> [!FAQ]- Why is "$\Theta(n^2)$" portable but "runs in 3 ms" is not?
> - **Hint:** RAM-model machine-independence.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\Theta(n^2)$ is a property under the RAM model ⟹ identical step count across machines/compilers.
> > - **Why:** **Folded constants** ➔ "3 ms" folds in CPU speed, compiler, and input — none generalise.

> [!FAQ]- Why do selection sort's best and worst cases coincide while quicksort's diverge?
> - **Hint:** Short-circuit vs input-dependent pivot.
> > [!SUCCESS]- Answer
> > - **Short answer:** Selection sort never early-terminates ⟹ cost depends only on $n$ ⟹ best=worst=$\Theta(n^2)$.
> > - **Why:** **Pivot quality** ➔ quicksort's cost depends on the input (median $\Theta(n\log n)$, min/max $\Theta(n^2)$), so its cases separate.

> [!FAQ]- If each comparison costs $O(m)$ but each swap is $O(1)$, does merge sort or selection sort scale better?
> - **Hint:** Weight ops by their true cost.
> > [!SUCCESS]- Answer
> > - **Short answer:** Merge sort $\Theta(nm\log n)$ vs selection sort $\Theta(n^2 m)$ ⟹ **merge sort wins**.
> > - **Why:** **Comparison-dominated** ➔ comparison cost amplified by $m$ dominates, so selection sort's $\Theta(n)$ swap-thrift doesn't help.
