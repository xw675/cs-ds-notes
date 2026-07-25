---
unit: FIT1058
domain: D
week: 11
parent: "[[Graph]]"
tags: [Math/GraphTheory, Math/Discrete]
---
# [[Special Graphs]]

**Context:** [[FIT1058_MOC]] · named [[Graph]] families · complete $K_n$, null $\overline{K_n}$, path $P_{n-1}$, cycle $C_n$ · reference points and building blocks

> [!abstract] Quick Revision
> - **🎯 Objective:** named graph families on $n$ vertices ➔ complete / null / path / cycle.
> - **📦 Core Components:** $K_n$ (all edges) ➔ $\overline{K_n}$ (none) ➔ $P_{n-1}$ (line) ➔ $C_n$ (loop).
> - **⚡ Key Constraint:** $K_n$ densest, $\overline{K_n}$ sparsest — the degree extremes $n-1$ and $0$.

## 📝 Core
### 1. The Four Families
- **Complete $K_n$** ➔ every pair joined; $\binom{n}{2}$ edges, degree $n-1$.
- **Null $\overline{K_n}$** ➔ no edges; degree 0.
- **Path $P_{n-1}$** ➔ $n$ vertices in sequence, $n-1$ edges.
- **Cycle $C_n$** ➔ path with ends joined; $n$ edges, all degree 2.

### 2. How They Relate
- **$C_n=P_{n-1}$ + one edge** ➔ joining first and last vertex.
- **Naming by length** ➔ path length $n-1$, cycle length $n$.

> [!NOTE] **When It Flips:** larger graphs are analysed by the special [[Subgraph|subgraphs]] they contain. $C_n$ has an [[Euler Tour]] (every degree 2) for all $n\ge3$; $C_n$ is [[Bipartite Graph|bipartite]] iff $n$ even.

## 📊 Exam Execution Trace

### Manual Execution Trace
$n=4$:

| Step / State | Family | Edges | Degrees |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | $K_4$ | 6 | all 3 |
| 2 | $P_3$ | 3 | 1,2,2,1 |
| 3 | $C_4$ | 4 | all 2 |

## ⚠️ Common Mistakes
- 💡 **$K_n$ maximal, $\overline{K_n}$ minimal** ➔ they bound the average degree $2m/n$ between 0 and $n-1$; a triangle is a $K_3$, an odd cycle blocks bipartiteness.

## 🧠 Active Recall
> [!FAQ]- Give the vertex/edge counts and degrees of $K_n,\overline{K_n},P_{n-1},C_n$.
> - **Hint:** Four benchmarks.
> > [!SUCCESS]- Answer
> > - **Short answer:** $K_n$: $\binom n2$ edges, deg $n-1$; $\overline{K_n}$: 0, deg 0; $P_{n-1}$: $n-1$ edges, ends deg 1; $C_n$: $n$ edges, all deg 2.
> > - **Why:** **$C_n=P_{n-1}+$ edge** ➔ joins the ends.

> [!FAQ]- Why is $K_n$ densest, and how do these bound the average degree?
> - **Hint:** Extremes.
> > [!SUCCESS]- Answer
> > - **Short answer:** $K_n$ joins every pair (max $\binom n2$, degree $n-1$); $\overline{K_n}$ has none.
> > - **Why:** **$2m/n$** ➔ any simple graph's average degree lies in $[0,n-1]$.
