---
unit: FIT1058
week: 11
parent: "[[Walks, Trails, and Paths]]"
tags: [Math/GraphTheory, Math/Discrete]
---
# [[Euler Tour]]

**Context:** [[FIT1058_MOC]] · a closed [[Walks, Trails, and Paths|trail]] using **every** edge · exists iff the graph is connected with all-even [[Degree and the Handshaking Lemma|degrees]] · the Königsberg bridges

> [!abstract] Quick Revision
> - **🎯 Objective:** a closed trail using every edge exactly once ➔ returns to start.
> - **📦 Core Components:** exists iff connected + all degrees even.
> - **⚡ Key Constraint:** a one-pass degree test (Königsberg: four odd degrees ⟹ impossible).

## 📝 Core
### 1. The Tour
- **Definition** ➔ a closed [[Walks, Trails, and Paths|trail]] using **every edge** exactly once, returning to start.
- **Euler's theorem (1736)** ➔ connected graph has an Euler tour iff every vertex has even [[Degree and the Handshaking Lemma|degree]].

### 2. Intuition
- **Pairing** ➔ each visit enters by one edge, leaves by another ⟹ even degree.
- **Connectivity** ➔ all edges must be reachable.

### 3. Königsberg
- **Model** ➔ land masses = vertices, bridges = edges.
- **Verdict** ➔ degrees $5,3,3,3$ all odd ⟹ no Euler tour; launched graph theory.

## ⚖️ Core Decision Matrix
| Graph | Degrees | Euler tour? |
| :--- | :--- | :--- |
| $C_3$ | 2,2,2 | ✅ |
| Königsberg | 5,3,3,3 | ❌ |
| $C_n$ | all 2 | ✅ ($n\ge3$) |
| any odd-degree vertex | — | ❌ |

> [!NOTE] **When It Flips:** a single pass over the degrees settles existence — no route search. Abstraction is the lesson: keep land-masses-and-bridges, discard geometry. Contrast a [[Cycle (Graph Theory)|cycle]] (uses each *vertex* once) with a tour (each *edge* once).

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Does $C_3$ have an Euler tour? Does Königsberg (degrees $5,3,3,3$)?
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
C_3 &: \text{connected, degrees all even} \Rightarrow \textbf{tour } a,b,c,a \\
\text{Königsberg} &: \text{degrees all odd} \Rightarrow \textbf{no tour}
\end{aligned}
$$
**Final Extracted Output:** $C_3$ yes; Königsberg no (four odd-degree vertices).

## ⚠️ Common Mistakes
- 💡 **Euler tour vs Euler trail** ➔ a closed tour needs all-even degrees; an open Euler *trail* allows exactly two odd-degree vertices (start/end).

## 🧠 Active Recall
> [!FAQ]- State Euler's theorem and the intuition behind the even-degree condition.
> - **Hint:** Edge pairing.
> > [!SUCCESS]- Answer
> > - **Short answer:** Connected graph has an Euler tour iff every vertex has even degree.
> > - **Why:** **In/out pairing** ➔ each visit uses two edges; odd degree leaves one unpaired.

> [!FAQ]- Why is the Königsberg walk impossible, and what makes it a landmark?
> - **Hint:** Model + degree test.
> > [!SUCCESS]- Answer
> > - **Short answer:** Land masses = vertices, bridges = edges; all four degrees odd violate the criterion.
> > - **Why:** **Search-free test** ➔ Euler (1736) gave a general condition, birthing graph theory.
