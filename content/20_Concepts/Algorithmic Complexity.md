---
unit: [FIT1008, FIT2004]
domain: A
week: 1
source: [applied]
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
- **Bit-length trap** ➔ a **number** $k$ has size $\lceil\log_2(k+1)\rceil\approx\log_2 k$, **not** $k$; halving $k$ to $1$ therefore takes $\Theta(\log k)$ steps, i.e. $\Theta(\text{bits})$.
- **Pseudo-polynomial** ➔ a loop running $k$ times is $O(2^n)$ in true size (Knapsack $O(nW)$, still NP-hard).
- **A BOUNDED parameter is a constant** ➔ if the spec caps a parameter ($n\le10^6$, $\text{arr}[i]<2^{32}$), that parameter contributes $\Theta(1)$ and **vanishes from the bound** — the cap makes it independent of input size, not merely small.
- **Which symbols are free** ➔ before quoting a bound, list which parameters can grow without limit; a bound may only be expressed in **those**.

### 3. Running Time & RAM Model
- **Abstraction** ➔ **Random-Access Machine** — each elementary op = 1 unit, $O(1)$ random access (ignores compiler/machine).
- **Portability** ➔ step count $T(n)$ is machine-independent ⟹ "$\Theta(n^2)$" portable, "3 ms" not.
- **Boundary** ➔ breaks for arbitrary-precision arithmetic / external-memory effects.
- **Declare the unit-cost assumption** ➔ "$+$ is $O(1)$" holds only for machine-word operands; on values whose **bit-length grows with $n$** an addition costs $\Theta(\text{bits})$ ➔ iterative Fibonacci is $\Theta(n)$ *word* operations but $\Theta(n^2)$ *bit* operations, since $F(n)=\Theta(\varphi^{n})$ occupies $\Theta(n)$ bits (see [[Fibonacci Sequence]], [[Recursion]]).

### 4. Time Complexity $T(n)$ & Step Cost
- **Counting rules** ➔ statement $=1$ | sequence sums | if = test + branch | loop = body × iters | recursion = **recurrence**.
- **CompEq factor** ➔ a step is $O(1)$ only for fixed-size keys; length-$m$ strings ⟹ $O(n\log n)\cdot\text{CompEq}$.
- **`swap` is $O(1)$** ➔ 3 copies; choose a sort minimising the **expensive** op.

### 5. Best / Worst / Average Case
- **Definitions** ➔ at fixed $n$: $W=\max$, $B=\min$, $A=\mathbb{E}_{\mathcal D}[\text{cost}]$, with $B\le A\le W$.
- **Best ≠ worst only on short-circuit** ➔ requires an `if`/`break`/early return, else best=worst (selection sort).
- **Average ≠ amortised** ➔ average needs a **distribution**; amortised is a worst-case-sequence guarantee with **no probability**.

### 6. Space: Total vs Auxiliary *(FIT2004 quoting standard)*
- **Total space** ➔ input **plus** everything allocated ⟹ always $\Omega(n)$ for an $n$-element input, so it never discriminates between algorithms.
- **Auxiliary space** ➔ **extra beyond the input** — the number quoted in a complexity table; **in-place** $\equiv$ $O(1)$ auxiliary.
- **Recursion stack counts** ➔ auxiliary space $\ge$ **max live frame chain**, i.e. $\Theta(\text{depth})\times$ frame size — sibling calls run sequentially, so only ONE root-to-leaf path is live at a time (never $\Theta(\text{total calls})$).
- **Depth is the discriminator** ➔ balanced recursion $\Theta(\log n)$ frames ([[Quick Sort]] with the smaller side recursed first) vs peeling one element $\Theta(n)$ frames — the same split that decides *time* in [[Divide and Conquer]].
- **Shrinking frames sum, not multiply** ➔ frames of size $n,n/2,n/4,\dots$ total $<2n=\Theta(n)$, not $\Theta(n\log n)$ (see [[Karatsuba Integer Multiplication]]).
- **Tightest bound** ➔ quote $\Theta$ when best $=$ worst; reserve $O$ for a genuine upper-bound-only claim.

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

## ✍️ Practice
> [!QUESTION]- Practice 1: `CountBits(x)` sets `bits=1` then halves `x` while `x>1`; `CountTotalBits(arr[1..n])` sums `CountBits` over the array. Give the $\Theta$ complexity when (a) $|arr|=n$, $0\le arr[i]\le2^{m}-1$ · (b) same but $1\le n\le10^{6}$ · (c) $|arr|=n$, $0\le arr[i]\le2^{32}-1$.
> - **Hint:** First cost one `CountBits`, then ask which of $n$ and $m$ is actually allowed to grow.
> > [!SUCCESS]- Answer
> > - **Inner cost** ➔ halving $x$ until $x\le1$ runs $\lfloor\log_2 x\rfloor$ times ⟹ $\Theta(\log x)$, i.e. $\Theta(\text{bit-length})$; capped by $arr[i]\le2^{m}-1$ this is $\Theta(m)$ worst case.
> > - **(a) $\Theta(nm)$** ➔ $n$ calls × $\Theta(m)$ each; both parameters are unbounded, so both appear.
> > - **(b) $\Theta(m)$** ➔ $n\le10^{6}$ is a **constant cap** ⟹ $n=\Theta(1)$ ⟹ it drops out. The loop still runs, but it runs a bounded number of times.
> > - **(c) $\Theta(n)$** ➔ $arr[i]<2^{32}$ caps the bit-length at $32=\Theta(1)$ ⟹ each `CountBits` is $\Theta(1)$ ⟹ $n$ calls of constant cost.
> > - **Why:** **A cap kills a parameter** ➔ asymptotics describe growth, and a quantity that cannot grow contributes a constant factor — which is exactly what $\Theta$ discards. This is why real 32/64-bit integer arithmetic is quoted as $O(1)$ while big-integer arithmetic is not.

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

> [!FAQ]- [[Merge Sort]] is called an $O(n)$-space sort and [[Quick Sort]] an in-place one, yet both allocate. Justify both labels precisely.
> - **Hint:** Auxiliary, and count the live stack chain.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Auxiliary** space is what is quoted. Merge sort needs a $\Theta(n)$ scratch array ⟹ $\Theta(n)$; quicksort partitions inside the array, leaving only the recursion stack, $O(\log n)$ when the smaller side recurses first.
> > - **Why:** **Live chain, not total calls** ➔ sibling calls execute sequentially, so only one root-to-leaf path of frames exists at once; "in-place" means $O(1)$ auxiliary *excluding* that stack, which is why quicksort's label survives its $O(\log n)$ frames — but degrades to $\Theta(n)$ frames on a worst-case pivot.

> [!FAQ]- If each comparison costs $O(m)$ but each swap is $O(1)$, does merge sort or selection sort scale better?
> - **Hint:** Weight ops by their true cost.
> > [!SUCCESS]- Answer
> > - **Short answer:** Merge sort $\Theta(nm\log n)$ vs selection sort $\Theta(n^2 m)$ ⟹ **merge sort wins**.
> > - **Why:** **Comparison-dominated** ➔ comparison cost amplified by $m$ dominates, so selection sort's $\Theta(n)$ swap-thrift doesn't help.
