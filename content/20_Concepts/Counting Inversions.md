---
unit: FIT2004
domain: A
week: 2
source: applied
parent: "[[Merge Sort]]"
tags:
  - CS/Algorithms
  - CS/Complexity
aliases:
  - inversion count
  - split inversions
  - sort-and-count
  - Kendall tau distance
---
# [[Counting Inversions]]

**Context:** [[FIT2004_MOC]] · Applied 2 Problem 5 — the unit's flagship **"adapt a paradigm to a NEW problem"** exercise ([[Divide and Conquer]] LO1): [[Merge Sort]]'s combine step is repurposed to *count* rather than merely order.
**Parent Framework:** [[Merge Sort]]

> [!abstract] Quick Revision
> - **🎯 Objective:** count pairs $(i,j)$ with $i<j$ and $V[i]>V[j]$ ➔ exhaustive search is $\Theta(N^{2})$; a merge sort that counts while it merges is $\Theta(N\log N)$.
> - **📦 Core Components:** **recurse left** $\to \text{Inv}_L$ | **recurse right** $\to \text{Inv}_H$ | **merge** $\to \text{Inv}_S$ (**split** inversions) | total $=\text{Inv}_L+\text{Inv}_H+\text{Inv}_S$.
> - **⚡ Key Constraint:** the recursive calls must **return sorted subarrays** — sortedness is not a side effect, it is the precondition that makes $\text{Inv}_S$ countable in $\Theta(N)$ instead of $\Theta(N^{2})$.

## 📝 How It Works
### 1. The counting-argument that forces the design
- **Output can be $\Theta(N^{2})$** ➔ a reversed array has $\binom{N}{2}$ inversions, so any $O(N\log N)$ algorithm **cannot inspect inversions individually** — it must count them in *blocks*. This is the observation that rules out every incremental approach before any code is written.
- **Application** ➔ collaborative filtering: two users' rankings of the same items are "similar" when few pairs disagree, so the inversion count *is* a distance measure between permutations.

### 2. The three-way partition of the inversion set
- **Every inversion sits in exactly one bucket** ➔ both indices in the left half ($\text{Inv}_L$) · both in the right half ($\text{Inv}_H$) · **one in each** ($\text{Inv}_S$, a **split inversion**). Disjoint and exhaustive ⟹ the counts simply add.
- **Recursion handles two buckets for free** ➔ the recursive calls already return $\text{Inv}_L$ and $\text{Inv}_H$; the *only* new work is $\text{Inv}_S$, and it must cost $\Theta(N)$ to preserve the merge sort recurrence.

### 3. Counting split inversions during the merge
- **Sortedness is the lever** ➔ at each merge step the smallest unconsumed element is the head of the left run or the head of the right run.
- **Take from LEFT ➔ zero** ➔ that element's index precedes every remaining right index and it is $\le$ all of them, so it inverts with none of them.
- **Take from RIGHT ➔ add the whole left remainder** ➔ if $B[j]$ is emitted while $A[i\ldots n_1]$ is unconsumed, then every one of those $n_1-i+1$ elements is **both larger and earlier** ⟹ $n_1-i+1$ split inversions, counted in $O(1)$.
- **⚡ Key Constraint:** each `else` branch counts a *whole block* of inversions with one addition — the block is exactly what buys $\Theta(N)$ per level over the $\Theta(N^{2})$ enumeration.

## ⚙️ Core Implementation
### 🔹 `sort_and_count` — merge sort with a counter threaded through
> [!code]- returns `(sorted_slice, inversions)`; raw index arithmetic, no library calls
> ```python
> def sort_and_count(array, lo, hi):
>     if lo == hi:                                  # base: 1 element, 0 inversions
>         return 0
>     mid = (lo + hi) // 2
>     inv_l = sort_and_count(array, lo, mid)        # both indices left
>     inv_h = sort_and_count(array, mid + 1, hi)    # both indices right
>     inv_s = merge_and_count(array, lo, mid, hi)   # one index each
>     return inv_l + inv_h + inv_s
>
> def merge_and_count(array, lo, mid, hi):
>     tmp = [0] * (hi - lo + 1)
>     i, j, k, split = lo, mid + 1, 0, 0
>     while i <= mid or j <= hi:
>         if j > hi or (i <= mid and array[i] <= array[j]):
>             tmp[k] = array[i]; i += 1             # from LEFT  -> count nothing
>         else:
>             tmp[k] = array[j]; j += 1
>             split += mid - i + 1                  # from RIGHT -> whole left remainder
>         k += 1
>     for k in range(len(tmp)):
>         array[lo + k] = tmp[k]
>     return split
> ```
> 💡 **Common Mistake:** **Incrementing `split` by $1$** ➔ emitting $B[j]$ early does not reveal *one* inversion, it reveals $mid-i+1$ of them at once. A $+1$ silently returns the number of *merge steps that saw an inversion*, which is $O(N\log N)$ and looks plausible.
> 💡 **Common Mistake:** **Using `<` in the tie-break** ➔ equal elements are **not** inversions ($V[i]>V[j]$ is strict), so ties must be taken from the left with `<=`; `<` counts each tied pair as an inversion. The sheet assumes distinct integers, which hides the bug.

