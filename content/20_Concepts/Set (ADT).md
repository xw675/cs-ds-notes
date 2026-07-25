---
unit: FIT1008
week: 2
parent: "[[Abstract Data Type (ADT)]]"
tags: [CS/DataStructures, OOP/Python, CS/Abstraction, CS/BitManipulation, CS/Complexity]
---
# [[Set (ADT)]]

**Context:** [[FIT1008_MOC]] · an **unordered, duplicate-free** [[Abstract Data Type (ADT)]] · backbone clustering **ArraySet** (any type) and **BVSet** (integers, $O(1)$) · contract via [[Abstract Base Class]]

> [!abstract] Quick Revision
> - **🎯 Objective:** membership + algebra (∪,∩,∖) over unordered, duplicate-free elements ➔ a characteristic function $\chi_S(x)=[x\in S]$.
> - **📦 Core Components:** **Contract** ➔ `add`/`remove`/`__contains__`/`union` | **ArraySet** ➔ any type, $O(N)$ scan | **BVSet** ➔ integers only, $O(1)$ word-parallel.
> - **⚡ Key Constraint:** same interface, **opposite cost profiles** ➔ the implementation, not the ADT, sets complexity (ArraySet $O(N)$ vs BVSet $O(1)$).

## 📝 Core
### 1. Set Contract (Membership + Algebra)
- **Set rules** ➔ **unordered** ($\{1,2,3\}=\{3,1,2\}$) + **duplicate-free** (re-add is a no-op).
- **Operations** ➔ `add`/`remove`/`__contains__` + `union` $\cup$ / `intersection` $\cap$ / `difference` $\setminus$ (≙ OR/AND/AND-NOT).
- **Characteristic function** ➔ $\chi_S(x)=[x\in S]$ ➔ [[Bit Vector|bit-vector]] makes it literal; **Bloom filter** approximates it (one-sided error).

### 2. ArraySet (Array-Backed, Any Type)
- **Storage substrate** ➔ fixed [[Array (Data Structure)]] + `size`; arrival order (irrelevant to a set).
- **Scan cost** ➔ every membership op scans ➔ $O(N)$; `add` is $O(N)$ (duplicate check dominates).
- **Swap-with-last delete** ➔ $O(1)$ — valid *because* unordered (a [[List (ADT)|list]] cannot).

### 3. BVSet (Bit-Vector, Integers Only)
- **Storage substrate** ➔ one arbitrary-precision int `elems` ([[Bit Vector]]); item $i$ ⟺ bit $i-1$; never full.
- **Word-parallel algebra** ➔ member/add/remove + `|`/`&`/`& ~` all **$O(1)$** per word.
- **Type/size boundary** ➔ **positive integers only**; `__len__` = popcount $O(|\text{elems}|)$ (driven by largest value).

## ⚙️ Core Implementation
### 🔹 ArraySet — linear scan, swap-with-last delete
> [!code]- `ArraySet(Set[T])`
> ```python
> class ArraySet(Set[T]):
>     def __contains__(self, item):              # member -> linear scan O(N)
>         for i in range(self.size):
>             if item == self.array[i]: return True
>         return False
>     def add(self, item):
>         if item not in self:                   # O(N) duplicate check dominates
>             if self.is_full(): raise Exception("Set is full")
>             self.array[self.size] = item; self.size += 1
>     def remove(self, item):
>         for i in range(self.size):
>             if item == self.array[i]:
>                 self.array[i] = self.array[self.size - 1]   # swap-with-last, O(1)
>                 self.size -= 1; break
>         else: raise KeyError(item)
> ```
> 💡 **Common Mistake:** **True cost is $O(N\cdot\text{comp})$** ➔ `comp` is $O(1)$ for ints, $O(m)$ for $m$-char strings; swap-with-last delete is $O(1)$ **only because the set is unordered**.

### 🔹 BVSet — word-parallel bit algebra
> [!code]- `BVSet(Set[T])`
> ```python
> class BVSet(Set[T]):
>     def clear(self):        self.elems = 0
>     def is_full(self):      return False                    # arbitrary-size ints never fill
>     def __contains__(self, item): return (self.elems >> (item-1)) & 1   # O(1)
>     def add(self, item):    self.elems |= 1 << (item-1)     # O(1)
>     def remove(self, item): self.elems &= ~(1 << (item-1))  # O(1)
>     def union(self, other):                                  # O(1) word-parallel
>         r = BVSet(); r.elems = self.elems | other.elems; return r
>     def __len__(self):                                       # O(|elems|) — the catch
>         return bin(self.elems).count("1")                    # popcount
> ```
> 💡 **Common Mistake:** **`__len__` is popcount $O(|\text{elems}|)$** ➔ governed by the largest value, not the count (a lone $10^6$ scans ~$10^6$ bits); use `int.bit_count()`/Kernighan, never a bit-by-bit loop.

