---
unit: FIT1008
week: 2
parent: "[[Data Type]]"
tags: [CS/DataStructures, CS/Abstraction]
---
# [[Data Structure]]

**Context:** [[FIT1008_MOC]] · the **physical memory layout** beneath an [[Abstract Data Type (ADT)]] · the bottom rung of the abstraction ladder · archetype [[Array (Data Structure)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** physical organisation of data in memory ➔ where the bytes sit; its one intrinsic operation is access.
> - **📦 Core Components:** **contiguous** ([[Array (Data Structure)|array]]) vs **linked** ([[Node]]/[[List (ADT)|LinkList]]) — opposite strengths.
> - **⚡ Key Constraint:** same ADT on different layouts differs in **constants + cache locality** even at identical Big-O.

## 📝 Core
### 1. The Data Structure (Layout, Access)
- **Definition** ➔ physical organisation of data in memory — about *layout*, not meaning.
- **One operation** ➔ intrinsic op is **access**; prototype = [[Array (Data Structure)]] ($O(1)$ index access).
- **Richer behaviour** ➔ `push`/`search`/`sort` are **algorithms layered on** by an ADT, not properties of the layout.

### 2. Contiguous-vs-Linked Dichotomy
- **Contiguous** (array) ➔ $O(1)$ random access (address arithmetic), **cache-friendly**, but fixed-size + $O(n)$ middle insert.
- **Linked** (nodes) ➔ $O(1)$ insert/delete given position, grows freely, but $O(n)$ access + **cache-hostile**.
- **Inheritance** ➔ higher structures inherit this (array vs linked [[Stack (ADT)]]; open-addressing vs chaining [[Hash Table]]).

## ⚙️ Core Implementation
### 🔹 The native access operation
> [!code]- $O(1)$ array access by address arithmetic
> ```python
> element = array[2]      # address = base + 2 * slot_size  -> O(1), the native op
> ```
> 💡 **Common Mistake:** **Cache locality is a first-order cost the RAM model hides** ➔ a contiguous scan and a linked scan can both be $O(n)$ yet differ by an order of magnitude (each cache miss ~100× a hit) — see [[Algorithmic Complexity|RAM model]].

## ⚖️ Core Decision Matrix
| Variant / Strategy | Access | Insert/delete at position | Growth | Cache / Memory Impact |
| :--- | :--- | :--- | :--- | :--- |
| **Contiguous** ([[Array (Data Structure)]]) | $O(1)$ | $O(n)$ (shift) | fixed (realloc) | **friendly** (spatial locality) |
| **Linked** ([[Node]]/[[List (ADT)|LinkList]]) | $O(n)$ (traverse) | $O(1)$ (relink) | free | **hostile** (pointer chasing) |

> [!NOTE] **When It Flips:** layout ≠ ADT — the same ADT on different structures differs in real-world performance even at identical Big-O (cache + constants). [[Tree]]s/graphs extend the linked layout to multi-child pointer nodes.

## 📊 Exam Execution Trace

### Manual Execution Trace
Array index → address consequences:

| Step / State | Property | Consequence |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | sequential addresses | index → address is **one** arithmetic op |
| 2 | equal-sized slots | $O(1)$ access to *any* element |
| 3 | contiguity | good spatial locality / cache |
| 4 | fixed size | growth ⟹ reallocation |

### Applied Exercise
**Problem:** Explain why two $O(n)$ scans (array vs linked) differ in wall-clock time.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{array scan} &: \text{sequential cache lines} \Rightarrow \text{few misses} \\
\text{linked scan} &: \text{pointers scattered} \Rightarrow \text{many misses} \;(\sim100\times \text{ each}) \\
\therefore\; \text{same } O(n) &,\ \text{order-of-magnitude wall-clock gap (hidden by RAM model)}
\end{aligned}
$$
**Final Extracted Output:** identical Big-O, very different constants — the memory hierarchy is the hidden variable.

## 🧠 Active Recall
> [!FAQ]- Contrast contiguous and linked data structures across access, insertion, and cache behaviour.
> - **Hint:** Opposite optimisation profiles.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Array** = $O(1)$ access / $O(n)$ insert / cache-friendly; **linked** = $O(n)$ access / $O(1)$ insert / cache-hostile.
> > - **Why:** **Trade** ➔ random-access speed + locality vs flexible growth + cheap structural edits.

> [!FAQ]- Two structures have identical Big-O for an operation yet very different real performance — why?
> - **Hint:** Big-O omits constants + memory hierarchy.
> > [!SUCCESS]- Answer
> > - **Short answer:** A contiguous traversal hits sequential cache lines; a linked traversal chases pointers (many misses, ~100× slower).
> > - **Why:** **Hidden assumption** ➔ the RAM model's unit-cost access ignores the order-of-magnitude cache gap.

> [!FAQ]- Why does the unit say a data structure's only operation is "access", and where does richer behaviour come from?
> - **Hint:** Layout vs layered algorithms.
> > [!SUCCESS]- Answer
> > - **Short answer:** A data structure is a memory layout; the hardware only reads/writes a location (`array[i]`).
> > - **Why:** **Layering** ➔ `push`/`search`/`sort` are algorithms an ADT implementation layers on top, not properties of the layout.
