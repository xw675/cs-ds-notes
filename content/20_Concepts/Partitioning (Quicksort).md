---
unit: [FIT1008, FIT2004]
domain: A
week: [4, 7]
source: [lecture, applied]
parent: "[[Quick Sort]]"
tags: [CS/Algorithms, CS/Sorting]
aliases: [Partition, Hoare Partition, Lomuto Partition, Out-of-place Partition, Dutch National Flag, DNF, 3-way Partition]
---
# [[Partitioning (Quicksort)]]

**Context:** [[FIT2004_MOC]] · the engine inside [[Quick Sort]] and [[Quickselect]] — promoted out of [[Quick Sort]] because W4 examines the **schemes themselves**
**Parent Framework:** [[Quick Sort]]

> [!abstract] Quick Revision
> - **🎯 Objective:** rearrange a range so `≤ pivot` sits left and `> pivot` sits right ➔ the pivot lands at its **final sorted index** and is excluded from every later call.
> - **📦 Core Components:** **Out-of-place** ➔ two temp lists, $\Theta(N)$ extra | **Hoare's** ➔ in-place, $\le 1$ swap per item | **Lomuto's** ➔ in-place, more swaps, simpler | **Dutch flag** ➔ 3-way, retires the $=p$ block.
> - **⚡ Key Constraint:** the lecture's three goals — **in-place · fast · stable** — are never all three at once; every scheme taught is **unstable**, and the *reason* differs per scheme.

## 📝 How It Works
### 1. The Shared Contract
- **The invariant being established** ➔ `left ≤ pivot`, `right > pivot` — the **equality goes left**, and that single choice is what costs stability in every in-place scheme.
- **The payoff** ➔ the pivot is provably final ⟹ both recursive calls skip it. [[Merge Sort]] has no equivalent free element; this is quicksort's "trivial combine".
- **Cost floor is identical** ➔ every scheme touches all $N$ items once ⟹ $\Theta(N)$ **comparisons** per call. Schemes differ only in **writes** and **space** — so "which partition is better" is always a swap-count or memory question ➔ [[Sorting Problem]].

### 2. Out-of-place Partitioning *(the unit notes' "naive 3-way partitioning", §3.2)*
- **Mechanism** ➔ scan left→right appending each item to a `left` ($<p$), `equal` ($=p$) and `right` ($>p$) buffer, then concatenate and copy back.
- **Two buckets vs three** ➔ the two-bucket form ($\le p$ / $>p$) is the one the lecture calls unstable; the **naive 3-way** form keeps the $=p$ bucket, restoring stability **and** grouping duplicates so the recursion can skip them.
- **Space** ➔ $\Theta(N)$ **additional** space beside the recursion stack ⟹ surrenders quicksort's only structural advantage over [[Merge Sort]].
- **Why the two-bucket form is NOT stable** ➔ `≤ pivot` sends every item **equal to the pivot** into the left buffer, i.e. **in front of** the pivot even when it started behind it ⟹ the pivot reorders its own duplicates. A **third** buffer repairs it — lecturer's framing: *anything can be made stable with more memory* ➔ [[Sorting Problem]] §5.

### 3. Hoare's In-place Partitioning *(the version taught in this unit)*
- **Setup** ➔ swap the pivot to the **front**; set `L_bad` to the second slot and `R_bad` to the last.
- **Loop** ➔ advance `L_bad` right to the first **bad** element ($>$ pivot) · retreat `R_bad` left to the first **bad** element ($<$ pivot) · **swap that pair** · repeat until the pointers cross.
- **Finish** ➔ swap the parked pivot into `R_bad` ⟹ under this variant `R_bad` **is the pivot's final index**, like Lomuto's return value.
- **Invariants** ➔ everything left of `L_bad` is $\le p$ · everything right of `R_bad` is $>p$ · the band `[L_bad … R_bad]` is **unprocessed** and empties when the pointers cross.
- **Why it is the fast one** ➔ **each item is swapped at most once** (only the pivot moves twice) because one swap repairs **two** misplaced items ⟹ roughly $3\times$ fewer writes than Lomuto's.
- **Stability** ➔ the pointer conditions *can* be tightened into a stable rule, but the **final swap** of the pivot from the front to `R_bad` jumps it over everything in between and destroys it ⟹ **not stable**.
- **Lecturer-flagged fragility** ➔ the naive write-up has edge cases where the final pivot swap must **not** fire, plus a further special case needing an extra guard. Hoare's is the scheme you get wrong; Lomuto's is the one you get right.