## ⚖️ Complexity
| Approach | Best | Average | Worst | Auxiliary space | Why |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Exhaustive pair scan | $\Theta(N^{2})$ | $\Theta(N^{2})$ | $\Theta(N^{2})$ | $O(1)$ | tests all $\binom{N}{2}$ pairs |
| `sort_and_count` | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N)$ scratch $+\ \Theta(\log N)$ stack $=\Theta(N)$ | $T(N)=2T(N/2)+\Theta(N)$, $r=a/b=1$ |

$$T(N) = 2\,T(N/2) + cN \;\Rightarrow\; T(N)=Nb+cN\log_2 N = \Theta(N\log N)$$

> [!NOTE] **When It Flips:** the counting version is asymptotically free — it inherits [[Merge Sort]]'s bounds exactly, because the added work is **one integer addition inside an existing loop iteration**. It destroys the input order, so keep a copy if the original permutation is still needed.

## 📊 Exam Execution Trace
Top-level merge of $V=[3,1,4,2]$ after both halves return $\text{Inv}_L=1$ (from $(3,1)$) and $\text{Inv}_H=1$ (from $(4,2)$); left run $A=[1,3]$ at $lo{=}0,mid{=}1$, right run $B=[2,4]$:

| Step | Head left | Head right | Take | `split +=` | Running `split` | `tmp` |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | $1$ ($i{=}0$) | $2$ ($j{=}2$) | — | — | $0$ | `[]` |
| 1 | $1$ | $2$ | left ($1\le2$) | $0$ | $0$ | `[1]` |
| 2 | $3$ ($i{=}1$) | $2$ | **right** ($3>2$) | $mid-i+1=1$ | $1$ | `[1,2]` |
| 3 | $3$ | $4$ ($j{=}3$) | left ($3\le4$) | $0$ | $1$ | `[1,2,3]` |
| 4 | — ($i>mid$) | $4$ | right (drain) | $0$ | $1$ | `[1,2,3,4]` |

**Read-off:** $\text{Inv}_S=1$ — the pair $(3,2)$, the only inversion straddling the halves. Total $=1+1+1=3$, matching the exhaustive count $\{(3,1),(3,2),(4,2)\}$ ✓.

## ⚠️ Common Mistakes
- 💡 **Counting on the drain** ➔ once the **left** run is exhausted ($i>mid$) the remaining right elements invert with nothing; adding $mid-i+1$ there yields a negative or bogus term. Guard the count inside the `else` branch only.
- 💡 **Sorting first, then counting** ➔ a sorted array has zero inversions, so the count must be accumulated **during** the sort. Any two-pass "sort then compare against the original" scheme is back to $\Theta(N^{2})$.
- 💡 **Claiming the pattern is merge-sort-specific** ➔ the transferable move is *"attach an accumulator to a D&C combine step whose subproblems must be preprocessed"*; the exam reward is naming that shape, not reciting this instance.

## 🧠 Active Recall
> [!FAQ]- Why can no $O(N\log N)$ inversion-counting algorithm look at inversions one at a time?
> - **Hint:** Bound the size of the *output quantity*, not the input.
> > [!SUCCESS]- Answer
> > - **Short answer:** a reversed array has $\binom{N}{2}=\Theta(N^{2})$ inversions, so enumerating them is already $\Omega(N^{2})$ work.
> > - **Why:** **Count in blocks** ➔ the algorithm must add many inversions per operation; the merge's `split += mid - i + 1` retires an entire block of them with one addition, which is exactly how $\Theta(N^{2})$ facts fit inside $\Theta(N\log N)$ steps.

> [!FAQ]- The recursive calls are asked to sort as well as count. Is the sorting incidental, or load-bearing?
> - **Hint:** What does the merge step assume about its two inputs?
> > [!SUCCESS]- Answer
> > - **Short answer:** load-bearing — without sorted halves the "take from the right ⟹ the whole left remainder inverts" rule is false, and split inversions would have to be counted pairwise at $\Theta(N^{2})$ per level.
> > - **Why:** **Sortedness converts a comparison into a block count** ➔ because $A[i\ldots mid]$ is ascending, $B[j]<A[i]$ implies $B[j]<A[t]$ for *every* $t\ge i$ in one deduction. The sort is the preprocessing that makes the $\Theta(N)$ combine possible.

> [!FAQ]- State the general pattern this problem teaches, in a form usable on an unseen exam question.
> - **Hint:** The examiner will not say "merge sort".
> > [!SUCCESS]- Answer
> > - **Short answer:** partition the answer set by *where its members' indices fall* relative to the split, let recursion supply the within-half counts, and design the combine so the cross-half count costs $\Theta(N)$.
> > - **Why:** **Disjoint-and-exhaustive decomposition** ➔ D&C only pays off when the quantity being computed decomposes additively across the split; identifying the cross-half term and finding a linear way to compute it *is* the whole design step, and the resulting $2T(N/2)+\Theta(N)$ is $\Theta(N\log N)$ by the $r=a/b=1$ regime in [[Solving Recurrences (Telescoping)]].
