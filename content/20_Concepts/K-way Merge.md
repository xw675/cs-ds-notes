---
unit: FIT2004
domain: A
week: 3
source: [applied]
parent: "[[Merge Sort]]"
tags: [CS/Algorithms, CS/Sorting, CS/Complexity]
aliases: [K-way Merging, Multiway Merge, Merging K Sorted Lists]
---
# [[K-way Merge]]

**Context:** [[FIT2004_MOC]] · [[Merge Sort]]'s combine step generalised from $2$ lists to $k$ · the exam shape is **"the naive version is $\Theta(Nk)$ — make it better"**, and the answer is an ADT swap to a min-[[Heap]] (LO3) · the engine of **external sorting**

> [!abstract] Quick Revision
> - **🎯 Objective:** merge $k$ sorted lists holding $N$ items total into one sorted list ➔ the only question each step asks is **"which head is smallest?"**, so the cost of answering it *is* the algorithm.
> - **📦 Core Components:** **linear scan of $k$ heads** ➔ $\Theta(k)$ per item, $\Theta(Nk)$ total | **min-[[Heap]] of $k$ heads** ➔ $\Theta(\log k)$ per item, $\Theta(N\log k)$ total.
> - **⚡ Key Constraint:** the heap holds **one item per list, never the whole input** ➔ auxiliary space is $\Theta(k)$ and independent of $N$, which is exactly why this merges runs too large for memory.

## 📝 How It Works
### 1. Why $k$-way Is Harder Than $2$-way
- **Two lists ⟹ one comparison** ➔ [[Merge Sort]]'s merge compares `a[ia]` against `b[ib]`, emits the smaller, advances that index — $\Theta(1)$ per output item, $\Theta(N)$ overall.
- **$k$ lists ⟹ a minimum query** ➔ "smaller of two" becomes "**minimum of $k$**", which a linear scan answers in $\Theta(k)$ ⟹ $\Theta(Nk)$ total. The merge is no longer free; **finding the minimum is the bottleneck**.
- **Reframe as an ADT problem** ➔ repeated *extract-min* with *insert* between extractions is the definition of a [[Priority Queue (ADT)]]; swapping the linear scan for the right ADT is the entire optimisation.

### 2. The Min-Heap Solution
- **Seed** ➔ push the **head of each list** as a triple $(\text{value},\ \text{list id},\ \text{index})$ ⟹ heap size exactly $k$.
- **Loop** ➔ `get_min` emits the next output item in $\Theta(\log k)$; then `add` that list's **successor**, keeping the heap at size $k$ ⟹ $\Theta(\log k)$.
- **Total** ➔ $N$ items each paying one extract and one insert ⟹ $\Theta(N\log k)$ time, $\Theta(k)$ auxiliary beyond the output.
- **Carrying the list id is mandatory** ➔ without it you know *what* the minimum was but not *which list to refill from*; the index field is what makes the successor lookup $O(1)$.

### 3. The Invariant That Proves It
- **Invariant** ➔ *at iteration $i$, the heap root is the correct value for `output[i]`, because it is $\le$ every item remaining in every list.*
- **Why it holds** ➔ each list is **sorted**, so a list's unconsumed head is that list's own minimum; the heap contains **all $k$ heads**; the root is the minimum of the heads ⟹ the minimum of everything unconsumed ➔ [[Invariant]].
- **Termination** ➔ each iteration removes exactly one item from a finite total of $N$ and refills only from a strictly advancing index ⟹ the heap empties after $N$ iterations.
- **Stability comes free** ➔ break heap ties by **list id** and the merge is stable, which matters when $k$-way merge is the combine step of a stable sort.

### 4. $\Theta(N\log k)$ Is Optimal — the Reduction
- **Claim** ➔ no **comparison-based** $k$-way merge can beat $O(N\log k)$.
- **The reduction** ➔ take any sequence of length $N$, split it into $N$ lists of length $1$ (each **trivially sorted**), and merge them with $k=N$. The output is the sorted sequence ⟹ the merge algorithm **is** a comparison sort.
- **The contradiction** ➔ comparison sorting is $\Omega(N\log N)$; at $k=N$ a merge faster than $O(N\log k)=O(N\log N)$ would therefore break that floor ➔ [[Sorting Problem]].
- **Read the shape, not just the result** ➔ this is a **lower bound by reduction**: you inherit a known bound by showing the new problem can *simulate* the old one. The same move proves optimality claims across the unit, so drill the argument, not the answer ➔ LO1.
- **The bound is on the comparison model only** ➔ a non-comparison merge over bounded integer keys is not covered by it, exactly as [[Counting Sort]] escapes the sorting floor.

