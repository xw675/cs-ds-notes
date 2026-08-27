---
unit: [FIT1008, FIT2004]
domain: A
week: [7, 3, 4]
source: [lecture, applied]
parent: "[[Divide and Conquer]]"
tags: [CS/Algorithms, CS/Sorting, CS/Complexity]
aliases: [Quicksort]
---
# [[Quick Sort]]

**Context:** [[FIT1008_MOC]] · a [[Divide and Conquer]] sort · solves the [[Sorting Problem]] · uses an [[Recursion|Auxiliary Function (Recursion)]] · contrast with [[Merge Sort]]; falls back to [[Sorting Problem|Insertion Sort]] for tiny arrays
**FIT2004 emphasis:** the three W3 design questions — **how to partition efficiently** ➔ [[Partitioning (Quicksort)]] · **how to choose a good pivot** (fixed → median-of-three → random → [[Quickselect]] → [[Median of Medians]]) · **how to ensure the worst case never occurs**. The same partition drives [[Quickselect]], and the W3 deck adds the **average-case** analysis that FIT1008 never gave.

> [!abstract] Quick Revision
> - **🎯 Objective:** partition around a pivot, recurse both sides ➔ heavy-split / trivial-combine D&C sort, no merge.
> - **📦 Core Components:** **Partition** ➔ smaller left, larger right | **Pivot** ➔ lands final | **Recurse** ➔ both sides.
> - **⚡ Key Constraint:** in-place partition + smallest constant ➔ but $\Theta(N^{2})$ on bad pivots; **pivot choice is the whole game** — and only a [[Median of Medians]] pivot converts "improbable" into "impossible".

## 📝 How It Works
### 1. The Algorithm (Partition → Recurse)
- **Non-trivial split** ➔ partition: smaller elements left of pivot, larger right ➔ [[Partitioning (Quicksort)]].
- **Trivial combine** ➔ pivot already final ➔ just sort each side (no merge).
- **Recursion boundary** ➔ the returned `boundary` is the pivot's final index and is **excluded** from both recursive calls; recurse until a partition has size $1$.
- **Mirror of [[Merge Sort]]** ➔ merge sort splits trivially and combines expensively; quicksort splits expensively and combines for free. Both pay $\Theta(N)$ per level — the difference is *where*.

### 2. Partitioning — the Scheme Is a Separate Decision
- **Three schemes taught** ➔ **out-of-place** ($\Theta(N)$ extra space) · **Hoare's** (in-place, $\le1$ swap per item) · **Lomuto's** (in-place, more swaps, simplest) ➔ full treatment, invariants and code in [[Partitioning (Quicksort)]].
- **3-way / Dutch national flag** ➔ partition into $<p$, $=p$, $>p$ and recurse only on the outer two ⟹ the **all-duplicates** input drops from $\Theta(N^{2})$ to $\Theta(N)$, and depth becomes $O(\log d)$ for $d$ distinct keys.
- **The choice never changes the complexity class** *(except the 3-way case)* ➔ all schemes are $\Theta(N)$ comparisons per level; they differ in **writes** and **space**, which is what matters when records are large ➔ [[Sorting Problem]].

### 3. Pivot Selection
- **Balanced split** ➔ median-ish pivot ➔ $\log_2 N$ levels × $\Theta(N)$ = $\Theta(N\log N)$.
- **Degenerate split** ➔ fixed pivot on sorted input peels off one element ➔ depth $N$, $\Theta(N^{2})$.
- **Balance need not be perfect** ➔ even a fixed $1:9$ split gives depth $\log_{10/9}N=\Theta(\log N)$ ⟹ still $\Theta(N\log N)$; only a split that is lopsided by a **constant number of elements at every level** reaches $\Theta(N^{2})$.

