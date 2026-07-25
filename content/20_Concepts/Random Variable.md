---
unit: FIT1058
week: [1, 10]
parent: "[[Probability]]"
tags: [Math/Probability, Math/Discrete]
---
# [[Random Variable]]

**Context:** [[FIT1058_MOC]] · a numerical [[Function (Mathematics)|function]] of a random outcome · "$X=k$" is an [[Sample Space and Events|event]] · has a probability **distribution**, summarised by [[Expectation]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a function $X:U\to\mathbb R$ of a random outcome ➔ "$X=k$" is an event.
> - **📦 Core Components:** distribution $\mathrm{Pr}(X=k)$ ➔ sums/independence ➔ summarised by [[Expectation]].
> - **⚡ Key Constraint:** write $\mathrm{Pr}(X=k)$, not $\mathrm{Pr}(X)$ — $X$ has a distribution, not one probability.

## 📝 Core
### 1. The Variable
- **Definition** ➔ a [[Function (Mathematics)|function]] $X:U\to\mathbb R$; randomness is in the drawn outcome $x$, $X$ deterministic.
- **Event** ➔ "$X=k$" is $\{x:X(x)=k\}$, $\mathrm{Pr}(X=k)=\sum_{x:X(x)=k}\mathrm{Pr}(x)$.

### 2. Distribution
- **Definition** ➔ the values of $X$ with their probabilities.
- **Notation** ➔ $\mathrm{Pr}(X=k)$, not $\mathrm{Pr}(X)$ ($X$ is not an event).
- **Self-contained** ➔ values + distribution are all you need.

### 3. Combining
- **Sum** ➔ $\mathrm{Pr}(X+Y=k)=\sum_{i+j=k}\mathrm{Pr}((X=i)\wedge(Y=j))$.
- **Independence** ➔ $\mathrm{Pr}((X=x)\wedge(Y=y))=\mathrm{Pr}(X=x)\mathrm{Pr}(Y=y)$ for **all** $x,y$.

**Key identities:**

$$\mathrm{Pr}(X=k)=\sum_{x:X(x)=k}\mathrm{Pr}(x),\qquad \mathrm{Pr}(X+Y=k)=\sum_{i+j=k}\mathrm{Pr}((X=i)\wedge(Y=j))$$

## ⚖️ Core Decision Matrix
| Object | Has | Note |
| :--- | :--- | :--- |
| event $\{X=k\}$ | a probability | $\mathrm{Pr}(X=k)$ |
| random variable $X$ | a distribution | not one number |
| sum $X+Y$ | a new distribution | convolution |
| independence | per-value product | all $(x,y)$ |

> [!NOTE] **When It Flips:** a sample space breaks outcomes into equiprobable atoms; a random variable extracts a *useful number*, lumping many outcomes (all pairs summing to 9). The distribution of $X+Y$ generally differs from the parts.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** $Z=$ sum of two fair dice — find $\mathrm{Pr}(Z=9)$ and $\mathrm{Pr}(Z=4)$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\mathrm{Pr}(Z=9) &= \tfrac{4}{36}=\tfrac19,\qquad \mathrm{Pr}(Z=4) = \tfrac{3}{36}=\tfrac1{12}
\end{aligned}
$$
**Final Extracted Output:** each = (pairs with that sum)/36; $Z$'s distribution is non-uniform.

## ⚠️ Common Mistakes
- 💡 **Never "$\mathrm{Pr}(X)$"** ➔ $X$ ranges over many values; only events like $\{X=k\}$ have a probability. A variable is never independent of itself.

## 🧠 Active Recall
> [!FAQ]- What is a random variable, and why write $\mathrm{Pr}(X=k)$ rather than $\mathrm{Pr}(X)$?
> - **Hint:** Function, not event.
> > [!SUCCESS]- Answer
> > - **Short answer:** $X:U\to\mathbb R$; "$X=k$" is an event; $X$ has a whole distribution.
> > - **Why:** **Many values** ➔ only events have single probabilities.

> [!FAQ]- How is the distribution of $X+Y$ found, and when are $X,Y$ independent?
> - **Hint:** Convolution + per-value product.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\mathrm{Pr}(X+Y=k)=\sum_{i+j=k}\mathrm{Pr}((X=i)\wedge(Y=j))$; independent iff the product holds for every $(x,y)$.
> > - **Why:** **New distribution** ➔ two uniform dice give a triangular total.
