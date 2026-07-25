---
unit: [FIT1058, FIT2014]
week: [1, 4]
parent: "[[Boolean Algebra Laws]]"
tags: [Math/Logic, Math/Discrete, Math/Theory, Monash/CS_DS]
aliases: [CNF, clause, conjunctive normal form]
---
# [[Conjunctive Normal Form]]

**Context:** [[FIT1058_MOC]], [[FIT2014_MOC]] · an AND-of-ORs standard form · the natural form for encoding rules · dual to [[Disjunctive Normal Form]] via De Morgan
**Applied in FIT2014:** [[Encoding Problems in Propositional Logic]] (problem → formula) · [[CNF Encoding Patterns (At Least, At Most, Exactly)]] (counting → clauses)

> [!abstract] Quick Revision
> - **🎯 Objective:** a conjunction (AND) of clauses, each a disjunction (OR) of literals ➔ the natural target when encoding rules.
> - **📦 Core Components:** clause = "satisfy at least one literal" ➔ whole CNF = "satisfy every clause".
> - **⚡ Key Constraint:** De Morgan **dual** of [[Disjunctive Normal Form]]; the standard SAT-solver input. **In FIT2014 CNF matters far more than DNF** — it is the uniform encoding used in complexity theory.

## 🎓 FIT2014 emphasis
- **CNF ≫ DNF in this unit** ➔ real specifications are conditions that must **all** hold, so CNF is written **directly from the stated conditions** — faster and less error-prone than the truth-table route.
- **A lone clause is already CNF** ➔ e.g. $P_{F,13}\vee P_{F,14}\vee P_{F,15}\vee P_{F,16}$ needs no conversion.
- **Dramatic size gap** ➔ for "at least one of $J,K,M$": **DNF needs 7 terms**, **CNF needs 1 clause** $(J\vee K\vee M)$ — see [[Disjunctive Normal Form]].
- **Standard conversion** ➔ any $\neg(p\wedge q)$ becomes the clause $(\neg p\vee\neg q)$ by De Morgan; rewrite $P\Rightarrow Q$ as $(\neg P\vee Q)$ and $P\Leftrightarrow Q$ as $(\neg P\vee Q)\wedge(P\vee\neg Q)$.

## 📝 Core
### 1. The Form (AND-of-ORs)
- **Definition** ➔ conjunction of **clauses**, each clause a disjunction of literals ➔ e.g. $(\neg P\vee Q)\wedge(P\vee\neg Q)$.
- **Clause = constraint** ➔ "satisfy at least one of these literals".
- **Whole CNF** ➔ demands **every** clause be satisfied.

### 2. Why CNF Matters
- **Rule shape** ➔ real rule sets are conditions that must **all** hold (top-level conjunction), each often "at least one option" (disjunction).
- **That shape is CNF** ➔ natural for [[Logical Modelling|encoding rules]]; the standard SAT input.

### 3. Duality with DNF
- **De Morgan duals** ➔ negating an AND-of-ORs and pushing $\neg$ inward gives an OR-of-ANDs.
- **Every expression has a CNF** ➔ via negate → DNF of $\neg P$ → negate → De Morgan (impractical but exists).

**Key identities:**

$$\text{only False row TF} \to (\neg X\vee Y) \;\Rightarrow\; P=(\neg X\vee Y)\ (\equiv X\Rightarrow Y)$$

## ⚖️ Core Decision Matrix
| | CNF | [[Disjunctive Normal Form|DNF]] |
| :--- | :--- | :--- |
| shape | AND-of-ORs | OR-of-ANDs |
| built from | False rows | True rows |
| natural for | rule/constraint modelling, SAT | listing satisfying assignments |
| conversion | De Morgan dual of the other | De Morgan dual |

> [!NOTE] **When It Flips:** because rule sets decompose as "this $\wedge$ that $\wedge$ …", CNF is usually written **directly** from the problem, not via the truth-table route; each clause encodes one constraint.

## 📊 Exam Execution Trace

### Manual Execution Trace
$P$ with output T,T,F,T (rows FF,FT,TF,TT):

| Step / State | $X$ | $Y$ | Output | Clause (False row) |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — | — |
| 1 | F | F | T | — |
| 2 | F | T | T | — |
| 3 | T | F | F | $(\neg X\vee Y)$ |
| 4 | T | T | T | — |

## ⚠️ Common Mistakes
- 💡 **Clause literals are flipped vs DNF** ➔ CNF negates the row-true literals (False rows); DNF keeps them (True rows). Both can blow up to $2^k$ rows.

## 🧠 Active Recall
> [!FAQ]- What is CNF, and why is it preferred over DNF for modelling real rules?
> - **Hint:** Rule sets are conjunctions of disjunctions.
> > [!SUCCESS]- Answer
> > - **Short answer:** CNF = conjunction of clauses (each a disjunction of literals), e.g. $(\neg P\vee Q)\wedge(P\vee\neg Q)$.
> > - **Why:** **Direct transcription** ➔ "all conditions hold, each 'at least one option'" *is* CNF — the standard SAT form.

> [!FAQ]- How are CNF and DNF related, and how do you get CNF from a truth table?
> - **Hint:** De Morgan duality.
> > [!SUCCESS]- Answer
> > - **Short answer:** Negate the output (→$\neg P$), read DNF of $\neg P$, negate, apply De Morgan → CNF.
> > - **Why:** **Duality** ➔ negating an AND-of-ORs and distributing $\neg$ gives an OR-of-ANDs; proves every expression has a CNF.