| Pivot policy | Cost to choose | Worst case | Triggered by | Verdict |
| :--- | :--- | :--- | :--- | :--- |
| First / last element | $O(1)$ | $\Theta(N^{2})$ | **already-sorted** input | never — sorted input is the common case, not a rare one |
| Minimum (or maximum) element | — | $\Theta(N^{2})$ | **every** input | worst *and* **best** case are both $\Theta(N^{2})$ — the split is empty:$N-1$ always |
| $10$th-percentile element | — | $\Theta(N\log N)$ | nothing | fine — a **constant fraction** $0.9^{k}n=1$ gives $k=\log_{10/9}N=\Theta(\log N)$ levels |
| Average (mean) element | $\Theta(N)$ | $\Theta(N^{2})$ | $a_i=i!$ and similar skewed sequences | **fails** — the mean can sit arbitrarily far from the median |
| Middle element | $O(1)$ | $\Theta(N^{2})$ | organ-pipe / crafted input | acceptable for coursework; still constructible |
| Median-of-three | $O(1)$ | $\Theta(N^{2})$ | a crafted "killer" sequence | the practical library default |
| **Random** | $O(1)$ + RNG | $\Theta(N^{2})$, probability $\to 0$ | an unlucky run only | removes the **adversary**, not the possibility |
| Exact median by [[Quickselect]] | $\Theta(N)$ expected, $\Theta(N^{2})$ worst | $\Theta(N^{2})$ | quickselect's own bad pivots | **fails** — see [[Quickselect]] §5 |
| [[Median of Medians]] | $\Theta(N)$ worst | $\Theta(N\log N)$ | nothing | when a **guarantee** is contractually required |

### 3b. Reading a Pivot Rule Correctly *(prep + applied W4)*
- **The only question that matters** ➔ does the rule guarantee that **both** sides shrink by a constant **fraction**? A fraction — even $1{:}9$ or $1{:}99$ — is $\Theta(N\log N)$; a constant **number of elements** is $\Theta(N^{2})$.
- **Minimum-element pivot is the extreme case** ➔ every element lands on the right, so $T(N)=T(N-1)+\Theta(N)=\Theta(N^{2})$ for **every** input ⟹ best case $=$ worst case $=\Theta(N^{2})$, and no "family of bad inputs" needs constructing.
- **Median pivot is the other extreme** ➔ two exact halves ⟹ $\log_{2}N$ levels ⟹ $\Theta(N\log N)$ for every input (ignoring the cost of *finding* it — see §4).
- **The mean is not the median** ➔ tempting and wrong. On $a_{i}=i!$ the mean is $\ge\frac{n!}{n}=(n-1)!$, so the chosen pivot is always the **second-largest** element ⟹ $T(N)=T(N-2)+\Theta(N)=\Theta(N^{2})$.
- **The general lesson (LO1)** ➔ this is the failure mode of any [[Divide and Conquer]] design that does not **guarantee proportional reduction** of the subproblem — the same reason [[Binary Search]] works and a "shrink by one" search does not.

### 4. Ensuring the Worst Case Never Occurs
- **Randomisation is a probability claim** ➔ it makes the $\Theta(N^{2})$ input impossible to *construct in advance*, since the split no longer depends on the input's arrangement; it does **not** bound any individual run. *Lecturer's practical verdict: in reality a random pivot works well enough on probability alone.*
- **An exact median is not the fix** ➔ computing it with [[Quickselect]] inherits quickselect's own $\Theta(N^{2})$ worst case and the whole sort stays $\Theta(N^{2})$ ➔ [[Quickselect]] §5 carries the level-sum derivation.
- **[[Median of Medians]] is the guarantee** ➔ a provable $30/70$ split at every level ⟹ depth $O(\log N)$ ⟹ $\Theta(N\log N)$ **worst case**, at a constant factor large enough that practice still prefers random pivots.
- **The exam framing** ➔ "how do you ensure the worst case never occurs?" is asking you to distinguish **expected** from **worst-case** bounds, then name a mechanism that upgrades one to the other ➔ [[Algorithmic Complexity]].
- **Introsort — the engineering answer** ➔ run randomised quicksort but **count the recursion depth**; if it exceeds $\approx 2\log_2 N$, abandon and finish with [[Heapsort]] ⟹ $\Theta(N\log N)$ worst case at quicksort's average constant. *(🔭 Beyond the lecture — not in the slides; named only because it is what real libraries ship.)*

### 5. Space — Quicksort Is Never In-place
- **The lecturer's flagged claim** ➔ *quicksort is **not** in-place even when in-place partitioning is used* — the recursion depth is at least $\Theta(\log N)$ and every live frame is auxiliary space ➔ [[Analysing Recursive Algorithms (Time and Auxiliary Space)]].
- **Naive risk** ➔ a degenerate split stacks $\Theta(N)$ frames ⟹ quicksort's **worst-case auxiliary space is $O(N)$**, not $O(\log N)$.
- **Fix** ➔ recurse the smaller partition first, loop (tail-call) on the larger ➔ depth $\le\log_2 N$ ⟹ $O(\log N)$ space **in every case**, independent of pivot quality.
- **Only [[Heapsort]]** achieves $O(1)$ auxiliary among the $\Theta(N\log N)$ sorts ➔ [[Sorting Problem]].

