---
unit: FIT1008
domain: A
week: 1
parent: "[[Algorithm]]"
tags: [CS/Algorithms, CS/Search, CS/Complexity]
---
# [[Linear Search]]

**Context:** [[FIT1008_MOC]] · the baseline **sequential** search · contrast with [[Binary Search]] and [[Hash Table]]

> [!abstract] Quick Revision
> - **🎯 Objective:** scan elements one by one until match or end ➔ $O(n)$, but works on any [[Iterable]] with no precondition.
> - **📦 Core Components:** walk sequence ➔ compare each ➔ return index / sentinel.
> - **⚡ Key Constraint:** $O(n)$ comparisons — no order, no random access needed, so it's the only option for unsorted data or a [[List (ADT)|LinkList]].

## 📝 Core
### 1. The Algorithm (Scan Until Found)
- **Mechanism** ➔ visit each element in order, compare to target, stop on match (return index) or exhaust (return sentinel/raise).
- **No precondition** ➔ needs neither order nor $O(1)$ random access ➔ works on any [[Iterable]], including a singly-linked [[List (ADT)|LinkList]].

### 2. Cost: Decrease-by-One Recurrence
- **Recurrence** ➔ check one, recurse on the rest ➔ $T(n)=T(n-1)+O(1)=O(n)$.
- **Bounds** ➔ best $O(1)$ (first element), worst/avg $O(n)$ (last / absent).

### 3. "Linear Relative to the Reference"
- **Reference matters** ➔ `naive(k)` guessing $1..k$ is $O(k)$ in the *value* but $O(2^n)$ in its *bit-length* $n$ ($k=2^n$).
- **Lesson** ➔ always state complexity *relative to input size* — "linear" is meaningless without naming the reference.

## ⚙️ Core Implementation
### 🔹 `linear_search` (sequential scan)
> [!code]- scan any iterable
> ```python
> def linear_search(arr, target) -> int:
>     for i in range(len(arr)):        # visit each position in order
>         if arr[i] == target:
>             return i                 # found → index
>     return -1                        # exhausted → sentinel (absent)
> ```
> 💡 **Common Mistake:** **"Linear" needs a reference** ➔ `naive(k)` looks $O(k)$ but is $O(2^n)$ in the bit-size $n$ of $k$ — complexity is only meaningful relative to input *size*, not value.

## ⚖️ Core Decision Matrix
| Search | Time (worst) | Precondition | Structure |
| :--- | :--- | :--- | :--- |
| **Linear** | $O(n)$ | none | any [[Iterable]] (incl. LinkList) |
| **[[Binary Search]]** | $O(\log n)$ | sorted + $O(1)$ access | array |
| **[[Hash Table]]** | $O(1)$ expected | good hash, no order | hash array |

> [!NOTE] **When It Flips:** binary/hash search beat linear asymptotically, but linear is the *only* option when data is unsorted **or** lacks $O(1)$ random access (linked structures). For one-off searches on tiny/unsorted data, linear's $O(1)$ setup wins over sorting first ($O(n\log n)$).

## 📊 Exam Execution Trace

### Manual Execution Trace
Search `23` in `[2,5,8,12,15,23,42,50]`:

| Step / State | Trigger Op | `i` | `arr[i]` | Action |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | init | — | — | — |
| 1 | compare | 0 | 2 | ≠ → advance |
| … | compare | 1–4 | 5,8,12,15 | ≠ → advance |
| 5 | compare | 5 | 23 | **match → return 5** |

### Applied Exercise
**Problem:** Derive the worst-case bound from the decrease-by-one recurrence.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
T(n) &= T(n-1) + O(1),\quad T(0)=O(1) \\
&= \underbrace{O(1)+O(1)+\dots+O(1)}_{n} = O(n)
\end{aligned}
$$
**Final Extracted Output:** worst/average $O(n)$ — one comparison per element, no shortcut without a precondition.

## 🧠 Active Recall
> [!FAQ]- When is linear search the *right* choice despite being $O(n)$ vs binary's $O(\log n)$?
> - **Hint:** Preconditions and setup cost.
> > [!SUCCESS]- Answer
> > - **Short answer:** When data is unsorted, or lacks $O(1)$ random access (a LinkList), or is searched once.
> > - **Why:** **No precondition** ➔ binary needs sorting ($O(n\log n)$) + array access; for a single search on unsorted data, paying that setup loses to a plain $O(n)$ scan.

> [!FAQ]- Why is `naive(k)` "linear in $k$" actually exponential, and what does that teach about stating complexity?
> - **Hint:** Value size vs bit size.
> > [!SUCCESS]- Answer
> > - **Short answer:** $k=2^n$, so $O(k)=O(2^n)$ in the number of bits $n$ needed to write $k$.
> > - **Why:** **Name the reference** ➔ complexity is defined relative to *input size*; "linear" without a stated reference is ambiguous and can hide exponential blow-up.
