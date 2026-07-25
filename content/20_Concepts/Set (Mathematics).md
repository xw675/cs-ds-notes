---
unit: FIT1058
week: 1
parent: "[[Power Set]]"
tags: [Math/SetTheory, Math/Discrete, Monash/CS_DS]
---
# [[Set (Mathematics)]]

**Context:** [[FIT1058_MOC]] · the simplest information structure · specified three ways · sized by its cardinality · the computational realisation is the [[Set (ADT)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** an unordered, duplicate-free collection determined solely by membership ➔ $\{1,2,3\}=\{3,1,2\}=\{1,1,2,3\}$.
> - **📦 Core Components:** **Roster** ➔ list | **Condition** ➔ filter a superset | **Construction rule** ➔ generate members.
> - **⚡ Key Constraint:** cardinality $|A|$ drives all counting — $|\mathcal P(A)|=2^{|A|}$, $|A\times B|=|A||B|$.

## 📝 Core
### 1. The Set (Membership Only)
- **Definition** ➔ a collection of **elements** with **no order, no repetition**.
- **Determined by** ➔ *which* objects belong ➔ membership $x\in A$ / non-membership $x\notin A$.
- **Foundational** ➔ defines **types** we compute with (integer type = membership of $\mathbb Z$).

### 2. Three Specifications
- **Roster** ➔ $\{\text{Harry},\text{Ron},\text{Hermione}\}$, $\emptyset=\{\ \}$.
- **By condition** ➔ $\{x\in\mathbb Z : x\text{ even}\}$ ➔ filter a larger set by a predicate.
- **By construction** ➔ $\{2n : n\in\mathbb Z\}$ ➔ generate members by a formula (colon = "such that").

### 3. Cardinality & Assumptions
- **Cardinality** ➔ $|A|$ = number of elements ($|\emptyset|=0$).
- **Elements may be sets** ➔ makes [[Power Set]] and [[Set Partition]] well-defined.
- **Assumption** ➔ naive set theory; sets are primitive collections (no paradox axioms).

**Key identities:**

$$\{x\in\mathbb Z : x\text{ even}\}=\{2n : n\in\mathbb Z\}$$
$$|\{\text{Harry},\text{Ron},\text{Hermione}\}|=3,\quad |\emptyset|=0,\quad |\mathcal P(A)|=2^{|A|},\quad |A\times B|=|A|\,|B|$$

## ⚖️ Core Decision Matrix
| Specification | Form | Best when |
| :--- | :--- | :--- |
| **Roster** | $\{a,b,c\}$ | small, explicit finite sets |
| **By condition** | $\{x\in U : P(x)\}$ | filtering an existing superset |
| **By construction** | $\{f(n) : n\in D\}$ | generating members by a rule |
| **Informal $\dots$** | $\{0,2,4,\dots\}$ | illustration only — **not** a definition |

> [!NOTE] **When It Flips:** order and repetition carry no information ($\{1,2,3\}=\{1,1,2,3\}$) — this is exactly what separates a **set** from a **tuple/sequence**, where $(1,2,3)\neq(3,2,1)$ (the domain of the [[Cartesian Product]]). The computational counterpart is the [[Set (ADT)]] with `add`/`contains`/`remove`.

## 📊 Exam Execution Trace

### Manual Execution Trace
Testing membership of $A=\{n\in\mathbb Z : -2\le n<3\}$:

| Step / State | Candidate $x$ | Satisfies $-2\le n<3$? | $x\in A$? |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | $-2$ | $-2\le-2<3$ | ✓ |
| 2 | $-1,0,1,2$ | all satisfy | ✓ |
| 3 | $3$ | $3<3$ false | ✗ |

## ⚠️ Common Mistakes
- 💡 **"$\{0,2,-2,4,\dots\}$" is an informal description, not a definition** ➔ it relies on guessing the pattern and never states the membership condition; use the condition/construction forms.

## 🧠 Active Recall
> [!FAQ]- Specify the even integers two formal ways, and explain why $\{0,2,-2,4,\dots\}$ is not one.
> - **Hint:** Predicate vs generator vs pattern-guessing.
> > [!SUCCESS]- Answer
> > - **Short answer:** By condition $\{x\in\mathbb Z : x\text{ even}\}$; by construction $\{2n : n\in\mathbb Z\}$.
> > - **Why:** **No stated condition** ➔ the "$\dots$" list only relies on inferring a pattern, so it never formally determines membership.

> [!FAQ]- Why are $\{1,2,3\}$, $\{3,2,1\}$ and $\{1,1,2,3\}$ the same set, and what structure distinguishes them?
> - **Hint:** Membership alone matters.
> > [!SUCCESS]- Answer
> > - **Short answer:** All have members exactly $1,2,3$; order and multiplicity carry no information.
> > - **Why:** **Use a tuple/multiset** ➔ if order matters, $(1,2,3)\neq(3,2,1)$ ([[Cartesian Product]]); if multiplicity matters, a multiset.

> [!FAQ]- What is $|\emptyset|$, and where does cardinality reappear in this unit?
> - **Hint:** Size underlies counting.
> > [!SUCCESS]- Answer
> > - **Short answer:** $|\emptyset|=0$.
> > - **Why:** **Counting laws** ➔ $|\mathcal P(A)|=2^{|A|}$ ([[Power Set]]), $\binom nk$ ([[Binomial Coefficient]]), $|A\times B|=|A||B|$ ([[Cartesian Product]]), $|\overline A|=|U|-|A|$ ([[Set Operations (Mathematics)|Set Complement and Difference]]).
