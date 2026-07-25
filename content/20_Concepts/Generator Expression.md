---
unit: FIT1008
domain: A
week: 5
parent: "[[Iterator]]"
tags: [CS/DataStructures, SWE/OOP]
---
# [[Generator Expression]]

**Context:** [[FIT1008_MOC]] · the **lazy** cousin of [[List Comprehension]] · produces an [[Iterator]] · consumes any [[Iterable]]

> [!abstract] Quick Revision
> - **🎯 Objective:** looks like a [[List Comprehension]] but with round brackets ➔ returns an [[Iterator]] producing elements on demand.
> - **📦 Core Components:** lazy transform + filter, one element at a time ➔ sugar for a `yield` loop.
> - **⚡ Key Constraint:** $O(1)$ memory + short-circuit + infinite streams — but **single-use**, no `len`/indexing.

## 📝 Core
### 1. The Generator Expression (Lazy Comprehension)
- **Syntax** ➔ same as a [[List Comprehension]] but **round brackets** ➔ returns an **[[Iterator]]**, not a list.
- **Lazy** ➔ produces elements one at a time in $O(1)$ memory.
- **Single-use** ➔ no `len`, no indexing, can't re-loop — once exhausted, rebuild.

### 2. Lazy Evaluation
- **Huge/infinite** ➔ process unbounded sequences in $O(1)$ memory (`(line for line in open(f))`).
- **Short-circuit** ➔ `any(p(x) for x in xs)` stops at the first hit.
- **Pipeline fusion** ➔ chain filter→map→reduce with no intermediate lists.
- **General form** ➔ `yield` (a generator function = restricted **coroutine**); a genexp is sugar for a simple `yield` loop.

## ⚙️ Core Implementation
### 🔹 List vs generator
> [!code]- eager `[...]` vs lazy `(...)`
> ```python
> A = [3*x for x in range(10)]          # LIST comprehension: all elements now, O(n) memory
> G = (3*x for x in range(10))          # GENERATOR: nothing computed yet
> next(G)  # 0   (computed only when asked)
> next(G)  # 3
> ```
> 💡 **Common Mistake:** **Only `()` vs `[]` differs, but three consequences follow** ➔ lazy iterator (not list), $O(1)$ (not $O(n)$) memory, and single-use (no `len`/indexing/re-loop).

## ⚖️ Core Decision Matrix
| | [[List Comprehension]] `[...]` | Generator `(...)` |
| :--- | :--- | :--- |
| returns | a list (all elements) | an [[Iterator]] (one at a time) |
| memory | $O(n)$ | $O(1)$ |
| computed | eagerly | lazily, per `next` |
| re-iterate? | yes | no — single-use |
| `len`/indexing? | yes | no |

> [!NOTE] **When It Flips:** generators win on memory + early-exit; lists win when you need random access, `len`, or to loop more than once. A genexp is equivalent to a `yield`-based generator function — both suspend at each yield and resume on `next` (a restricted coroutine).

## 📊 Exam Execution Trace

### Manual Execution Trace
`sum(x*x for x in range(4) if x%2)`:

| Step / State | `x` | `x%2`? | `x*x` | Running sum |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — | 0 |
| 1 | 0 | no | — | 0 |
| 2 | 1 | yes | 1 | 1 |
| 3 | 2 | no | — | 1 |
| 4 | 3 | yes | 9 | **10** |

Streams filter→map→reduce with **no** intermediate list.

### Applied Exercise
**Problem:** Show short-circuiting saves work.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\texttt{any(is\_prime(x) for x in xs)} \;:\; \text{stop at the first prime} \;\Rightarrow\; \text{rest never evaluated (eager list computes all)}
\end{aligned}
$$
**Final Extracted Output:** laziness lets `any`/`next` terminate early — unreachable for a materialised list.

## 🧠 Active Recall
> [!FAQ]- Beyond memory, name two things lazy generators enable that an eager list cannot.
> - **Hint:** Infinite + short-circuit.
> > [!SUCCESS]- Answer
> > - **Short answer:** (1) Infinite sequences — `(x*x for x in itertools.count())`; (2) short-circuiting — `any(is_prime(x) for x in xs)` stops at the first prime.
> > - **Why:** **On-demand** ➔ elements never materialise; generators also fuse pipelines with no intermediate lists.

> [!FAQ]- What is the single syntactic difference from a list comprehension, and the three behavioural consequences?
> - **Hint:** `()` vs `[]`.
> > [!SUCCESS]- Answer
> > - **Short answer:** Round brackets ⟹ lazy **iterator** (not list), **$O(1)$** memory (not $O(n)$), **single-use** (no `len`/indexing/re-loop).
> > - **Why:** **Pick by usage** ➔ generator for one-pass/huge data, comprehension for a reusable indexable collection.

> [!FAQ]- How does a generator expression relate to a `yield`-based generator function?
> - **Hint:** Sugar for a yield loop.
> > [!SUCCESS]- Answer
> > - **Short answer:** `(f(x) for x in xs if p(x))` ≡ a function looping over `xs` and `yield f(x)` when `p(x)`.
> > - **Why:** **Restricted coroutine** ➔ both suspend at each yield, resume on `next`; `yield` functions handle arbitrary control flow.
