---
unit: FIT1058
domain: D
week: 2
parent: "[[Cartesian Product]]"
tags: [Math/Relations, Math/Discrete]
---
# [[Binary Relation]]

**Context:** [[FIT1058_MOC]] · a [[Subset and Superset|subset]] of a [[Cartesian Product]] · generalises the [[Function (Mathematics)|function]] · classified by [[Properties of Binary Relations]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a subset $R\subseteq A\times B$ recording which elements are related ➔ pairs, not single-valued.
> - **📦 Core Components:** domain/codomain ➔ forward/backward lookup ➔ inverse relation.
> - **⚡ Key Constraint:** a function is the single-valued + total special case; the inverse **relation** always exists.

## 📝 Core
### 1. The Relation (Subset of a Product)
- **Definition** ➔ $R\subseteq A\times B$, a set of ordered pairs $(a,b)$ recording "related".
- **On $A$** ➔ the case $B=A$ ($R\subseteq A\times A$).
- **Notation** ➔ $(x,y)\in R\equiv x\,R\,y\equiv R(x,y)$.

### 2. Function as Special Case
- **Functional constraint** ➔ for **every** $a$, exactly one $b$ with $(a,b)\in R$.
- **General relation** ➔ an element relates to zero, one, or many.
- **Every function is a relation** ➔ not conversely.

### 3. Operations
- **Active domain/image** ➔ first/second coordinates actually used.
- **Lookups** ➔ $R(x)=\{y:x\,R\,y\}$; $R^{-1}(y)=\{x:x\,R\,y\}$.
- **Inverse** ➔ $R^{-1}$ swaps every pair — always exists.

**Key identities:**

$$R(x)=\{y:x\,R\,y\},\qquad R^{-1}(y)=\{x:x\,R\,y\},\qquad y\,R^{-1}x\iff x\,R\,y$$

## ⚖️ Core Decision Matrix
| Object | Constraint | Count ($m\times n$) |
| :--- | :--- | :--- |
| relation $A\to B$ | none | $2^{mn}$ |
| function $A\to B$ | single-valued + total | $n^m$ |
| inverse relation | swap pairs | always exists |
| inverse function | bijection required | conditional |

> [!NOTE] **When It Flips:** relations model orders ($=,<,\le,\subseteq$), graph edges, and database rows; they are sets of pairs, so $R\cup S$, $R\cap S$ apply. The [[Function (Mathematics)]] is the single-valued, total specialisation.

## 📊 Exam Execution Trace

### Manual Execution Trace
$A=\{1,2,3\}$, $R=\{(1,2),(2,3),(1,3)\}$ ("$<$"):

| Step / State | Query | Result |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | $R(1)$ | $\{2,3\}$ |
| 2 | $R(2)$ | $\{3\}$ |
| 3 | $R^{-1}$ | $\{(2,1),(3,2),(3,1)\}$ |

## ⚠️ Common Mistakes
- 💡 **Inverse relation ≠ inverse function** ➔ $R^{-1}$ exists for *any* relation (swap pairs); it's a function only if $R$ is a bijection.

## 🧠 Active Recall
> [!FAQ]- Define a binary relation, and the extra constraint that makes one a function.
> - **Hint:** Subset + functional constraint.
> > [!SUCCESS]- Answer
> > - **Short answer:** A relation is any $R\subseteq A\times B$; a function requires exactly one $b$ per $a$ (total + single-valued).
> > - **Why:** **Every function is a relation** ➔ not conversely; general relations allow 0/1/many.

> [!FAQ]- Why does the inverse *relation* always exist while an inverse *function* may not?
> - **Hint:** Swap vs bijection.
> > [!SUCCESS]- Answer
> > - **Short answer:** $R^{-1}$ swaps pairs — always valid; an inverse function needs $R$ bijective.
> > - **Why:** **Single-valued/total** ➔ non-injective ⟹ many preimages; non-surjective ⟹ missing preimages.
