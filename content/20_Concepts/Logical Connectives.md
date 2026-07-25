---
unit: FIT1058
week: [1, 4]
parent: "[[Proposition and Truth Value]]"
tags: [Math/Logic, Math/Discrete]
---
# [[Logical Connectives]]

**Context:** [[FIT1058_MOC]] · operations that combine [[Proposition and Truth Value|propositions]] · defined by truth tables · the logical duals of the [[Set Operations (Mathematics)|set operations]]

> [!abstract] Quick Revision
> - **🎯 Objective:** build a new proposition from existing ones, defined by a truth table ➔ the logic gates of reasoning.
> - **📦 Core Components:** unary $\neg$ ➔ binary $\wedge,\vee,\Rightarrow,\Leftrightarrow,\oplus$.
> - **⚡ Key Constraint:** $\wedge\leftrightarrow\cap$, $\vee\leftrightarrow\cup$, $\neg\leftrightarrow$ complement — set laws reappear as [[Boolean Algebra Laws|De Morgan]].

## 📝 Core
### 1. The Connectives (Truth-Table Defined)
- **Definition** ➔ each connective is fixed by a **truth table** giving the result for every argument combination.
- **Basic set** ➔ **unary** $\neg$ (not); **binary** $\wedge$ (and), $\vee$ (inclusive or), $\Rightarrow$ (implication), $\Leftrightarrow$ (equivalence), $\oplus$ (xor).
- **Hardware** ➔ these are **logic gates**.

### 2. Values at a Glance
- **$\neg$** ➔ flips the value.
- **$\wedge$** ➔ T iff **both** T; **$\vee$** ➔ T iff **at least one** T.
- **$\Rightarrow$** ➔ F **only** when $P$ T and $Q$ F.
- **$\Leftrightarrow$** ➔ T iff values **equal**; **$\oplus$** ➔ T iff values **differ**.

### 3. The Set Duality
- **Correspondence** ➔ for "$x\in A$": $\wedge\leftrightarrow\cap$, $\vee\leftrightarrow\cup$, $\neg\leftrightarrow$ complement.
- **Payoff** ➔ every set-algebra law has an identical logical form ➔ results transfer both ways.

## ⚖️ Core Decision Matrix
| Connective | Arity | T exactly when | Set dual |
| :--- | :--- | :--- | :--- |
| $\neg$ | unary | argument is F | complement |
| $\wedge$ | binary | both T | $\cap$ |
| $\vee$ | binary | at least one T | $\cup$ |
| $\Rightarrow$ | binary | not ($P$ T, $Q$ F) | $A\subseteq B$ |
| $\Leftrightarrow$ | binary | values equal | $A=B$ |
| $\oplus$ | binary | values differ | symmetric difference |

> [!NOTE] **When It Flips:** inclusive $\vee$ is T when either *or both* hold; exclusive $\oplus$ excludes the both-true case — they agree on three rows and differ only at TT. "and"/"or" are narrower than English: defined *solely* by the truth tables, no temporal/causal meaning.

## 📊 Exam Execution Trace

### Manual Execution Trace
Evaluate $(P\wedge\neg Q)\vee Q$:

| Step / State | $P$ | $Q$ | $\neg Q$ | $P\wedge\neg Q$ | $(P\wedge\neg Q)\vee Q$ |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — | — | — |
| 1 | F | F | T | F | F |
| 2 | F | T | F | F | T |
| 3 | T | F | T | T | T |
| 4 | T | T | F | F | T |

## ⚠️ Common Mistakes
- 💡 **$\Rightarrow$ is F only on T→F** ➔ every other row is T (including F→anything, "vacuously true"); and "or" means **inclusive** $\vee$, not $\oplus$.

## 🧠 Active Recall
> [!FAQ]- Give the truth tables of $\wedge$, $\vee$, $\Rightarrow$, and the one row separating inclusive from exclusive or.
> - **Hint:** Row-by-row values.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\wedge$: F,F,F,T; $\vee$: F,T,T,T; $\Rightarrow$: T,T,F,T (for FF,FT,TF,TT).
> > - **Why:** **TT row** ➔ $\vee$ gives T, $\oplus$ gives F — the sole distinguishing row.

> [!FAQ]- How do $\wedge,\vee,\neg$ correspond to set operations, and what does the correspondence buy you?
> - **Hint:** Logic ↔ set algebra.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\wedge$ = intersection, $\vee$ = union, $\neg$ = complement (via "$x\in A$").
> > - **Why:** **Law transfer** ➔ every set law (De Morgan, distributive, double complement) has an identical logical form, so results move freely between sets and logic.
