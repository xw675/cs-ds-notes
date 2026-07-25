---
unit: FIT1058
domain: D
week: 11
parent: "[[Graph]]"
tags: [Math/GraphTheory, Math/Discrete]
---
# [[Subgraph]]

**Context:** [[FIT1058_MOC]] · a [[Graph]] sitting inside another · $U\subseteq V$ and $D\subseteq E$ · the containment relation $F\le G$ · basis of [[Connectivity|components]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $F=(U,D)$ inside $G=(V,E)$ ➔ $U\subseteq V$ and $D\subseteq E$, written $F\le G$.
> - **📦 Core Components:** double containment ➔ validity (endpoints retained) ➔ proper $<$.
> - **⚡ Key Constraint:** $F$ must itself be a graph — can't keep an edge while dropping an endpoint.

## 📝 Core
### 1. The Subgraph
- **Definition** ➔ $F=(U,D)$ with $U\subseteq V$ **and** $D\subseteq E$; write $F\le G$.
- **Proper** ➔ $F<G$ if $F\le G$ and $F\neq G$.

### 2. Validity Condition
- **$F$ a graph** ➔ every edge in $D$ has both endpoints in $U$.
- **Can't orphan an edge** ➔ dropping an endpoint drops its edges.

### 3. Variants
- **Induced** ➔ keep *all* edges among $U$.
- **General** ➔ keep only some (the base definition).

**Key identities:**

$$F\le G \iff U\subseteq V \wedge D\subseteq E \wedge (\forall\{v,w\}\in D:\ v,w\in U)$$

> [!NOTE] **When It Flips:** $\le$ is a [[Subset and Superset|partial order]] — it *is* double containment. Proper $<$ excludes $G$ itself, used to define a **maximal** connected subgraph = a [[Connectivity|component]]. Special graphs appear as subgraphs ("$G$ contains a $K_3$").

## 📊 Exam Execution Trace

### Manual Execution Trace
Is $F=(\{a,b,c\},\{ab,ac,bc\})\le G$?

| Step / State | Check | Result |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | $U\subseteq V$ | ✅ |
| 2 | $D\subseteq E$ | ✅ |
| 3 | endpoints in $U$ | ✅ |

## ⚠️ Common Mistakes
- 💡 **$D\subseteq E$ alone is not enough** ➔ every retained edge needs both endpoints retained, else $F$ isn't a graph.

## 🧠 Active Recall
> [!FAQ]- Define a subgraph and proper subgraph, and the extra validity condition.
> - **Hint:** Double containment + graph.
> > [!SUCCESS]- Answer
> > - **Short answer:** $F\le G$ iff $U\subseteq V$ and $D\subseteq E$; proper if $F\neq G$; each edge's endpoints in $U$.
> > - **Why:** **Partial order** ➔ $\le$ behaves like $\subseteq$.

> [!FAQ]- Why can't you keep an edge while dropping one of its endpoints?
> - **Hint:** $F$ must be a graph.
> > [!SUCCESS]- Answer
> > - **Short answer:** An edge $\{v,w\}\in D$ needs both $v,w\in U$.
> > - **Why:** **No orphan edges** ➔ an edge with a missing endpoint isn't a graph.
