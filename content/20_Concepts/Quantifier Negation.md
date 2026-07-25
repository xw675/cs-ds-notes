---
unit: FIT1058
week: 5
parent: "[[Quantifiers (Existential and Universal)]]"
tags: [Math/Logic, Math/Discrete]
---
# [[Quantifier Negation]]

**Context:** [[FIT1058_MOC]] · moving $\neg$ across a [[Quantifiers (Existential and Universal)|quantifier]] flips it · the first-order form of [[Boolean Algebra Laws|De Morgan]] · key to negating statements

> [!abstract] Quick Revision
> - **🎯 Objective:** move $\neg$ across a quantifier, flipping $\exists\leftrightarrow\forall$ ➔ the first-order De Morgan.
> - **📦 Core Components:** $\neg\forall Y\,P\equiv\exists Y\,\neg P$ ➔ $\neg\exists Y\,P\equiv\forall Y\,\neg P$.
> - **⚡ Key Constraint:** to negate, push $\neg$ through **every** quantifier then De Morgan the body.

## 📝 Core
### 1. The Two Laws
- **Universal** ➔ $\neg\forall Y\,P(Y)\equiv\exists Y\,\neg P(Y)$.
- **Existential** ➔ $\neg\exists Y\,P(Y)\equiv\forall Y\,\neg P(Y)$.
- **Name** ➔ the quantifier (generalised) De Morgan laws.

### 2. Why It Generalises De Morgan
- **$\forall$ = conjunction, $\exists$ = disjunction** over the domain.
- **$\neg\forall=\exists\neg$** ➔ "$\neg$ of an AND is an OR of $\neg$" across all elements.

### 3. Negation Procedure
- **Push right** ➔ move $\neg$ through **every** quantifier, flipping each.
- **De Morgan the body** ➔ negate the innermost [[Predicate|predicate]] with Boolean laws.
- **Restriction respected** ➔ a universal's $\Rightarrow$ negates into an existential's $\wedge$.

**Key identities:**

$$
$$

> [!NOTE] **When It Flips:** negation = disproof — $\neg\forall x\,P(x)=\exists x\,\neg P(x)$ is exactly why one counterexample disproves a universal, and $\neg\exists=\forall\neg$ why disproving an existential needs all cases.

## 📊 Exam Execution Trace

### Manual Execution Trace
Negating $\forall X\,(\text{dog}(X)\Rightarrow\text{happy}(X))$:

| Step / State | Expression | Rule |
| :--- | :--- | :--- |
| **0 (Init)** | $\neg\forall X\,(\text{dog}\Rightarrow\text{happy})$ | — |
| 1 | $\exists X\,\neg(\text{dog}\Rightarrow\text{happy})$ | $\neg\forall\to\exists\neg$ |
| 2 | $\exists X\,\neg(\neg\text{dog}\vee\text{happy})$ | $\Rightarrow$ rewrite |
| 3 | $\exists X\,(\text{dog}\wedge\neg\text{happy})$ | De Morgan + $\neg\neg$ |

## ⚠️ Common Mistakes
- 💡 **$\Rightarrow$ negates to $\wedge$** ➔ a restricted universal's implication becomes the existential's conjunction; a double flip $\neg\forall Y\neg P\equiv\exists Y\,P$ returns the original.

## 🧠 Active Recall
> [!FAQ]- State the two quantifier-negation laws and show "not all dogs are happy" = "there is an unhappy dog".
> - **Hint:** Flip + De Morgan the body.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\neg\forall Y\,P\equiv\exists Y\,\neg P$; $\neg\exists Y\,P\equiv\forall Y\,\neg P$; the dog case reduces to $\exists X(\text{dog}\wedge\neg\text{happy})$.
> > - **Why:** **$\Rightarrow\to\wedge$** ➔ rewriting $\neg\text{dog}\vee\text{happy}$ and applying De Morgan.

> [!FAQ]- How do you negate $\forall X\exists Y\,\text{adj}(X,Y)$, and what does $\neg\forall Y\neg P(Y)$ simplify to?
> - **Hint:** Flip each quantifier.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\neg\forall X\exists Y\,\text{adj}\equiv\exists X\forall Y\,\neg\text{adj}$; $\neg\forall Y\neg P\equiv\exists Y\,P$.
> > - **Why:** **Double flip cancels** ➔ two negations and two quantifier-flips return a plain existential.
