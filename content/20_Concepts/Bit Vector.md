---
unit: FIT1008
week: 2
parent: "[[Data Structure]]"
tags: [CS/DataStructures, CS/BitManipulation]
---
# [[Bit Vector]]

**Context:** [[FIT1008_MOC]] · the representation behind [[Set (ADT)|BVSet]] · realises a [[Set (ADT)]] with bitwise ops · a [[Data Structure]]

> [!abstract] Quick Revision
> - **🎯 Objective:** store small non-negative integers as the bits of an integer ➔ bit $i{-}1$ set ⟺ item $i$ present (the characteristic function).
> - **📦 Core Components:** bitwise member/add/remove ➔ word-parallel algebra ➔ popcount for size.
> - **⚡ Key Constraint:** $O(1)$ ops, $O(u/w)$ algebra — cost scales with the **universe** (max value), not the count.

## 📝 Core
### 1. The Bit Vector (Bits = Set)
- **Representation** ➔ item $i$ present ⟺ **bit $i{-}1$** is 1 ➔ the integer's binary form *is* the set's characteristic function.
- **Unbounded** ➔ arbitrary-precision integers let it grow ➔ storage behind [[Set (ADT)|BVSet]].
- **Set algebra** ➔ bitwise logic: union `|`, intersection `&`, difference `& ~` ➔ ideal for **dense** sets over a **small** universe.

### 2. Word-Parallelism & Popcount
- **Word-parallel** ➔ one machine `AND`/`OR` combines **64 membership bits at once** ➔ algebra over universe $u$ is $O(u/w)$ words ($w=64$), a ~$64\times$ speedup.
- **Count = popcount** ➔ naïve $O(u)$ | **Kernighan `n &= n-1`** $O(\text{popcount})$ | hardware `POPCNT` $O(u/w)$.
- **Universe-bound** ➔ holding only $\{10^6\}$ still spans ~$10^6$ bits ➔ cost tracks max value, not count.

## ⚙️ Core Implementation
### 🔹 Bitwise set operations
> [!code]- member / add / remove / algebra
> ```python
> def contains(elems, i): return (elems >> (i-1)) & 1   # member: shift down, mask
> elems |= 1 << (i-1)                                    # add: OR in a 1
> elems &= ~(1 << (i-1))                                 # remove: AND with negated mask
> union, inter, diff = a | b, a & b, a & ~b              # set algebra = bitwise logic
> ```
> 💡 **Common Mistake:** **Counting is popcount, not maintained** ➔ use `int.bit_count()` / Kernighan's `n &= n-1` (clears the lowest set bit), never a bit-by-bit Python loop; a lone huge value makes `__len__` linear in that value.

## ⚖️ Core Decision Matrix
| Operation | Complexity | Why |
| :--- | :--- | :--- |
| member / add / remove | $O(1)$ (per word) | a few bitwise ops |
| union / intersection / difference | $O(u/w)$ | word-parallel `&` / `\|` / `& ~` |
| count (`__len__`) | $O(u/w)$ POPCNT / $O(\text{popcount})$ Kernighan | no count maintained |
| space | $u$ bits | 1 bit/element — extremely compact for dense sets |

> [!NOTE] **When It Flips:** right for **dense** small-integer sets with heavy membership/algebra (graph adjacency, dataflow analysis); wrong for **sparse** sets over a huge universe — use a hash set ($O(1)$ expected, space ∝ count) or a **Bloom filter** (probabilistic, sub-linear).

## 📊 Exam Execution Trace

### Manual Execution Trace
`add 1, add 3, add 4`, then `∪ {2,3}`:

| Step / State | Trigger Op | `elems` (binary) | Set |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | init | `0000` | $\varnothing$ |
| 1 | add 1 | `0001` | $\{1\}$ |
| 2 | add 3 | `0101` | $\{1,3\}$ |
| 3 | add 4 | `1101` | $\{1,3,4\}$ |
| 4 | ∪ `0110` | `1111` | $\{1,2,3,4\}$ |

### Applied Exercise
**Problem:** Quantify the word-parallel union speedup.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{element-wise union} &: O(u) \text{ comparisons} \\
\text{bit-vector union} &: \lceil u/w\rceil \text{ word ORs},\ w=64 \;\Rightarrow\; \approx 64\times \text{ faster (constant factor)}
\end{aligned}
$$
**Final Extracted Output:** ~$64\times$ constant-factor gain — same $\Theta$ order, dramatically smaller constant on dense universes.

## 🧠 Active Recall
> [!FAQ]- What is "word-parallelism" and why does it make bit-vector set algebra so fast?
> - **Hint:** One instruction, 64 bits.
> > [!SUCCESS]- Answer
> > - **Short answer:** One `&`/`\|` combines 64 memberships at once ⟹ union over $u$ is $\lceil u/64\rceil$ word ops.
> > - **Why:** **Constant factor** ➔ ~$64\times$ fewer operations than element-wise — why bitsets dominate for dense small-universe sets.

> [!FAQ]- Counting set bits naïvely is $O(u)$ — describe Kernighan's trick and the hardware alternative.
> - **Hint:** Cost ∝ set bits, not universe.
> > [!SUCCESS]- Answer
> > - **Short answer:** `n &= n-1` clears the lowest set bit ⟹ loop runs *popcount* times ($O(\text{set bits})$); `POPCNT` counts a word in one cycle.
> > - **Why:** **Skip the zeros** ➔ both avoid scanning every bit, fast for sparse vectors.

> [!FAQ]- When is a bit vector the wrong choice for a set, and what replaces it?
> - **Hint:** Sparse over a huge universe.
> > [!SUCCESS]- Answer
> > - **Short answer:** Holding `{1_000_000}` wastes ~$10^6$ bits and counting is $O(\text{max value})$.
> > - **Why:** **Space ∝ count** ➔ use a hash set ($O(1)$ expected) or, if approximate membership is ok, a Bloom filter (sub-linear, one-sided error).
