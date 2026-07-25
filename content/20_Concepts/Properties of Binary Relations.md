---
unit: FIT1058
week: 2
parent: "[[Binary Relation]]"
tags: [Math/Relations, Math/Discrete, Monash/CS_DS]
---
# [[Properties of Binary Relations]]

**Context:** [[FIT1058_MOC]] · classifies a [[Binary Relation]] on a set · the four properties that define an [[Equivalence Relation]] · combined by composition and closure

> [!abstract] Quick Revision
> - **🎯 Objective:** four structural properties of a relation on a set ➔ build orders and equivalences.
> - **📦 Core Components:** reflexive ➔ symmetric ➔ antisymmetric ➔ transitive.
> - **⚡ Key Constraint:** symmetry vs antisymmetry splits equivalences from partial orders; transitive closure records any-length chains.

## 📝 Core
### 1. The Four Properties
- **Reflexive** ➔ $\forall x:\ x\,R\,x$.
- **Symmetric** ➔ $x\,R\,y\Rightarrow y\,R\,x$.
- **Antisymmetric** ➔ $x\,R\,y\wedge y\,R\,x\Rightarrow x=y$.
- **Transitive** ➔ $x\,R\,y\wedge y\,R\,z\Rightarrow x\,R\,z$.

### 2. Standard Profiles
- **$=$** ➔ reflexive, **both** symmetric and antisymmetric, transitive.
- **$\le,\subseteq$** ➔ reflexive, antisymmetric, transitive (partial order, not symmetric).
- **$<,\subset$** ➔ transitive only; **Parent** ➔ none (grandparent breaks transitivity).

### 3. Composition & Closure
- **Composition** ➔ $S\circ R=\{(x,z):\exists y,\ x\,R\,y\wedge y\,S\,z\}$.
- **Reachability** ➔ $\text{knows}^{(6)}$ = six degrees of separation.
- **Transitive closure** ➔ $R^+$ = smallest transitive relation containing $R$ (any-length chains).

**Key identities:**

$$\text{refl } \forall x:xRx,\quad \text{sym } xRy\Rightarrow yRx,\quad \text{antisym } xRy\wedge yRx\Rightarrow x{=}y,\quad \text{trans } xRy\wedge yRz\Rightarrow xRz$$
$$S\circ R=\{(x,z):\exists y,\ xRy\wedge yScz\}$$

## ⚖️ Core Decision Matrix
| Relation | R | S | AntiS | T |
| :--- | :--- | :--- | :--- | :--- |
| $=$ | ✅ | ✅ | ✅ | ✅ |
| $\le,\subseteq$ | ✅ | ❌ | ✅ | ✅ |
| $<,\subset$ | ❌ | ❌ | ✅(vac) | ✅ |
| Parent | ❌ | ❌ | ❌ | ❌ |

> [!NOTE] **When It Flips:** relations are sets of pairs, so $R\cup S$ ($\text{Parent}=\text{Mother}\cup\text{Father}$), $R\cap S$ apply. $R^+$ is always transitive and minimal; under six-degrees $\text{knows}^+=\text{knows}^{(6)}$.

## 📊 Exam Execution Trace

### Manual Execution Trace
$A=\{1,2,3\}$, $R=\{(1,1),(2,2),(3,3),(1,2),(2,1)\}$:

| Step / State | Property | Check | Holds? |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | reflexive | $(1,1),(2,2),(3,3)$ | ✅ |
| 2 | symmetric | $(1,2),(2,1)$ | ✅ |
| 3 | transitive | chains close | ✅ |
| 4 | antisymmetric | $(1,2),(2,1),1\neq2$ | ❌ |

## ⚠️ Common Mistakes
- 💡 **Symmetric and antisymmetric are not opposites** ➔ $=$ is both; many relations are neither. Antisymmetry says mutual relation forces equality, not that symmetry fails.

## 🧠 Active Recall
> [!FAQ]- Define the four properties; why is $=$ special and which does $\le$ satisfy?
> - **Hint:** Symmetry vs antisymmetry.
> > [!SUCCESS]- Answer
> > - **Short answer:** $=$ is the unique both-symmetric-and-antisymmetric relation; $\le$ is reflexive, antisymmetric, transitive (partial order).
> > - **Why:** **Mutual ⟹ equal** ➔ antisymmetry is why $\le$ isn't symmetric.

> [!FAQ]- What is the transitive closure $R^+$, and how does composition model six degrees of separation?
> - **Hint:** Any-length chains.
> > [!SUCCESS]- Answer
> > - **Short answer:** $R^+$ is the smallest transitive relation containing $R$; $\text{knows}^{(k)}$ relates people within $k$ hops.
> > - **Why:** **Stabilises** ➔ six-degrees asserts $\text{knows}^{(6)}$ links everyone, so $\text{knows}^+=\text{knows}^{(6)}$.