### 4. Lomuto's In-place Partitioning
- **Mechanism** ➔ one left-to-right scan; `boundary` marks the end of the `≤ pivot` run; every smaller item is swapped up to `boundary`; a final swap drops the pivot onto `boundary`.
- **Contract** ➔ returns the pivot's **final index** $j$ ⟹ recurse `(start, j-1)` and `(j+1, end)`.
- **Verdict from the lecture** ➔ in place · **writes far more** — every item below the pivot is swapped even when already on the correct side · **still unstable** ⟹ *"worse than Hoare's"*.
- **Why it survives anyway** ➔ easier to understand and implement, and free of Hoare's edge cases — the FIT1008 version, and the one to write under time pressure.

### 5. Dutch National Flag — the In-place 3-way Partition
- **Where the idea came from** ➔ chasing stability exposed the real waste: the $=p$ block is **already final**, so re-sorting it is pure loss. Split into $<p \mid =p \mid >p$ and both recursive calls skip the middle.
- **Pointers** ➔ `boundary1` (end of the $<p$ prefix) · `j` (scan cursor) · `boundary2` (start of the $>p$ suffix); the loop runs while `j <= boundary2`.
- **Invariants** ➔ `[1 … boundary1-1]` is $<p$ · `[boundary1 … j-1]` is $=p$ · `[boundary2+1 … N]` is $>p$ · `[j … boundary2]` is **unprocessed**, empty exactly when the loop exits.
- **Returns two boundaries** ➔ quicksort recurses on `[start … boundary1-1]` and `[boundary2+1 … end]` **only**.
- **Payoff** ➔ with $d$ distinct keys the depth is $O(\log d)$, not $O(\log N)$; the all-duplicates input drops from $\Theta(N^{2})$ to $\Theta(N)$.
- **Two lecturer-flagged traps** ➔ the code changes depending on whether `boundary1`/`boundary2` are **inclusive or exclusive** — commit to one and state it · and one specific case still fails without an extra `if`/`else` inside the loop.
- **Still not stable** ➔ the $>p$ branch swaps across long distances; a 3-way split fixes **work**, never **order**.

### 6. $k$-Partitioning — the Generalisation *(applied W4)*
- **The problem** ➔ given $k\le n$ pivots $p_{1}<\dots<p_{k}$ (**not** supplied sorted), rearrange so every item $\le p_{1}$ comes first, then everything above $p_{1}$ and at most $p_{2}$, and so on — ordinary partitioning is $k=1$.
- **Step 0 always** ➔ sort the pivots, $\Theta(k\log k)$; dominated because $n\ge k$.
- **Naive: $\Theta(nk)$** ➔ 2-way partition on $p_{1}$, then partition the **suffix** on $p_{2}$, and so on ➔ $k$ calls of up to $\Theta(n)$.
- **Divide and conquer: $\Theta(n\log k)$** ➔ partition the whole array on the **middle** pivot $p_{\lceil k/2\rceil}$, then recurse left with the lower $k/2$ pivots and right with the upper $k/2$ ➔ $\Theta(\log k)$ levels $\times$ $\Theta(n)$ ([[Divide and Conquer]]).
- **Why it is optimal — prove by reduction** ➔ take all $n$ elements as pivots ($k=n$); $k$-partitioning then **sorts** the array, so beating $O(n\log k)$ would beat the comparison model's $\Omega(n\log n)$ floor ➔ $\Omega(n\log k)$.
- **The transferable move** ➔ identical in shape to [[K-way Merge]]'s $\Theta(Nk)\to\Theta(N\log k)$ upgrade: a **linear sweep over $k$ things** becomes **logarithmic in $k$** once a balanced structure is imposed — D&C here, a min-[[Heap]] there.

