---
unit: FIT1058
week: 4
parent: "[[Logical Connectives]]"
tags: [Math/Logic, Math/Discrete, Monash/CS_DS]
---
# [[Exclusive-or]]

**Context:** [[FIT1058_MOC]] · the "exactly one" [[Logical Connectives|connective]] · the negation of equivalence · generalises to odd parity · the logical [[Set Operations (Mathematics)|Symmetric Difference]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $P\oplus Q$ is True precisely when $P,Q$ differ ➔ "or, but not both".
> - **📦 Core Components:** $P\oplus Q=\neg(P\Leftrightarrow Q)$ ➔ chains to odd parity ➔ addition mod 2.
> - **⚡ Key Constraint:** differs from inclusive $\vee$ only on the both-true row.

## 📝 Core
### 1. The Connective (Exactly One)
- **Definition** ➔ $P\oplus Q$ True iff **exactly one** of $P,Q$ is True (they **differ**).
- **vs $\vee$** ➔ inclusive-or also accepts both-true; $\oplus$ excludes it.
- **Negation of equivalence** ➔ $P\oplus Q=\neg(P\Leftrightarrow Q)$ (opposite columns).

### 2. Odd Parity Generalisation
- **Chain** ➔ $P_1\oplus\cdots\oplus P_n$ True iff an **odd number** of the $P_i$ are True.
- **Why** ➔ two trues cancel (mod-2 addition); provable by [[Mathematical Induction]].
- **Use** ➔ **parity bits** for error detection.

### 3. Algebraic Structure
- **Associative + commutative** ➔ chained $\oplus$ is unambiguous.
- **Identity F** ➔ $P\oplus\text{F}=P$; **self-inverse** ➔ $P\oplus P=\text{F}$.
- **Set dual** ➔ mirrors [[Set Operations (Mathematics)|Symmetric Difference]] $A\triangle B$ (elements in exactly one set).

**Key identities:**

$$P_1\oplus\cdots\oplus P_n=\text{True} \iff \#\{i: P_i=\text{True}\}\text{ is odd}$$

## ⚖️ Core Decision Matrix
| Relation | Formula | Meaning |
| :--- | :--- | :--- |
| vs equivalence | $\oplus=\neg(\Leftrightarrow)$ | True on disagreement |
| vs inclusive-or | agree except TT | $\oplus$ excludes both-true |
| identity / inverse | $P\oplus\text{F}=P$, $P\oplus P=\text{F}$ | addition mod 2 |
| set analogue | $A\triangle B$ | exactly one set |

> [!NOTE] **When It Flips:** for "$x\in A$"/"$x\in B$", $\oplus$ corresponds to [[Set Operations (Mathematics)|Symmetric Difference]] $A\triangle B$ — just as $\vee\leftrightarrow\cup$, $\wedge\leftrightarrow\cap$. XOR is the logical "exactly one".

## 📊 Exam Execution Trace

### Manual Execution Trace
Accumulate $1\oplus 0\oplus 1\oplus 1$ left to right:

| Step / State | Bit $P_i$ | Running $\oplus$ | #True odd? |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | 0 | no |
| 1 | 1 | 1 | yes |
| 2 | 0 | 1 | yes |
| 3 | 1 | 0 | no |
| 4 | 1 | 1 | yes |

## ⚠️ Common Mistakes
- 💡 **$\oplus$ vs $\vee$ split only at TT** ➔ agree on three rows; $\vee$ gives T at both-true, $\oplus$ gives F.

## 🧠 Active Recall
> [!FAQ]- How does exclusive-or relate to equivalence and to inclusive-or?
> - **Hint:** Opposite of $\Leftrightarrow$; splits from $\vee$ at TT.
> > [!SUCCESS]- Answer
> > - **Short answer:** $P\oplus Q=\neg(P\Leftrightarrow Q)$ (True on difference); matches $\vee$ except both-true.
> > - **Why:** **"Or but not both"** ➔ $\vee$ returns T at TT, $\oplus$ returns F.

> [!FAQ]- When is $P_1\oplus\cdots\oplus P_n$ true, and where is this used?
> - **Hint:** Odd count.
> > [!SUCCESS]- Answer
> > - **Short answer:** True iff an odd number of the $P_i$ are True (pairs cancel, mod-2 addition).
> > - **Why:** **Parity bits** ➔ this odd-parity property (by induction) underlies error detection in stored/transmitted data.
