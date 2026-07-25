---
unit: FIT1008
week: 3
parent: "[[List (ADT)]]"
tags: [CS/DataStructures, CS/Complexity, OOP/Python]
---
# [[Dynamic Array Resizing]]

**Context:** [[FIT1008_MOC]] · how a fixed [[Array (Data Structure)]] backs an unbounded [[List (ADT)|ArrayList]] · the doubling-amortisation argument

> [!abstract] Quick Revision
> - **🎯 Objective:** let an ArrayList exceed capacity ➔ allocate a bigger array, copy across, replace, insert.
> - **📦 Core Components:** grow by a **constant factor** ➔ `append` is **$O(1)$ amortised** (so no `is_full`).
> - **⚡ Key Constraint:** a single `append` can be $O(N)$ (resize copy), but factor growth makes the sequence $O(1)$ each; **additive** growth fails ($\Theta(n^2)$).

## 📝 Core
### 1. The Resize (Allocate → Copy → Replace → Insert)
- **On overflow** ➔ allocate a **bigger** array ➔ **copy** all elements ➔ replace (old → garbage) ➔ insert.
- **Factor growth** ➔ constant-factor resize makes `append` **$O(1)$ amortised** ➔ why the [[List (ADT)]] has no `is_full`.

### 2. The Growth Factor (Space–Time Dial)
- **Doubling (×2)** ➔ few resizes, up to 2× slack, each new block exceeds sum of all previous (no allocator reuse).
- **×1.5** (CPython ~1.125+const) ➔ less slack, freed blocks reusable, more copies.
- **Shrinking** ➔ needs **hysteresis** (halve only at ¼ full) to avoid $O(n)$ thrashing at a boundary.

## ⚙️ Core Implementation
### 🔹 Grow-on-overflow `append`
> [!code]- resize + insert
> ```python
> def append(self, item):
>     if len(self) == len(self.array):              # full -> resize
>         new_array = ArrayR(self.__newsize())      # newsize = old * factor
>         for i in range(len(self)):                # copy: O(N)
>             new_array[i] = self.array[i]
>         self.array = new_array
>     self.array[len(self)] = item; self.length += 1
> ```
> 💡 **Common Mistake:** **Growth must be multiplicative** ➔ a constant *additive* (+$k$) growth makes $n$ appends $\Theta(n^2)$; the multiplicative factor is exactly what makes resizes geometrically rare.

## ⚖️ Core Decision Matrix
| Situation | `append` | Why |
| :--- | :--- | :--- |
| room available | $O(1)$ | write + increment |
| full (resize) | $O(N)$ | allocate + copy $N$ |
| **amortised** | $O(1)$ | factor growth spreads rare copies |

> [!NOTE] **When It Flips:** three proofs of amortised $O(1)$ (doubling) — **Aggregate:** copies cost $1+2+4+\dots+n<2n$ ⟹ $O(1)$ each. **Accounting:** charge 3 credits/append (1 write + 2 banked); never negative. **Potential:** $\Phi=2\cdot\text{len}-\text{capacity}$; normal append amortised $1+\Delta\Phi=3$, resize's $O(n)$ copy cancelled by the drop in $\Phi$. Same argument powers [[Hash Table]] rehashing; **amortised ≠ average** — a worst-case-sequence guarantee with no probability.

## 📊 Exam Execution Trace

### Manual Execution Trace
Appends into a doubling array (start cap 1):

| Step / State | Append # | Capacity | Resize? | Copy cost |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | — | 1 | — | 0 |
| 1 | 2 | 1→2 | yes | 1 |
| 2 | 3 | 2→4 | yes | 2 |
| 3 | 5 | 4→8 | yes | 4 |
| 4 | 9 | 8→16 | yes | 8 |

### Applied Exercise
**Problem:** Prove the aggregate amortised bound.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{total copies over } n \text{ appends} &= 1+2+4+\dots+n = \sum_{i=0}^{\log_2 n}2^i < 2n \\
\Rightarrow\; \text{amortised per append} &= \frac{n + 2n}{n} = O(1)
\end{aligned}
$$
**Final Extracted Output:** rare geometric resizes ⟹ $O(1)$ amortised append; additive growth would give $\Theta(n)$ per append.

## 🧠 Active Recall
> [!FAQ]- Prove doubling-on-overflow makes append $O(1)$ amortised, and show why additive growth fails.
> - **Hint:** Geometric vs arithmetic copy totals.
> > [!SUCCESS]- Answer
> > - **Short answer:** Doubling: copies total $1+2+\dots+n<2n$ ⟹ $O(1)$ amortised; additive (+$k$): copies $k+2k+\dots+n=\Theta(n^2/k)=\Theta(n^2)$ ⟹ $\Theta(n)$ each.
> > - **Why:** **Geometric rarity** ➔ a multiplicative factor makes resizes exponentially spaced.

> [!FAQ]- Contrast growth factor 2 vs 1.5 on memory, and explain the shrinking subtlety.
> - **Hint:** Slack vs reuse; hysteresis.
> > [!SUCCESS]- Answer
> > - **Short answer:** ×2 = fewest resizes but up to 2× slack, no block reuse; ×1.5 = more copies, less slack, freed blocks reusable.
> > - **Why:** **Shrink at ¼** ➔ halving only at quarter-full stops alternating append/pop from triggering an $O(n)$ resize every op (thrashing).

> [!FAQ]- A single append can be $O(N)$ yet we call it $O(1)$ — which measure, and how does it differ from average-case?
> - **Hint:** Amortised vs expected.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Amortised** — worst-case sequence cost ÷ length.
> > - **Why:** **No probability** ➔ even an adversary's worst append sequence gets $O(1)$ each; average-case is an expectation over an assumed distribution.