## ⚙️ Core Implementation
### 🔹 Out-of-place — stable only with a third buffer
> [!code]- `partition_out_of_place`
> ```python
> def partition_out_of_place(array, start, end, pivot_index):
>     pivot = array[pivot_index]
>     left, equal, right = [], [], []
>     for k in range(start, end + 1):
>         if k == pivot_index:
>             continue
>         if array[k] < pivot:
>             left.append(array[k])
>         elif array[k] == pivot:
>             equal.append(array[k])       # drop this bucket -> unstable
>         else:
>             right.append(array[k])
>     write = start
>     for item in left + equal + [pivot] + right:
>         array[write] = item
>         write += 1
>     return start + len(left) + len(equal)
> ```
> 💡 **Common Mistake:** **Merging `equal` into `left`** ➔ that is the two-bucket version the lecture calls unstable: every duplicate of the pivot is emitted *before* the pivot regardless of where it started.

### 🔹 Hoare's — swap once per item, pivot parked at the front
> [!code]- `hoare_partition` *(unit variant — returns the pivot's FINAL index)*
> ```python
> def hoare_partition(array, start, end, pivot_index):
>     swap(array, start, pivot_index)      # park the pivot at the front
>     pivot = array[start]
>     l_bad, r_bad = start + 1, end
>     while l_bad <= r_bad:
>         while l_bad <= r_bad and array[l_bad] <= pivot:
>             l_bad += 1                   # stop on the first item > pivot
>         while l_bad <= r_bad and array[r_bad] > pivot:
>             r_bad -= 1                   # stop on the first item < pivot
>         if l_bad < r_bad:
>             swap(array, l_bad, r_bad)    # ONE swap fixes TWO wrong items
>     swap(array, start, r_bad)            # pivot to its final slot
>     return r_bad
> ```
> 💡 **Common Mistake:** **Firing the final swap unconditionally** ➔ lecturer-flagged as a live bug: when the crossing leaves `r_bad` on the pivot itself (or on an item $>$ pivot) the swap corrupts the partition. Guard it, and hand-test the all-equal and length-$2$ ranges.

### 🔹 Lomuto's — one pointer, more writes
> [!code]- `lomuto_partition`
> ```python
> def lomuto_partition(array, start, end):
>     mid = (start + end) // 2
>     pivot = array[mid]
>     swap(array, start, mid)              # park pivot at start
>     boundary = start
>     for k in range(start + 1, end + 1):
>         if array[k] < pivot:
>             boundary += 1
>             swap(array, k, boundary)     # written even if already in place
>     swap(array, start, boundary)
>     return boundary
> ```

### 🔹 Dutch national flag — 3-way, returns two boundaries
> [!code]- `dnf_partition` *(lecture pseudocode, translated)*
> ```python
> def dnf_partition(array, start, end, pivot):
>     boundary1, j, boundary2 = start, start, end
>     while j <= boundary2:
>         if array[j] < pivot:                       # "blue"
>             swap(array, boundary1, j)
>             boundary1 += 1
>             j += 1
>         elif array[j] > pivot:                     # "red"
>             swap(array, j, boundary2)
>             boundary2 -= 1                         # NOTE: j does NOT advance
>         else:                                      # "white" == pivot
>             j += 1
>     return boundary1, boundary2
> ```
> 💡 **Common Mistake:** **Advancing `j` on the red branch** ➔ the item swapped in from `boundary2` is **unexamined**; incrementing `j` skips it and strands a $<p$ or $>p$ element in the $=p$ block.

### 🔹 $k$-partitioning — D&C, $\Theta(n\log k)$
> [!code]- `k_partition`
> ```python
> def k_partition(array, lo, hi, pivots, p_lo, p_hi):
>     # pivots[p_lo..p_hi] must already be sorted
>     if p_hi < p_lo or hi < lo:
>         return
>     mid = (p_lo + p_hi + 1) // 2                    # ceil - the middle pivot
>     j = partition(array, lo, hi, pivots[mid])       # ordinary 2-way partition
>     k_partition(array, lo, j - 1, pivots, p_lo, mid - 1)
>     k_partition(array, j + 1, hi, pivots, mid + 1, p_hi)
> ```
> 💡 **Common Mistake:** **Recursing on the pivots but not narrowing the array range** ➔ each call must inherit only its own side; re-partitioning the full array at every level gives $\Theta(nk)$ back.

## ⚖️ Core Decision Matrix
| Scheme | In-place | Writes per call | Extra space | Returns | Stable | Pick it when |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| Out-of-place | No | $\Theta(N)$ copies | $\Theta(N)$ + stack | pivot's final index | No · **Yes** with a 3rd buffer | stability is contractual and memory is free |
| **Hoare's** | Yes | $\le 1$ swap per item | $O(1)$ | pivot's final index *(this unit)* | No | records are large ⟹ writes dominate |
| Lomuto's | Yes | 1 swap per item $<p$, many redundant | $O(1)$ | pivot's final index | No | writing it correctly under exam time |
| Dutch flag (3-way) | Yes | 1 swap per misplaced item | $O(1)$ | **two** boundaries | No | duplicate keys are common ⟹ $d \ll N$ |

> [!NOTE] **When It Flips:** integer keys ⟹ the swap-count gap between Hoare's and Lomuto's is invisible, so write Lomuto's. Large records, or a stated write/IO cost ⟹ Hoare's $3\times$ write saving is the whole answer. Once the key domain is small (grades, flags, three sensor states) the argument stops being about swaps at all and the 3-way split changes the **complexity class** ➔ [[Quick Sort]] §2.

## 📊 Exam Execution Trace

### Manual Execution Trace
Hoare's on the lecture's array `[2, 8, 6, 4, 1, 7, 3, 5]`, pivot $=4$, **1-indexed**:

| Step | `L_bad` stops at | `R_bad` stops at | Action | Array payload |
| :--- | :--- | :--- | :--- | :--- |
| **0 (park)** | — | — | swap pivot to front | `[4, 8, 6, 2, 1, 7, 3, 5]` |
| 1 | $2$ (`8` $>4$) | $7$ (`3` $<4$) | swap | `[4, 3, 6, 2, 1, 7, 8, 5]` |
| 2 | $3$ (`6` $>4$) | $5$ (`1` $<4$) | swap | `[4, 3, 1, 2, 6, 7, 8, 5]` |
| 3 | $5$ (`6` $>4$) | $4$ (`2` $<4$) | **crossed** ⟹ exit | `[4, 3, 1, 2, 6, 7, 8, 5]` |
| 4 (finish) | — | $4$ | swap pivot into `R_bad` | `[2, 3, 1, 4, 6, 7, 8, 5]` |

**Read the result:** $4$ sits at index $4$ — its **final** sorted position — after only $3$ swaps for $8$ items, each moved item moving exactly once. Lomuto's on the same input writes every one of the three items below the pivot plus the two pivot swaps.

### Manual Execution Trace *(prep W4 — duplicates, both schemes)*
`[7, 1, 12, 9, 3, 3, 10, 6, 7, 14, 4]`, pivot $=7$ (the **first** element).

**Naive 3-way (out-of-place).** One pass builds three buckets, then concatenates: $<7$ = `[1, 3, 3, 6, 4]` · $=7$ = `[7, 7]` · $>7$ = `[12, 9, 10, 14]` ⟹ `[1, 3, 3, 6, 4, 7, 7, 12, 9, 10, 14]` — the pivot's duplicates sit **together**, so quicksort recurses on the two outer blocks only.

**Hoare's, in-place.** `lo` advances to a value $>7$; `hi` retreats to a value $\le 7$; swap; stop when they cross; finally swap the parked pivot with `hi`:

| Step | `lo` at | `hi` at | Action | Array |
| :--- | :--- | :--- | :--- | :--- |
| **0** | — | — | pivot already at the front | `[7, 1, 12, 9, 3, 3, 10, 6, 7, 14, 4]` |
| $1$ | $3$ (`12`) | $11$ (`4`) | swap | `[7, 1, 4, 9, 3, 3, 10, 6, 7, 14, 12]` |
| $2$ | $4$ (`9`) | $9$ (`7`) | swap | `[7, 1, 4, 7, 3, 3, 10, 6, 9, 14, 12]` |
| $3$ | $7$ (`10`) | $8$ (`6`) | swap | `[7, 1, 4, 7, 3, 3, 6, 10, 9, 14, 12]` |
| $4$ | $8$ | $7$ | **crossed** ⟹ exit | `[7, 1, 4, 7, 3, 3, 6, 10, 9, 14, 12]` |
| $5$ | — | $7$ | swap pivot into `hi` | `[6, 1, 4, 7, 3, 3, 7, 10, 9, 14, 12]` |

**Read the result:** the pivot $7$ lands at index $7$ in $4$ swaps. But the **duplicate** $7$ (originally index $9$) now sits at index $4$ — *left* of the pivot and not adjacent. Naive 3-way grouped the duplicates; Hoare's scatters them, which is precisely the gap the **Dutch national flag** scheme closes.

- **Convention warning** ➔ the prep sheet's `hi` stops on $\le p$ while §3's `R_bad` stops on $<p$; both are correct schemes but they produce **different arrays**. State which stopping rule you use before the first swap.

## ⚠️ Common Mistakes
- 💡 **Assuming one universal Hoare contract** ➔ **this unit's** variant parks the pivot and swaps it to `R_bad`, so `R_bad` is the pivot's **final index** ⟹ recurse `(start, j-1)` and `(j+1, end)`. The textbook Hoare partition never parks the pivot and returns a **split point** that must be **included** on the left ⟹ `(start, j)` and `(j+1, end)`. Copying the wrong call shape silently drops or duplicates an element — **state which contract you are using before you recurse**.
- 💡 **Claiming a partition is $\Theta(N)$ "swaps"** ➔ it is $\Theta(N)$ **comparisons**; swaps are $O(N)$ but the constant is the entire point of comparing schemes.
- 💡 **Calling the 3-way split a stability fix** ➔ it was *motivated* by the stability discussion but delivers **work reduction**; the equal block is skipped, not preserved in order.

## 🧠 Active Recall
> [!FAQ]- The three partition schemes all make $\Theta(N)$ comparisons per call. On what basis does the lecture rank them?
> - **Hint:** Count what is written, not what is read.
> > [!SUCCESS]- Answer
> > - **Short answer:** **writes and space.** Out-of-place copies $\Theta(N)$ items into $\Theta(N)$ extra memory; Lomuto's swaps every item below the pivot; Hoare's swaps each item **at most once**.
> > - **Why:** **One swap repairs two items** ➔ Hoare's only touches genuinely misplaced pairs, giving $\approx3\times$ fewer writes — invisible for integer keys, decisive for large records or an IO-costed model.

> [!FAQ]- Out-of-place partitioning copies items in input order, yet the lecture calls it unstable. Where is the order lost?
> - **Hint:** Look at what happens to items *equal* to the pivot.
> > [!SUCCESS]- Answer
> > - **Short answer:** the `≤ pivot` rule sends every duplicate of the pivot into the **left** buffer, i.e. **before** the pivot, even the ones that started after it.
> > - **Why:** **The pivot reorders its own duplicates** ➔ a two-bucket split has nowhere else to put them; a **third** buffer restores stability at more memory ➔ [[Sorting Problem]] §5.

> [!FAQ]- State the Dutch national flag invariants and say what each recursive call receives.
> - **Hint:** Four regions, one of which must be empty at exit.
> > [!SUCCESS]- Answer
> > - **Short answer:** `[1 … boundary1-1]` $<p$ · `[boundary1 … j-1]` $=p$ · `[boundary2+1 … N]` $>p$ · `[j … boundary2]` **unprocessed**; quicksort recurses on the $<p$ and $>p$ regions **only**.
> > - **Why:** **The $=p$ block is already final** ➔ with $d$ distinct keys the recursion depth is $O(\log d)$ and an all-equal input costs $\Theta(N)$ instead of $\Theta(N^{2})$ ➔ [[Quick Sort]].

> [!FAQ]- Partitioning on $k$ pivots at once: give the two algorithms, and prove you cannot beat the better one.
> - **Hint:** Reduce it to a problem whose lower bound you already know.
> > [!SUCCESS]- Answer
> > - **Short answer:** $k$ sequential 2-way partitions is $\Theta(nk)$; pivoting on the **middle** pivot and recursing on both halves is $\Theta(n\log k)$, and that is optimal in the comparison model.
> > - **Why:** **D&C balances the pivot budget, not the data** ➔ each level halves the number of *pivots* still to place while still touching $\Theta(n)$ items ⟹ $\Theta(\log k)$ levels. **The lower bound comes from a reduction** ➔ set $k=n$ and $k$-partitioning becomes sorting, so an $o(n\log k)$ algorithm would break $\Omega(n\log n)$. Sorting the pivots first is free at $\Theta(k\log k)$.
