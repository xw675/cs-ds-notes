---
unit: FIT1008
week: 3
parent: "[[List (ADT)]]"
tags: [OOP/Python, CS/DataStructures]
---
# [[List Slicing]]

**Context:** [[FIT1008_MOC]] · Python feature that simplifies block shifts in [[List (ADT)|ArrayList]] · copy (not view) semantics

> [!abstract] Quick Revision
> - **🎯 Objective:** lst[a:b] returns a new list of elements [a, b) ➔ on the left of = it overwrites a block in one statement.
> - **📦 Core Components:** `[a:b:step]` stride ➔ slice **assignment** replaces shift loops.
> - **⚡ Key Constraint:** a Python slice **copies** ($O(k)$ time + space) — NumPy slices are $O(1)$ **views** (aliased).

## 📝 Core
### 1. The Slice (Extract / Overwrite a Block)
- **Read** ➔ `lst[a:b]` returns a **new list** of elements `a` up to (excluding) `b`; omitting an endpoint defaults to start/end; `[a:b:step]` adds a stride.
- **Assignment** ➔ on the **left** of `=` it overwrites a block in one statement ➔ replaces [[List (ADT)|ArrayList]]'s element-shifting loop.

### 2. Copy vs View Semantics
- **Python copies** ➔ `lst[a:b]` builds a new list of $k=b-a$ elements ➔ $\Theta(k)$ time + space (a *shallow* copy — element refs shared, not the objects).
- **Hidden cost** ➔ slicing inside a loop can hide a $\Theta(n^2)$ cost.
- **NumPy views** ➔ return **views** (no copy, $O(1)$) sharing the parent buffer ➔ fast but **aliased** (mutating the view mutates the original).

## ⚙️ Core Implementation
### 🔹 Slice reads, reverse, and assignment
> [!code]- slicing operations
> ```python
> x = [0,1,2,3,4,5]
> x[1:3]    # [1,2]         (3 excluded)
> x[:2]     # [0,1]         x[2:]  # [2,3,4,5]
> x[::-1]   # [5,4,3,2,1,0] (reverse via step -1 — a COPY)
> x[3:6] = x[2:5]           # slice assignment: x -> [0,1,2,2,3,4]
> ```
> 💡 **Common Mistake:** **`x[::-1]` makes a reversed copy** ($\Theta(n)$ time + space) ➔ it does **not** reverse in place (use `list.reverse()`/`reversed()`); every read-slice allocates.

## ⚖️ Core Decision Matrix
| Slice use | Cost | Note |
| :--- | :--- | :--- |
| `lst[a:b]` (read) | $O(k)$ time + space | shallow copy of $k$ elements |
| `lst[a:b] = seq` | $O(k + n)$ | may shift the tail if lengths differ |
| replace shift loop | $O(k)$ | one block-copy vs explicit per-element loop |
| NumPy `arr[a:b]` | $O(1)$ | **view** (aliased), not a copy |

> [!NOTE] **When It Flips:** slicing is concise and often C-optimised (small constant) but **allocates** — for huge ranges or hot loops, in-place index manipulation avoids the copy.

## 📊 Exam Execution Trace

### Manual Execution Trace
Python copy vs NumPy view:

| Step / State | Python `list[a:b]` | NumPy `arr[a:b]` |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| allocates? | yes (new list) | no (shares buffer) |
| cost | $O(k)$ | $O(1)$ |
| mutate affects original? | no | **yes** (aliased) |

### Applied Exercise
**Problem:** Compare slice assignment to a shift loop.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\texttt{array[pos:len-1] = array[pos+1:len]} \;\equiv\; \text{shift each later element left} \;:\; \Theta(N-\text{pos}),\ \text{clearer + smaller constant}
\end{aligned}
$$
**Final Extracted Output:** same $\Theta(N)$ asymptotics — slice assignment is a readability/constant-factor win, not a complexity win.

## 🧠 Active Recall
> [!FAQ]- A Python slice and a NumPy slice look identical — how do they differ, and what bug does each invite?
> - **Hint:** Copy vs view.
> > [!SUCCESS]- Answer
> > - **Short answer:** Python list slice **copies** ($O(k)$, independent); NumPy slice is a **view** ($O(1)$, shares buffer, mutations propagate).
> > - **Why:** **Two bug classes** ➔ list slice invites a hidden $\Theta(n^2)$ if sliced in a loop; NumPy view invites an aliasing bug (use `.copy()`).

> [!FAQ]- Why is replacing an ArrayList shift loop with slice assignment a readability win but not a complexity win?
> - **Hint:** Same $\Theta$, smaller constant.
> > [!SUCCESS]- Answer
> > - **Short answer:** Both are $\Theta(N)$: the loop shifts each element once; slice assignment block-copies the same $N-\text{pos}$ elements.
> > - **Why:** **Inherently linear** ➔ order-preserving shift is $\Theta(N)$; C block-copy only lowers the constant.

> [!FAQ]- What does `x[::-1]` produce and what is its cost?
> - **Hint:** Reversed copy, not in-place.
> > [!SUCCESS]- Answer
> > - **Short answer:** A reversed **copy** (step $-1$), e.g. `[0,1,2]`→`[2,1,0]`, at $\Theta(n)$ time + space.
> > - **Why:** **Allocates** ➔ builds a new $n$-element list, not an in-place reverse (use `list.reverse()`/`reversed()`).
