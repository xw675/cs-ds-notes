---
unit: [FIT1058, FIT2014]
week: [1, 5]
parent: "[[Binary Relation]]"
tags: [Math/Logic, Math/Discrete, Math/Theory]
aliases: [predicate, free variable, bound variable, arity, k-ary, truth-valued function, domain]
---
# [[Predicate]]

**Context:** [[FIT1058_MOC]], [[FIT2014_MOC]] · a [[Binary Relation|relation]] used in a logical context · a truth-valued function of its arguments · combined by [[Logical Connectives]] and bound by [[Quantifiers (Existential and Universal)|quantifiers]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a truth-valued function of its arguments ➔ extends propositional logic to assertions *about objects*.
> - **📦 Core Components:** arity ➔ unary (property) / binary (infix $<$) / higher ➔ yields a proposition once arguments fixed.
> - **⚡ Key Constraint:** binds variables via [[Quantifiers (Existential and Universal)|quantifiers]]; only $=$ is available by default.

## 📝 Core
### 1. The Predicate (Relation as Truth-Function)
- **Definition** ➔ a [[Binary Relation|relation]] viewed as a **truth-valued function** of its arguments ➔ the basis of predicate (first-order) logic.
- **Power** ➔ one statement with a **variable** stands for infinitely many specific assertions.
- **Just a relation** ➔ calling it "predicate" adds no maths ➔ flags intent to *make and combine logical statements*.

### 2. Arity & Composition
- **Unary** ➔ $\text{isNegative}(x)$ (also a **property**); **binary** ➔ $x<y$ (infix); **higher** ➔ $\text{knows}(x,y,t)$.
- **Evaluation** ➔ applied to specific arguments ⟹ a truth value ($\text{Parent}(\text{Ada},\text{Byron})=$T).
- **Combine** ➔ once arguments fixed, each application is a [[Proposition and Truth Value|proposition]] ➔ all [[Logical Connectives]] apply.

### 3. Equality Is Free
- **Built-in** ➔ $=$ usable over **any** domain without declaration.
- **Why** ➔ you cannot reason about a class without telling when two objects are the same ➔ the *only* default predicate.

### 4. Free vs Bound Variables (FIT2014)
- **Free variable** ➔ no value given yet, so the statement has **no truth value** ("$W$ is negative", "$Y=Z$"); each assignment of values creates a **different specific** [[Proposition and Truth Value|proposition]].
- **Bound variable** ➔ a [[Quantifiers (Existential and Universal)|quantifier]] binds it, turning the open statement into a **single proposition about the whole domain**; you can no longer substitute specific values.
- **Domain matters** ➔ $\exists W\in\mathbb{N}:W<0$ is **False**, while $\exists W\in\mathbb{Z}:W<0$ is **True** — the same predicate flips truth value with the domain.
- **Quantify variables only** ➔ $\exists 5$ or $\exists\text{Annie}$ is meaningless; quantifiers apply to variables, not constants.

### 5. Predicates vs Functions
- **Predicate** ➔ a **truth-valued** function: codomain is $\{\text{True},\text{False}\}$; $k$-ary for $k$ arguments (**unary = property**, **$\ge 2$ = relation**).
- **Function** ➔ values need **not** be truth values, e.g. $\sqrt{X}$ (nonnegative numbers $\to$ numbers), $\mathrm{motherOf}(X)$ (people $\to$ people), $X+Y$.
- **Constant** ➔ a function with **no arguments** (e.g. $5$, Annie); a function's arguments may be constants, variables, or other functions.

**Key identities:**

$$\text{Parent}(\text{Ada},\text{Byron})=\text{True},\qquad \text{Parent}(\text{Boole},\text{Everest})=\text{False}$$
$$\text{Parent}(\text{Plato},\text{Ariston})\wedge\text{Parent}(\text{Hypatia},\text{Theon}) \quad (\text{combine with connectives})$$

## ⚖️ Core Decision Matrix
| Arity | Form | Name | Example |
| :--- | :--- | :--- | :--- |
| 1 | $P(x)$ | property | $\text{Even}(x)$ |
| 2 | $x<y$ / $R(x,y)$ | binary relation | $\text{Parent}(x,y)$ |
| $n$ | $R(x_1,\dots,x_n)$ | [[n-ary Relation]] | $\text{knows}(x,y,t)$ |

> [!NOTE] **When It Flips:** predicates beat plain propositions because a variable-carrying statement generalises over a whole domain; a fixed proposition is just a predicate with all arguments bound. Equality is the sole assumed predicate; all others need declared arity + domains.

## 📊 Exam Execution Trace

### Manual Execution Trace
Domain $\{2,3,4\}$, predicates $\text{Even}(x)$, $\text{Lt}(x,y)\equiv x<y$:

| Step / State | Expression | Evaluation | Value |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | $\text{Even}(4)$ | $4$ even | T |
| 2 | $\text{Lt}(2,3)$ | $2<3$ | T |
| 3 | $\neg\text{Even}(3)\wedge\text{Lt}(3,4)$ | $\text{T}\wedge\text{T}$ | T |

## ⚠️ Common Mistakes
- 💡 **Arguments must fit the domains** ➔ a predicate's arguments are [[Term, Variable, and Constant|terms]] whose types match each slot ($<$ on $\mathbb R$ needs real arguments); a bare predicate with a free variable is *not yet* a proposition until fixed or quantified.

## 🧠 Active Recall
> [!FAQ]- How is a predicate related to a relation, and what does calling it a "predicate" add?
> - **Hint:** Relation as truth-function.
> > [!SUCCESS]- Answer
> > - **Short answer:** A predicate *is* a relation viewed as a truth-valued function; "predicate" signals intent to form logical statements.
> > - **Why:** **Property = unary** ➔ $\text{Parent}(x,y)$ returns True iff $(x,y)$ is in the relation; connectives and quantifiers then apply.

> [!FAQ]- Why is $=$ always available when no other predicate is assumed?
> - **Hint:** Identity is prerequisite to reasoning.
> > [!SUCCESS]- Answer
> > - **Short answer:** You cannot reason about a class without deciding when two objects are the same.
> > - **Why:** **Sole built-in** ➔ every other predicate must be declared with arity + argument domains.
