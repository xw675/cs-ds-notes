---
unit: FIT1008
week: 3
parent: "[[Higher-Order Function]]"
tags: [OOP/Python, CS/DataStructures]
---
# [[List Comprehension]]

**Context:** [[FIT1008_MOC]] · declarative syntax over [[Higher-Order Function|map/filter]] for building a [[List (ADT)|list]] · eager sibling of [[Generator Expression]]

> [!abstract] Quick Revision
> - **🎯 Objective:** build a new list with set-builder syntax [expr for x in iterable if cond] ➔ Python's declarative map/filter.
> - **📦 Core Components:** transform (`expr`) + optional filter (`if`) ➔ nests.
> - **⚡ Key Constraint:** $O(n)$ time, **$O(n)$ memory** (materialises) — the [[Generator Expression|generator]] is the $O(1)$-memory lazy alternative.

## 📝 Core
### 1. The Comprehension (Set-Builder Syntax)
- **Form** ➔ `[expr for x in iterable if condition]` ➔ mirrors $\{3x : x\in\{0..9\}\}$ as `[3*x for x in range(10)]`.
- **Declarative** ➔ the alternative to `map`/`filter` ([[Higher-Order Function|HOFs]]).
- **Materialises** ➔ builds the whole list ($O(n)$ memory); body should be a pure-ish transform/filter — side-effecting comprehensions are an anti-pattern (use a loop).

## ⚙️ Core Implementation
### 🔹 Transform, filter, nest — and the three forms
> [!code]- comprehension vs HOF vs generator
> ```python
> A = [3*x for x in range(10)]          # transform:  [0,3,6,...,27]
> C = [x for x in A if x % 2 == 0]      # filter:     [0,6,12,18,24]
> M = [[r*c for c in range(3)] for r in range(3)]   # nested
>
> [f(x) for x in xs if p(x)]            # comprehension — eager list, O(n) space
> list(map(f, filter(p, xs)))          # HOF form — same result
> (f(x) for x in xs if p(x))           # GENERATOR expr — lazy, O(1) space, single-pass
> ```
> 💡 **Common Mistake:** **All three are $O(n)$ *time*** ➔ the comprehension uses $O(n)$ memory (materialised, reusable, indexable), the [[Generator Expression]] $O(1)$ (lazy, single-pass) — pick the generator when you iterate once or the source is huge.

## ⚖️ Core Decision Matrix
| Form | Time | Space | When |
| :--- | :--- | :--- | :--- |
| **list comprehension** | $O(n)$ | $O(n)$ | need the whole list, reused/indexed |
| [[Generator Expression]] | $O(n)$ | $O(1)$ | single pass / huge or infinite source |
| explicit `for` loop | $O(n)$ | $O(n)$ | side effects, complex control flow |

> [!NOTE] **When It Flips:** comprehensions are concise and faster than an equivalent `append` loop (C-optimised list-building) but materialise everything; deeply nested comprehensions hurt readability — fall back to loops.

## 📊 Exam Execution Trace

### Manual Execution Trace
`[x for x in range(6) if x % 2 == 0]`:

| Step / State | `x` | `x%2==0`? | Emit |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | `[]` |
| 1 | 0, 2, 4 | yes | kept |
| 2 | 1, 3, 5 | no | dropped |
| result | — | — | `[0, 2, 4]` |

### Applied Exercise
**Problem:** Show a comprehension equals map∘filter.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
[\,f(x)\ \text{for}\ x\ \text{in}\ xs\ \text{if}\ p(x)\,] \;\equiv\; \texttt{list(map}(f, \texttt{filter}(p, xs)))\ \text{materialised}
\end{aligned}
$$
**Final Extracted Output:** the comprehension is the eager, materialised form of the filter→map pipeline.

## 🧠 Active Recall
> [!FAQ]- Give the same transform as a list comprehension and a generator expression, and state when each is correct.
> - **Hint:** Materialise vs stream.
> > [!SUCCESS]- Answer
> > - **Short answer:** `[f(x) for x in xs if p(x)]` vs `(f(x) for x in xs if p(x))`; both $O(n)$ time.
> > - **Why:** **Reuse vs one-pass** ➔ comprehension when you index/reuse/`len`; generator when you iterate once or the source is huge/infinite ($O(1)$ memory).

> [!FAQ]- How does a comprehension relate to `map`/`filter`, and why is it usually preferred in Python?
> - **Hint:** Same semantics, better readability.
> > [!SUCCESS]- Answer
> > - **Short answer:** `[f(x) for x in xs if p(x)]` = `map(f, filter(p, xs))` materialised.
> > - **Why:** **Left-to-right + no lambda** ➔ reads in one expression, avoids lambda overhead; `map`/`filter` win when `f`/`p` are named and laziness is wanted.

> [!FAQ]- When should you *not* use a comprehension and use a plain loop instead?
> - **Hint:** Side effects / complex control.
> > [!SUCCESS]- Answer
> > - **Short answer:** For side effects (printing, mutating external state), complex control flow (break, try/except, accumulation), or unreadable nesting.
> > - **Why:** **Purpose-built** ➔ comprehensions build a collection by transform/filter; everything else is clearer as a loop.