### 6. Stability
- **Unstable as written** ➔ partition swaps across long distances, throwing equal keys past one another — the same mechanism that makes [[Sorting Problem|selection sort]] unstable.
- **"Depends on the partition"** ➔ each scheme fails stability for its **own** reason, and none of the three taught schemes is stable ➔ [[Partitioning (Quicksort)]] §2–§5.
- **Universal fallback** ➔ index-tagging works here as on any comparison sort, at $\Theta(N)$ space and no change to the time bound ➔ [[Sorting Problem]] §6 owns the mechanism.

## ⚙️ Core Implementation
### 🔹 `quick_sort` — the driver
> [!code]- `quick_sort`, `quick_sort_aux` *(partition schemes live in [[Partitioning (Quicksort)]])*
> ```python
> def quick_sort(array: ArrayR) -> None:
>     quick_sort_aux(array, 0, len(array) - 1)
>
> def quick_sort_aux(array, start, end) -> None:
>     if start < end:
>         boundary = lomuto_partition(array, start, end)  # pivot final at boundary
>         quick_sort_aux(array, start, boundary - 1)
>         quick_sort_aux(array, boundary + 1, end)
>
> def quick_sort_3way(array, start, end) -> None:
>     if start < end:
>         pivot = array[(start + end) // 2]
>         b1, b2 = dnf_partition(array, start, end, pivot)
>         quick_sort_3way(array, start, b1 - 1)   # the [b1..b2] block is FINAL
>         quick_sort_3way(array, b2 + 1, end)
> ```
> 💡 **Common Mistake:** **Sorting the $=p$ block** ➔ under a 3-way split the middle region is already final; including it in either recursive call restores the duplicate-key blow-up the split was built to remove.

## ⚖️ Core Decision Matrix
*(Domain A complexity table — Best / Average / Worst Time, Space, Stability.)*

| Algorithm | Best | Average | Worst | Auxiliary space | Stable | Trait |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Quick Sort** | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N^{2})$ | $O(\log N)$ smaller-first · $O(N)$ naive | No | in-place partition, fastest in practice |
| Quick Sort $+$ [[Median of Medians]] | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $O(\log N)$ | No | worst case **eliminated**, large constant |
| Quick Sort $+$ exact-median [[Quickselect]] | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N^{2})$ | $O(\log N)$ | No | **no gain** — inherits quickselect's worst case |
| [[Merge Sort]] | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N)$ | **Yes** | guaranteed + stable, scratch |
| [[Heapsort]] | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $O(1)$ | No | in-place + guaranteed |
| [[Quickselect]] | $\Theta(N)$ | $\Theta(N)$ | $\Theta(N^{2})$ | $O(1)$ iterative | — | **one rank only**, not a sort |

> [!NOTE] **When It Flips:** quicksort's no-merge, cache-friendly, in-place partition gives the **smallest constant** among $\Theta(N\log N)$ sorts — choose it unless a worst-case *bound* ([[Heapsort]]) or **stability** ([[Merge Sort]]) is required. A quicksort run mirrors the [[Binary Tree|BST]] shape of inserting the same pivots. Switch to a 3-way partition once duplicate keys are common, and to [[Quickselect]] the moment only one rank is wanted rather than the whole order.

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace — the average-case height argument
Colour the middle half of the pivot positions **green** ($N/4$ to $3N/4$) and the outer quarters grey. A uniformly random pivot is green with probability $\tfrac12$, and the **worst** green pivot (at $N/4$ or $3N/4$) leaves a larger side of $\tfrac{3N}{4}$.

| Level | Largest subproblem if every level is green | Work at this level | Running claim |
| :--- | :--- | :--- | :--- |
| $0$ | $N$ | $\le cN$ | partition the whole range |
| $1$ | $\tfrac{3N}{4}$ | $\le cN$ | sibling ranges still total $N$ |
| $2$ | $\tfrac{9N}{16}$ | $\le cN$ | $T(N)\to T(3N/4)$ each green level |
| $h$ | $N\left(\tfrac34\right)^{h}=1$ | — | base case reached |

