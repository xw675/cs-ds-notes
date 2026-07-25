---
unit: FIT1058
week: 12
parent: "[[Graph]]"
tags: [Math/GraphTheory, Math/Discrete, Monash/CS_DS]
---
# [[Planar Graph]]

**Context:** [[FIT1058_MOC]] · a [[Graph]] drawable in the plane with **no edge crossings** · a drawing splits the plane into **faces** · constrained by [[Euler's Formula (Planar Graphs)|Euler's formula]]

> [!abstract] Quick Revision
> - **🎯 Objective:** drawable with no edge crossings ➔ edges meet only at shared endpoints.
> - **📦 Core Components:** plane graph ➔ faces (incl. outer) ➔ each edge borders ≤2 faces.
> - **⚡ Key Constraint:** edge bounds $m\le3n-6$ (or $2n-4$ triangle-free) disprove planarity; $K_5,K_{3,3}$ minimal obstructions.

## 📝 Core
### 1. Planarity
- **Definition** ➔ some drawing has no crossings (edges meet only at endpoints).
- **Plane graph** ➔ such a drawing; regions are **faces** (incl. unbounded outer face).
- **About existence** ➔ not any single drawing ($K_4$ is planar despite its usual crossed picture).

### 2. Faces, Boundaries, Sides
- **Face** ➔ a maximal region; **boundary** = closed walk of surrounding edges.
- **Two sides per edge** ➔ each edge borders ≤2 faces, appears twice across boundary walks.

### 3. Why Crossings Matter
- **Costs** ➔ diagram clarity, transport bridges/tunnels, circuit layers.

**Key identities:**

$$m\le 3n-6\ (n\ge3),\qquad m\le 2n-4\ (\text{triangle-free})$$

## ⚖️ Core Decision Matrix
| Graph | $n,m$ | Bound | Planar? |
| :--- | :--- | :--- | :--- |
| $K_4$ | 4,6 | $3n-6=6$ ✓ | yes |
| $K_5$ | 5,10 | $3n-6=9$ | no |
| $K_{3,3}$ | 6,9 | $2n-4=8$ (bipartite) | no |
| trees/paths/cycles | — | — | always |

> [!NOTE] **When It Flips:** $K_5$ and $K_{3,3}$ are the smallest nonplanar graphs (utilities puzzle = $K_{3,3}$). A [[Bipartite Graph|bipartite]] graph is triangle-free, so the stronger $2n-4$ bound applies. Bounds come from [[Euler's Formula (Planar Graphs)|Euler's formula]].

## 📊 Exam Execution Trace

### Manual Execution Trace
Edge-bound test:

| Step / State | Graph | $m$ vs bound | Verdict |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | $K_4$ | $6\le6$ | planar |
| 2 | $K_5$ | $10>9$ | nonplanar |
| 3 | $K_{3,3}$ | $9>8$ (triangle-free) | nonplanar |

## ⚠️ Common Mistakes
- 💡 **Violating a bound proves nonplanarity; passing it does not prove planarity** ➔ $K_{3,3}$ passes $3n-6$ but, being bipartite (triangle-free), breaks $2n-4$.

## 🧠 Active Recall
> [!FAQ]- What does planarity mean, and what are faces, boundaries, and sides?
> - **Hint:** Existence of a crossing-free drawing.
> > [!SUCCESS]- Answer
> > - **Short answer:** Some drawing has no crossings; faces are the regions (incl. outer), boundary = closed walk of surrounding edges.
> > - **Why:** **Two sides** ➔ each edge borders ≤2 faces, appears twice among boundaries.

> [!FAQ]- How do edge bounds prove nonplanarity, and which settle $K_5$ and $K_{3,3}$?
> - **Hint:** $3n-6$ / $2n-4$.
> > [!SUCCESS]- Answer
> > - **Short answer:** $K_5$ breaks $m\le3n-6$ ($10>9$); $K_{3,3}$ (triangle-free) breaks $m\le2n-4$ ($9>8$).
> > - **Why:** **Minimal obstructions** ➔ the two smallest nonplanar graphs.