## ⚖️ Core Decision Matrix
| Variant / Strategy | Trigger Condition | member / add / remove | union / ∩ / ∖ | `__len__` | Element types |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **ArraySet** (unsorted) | Arbitrary types, small sets | $O(N\cdot\text{comp})$ | $O(M(N{+}M)\,\text{comp})$ | $O(1)$ | **any** |
| **BVSet** (bit-vector) | Dense small-int sets, heavy algebra | $O(1)$ | $O(1)$ word-parallel | $O(\lvert\text{elems}\rvert)$ | **ints only** |
| sorted array | Membership-heavy, ordered | $O(\log N)$ / $O(N)$ | $O(N{+}M)$ merge | $O(1)$ | comparable |
| hash set | General-purpose point queries | $O(1)$ expected | $O(N{+}M)$ expected | $O(1)$ | hashable |
| balanced BST | Ordered iteration / range | $O(\log N)$ | $O(N{+}M)$ | $O(1)$ | comparable |

> [!NOTE] **When It Flips:** ArraySet and BVSet are exact inverses (any-type/$O(1)$-size vs ints-only/$O(1)$-membership). BVSet's $O(1)$ union is really $O(\lceil u/64\rceil)$ — a ~64× constant-factor speedup, valid only for integer universes that aren't enormous/sparse.

## 📊 Exam Execution Trace

### Manual Execution Trace
`BVSet`: `add 1, add 3, add 4; union {2,3}`

| Step / State | Trigger Op | `elems` (binary, bit $i{-}1$) | Set Payload |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | `init` | `0000` | $\{\}$ |
| 1 | `add 1` | `0001` | $\{1\}$ |
| 2 | `add 3` | `0101` | $\{1,3\}$ |
| 3 | `add 4` | `1101` | $\{1,3,4\}$ |
| 4 | `∪ 0110` | `1101 \| 0110 = 1111` | $\{1,2,3,4\}$ |

### Applied Exercise
**Problem:** Explain why ArraySet `add` is $\Theta(N)$ but its `remove` is $O(1)$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\texttt{add}: \quad & \text{verify absence} \Rightarrow \text{scan all } N \Rightarrow O(N\cdot\text{comp}) \\
\texttt{remove}: \quad & \text{overwrite target with last, } \texttt{size}{-}{-} \Rightarrow O(1) \\
& (\text{valid because order is irrelevant to a set})
\end{aligned}
$$
**Final Extracted Output:** `add` $\Theta(N)$ (no-duplicates check), `remove` $O(1)$ (swap-with-last in an unordered set).

## 🧠 Active Recall
> [!FAQ]- The same Set ADT yields $O(1)$ on one implementation and $O(N)$ on another — state the design lesson.
> - **Hint:** Separate interface from cost.
> > [!SUCCESS]- Answer
> > - **Short answer:** The interface fixes *what*; the **implementation** sets the cost.
> > - **Why:** **Inverse profiles** ➔ ArraySet $O(N)$ membership / any type / $O(1)$ size; BVSet $O(1)$ membership / ints only / $O(|\text{elems}|)$ size — match implementation to element type + op mix.

> [!FAQ]- BVSet does union in $O(1)$ but ArraySet in $O(M(N+M))$ — what hardware property explains the gap, and its limit?
> - **Hint:** Word-parallelism as a constant factor.
> > [!SUCCESS]- Answer
> > - **Short answer:** One machine `OR` combines **64 membership bits** at once ➔ $O(\lceil u/64\rceil)$.
> > - **Why:** **Constant-factor limit** ➔ the ~64× speedup applies only to **integer** elements over a not-too-large universe.

> [!FAQ]- A set is "a characteristic function" — explain, and how a bit-vector vs a Bloom filter realise it.
> - **Hint:** Exact vs lossy $\chi_S$.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\chi_S(x)=1$ iff $x\in S$; bit-vector stores it literally (bit $i$), Bloom filter stores it lossily via $k$ hashes.
> > - **Why:** **One-sided error** ➔ Bloom membership is $O(k)$ with **false positives, never false negatives**, trading exactness for sub-linear space.

> [!FAQ]- One scenario where BVSet is clearly right, and one where it is clearly wrong.
> - **Hint:** Dense small-universe vs sparse large-universe.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Right** = small integer IDs with heavy membership/algebra (graph adjacency); **wrong** = strings or large/sparse integers.
> > - **Why:** **Universe-driven cost** ➔ BVSet is 1 bit/element + ~64× algebra for dense ints, but allocates a bit per *possible* value ⟹ a lone $10^6$ wastes space and makes `__len__` linear; use a hash set.
