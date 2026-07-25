---
unit: FIT1058
domain: D
week: 4
parent: "[[Conjunctive Normal Form]]"
tags: [Math/Logic, Math/Discrete]
---
# [[Logical Modelling]]

**Context:** [[FIT1058_MOC]] · encoding real rule sets as a [[Conjunctive Normal Form|CNF]] expression · top-level conjunction of conditions · includes counting "how many are true"

> [!abstract] Quick Revision
> - **🎯 Objective:** turn a set of rules into one Boolean expression ➔ rules hold together ⟹ top-level conjunction ⟹ [[Conjunctive Normal Form|CNF]].
> - **📦 Core Components:** one Boolean variable per fact ➔ translate each rule ➔ AND them.
> - **⚡ Key Constraint:** counting constraints (at most/least/exactly $k$) expand to $\binom{n}{\cdot}$-many clauses.

## 📝 Core
### 1. The Model (Conjunction of Conditions)
- **Encode** ➔ rules → a single Boolean expression over chosen **variables**.
- **Together** ➔ all rules must hold ⟹ top level is $\wedge$ ⟹ [[Conjunctive Normal Form|CNF]].
- **Translate, don't solve** ➔ modelling builds the constraint; finding an assignment is the separate satisfiability problem.

### 2. Rule Translation
- **"at least one"** ➔ $A\vee B\vee\dots$
- **"only if"** ➔ $\text{Hagrid}\Rightarrow\text{Norberta}=\neg\text{Hagrid}\vee\text{Norberta}$.
- **"none or both"** ➔ $\text{Fred}\Leftrightarrow\text{George}=(\neg\text{Fred}\vee\text{George})\wedge(\text{Fred}\vee\neg\text{George})$.

### 3. Counting Constraints (in CNF)
- **At most $k$** ➔ every $(k{+}1)$-subset has a False one ➔ AND of (OR of **negations**).
- **At least $k$** ➔ every $(n{-}k{+}1)$-subset has a True one ➔ AND of (OR of **plain** literals).
- **Exactly $k$** ➔ (at least $k$) $\wedge$ (at most $k$).

**Key identities:**

$$\text{Harry}\vee\text{Ron}\vee\text{Hermione}\vee\text{Ginny} \quad(\text{at least one})$$
$$\neg\text{Hagrid}\vee\text{Norberta} \quad(\text{Hagrid only if Norberta})$$
$$(\neg\text{Fred}\vee\text{George})\wedge(\text{Fred}\vee\neg\text{George}) \quad(\text{none or both})$$
$$(\neg V\vee\neg B)\wedge(\neg V\vee\neg D)\wedge(\neg B\vee\neg D) \quad(\text{at most one of }V,B,D)$$

## ⚖️ Core Decision Matrix
| Rule | Logical form | CNF |
| :--- | :--- | :--- |
| at least one of $A,B$ | $A\vee B$ | $(A\vee B)$ |
| $A$ only if $C$ | $A\Rightarrow C$ | $(\neg A\vee C)$ |
| none or both $A,B$ | $A\Leftrightarrow B$ | $(\neg A\vee B)\wedge(A\vee\neg B)$ |
| at most one of $A,B,C$ | pairwise not-both | $(\neg A\vee\neg B)\wedge(\neg A\vee\neg C)\wedge(\neg B\vee\neg C)$ |

> [!NOTE] **When It Flips:** the outermost operator is always $\wedge$ — you cannot ignore inconvenient rules. Cardinality constraints use [[Binomial Coefficient|$\binom{n}{k+1}$]]-many clauses, so encodings can grow quickly.

## 📊 Exam Execution Trace

### Manual Execution Trace
Encoding three rules:

| Step / State | Rule | CNF clause(s) |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | at least one of $A,B$ | $(A\vee B)$ |
| 2 | $A$ only if $C$ | $(\neg A\vee C)$ |
| 3 | at most one of $A,B,C$ | $(\neg A\vee\neg B)\wedge(\neg A\vee\neg C)\wedge(\neg B\vee\neg C)$ |

## ⚠️ Common Mistakes
- 💡 **"At most one" = forbid every pair** ➔ a "not both" clause $(\neg a\vee\neg b)$ for each pair; AND-ing all parts gives the single CNF.

## 🧠 Active Recall
> [!FAQ]- Why is a rule set modelled as a conjunction, and how are "Hagrid only if Norberta" / "none or both of Fred and George" encoded?
> - **Hint:** All rules hold at once.
> > [!SUCCESS]- Answer
> > - **Short answer:** Top level is $\wedge$ (can't drop rules) ⟹ CNF; "only if" = $\text{Hagrid}\Rightarrow\text{Norberta}$; "none or both" = $\text{Fred}\Leftrightarrow\text{George}$.
> > - **Why:** **Rewrites** ➔ $\Rightarrow=\neg P\vee Q$, $\Leftrightarrow=(\neg P\vee Q)\wedge(P\vee\neg Q)$.

> [!FAQ]- How do you express "at most $k$ of $n$ true" and "exactly $k$" as CNF?
> - **Hint:** Subset clauses.
> > [!SUCCESS]- Answer
> > - **Short answer:** At most $k$: for every $(k{+}1)$-subset, OR of negations; at least $k$: for every $(n{-}k{+}1)$-subset, OR of plain literals; exactly $k$ = both.
> > - **Why:** **$\binom{n}{k+1}$ clauses** ➔ each subset forces the required True/False count.
