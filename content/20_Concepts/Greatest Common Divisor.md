---
unit: FIT1058
week: 7
parent: "[[Divisibility]]"
tags: [Math/NumberTheory, Math/Discrete, Monash/CS_DS]
---
# [[Greatest Common Divisor]]

**Context:** [[FIT1058_MOC]] · the largest integer dividing both $a$ and $b$ · reduced via $\gcd(a,b)=\gcd(b,a-b)$ · computed by the [[Euclidean Algorithm]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $\gcd(a,b)$ = greatest $d$ with $d\mid a$ and $d\mid b$ ➔ symmetric, computable by reduction.
> - **📦 Core Components:** easy cases ➔ reduction $\gcd(a,b)=\gcd(b,a-b)$ ➔ smallest positive $xa+yb$.
> - **⚡ Key Constraint:** reduction preserves common divisors, driving numbers down to a base case.

## 📝 Core
### 1. The GCD
- **Definition** ➔ greatest $d$ with $d\mid a$ **and** $d\mid b$; symmetric $\gcd(a,b)=\gcd(b,a)$.
- **Easy cases** ➔ $\gcd(a,1)=1$; $b\mid a\Rightarrow\gcd(a,b)=b$; $\gcd(a,p)=p$ if $p\mid a$ else 1.

### 2. Reduction Theorem
- **Identity** ➔ $\gcd(a,b)=\gcd(b,a-b)$.
- **Why** ➔ $(a,b)$ and $(b,a-b)$ share the **same** common divisors ($d\mid a,b\Rightarrow d\mid(a-b)$).
- **Drive down** ➔ repeatedly subtract the smaller to reach an easy base case.

### 3. Linear-Combination Characterisation
- **Bézout** ➔ $\gcd(a,b)$ = smallest positive [[Integer Linear Combination|$xa+yb$]].
- **Bridge** ➔ to [[Coprimality]] ($\gcd=1$) and [[Modular Inverse|modular inverses]].

**Key identities:**

$$\gcd(a,b)=\gcd(b,\,a-b)$$
$$\gcd(20,12)=\gcd(12,8)=\gcd(8,4)=4\ (4\mid8)$$

> [!NOTE] **When It Flips:** $\gcd(a,b)$ is also the **smallest positive** $xa+yb$ — the bridge to coprimality and modular inverses. Order is irrelevant to the value but convenient (larger first) for the algorithm.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Compute $\gcd(20,12)$ using the reduction.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\gcd(20,12) &= \gcd(12,8) = \gcd(8,4) = 4\ (4\mid8)
\end{aligned}
$$
**Final Extracted Output:** $\gcd(20,12)=4$; each step preserves the common divisors.

## ⚠️ Common Mistakes
- 💡 **Subtraction = slow mod** ➔ repeatedly subtracting $b$ until $<b$ computes $a\bmod b$; one $\bmod$ replaces many subtractions (the Euclidean speed-up).

## 🧠 Active Recall
> [!FAQ]- State and justify $\gcd(a,b)=\gcd(b,a-b)$, and use it for $\gcd(20,12)$.
> - **Hint:** Same common divisors.
> > [!SUCCESS]- Answer
> > - **Short answer:** $d\mid a,b\Rightarrow d\mid(a-b)$ and conversely, so the two pairs share divisors; $\gcd(20,12)=\gcd(12,8)=\gcd(8,4)=4$.
> > - **Why:** **Identical divisor sets** ➔ same maximum.

> [!FAQ]- Give three quick gcd cases and the deeper linear-combination characterisation.
> - **Hint:** Bézout.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\gcd(a,1)=1$; $b\mid a\Rightarrow b$; $\gcd(a,p)=p$ or 1; and $\gcd$ = smallest positive $xa+yb$.
> > - **Why:** **Coprimality** ➔ $\gcd=1$ characterises coprime pairs and inverses mod $n$.
