---
unit: FIT1058
domain: D
week: 5
parent: "[[Predicate]]"
tags: [Math/Logic, Math/Discrete]
---
# [[Term, Variable, and Constant]]

**Context:** [[FIT1058_MOC]] · what goes into a [[Predicate|predicate's]] argument slots · free vs bound variables · a [[Predicate|predicate]] becomes a [[Proposition and Truth Value|proposition]] once all free variables are assigned

> [!abstract] Quick Revision
> - **🎯 Objective:** the inputs a predicate consumes ➔ constant / variable / function-applied-to-terms.
> - **📦 Core Components:** variable (domain-ranging) ➔ constant (fixed) ➔ term (recursive).
> - **⚡ Key Constraint:** a predicate becomes a [[Proposition and Truth Value|proposition]] only when every **free** variable is assigned or bound.

## 📝 Core
### 1. The Three Objects
- **Variable** ➔ a name for an unspecified object from a **domain**.
- **Constant** ➔ a specific value ($3$, $\pi$, Alan Turing).
- **Term** ➔ a constant, a variable, or **a function applied to (valid) terms** (recursive).

### 2. Free vs Bound
- **Free** ➔ no value yet, open to assignment ➔ a predicate with a free variable is **not** a proposition.
- **Bound** ➔ captured by a [[Quantifiers (Existential and Universal)|quantifier]] ➔ no longer assignable.
- **Becomes a proposition** ➔ when every free variable is assigned from its domain (or bound).

### 3. Type-Checking Terms
- **Domain fit** ➔ a term must make sense in its argument's domain.
- **Available functions only** ➔ codomains must match the next argument's domain ([[Function Composition]] of types).

**Key identities:**

$$\textbf{terms}: \quad -5,\ 22/7,\ y,\ 3\times x+1,\ 2\times\pi\times x$$
$$\textbf{not terms}: \quad 2+3+,\ \log x\ (\text{unavailable}),\ x\wedge y\ (\text{connective, not a function})$$
$$\text{Parent}(\text{Turing},X)\ (\text{free }X) \xrightarrow{X:=\text{Sara Turing}} \text{Parent}(\text{Turing},\text{Sara Turing})\ (\text{proposition})$$

## ⚖️ Core Decision Matrix
| Object | Ranges / fixed | Quantifiable? | Role |
| :--- | :--- | :--- | :--- |
| variable | ranges over a domain | yes | assigned or bound |
| constant | fixed object | **no** | a specific value |
| term | names an object | — | predicate input |
| predicate application | a statement | — | has a truth value |

> [!NOTE] **When It Flips:** math favours single letters ($x,\theta$) because juxtaposition means multiplication (`myVar` reads as a product). Term ≠ formula: a term names an object; a predicate application is a statement.

## 📊 Exam Execution Trace

### Manual Execution Trace
Classify expressions and variable occurrences:

| Step / State | Expression | Term? | Variable status |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | $3\times x+1$ | term | $x$ free |
| 2 | $\log x$ | not (unavailable fn) | — |
| 3 | $x\wedge y$ | not (connective) | — |
| 4 | $\forall x\,(x<y)$ | — | $x$ bound, $y$ free |

## ⚠️ Common Mistakes
- 💡 **$x\wedge y$ is not a term** ➔ $\wedge$ combines *statements*, not objects; and constants can't be quantified ($\exists 5$, $\forall\text{Annie}$ are errors).

## 🧠 Active Recall
> [!FAQ]- What is a term, and which of $3\times x+1$, $\log x$, $x\wedge y$ qualify?
> - **Hint:** Constant/variable/function-applied.
> > [!SUCCESS]- Answer
> > - **Short answer:** A term is a constant, variable, or function applied to terms; only $3\times x+1$ qualifies.
> > - **Why:** **Object vs statement** ➔ $\log$ is unavailable; $\wedge$ combines statements, not objects.

> [!FAQ]- Distinguish free vs bound variables, and when does a predicate become a proposition?
> - **Hint:** Assignment / binding.
> > [!SUCCESS]- Answer
> > - **Short answer:** Free = open to assignment (no truth value); bound = captured by a quantifier; a predicate becomes a proposition when every free variable is assigned or bound.
> > - **Why:** **No truth value while free** ➔ $\text{Parent}(\text{Turing},X)$ is not a proposition until $X$ is given a person.
