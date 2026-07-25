---
unit: FIT1058
domain: D
week: 11
parent: "[[Walks, Trails, and Paths]]"
tags: [Math/GraphTheory, Math/Discrete]
---
# [[Cycle (Graph Theory)]]

**Context:** [[FIT1058_MOC]] · a closed [[Walks, Trails, and Paths|trail]] with no repeated interior vertex · a "closed path" · odd cycles obstruct [[Bipartite Graph|bipartiteness]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a closed trail, no vertex repeated except start=end ➔ a "closed path".
> - **📦 Core Components:** length $\ge3$ (triangle $K_3$) ➔ strictest closed traversal.
> - **⚡ Key Constraint:** odd closed walk ⟺ odd cycle; odd cycles block [[Bipartite Graph|2-colouring]].

## 📝 Core
### 1. The Cycle
- **Definition** ➔ a closed [[Walks, Trails, and Paths|trail]] with no interior vertex repeat.
- **Closed path** ➔ *path* alone forbids closing.
- **Length** ➔ edge count; smallest is 3 (triangle $K_3$).

### 2. Odd Closed Walk ⟺ Odd Cycle
- **Theorem** ➔ a graph has an odd closed walk iff it has an odd cycle.
- **Proof idea** ➔ shortest odd closed walk with an interior repeat splits into two shorter closed walks, one odd — contradiction.

### 3. Strictness
- **Closed walk** ➔ reuse freely; **closed trail** ➔ no edge reuse; **cycle** ➔ also no interior vertex reuse.

## ⚖️ Core Decision Matrix
| Traversal | Edge reuse | Interior vertex reuse |
| :--- | :--- | :--- |
| closed walk | allowed | allowed |
| closed trail | no | allowed |
| cycle | no | **no** |
| cycle graph $C_n$ | — | prototype |

> [!NOTE] **When It Flips:** odd cycles are exactly what stop a graph being [[Bipartite Graph|2-colourable]]; the cycle/closed-walk equivalence converts the easy "odd closed walk" into the structural "odd cycle". A [[Tree]] is a connected acyclic graph.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Is $a,b,c,a$ a cycle? Is $a,b,a$?
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
a,b,c,a &: \text{edges } ab,bc,ca \text{ distinct, only } a \text{ repeats} \Rightarrow \textbf{cycle (3)} \\
a,b,a &: \{a,b\} \text{ twice} \Rightarrow \textbf{not a trail}
\end{aligned}
$$
**Final Extracted Output:** $a,b,c,a$ is an odd 3-cycle (so $G$ non-bipartite); $a,b,a$ is only a closed walk.

## ⚠️ Common Mistakes
- 💡 **"Odd" is essential** ➔ $K_2$ has the even closed walk $v,w,v$ (reuses the edge) but no cycle; even closed walks need not contain cycles.

## 🧠 Active Recall
> [!FAQ]- Define a cycle and prove an odd closed walk implies an odd cycle.
> - **Hint:** Minimal counterexample.
> > [!SUCCESS]- Answer
> > - **Short answer:** A cycle is a closed trail with no interior repeat; shortest odd closed walk must be a cycle.
> > - **Why:** **Split at a repeat** ➔ yields a shorter odd closed walk, contradicting minimality.

> [!FAQ]- Why does the equivalence fail for even lengths?
> - **Hint:** Back-and-forth reuse.
> > [!SUCCESS]- Answer
> > - **Short answer:** $K_2$'s $v,w,v$ is an even closed walk but reuses the edge — no cycle exists.
> > - **Why:** **Not a trail** ➔ even closed walks needn't contain cycles.
