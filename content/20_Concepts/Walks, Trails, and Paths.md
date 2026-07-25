---
unit: FIT1058
week: 11
parent: "[[Graph]]"
tags: [Math/GraphTheory, Math/Discrete, Monash/CS_DS]
---
# [[Walks, Trails, and Paths]]

**Context:** [[FIT1058_MOC]] · three increasingly strict ways to traverse a [[Graph]] · walk $\supseteq$ trail $\supseteq$ path · shortest path defines distance

> [!abstract] Quick Revision
> - **🎯 Objective:** traverse a graph ➔ walk (anything) ⊇ trail (no repeat edge) ⊇ path (no repeat vertex).
> - **📦 Core Components:** length = edge count ➔ closed if $v_0=v_k$.
> - **⚡ Key Constraint:** shortest walk = shortest path (defines distance); a path can't be closed.

## 📝 Core
### 1. The Three Levels
- **Walk** ➔ alternating $v_0,e_1,\dots,e_k,v_k$; repeats allowed.
- **Trail** ➔ no repeated **edge** (vertices may repeat).
- **Path** ➔ no repeated **vertex** (hence no repeated edge).

### 2. Nesting & Length
- **path ⊆ trail ⊆ walk** ➔ each stricter than the last.
- **Length** ➔ number of edges; **closed** if $v_0=v_k$.
- **Simple graph** ➔ the vertex sequence alone determines a walk.

### 3. Distance
- **Shortest walk = shortest path** ➔ delete loops between repeats.
- **Distance** ➔ length of the shortest path.

**Key identities:**

$$\text{walk} \supseteq \text{trail (no repeat edge)} \supseteq \text{path (no repeat vertex)}$$
$$\text{distance}(v,w)=\text{length of shortest path}=\text{length of shortest walk}$$

## ⚖️ Core Decision Matrix
| Traversal | Repeat edge? | Repeat vertex? |
| :--- | :--- | :--- |
| walk | allowed | allowed |
| trail | **no** | allowed |
| path | no | **no** |
| cycle | no | only endpoints |

> [!NOTE] **When It Flips:** whenever a walk from $v$ to $w$ exists, a path does too (cut the loops) — the basis of [[Connectivity]]. A length-0 walk (single vertex) is the reflexive case making connectivity an [[Equivalence Relation]].

## 📊 Exam Execution Trace

### Manual Execution Trace
$G$ ($ab,ac,bc,cd$), classify sequences:

| Step / State | Sequence | Repeats | Type |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | $a,b,c,a,c$ | edge $\{a,c\}$ | walk |
| 2 | $a,b,c,a$ | vertex $a$ (closed) | closed trail (cycle) |
| 3 | $a,b,c,d$ | none | path (length 3) |

## ⚠️ Common Mistakes
- 💡 **A path can't be closed** ➔ closing repeats the start vertex; that role belongs to a [[Cycle (Graph Theory)|cycle]] (closed trail, no interior repeat).

## 🧠 Active Recall
> [!FAQ]- Define walk, trail, and path, and how they nest.
> - **Hint:** Repetition rules.
> > [!SUCCESS]- Answer
> > - **Short answer:** Walk allows all repeats; trail bans edge reuse; path bans vertex reuse; path ⊆ trail ⊆ walk.
> > - **Why:** **Closed** ➔ $v_0=v_k$; a path can't be closed.

> [!FAQ]- Why does "shortest walk = shortest path", and how is distance defined?
> - **Hint:** Cut the detours.
> > [!SUCCESS]- Answer
> > - **Short answer:** Any walk shortens to a path by deleting the loop between repeated vertices; distance = shortest-path length.
> > - **Why:** **No repeats in the minimum** ➔ so shortest-walk = shortest-path length.