$$
\begin{aligned}
N\left(\tfrac34\right)^{h} = 1 &\;\Longrightarrow\; N = \left(\tfrac43\right)^{h} \;\Longrightarrow\; h = \log_{4/3} N \\
\text{green only half the time} &\;\Longrightarrow\; \text{expected depth} \approx 2h = 2\log_{4/3} N \\
\log_{4/3} N = \frac{\log_2 N}{\log_2(4/3)} &\;\Longrightarrow\; 2\log_{4/3} N = \Theta(\log N) \\
\Theta(\log N)\ \text{levels} \times \Theta(N)\ \text{per level} &\;\Longrightarrow\; T_{\text{avg}}(N) = \Theta(N\log N)
\end{aligned}
$$

**Read the result:** the **change-of-base rule** is what licenses the last step — $\log_a N$ and $\log_b N$ differ by the constant $\log_b a$, so the base is invisible to the complexity class (though very visible in practice).

### Applied Exercise — average case from the recurrence *(lecturer-flagged **NOT EXAMINABLE**)*
**Problem:** with partitioning costed at $N+1$ operations and the pivot equally likely to land at any rank $k$, derive the average-case bound directly.
$$
\begin{aligned}
T_k(N) &= (N+1) + T(N-k) + T(k-1) \\
T(N) &= (N+1) + \frac{1}{N}\sum_{k=1}^{N}\bigl[T(N-k)+T(k-1)\bigr] = (N+1) + \frac{2}{N}\sum_{k=1}^{N}T(k-1) \\
N\,T(N) &= N(N+1) + 2\sum_{k=1}^{N}T(k-1) \qquad\text{(A)} \\
(N-1)T(N-1) &= N(N-1) + 2\sum_{k=1}^{N-1}T(k-1) \qquad\text{(B)} \\
\text{(A)}-\text{(B)}:\quad N\,T(N) &= 2N + (N+1)\,T(N-1) \;\Longrightarrow\; T(N) = 2 + \frac{N+1}{N}T(N-1) \\
\text{telescoping to } T(1)=b:\quad T(N) &= 2 + b(N+1) + 2(N+1)\sum_{k=3}^{N}\frac1k \\
\sum_{k=3}^{N}\frac1k \le \int_{1}^{N}\frac{1}{x}\,dx = \ln N &\;\Longrightarrow\; T(N) \le 2 + b(N+1) + 2(N+1)\ln N
\end{aligned}
$$
**Final Extracted Output:** $T(N)=O(N\log N)$. Two moves carry it — subtracting the $(N-1)$ instance to kill the summation, and bounding the **harmonic** tail by the area under $1/x$. Learn the technique; the derivation itself is off the exam.

### Applied Exercise — matching $n$ locks to $n$ keys in $\Theta(n\log n)$ *(applied W4)*
**Problem:** a key can be tried in a lock (too big / too small / fits), but two keys cannot be compared to each other, nor two locks. Match them all.
**The move:** partition needs only *one* comparable pair, so use a **lock as the pivot for the keys**, then the matching **key as the pivot for the locks**.
$$
\begin{aligned}
\text{Step 1} &: \text{pick a lock, try every key} \Rightarrow n \text{ comparisons; the fitting key is found} \\
\text{Step 2} &: \text{take that key, try every other lock} \Rightarrow n-1 \text{ comparisons} \\
\text{partition cost} &= \Theta(n), \qquad \text{recursion depth (average)} = \Theta(\log n) \\
T(n) &= 2T(n/2)+\Theta(n) = \Theta(n\log n) \quad\text{(average case)}
\end{aligned}
$$
**Final Extracted Output:** $\Theta(n\log n)$ average. The transferable move is **cross-pivoting**: when the comparison model forbids comparing within a set, pivot each set on an element of the *other* set. The bound is average-case for the same reason quicksort's is — an adversarial lock order still gives $\Theta(n^{2})$.

## ⚠️ Common Mistakes
- 💡 **Calling quicksort in-place** ➔ the *partition* is in-place; the *sort* is not, because $\Theta(\log N)$ recursion frames are auxiliary space. The lecturer flags this explicitly ➔ [[Analysing Recursive Algorithms (Time and Auxiliary Space)]].
- 💡 **Worst case needs lopsided-at-every-level** ➔ one bad split is harmless; $\Theta(N^{2})$ requires a constant-**size** split at every level. A $1:9$ split is still $\Theta(N\log N)$.
- 💡 **Worrying about the log base** ➔ $2\log_{4/3}N$, $\log_2 N$ and $\ln N$ are the same complexity class by change of base; only quote a base when discussing constants.

