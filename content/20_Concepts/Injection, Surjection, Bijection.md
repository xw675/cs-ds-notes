---
unit: FIT1058
week: 2
parent: "[[Function (Mathematics)]]"
tags: [Math/Functions, Math/Discrete, Monash/CS_DS]
---
# [[Injection, Surjection, Bijection]]

**Context:** [[FIT1058_MOC]] · classifies a [[Function (Mathematics)|function]] by how it maps to its codomain · controls when an [[Inverse Function]] exists · counted in [[Counting Functions]]

> [!abstract] Quick Revision
> - **🎯 Objective:** restrict how a function maps to its codomain ➔ injective (distinct outputs), surjective (full coverage), bijective (both).
> - **📦 Core Components:** injective = lossless ➔ surjective = image=codomain ➔ bijective = permutation (finite).
> - **⚡ Key Constraint:** on a finite same-set map, injective ⟺ surjective ⟺ bijective (pigeonhole).

## 📝 Core
### 1. The Three Classifications
- **Injective** ➔ $x_1\neq x_2\Rightarrow f(x_1)\neq f(x_2)$ (one-to-one).
- **Surjective** ➔ $\forall y\in B\ \exists x:\ f(x)=y$ ⟹ image = codomain.
- **Bijective** ➔ injective **and** surjective (perfect correspondence).

### 2. Lossless vs Lossy
- **Injective = lossless** ➔ each output traces to one input ➔ reversible (basis of [[Inverse Function]], encryption).
- **Non-injective = lossy** ➔ $x\mapsto x^2$ sends $2,-2\to4$; output can't recover input.

### 3. Domain Restriction
- **$x^3$** ➔ injective on $\mathbb R$; **$x^2$** ➔ not, but injective on $\mathbb R^+_0$.
- **Finite bijection** ➔ a **permutation** (rearrangement).

**Key identities:**

$$\textbf{Injective: } f(x_1)=f(x_2)\Rightarrow x_1=x_2$$
$$\textbf{Surjective: } \forall y\in B\ \exists x\in A:\ f(x)=y \iff \text{Image}(f)=B$$

## ⚖️ Core Decision Matrix
| Map | Injective? | Surjective? | Note |
| :--- | :--- | :--- | :--- |
| $x\mapsto 2x$ on $\mathbb N$ | yes | no (odds skipped) | infinite breaks equivalence |
| $x\mapsto\lfloor x/2\rfloor$ | no ($0,1\mapsto0$) | yes | — |
| $x\mapsto x^2$ on $\mathbb R$ | no | no | lossy |
| finite $f:A\to A$ | inj ⟺ surj ⟺ bij | | pigeonhole |

> [!NOTE] **When It Flips:** for finite $f:A\to A$, injective ⟺ surjective ⟺ bijective — no repeats among $\lvert A\rvert$ outputs fills all $\lvert A\rvert$ slots, and vice versa. Infinite sets have "room" to be one without the other.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Classify $f(x)=2x$ on $\mathbb Z$ and the permutation $g$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
f &: 2x_1=2x_2\Rightarrow x_1=x_2\ (\text{inj}),\ \text{odds unhit}\ (\text{not surj}) \\
g &: \text{outputs distinct + all hit} \Rightarrow \text{bijective}
\end{aligned}
$$
**Final Extracted Output:** (a) injective only; (b) bijective (permutation of a 3-set).

## ⚠️ Common Mistakes
- 💡 **Surjectivity is codomain-relative** ➔ the same rule can be onto a tight codomain but not a larger one; injective ⟹ inverse on the image, bijective ⟹ inverse on the whole codomain.

## 🧠 Active Recall
> [!FAQ]- Give the formal definitions of injective and surjective, and explain "lossless" vs "lossy".
> - **Hint:** Distinct outputs / full image.
> > [!SUCCESS]- Answer
> > - **Short answer:** Injective: $f(x_1)=f(x_2)\Rightarrow x_1=x_2$; surjective: image = codomain.
> > - **Why:** **Recoverability** ➔ injective outputs trace to unique inputs (lossless); $x^2$ loses the sign (lossy).

> [!FAQ]- For a finite same-set function, why are the three notions equivalent, and why does this fail for infinite sets?
> - **Hint:** Pigeonhole vs room.
> > [!SUCCESS]- Answer
> > - **Short answer:** With $\lvert A\rvert$ inputs into $\lvert A\rvert$ slots, no collision ⟺ all slots filled.
> > - **Why:** **Infinite room** ➔ $x\mapsto2x$ on $\mathbb N$ is injective but not surjective.