## ⚙️ Core Implementation
### 🔹 Heap-backed $k$-way merge
> [!code]- `k_way_merge` — min-[[Heap]] of $(\text{value},\ \text{list id},\ \text{index})$ triples
> ```python
> def k_way_merge(lists):
>     # lists: k already-sorted lists. MinHeap is the mirror of the vault's
>     # max-heap: parent <= child, add -> rise, get_min -> sink
>     heap = MinHeap()
>     total = 0
>     for lid in range(len(lists)):
>         if len(lists[lid]) > 0:
>             heap.add((lists[lid][0], lid, 0))   # seed with each list's HEAD
>         total = total + len(lists[lid])
>     output = [None] * total
>     write = 0
>     while write < total:
>         value, lid, idx = heap.get_min()        # O(log k) -- the whole cost
>         output[write] = value
>         write = write + 1
>         if idx + 1 < len(lists[lid]):           # refill from the SAME list
>             heap.add((lists[lid][idx + 1], lid, idx + 1))
>     return output
> ```
> 💡 **Common Mistake:** **Pushing every item at seed time** ➔ a heap of all $N$ items costs $\Theta(N)$ space and $\Theta(N\log N)$ time — that is heapsort, not a merge, and it discards the fact that the lists are already sorted. The heap must never exceed $k$.

## ⚖️ Core Decision Matrix
| Strategy | Time | Auxiliary space | Selection rule |
| :--- | :--- | :--- | :--- |
| Linear scan of the $k$ heads | $\Theta(Nk)$ | $\Theta(k)$ indices | $k$ tiny (2–4) — $\log k$ is not worth the heap's constant |
| **Min-[[Heap]] of $k$ heads** | $\Theta(N\log k)$ | $\Theta(k)$ | the default; also the only option when the lists stream from disk |
| Divide & conquer (recursive halving) | $\Theta(N\log k)$ | $\Theta(N)$ scratch | lists are already resident and you want [[Merge Sort]]'s 2-way merge **reused unchanged** |
| Concatenate, then sort | $\Theta(N\log N)$ | $\Theta(N)$ | never for sorted input — it **discards** the sortedness you were given |
| Sequential accumulate (merge one at a time) | $\Theta(Nk)$ | $\Theta(N)$ | never — re-copies the growing accumulator $k$ times |

> [!NOTE] **When It Flips:** the heap wins once $\log_2 k < k$ in the constants, i.e. from roughly $k\ge8$. Note that $\Theta(N\log k)$ **is** [[Merge Sort]] when $k=N$: seeding $N$ singleton lists reproduces $\Theta(N\log N)$ exactly — the two algorithms are the same recurrence read from opposite ends.

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace
$k=3$: $A=[1,4,9]$, $B=[2,3,8]$, $C=[5,6,7]$. Heap shown as sorted contents for readability; only the **root** is actually ordered.

| Step | Heap (size $k=3$) | Root extracted | Refilled from | Output so far |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Seed)** | $(1,A),(2,B),(5,C)$ | — | — | `[]` |
| 1 | $(2,B),(4,A),(5,C)$ | $1$ | $A\to4$ | `[1]` |
| 2 | $(3,B),(4,A),(5,C)$ | $2$ | $B\to3$ | `[1,2]` |
| 3 | $(4,A),(5,C),(8,B)$ | $3$ | $B\to8$ | `[1,2,3]` |
| 4 | $(5,C),(8,B),(9,A)$ | $4$ | $A\to9$ | `[1,2,3,4]` |
| 5 | $(6,C),(8,B),(9,A)$ | $5$ | $C\to6$ | `[1,2,3,4,5]` |

**Invariant check at step 3:** the root $3$ is $\le$ the other heads $4$ and $5$, and each head is $\le$ everything left in its own list ⟹ $3$ is the global minimum of all unconsumed items, so `output[2] = 3` is final.