## 🧠 Active Recall
> [!FAQ]- Derive quicksort's average-case height without the full recurrence.
> - **Hint:** Give the middle half of the pivot positions a colour and count.
> > [!SUCCESS]- Answer
> > - **Short answer:** A pivot lands in the middle half with probability $\tfrac12$; the worst such split leaves $\tfrac{3N}{4}$, so a green-only run has depth $h=\log_{4/3}N$, and averaging one green level per two gives $\approx 2h = \Theta(\log N)$ ⟹ $\Theta(N\log N)$.
> > - **Why:** **Constant fraction ⟹ logarithmic depth** ➔ solve $N(3/4)^h=1$ for $h$; the factor $2$ and the base $4/3$ are both **constants**, erased by change of base $\log_{4/3}N=\log_2 N/\log_2(4/3)$ ➔ [[Solving Recurrences (Telescoping)]].

> [!FAQ]- Why is quicksort $\Theta(N\log N)$ on average despite a $\Theta(N^{2})$ worst case?
> - **Hint:** Tie cost to split balance and pivot policy.
> > [!SUCCESS]- Answer
> > - **Short answer:** A reasonable pivot ➔ two roughly equal halves ➔ $\Theta(\log N)$ levels × $\Theta(N)$ = $\Theta(N\log N)$.
> > - **Why:** **Lopsided-at-every-level** ➔ the $\Theta(N^{2})$ case needs a maximally bad split each level (fixed pivot on sorted input); random/median-of-three makes it improbable. A merely *unequal* split does not suffice — $1:9$ is still logarithmic in depth.

> [!FAQ]- "Ensure the worst case never occurs." Distinguish what randomisation gives you from what [[Median of Medians]] gives you.
> - **Hint:** One statement quantifies over inputs, the other over runs.
> > [!SUCCESS]- Answer
> > - **Short answer:** Randomisation makes the bad case **unconstructible**; [[Median of Medians]] makes it **impossible**.
> > - **Why:** **Expected vs worst-case bound** ➔ with a random pivot the split no longer depends on the input's arrangement, so no adversary can pre-build a killer input — but an unlucky run is still permitted, and $\Theta(N^{2})$ remains the worst-case bound. A deterministic $30/70$ guarantee changes the bound itself to $\Theta(N\log N)$, at a constant so large that practice keeps randomisation ➔ [[Algorithmic Complexity]].

> [!FAQ]- Quicksort's partition is in-place, yet the sort can use $O(N)$ space. Reconcile that, then guarantee $O(\log N)$.
> - **Hint:** Count live frames, then control which call recurses.
> > [!SUCCESS]- Answer
> > - **Short answer:** The recursion stack is auxiliary space, so quicksort is **never** in-place; **recurse on the smaller partition first and loop on the larger** to cap the depth at $\log_2 N$.
> > - **Why:** **Depth halving** ➔ the explicit recursive call always at least halves the range ⟹ stack depth $\le\log_2 N$. Without it, the degenerate split stacks $N$ frames and the auxiliary space is $\Theta(N)$ — the figure the sorting summary table records for quicksort's worst case ➔ [[Sorting Problem]].

> [!FAQ]- When is merge sort preferable to quicksort, and vice versa?
> - **Hint:** Map guarantees/stability vs average speed/space.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Merge** for worst-case guarantees, stability, linked lists, external data; **quicksort** for in-memory arrays.
> > - **Why:** **Space/stability trade** ➔ merge guarantees $\Theta(N\log N)$ + stable but $\Theta(N)$ scratch; quicksort partitions in place with smaller constants, $\Theta(N^{2})$ tamed by randomisation. Quicksort can be made stable only by partitioning out-of-place or index-tagging, both costing $\Theta(N)$ — at which point merge sort's advantage is free.

> [!FAQ]- Bob pivots on the element closest to the **mean**. Worst case, and a family of inputs that triggers it?
> - **Hint:** The mean is a value; the pivot must be a *rank*.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\Theta(n^{2})$, on any sequence whose mean is far from its median — e.g. $a_{i}=i!$.
> > - **Why:** **The mean is dragged by outliers, the median is not** ➔ for factorials $\frac1n\sum i!\ge\frac{n!}{n}=(n-1)!$, so the closest element is the second-largest and the split is $n-2$ against $1$. **Constant-size splits, not unbalanced ones, are fatal** ➔ $T(n)=T(n-2)+\Theta(n)$ telescopes to $\Theta(n^{2})$ by the [[Arithmetic Series]], whereas a $1{:}9$ *fraction* would still be $\Theta(n\log n)$. **The general diagnosis** ➔ a [[Divide and Conquer]] rule that does not guarantee **proportional** reduction has no logarithmic depth to lean on.
