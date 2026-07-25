---
unit: FIT1058
domain: D
week: 11
parent: "[[Graph]]"
tags: [Math/GraphTheory, Math/Discrete]
---
# [[Connectivity]]

**Context:** [[FIT1058_MOC]] · vertices linked by a [[Walks, Trails, and Paths|path]] · components are maximal connected [[Subgraph|subgraphs]] · connectivity is an [[Equivalence Relation]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $v,w$ connected iff a path/walk joins them ➔ graph connected iff every pair is.
> - **📦 Core Components:** walk relation ➔ [[Equivalence Relation]] ➔ classes = components.
> - **⚡ Key Constraint:** a component is a **maximal** connected [[Subgraph]]; "connected" ≠ "adjacent".

## 📝 Core
### 1. The Definitions
- **Connected vertices** ➔ a [[Walks, Trails, and Paths|path/walk]] joins $v,w$.
- **Connected graph** ➔ every pair connected.
- **Component** ➔ a maximal connected [[Subgraph]].

### 2. Equivalence Relation
- **Reflexive** ➔ length-0 walk.
- **Symmetric** ➔ reverse a walk.
- **Transitive** ➔ concatenate walks.
- **Classes** ➔ [[Set Partition|partition]] $V$ = component vertex sets.

### 3. Cautions
- **Maximality** ➔ a connected subgraph that can be enlarged is not a component.
- **Connected ≠ adjacent** ➔ connected may be a long path; adjacent = one edge.

**Key identities:**

$$v\,R\,w \iff \text{a walk joins } v,w$$
$$\text{refl (0-walk)},\ \text{sym (reverse)},\ \text{trans (concatenate)} \Rightarrow \text{classes partition } V = \text{components}$$

> [!NOTE] **When It Flips:** because the walk relation is an [[Equivalence Relation]], components are automatically disjoint and cover $V$ ([[Set Partition]]) — no overlaps, nothing left out. Walk- and path-connectivity coincide.

## 📊 Exam Execution Trace

### Manual Execution Trace
$G$: $E=\{ab,ac,bc,cd,fg\}$:

| Step / State | Component | Vertices | Edges |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | 1 | $\{a,b,c,d\}$ | $ab,ac,bc,cd$ |
| 2 | 2 | $\{e\}$ | $\emptyset$ |
| 3 | 3 | $\{f,g\}$ | $fg$ |

## ⚠️ Common Mistakes
- 💡 **A component must be maximal** ➔ the triangle $\{a,b,c\}$ inside $\{a,b,c,d\}$ is connected but not a component; an isolated vertex is its own component.

## 🧠 Active Recall
> [!FAQ]- Show connectivity is an equivalence relation and that its classes are the components.
> - **Hint:** Reflexive/symmetric/transitive.
> > [!SUCCESS]- Answer
> > - **Short answer:** 0-walk (refl), reverse (sym), concatenate (trans) ⟹ classes partition $V$.
> > - **Why:** **Maximal reachable set** ➔ each class is a component's vertex set.

> [!FAQ]- Why is a connected subgraph not always a component, and why isn't "connected" the same as "adjacent"?
> - **Hint:** Maximality + path length.
> > [!SUCCESS]- Answer
> > - **Short answer:** A component must be maximal connected; connected = path of any length, adjacent = one edge.
> > - **Why:** **Adjacent ⟹ connected** ➔ but not conversely; a sub-triangle isn't maximal.