### Applied Exercise
**Problem:** An external sort produced $k=1000$ sorted runs totalling $N=10^{6}$ records. Quantify the gain from replacing the linear-scan minimum with a heap.
$$
\begin{aligned}
T_{\text{scan}} &= N\cdot\Theta(k) = 10^{6}\times 10^{3} = \Theta(10^{9}) \text{ comparisons} \\
T_{\text{heap}} &= N\cdot\Theta(\log_2 k) = 10^{6}\times\lceil\log_2 1000\rceil = 10^{6}\times 10 = \Theta(10^{7}) \\
S_{\text{aux}} &= \Theta(k) = \Theta(10^{3}) \text{ triples, independent of } N
\end{aligned}
$$
**Final Extracted Output:** $\Theta(N\log k)$ against $\Theta(Nk)$ — a $100\times$ reduction here, with auxiliary space unchanged at $\Theta(k)$. The $\Theta(k)$ bound is what permits $N$ to exceed memory: only $k$ records are ever resident.

## ⚠️ Common Mistakes
- 💡 **Quoting $\Theta(N\log N)$ for the heap version** ➔ the heap never holds more than $k$ items, so each operation is $\Theta(\log k)$, not $\Theta(\log N)$ — the whole point is that $k\ll N$.
- 💡 **Losing the list id** ➔ storing bare values makes the refill step ambiguous; the triple $(\text{value},\ \text{list id},\ \text{index})$ is not optional bookkeeping, it is what keeps the refill $O(1)$.
- 💡 **Reaching for `build_heap`** ➔ bottom-up $\Theta(k)$ construction needs all $k$ heads up front, which is fine at seed time but useless mid-merge; the refills are one-at-a-time `add` calls ➔ [[Heap]].

## 🧠 Active Recall
> [!FAQ]- State the invariant that proves $k$-way merge correct, and justify why the heap **root** alone settles the next output slot.
> - **Hint:** Use the fact that each input list is already sorted.
> > [!SUCCESS]- Answer
> > - **Short answer:** At iteration $i$ the root is $\le$ every unconsumed item, so it is `output[i]`.
> > - **Why:** **Heads dominate their own lists** ➔ sortedness makes each list's unconsumed head that list's minimum; the heap holds all $k$ heads, so the global minimum must be among them, and the heap root *is* their minimum. No item deeper in any list can undercut it ➔ [[Invariant]].

> [!FAQ]- Why is auxiliary space $\Theta(k)$ rather than $\Theta(N)$, and what capability does that buy?
> - **Hint:** Count how many records must be in memory simultaneously.
> > [!SUCCESS]- Answer
> > - **Short answer:** Only one record per list is resident ⟹ $\Theta(k)$, independent of $N$ ⟹ **external sorting** becomes possible.
> > - **Why:** **Streamable** ➔ the algorithm touches each list strictly left-to-right and never looks back, so the lists can live on disk and be read as streams; a strategy that loads all $N$ items to sort them cannot merge data larger than memory at any complexity ➔ [[Algorithmic Complexity]].

> [!FAQ]- Someone proposes merging the $k$ lists into an accumulator one at a time. Give the bound and the flaw.
> - **Hint:** Ask how large the accumulator is on the $i$-th merge.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\Theta(Nk)$ — the same as the naive scan, and with $\Theta(N)$ copying on every round.
> > - **Why:** **The accumulator is re-walked $k$ times** ➔ merging list $i$ into an accumulator of size $\approx\tfrac{iN}{k}$ costs that much again, summing to $\Theta(Nk)$ by the [[Arithmetic Series]]. **Divide and conquer** fixes it: recursively merge the first $\lfloor k/2\rfloor$ lists and the remaining $\lceil k/2\rceil$, then one ordinary 2-way merge ⟹ depth $\Theta(\log k)$, $\Theta(N)$ work per level, $\Theta(N\log k)$ total — matching the heap while reusing [[Merge Sort]]'s merge verbatim.

> [!FAQ]- Prove that no comparison-based $k$-way merge can run faster than $O(N\log k)$.
> - **Hint:** Choose the value of $k$ that turns merging into a problem you already have a bound for.
> > [!SUCCESS]- Answer
> > - **Short answer:** At $k=N$ with singleton lists, a $k$-way merge **is** a comparison sort, so beating $O(N\log k)$ would beat $\Omega(N\log N)$.
> > - **Why:** **Lower bound by reduction** ➔ split any sequence of length $N$ into $N$ lists of one element each; every such list is trivially sorted, so it is a legal input to the merge, and its output is the sorted sequence. Any merge faster than $O(N\log k)$ would therefore sort faster than $\Omega(N\log N)$ — impossible in the comparison model ➔ [[Sorting Problem]]. Note this bounds the **comparison** model only.
