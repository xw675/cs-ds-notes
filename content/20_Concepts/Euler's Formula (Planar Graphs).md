---
unit: FIT1058
week: 12
parent: "[[Planar Graph]]"
tags: [Math/GraphTheory, Math/Discrete]
---
# [[Euler's Formula (Planar Graphs)]]

**Context:** [[FIT1058_MOC]] · $n-m+f=2$ for a connected [[Planar Graph|plane graph]] · yields the edge bounds proving $K_5$, $K_{3,3}$ nonplanar

> [!abstract] Quick Revision
> - **🎯 Objective:** $n-m+f=2$ for a connected [[Planar Graph|plane graph]] ➔ invariant across drawings.
> - **📦 Core Components:** derive $m\le3n-6$ (and $2n-4$ triangle-free) ➔ prove $K_5,K_{3,3}$ nonplanar.
> - **⚡ Key Constraint:** bounds are **necessary, not sufficient**; passing $3n-6$ doesn't prove planarity.

## 📝 Core
### 1. The Formula
- **Statement** ➔ connected plane graph: $n-m+f=2$ ($f$ counts the outer face).
- **Invariant** ➔ same for all crossing-free drawings (proved by [[Mathematical Induction|induction]]).

### 2. The Edge Bounds
- **General** ➔ faces have $\ge3$ sides ⟹ $3f\le2m$ ⟹ $m\le3n-6$ ($n\ge3$).
- **Triangle-free** ➔ faces $\ge4$ sides ⟹ $m\le2n-4$.

### 3. The Obstructions
- **$K_5$** ➔ $m=10>9=3n-6$ ⟹ nonplanar.
- **$K_{3,3}$** ➔ passes $3n-6$ but bipartite ⟹ triangle-free ⟹ $9>8=2n-4$.

**Key identities:**

$$\text{each face} \ge3 \text{ sides},\ \text{each edge} = 2 \text{ sides} \Rightarrow 3f\le2m \Rightarrow f\le\tfrac{2m}3$$
$$f=2-n+m \Rightarrow 2-n+m\le\tfrac{2m}3 \Rightarrow m\le3n-6$$

> [!NOTE] **When It Flips:** the "sides $=2m$" double-count parallels the [[Degree and the Handshaking Lemma|degree-sum]] argument. Faces depend on connectivity; $n-m+f=2$ assumes the plane graph is connected.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** A connected plane graph has $n=8$, $m=10$. Find $f$; test $K_5$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
f &= 2-n+m = 2-8+10 = 4 \\
K_5 &: m=10>3(5)-6=9 \Rightarrow \text{nonplanar}
\end{aligned}
$$
**Final Extracted Output:** $f=4$ (satisfies $8-10+4=2$); $K_5$ nonplanar.

## ⚠️ Common Mistakes
- 💡 **Necessary, not sufficient** ➔ $K_{3,3}$ passes $m\le3n-6$ yet is nonplanar; only a *violation* proves nonplanarity.

## 🧠 Active Recall
> [!FAQ]- State Euler's formula and derive $m\le3n-6$.
> - **Hint:** Double-count sides.
> > [!SUCCESS]- Answer
> > - **Short answer:** $n-m+f=2$; faces $\ge3$ sides, edges 2 sides ⟹ $3f\le2m$; substitute $f=2-n+m$.
> > - **Why:** **Rearrange** ➔ $2-n+m\le\tfrac{2m}3$ gives $m\le3n-6$.

> [!FAQ]- Prove $K_5$ and $K_{3,3}$ are nonplanar.
> - **Hint:** Two bounds.
> > [!SUCCESS]- Answer
> > - **Short answer:** $K_5$: $10>9=3n-6$; $K_{3,3}$: triangle-free, $9>8=2n-4$.
> > - **Why:** **Minimal obstructions** ➔ the two smallest nonplanar graphs.
