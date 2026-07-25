---
unit: FIT1058
week: 11
parent: "[[Graph]]"
tags: [Math/GraphTheory, Math/Discrete, Monash/CS_DS]
---
# [[Degree and the Handshaking Lemma]]

**Context:** [[FIT1058_MOC]] · the number of neighbours of a vertex · degrees sum to $2m$ · constrains which degree sets are realisable

> [!abstract] Quick Revision
> - **🎯 Objective:** $\deg(v)$ = number of neighbours/incident edges ➔ $\sum_v\deg(v)=2m$.
> - **📦 Core Components:** handshaking ➔ two equal degrees ➔ even count of odd degrees.
> - **⚡ Key Constraint:** these are **necessary** conditions on a degree sequence, not sufficient.

## 📝 Core
### 1. Degree
- **Definition** ➔ $\deg_G(v)$ = neighbours = incident edges (simple graph).
- **Range** ➔ $\{0,\dots,n-1\}$; isolated = 0, leaf = 1.

### 2. Handshaking Lemma
- **Statement** ➔ $\sum_{v\in V}\deg(v)=2m$.
- **Proof** ➔ each edge adds 1 to each of its two endpoints ⟹ counted twice.
- **Corollary** ➔ average degree $=2m/n$.

### 3. Two Consequences
- **Equal degrees** ➔ every graph has two vertices of equal degree (pigeonhole: 0 and $n-1$ can't coexist).
- **Even odd-count** ➔ the number of odd-degree vertices is even.

> [!NOTE] **When It Flips:** global $n,m$ give the local average $2m/n$ (real networks far below max $n-1$). The equal-degree theorem is proof by [[Proof Techniques|cases]] + pigeonhole; [[Euler Tour]] existence hinges on all degrees being even.

## 📊 Exam Execution Trace

### Manual Execution Trace
$G$: $E=\{ab,ac,bc,cd,fg\}$:

| Step / State | Vertex | $\deg$ | Odd? |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | $a,b$ | 2,2 | no |
| 2 | $c$ | 3 | yes |
| 3 | $d,e,f,g$ | 1,0,1,1 | yes,–,yes,yes |

## ⚠️ Common Mistakes
- 💡 **Necessary, not sufficient** ➔ an odd count of odd numbers can't be a degree sequence, but satisfying the parity rules doesn't guarantee a graph exists.

## 🧠 Active Recall
> [!FAQ]- State and prove the Handshaking Lemma, and give its average-degree corollary.
> - **Hint:** Double counting.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\sum\deg=2m$; each edge counted twice; average $=2m/n$.
> > - **Why:** **Two endpoints** ➔ every edge adds 1 to each endpoint's degree.

> [!FAQ]- Why must every graph have two equal degrees, and why is the odd-degree count even?
> - **Hint:** Pigeonhole + parity.
> > [!SUCCESS]- Answer
> > - **Short answer:** 0 and $n-1$ can't coexist ⟹ only $n-1$ values for $n$ vertices (pigeonhole); $\sum\deg$ even forces an even number of odd degrees.
> > - **Why:** **Parity** ➔ even-degree vertices sum even, so odd ones must too.
