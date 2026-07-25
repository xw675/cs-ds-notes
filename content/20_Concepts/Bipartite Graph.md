---
unit: FIT1058
domain: D
week: 11
parent: "[[Graph]]"
tags: [Math/GraphTheory, Math/Discrete]
---
# [[Bipartite Graph]]

**Context:** [[FIT1058_MOC]] · vertices split into two sides with edges only across · equivalent to 2-colourability and to having no odd [[Cycle (Graph Theory)|cycle]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $V=A\sqcup B$, every edge crosses ➔ two-sided graph.
> - **📦 Core Components:** three equivalent views — parts / 2-colouring / no odd cycle.
> - **⚡ Key Constraint:** a single odd cycle disproves it; the triangle $K_3$ is the smallest non-bipartite graph.

## 📝 Core
### 1. The Definition
- **Bipartite** ➔ $V=A\sqcup B$ with every edge one end in $A$, one in $B$.
- **Partition** ➔ if $G$ has an edge, both parts nonempty ([[Set Partition]]).

### 2. Three Equivalent Views
- **Parts** ➔ $A\sqcup B$.
- **2-colouring** ➔ adjacent vertices differ; parts are colour [[Inverse Function|preimages]].
- **No odd cycle** ➔ equivalently no odd closed walk.

### 3. Why No Odd Cycle
- **Walks alternate** ➔ $A,B,A,B,\dots$ ⟹ a closed walk needs even length.
- **Distance-parity colouring** ➔ colour by parity of distance from a ground vertex.

**Key identities:**

$$\text{bipartite} \iff \text{2-colourable} \iff \text{no odd closed walk} \iff \text{no odd cycle}$$

> [!NOTE] **When It Flips:** the distance-parity colouring works per component (pick a ground vertex in each); the no-odd-walk hypothesis guarantees consistency. Odd cycles are the sole obstruction (via the odd-closed-walk ⟺ odd-cycle equivalence).

## 📊 Exam Execution Trace

### Manual Execution Trace
2-colour $C_4$:

| Step / State | Vertex | Distance parity | Colour |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | 1 (ground) | even | Black |
| 1 | 2 | odd | White |
| 2 | 3 | even | Black |
| 3 | 4 | odd | White |

## ⚠️ Common Mistakes
- 💡 **One odd cycle disproves it** ➔ to prove bipartite exhibit the parts / 2-colouring; to disprove, exhibit an odd cycle (e.g. a triangle).

## 🧠 Active Recall
> [!FAQ]- Give the three equivalent characterisations of a bipartite graph.
> - **Hint:** Parts / colouring / odd cycle.
> > [!SUCCESS]- Answer
> > - **Short answer:** (1) $V=A\sqcup B$ edges crossing; (2) 2-colourable; (3) no odd cycle.
> > - **Why:** **Distance parity** ➔ colour by distance parity; odd cycle is the obstruction.

> [!FAQ]- How do you prove/disprove bipartiteness, and what's the smallest non-bipartite graph?
> - **Hint:** Colouring vs odd cycle.
> > [!SUCCESS]- Answer
> > - **Short answer:** Prove by exhibiting parts/2-colouring; disprove with one odd cycle; smallest non-bipartite is $K_3$.
> > - **Why:** **Three mutually adjacent** ➔ a triangle needs three colours.
