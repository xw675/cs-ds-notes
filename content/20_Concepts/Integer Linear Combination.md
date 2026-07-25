---
unit: FIT1058
week: 7
parent: "[[Greatest Common Divisor]]"
tags: [Math/NumberTheory, Math/Discrete]
---
# [[Integer Linear Combination]]

**Context:** [[FIT1058_MOC]] · the values $xm+yn$ with $x,y\in\mathbb Z$ · Bézout: $\gcd$ is the smallest positive one · found by the [[Extended Euclidean Algorithm]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $xm+yn$ for $x,y\in\mathbb Z$ ➔ Bézout: $\gcd$ = smallest positive one.
> - **📦 Core Components:** the set $m\mathbb Z+n\mathbb Z$ ➔ $=\gcd(m,n)\mathbb Z$ ➔ closed under differences.
> - **⚡ Key Constraint:** Bézout guarantees $x,y$ exist; **finding** them needs the [[Extended Euclidean Algorithm]].

## 📝 Core
### 1. The Combinations
- **Definition** ➔ $xm+yn$, integer coefficients, linear (no powers).
- **Set** ➔ $m\mathbb Z+n\mathbb Z=\{xm+yn:x,y\in\mathbb Z\}$.
- **Bézout** ➔ $\gcd(m,n)$ = smallest positive member; $m\mathbb Z+n\mathbb Z=\gcd(m,n)\mathbb Z$.

### 2. Why the GCD
- **Same divisors** ➔ common divisors of $\{m,n\}$ = of the whole set ($(1,0),(0,1)$ recover $m,n$).
- **Generator** ➔ smallest positive $\Delta$ generates and divides the set ⟹ $\Delta=\gcd$.
- **Closure** ➔ differences of combinations are combinations.

### 3. Corollary
- **Coprimality** ➔ $\gcd(m,n)=1\Leftrightarrow 1\in m\mathbb Z+n\mathbb Z$.
- **Non-unique** ➔ adding $(n,-m)$ to $(x,y)$ leaves the value unchanged.

**Key identities:**

$$m\mathbb Z+n\mathbb Z=\gcd(m,n)\,\mathbb Z,\qquad \gcd(m,n)=\min\{xm+yn>0\}$$
$$12\mathbb Z+20\mathbb Z=4\mathbb Z:\ 2\cdot12-1\cdot20=4$$

> [!NOTE] **When It Flips:** the crucial corollary — $\gcd(m,n)=1$ iff some $xm+yn=1$ — is the definition-level link to [[Coprimality]] and [[Modular Inverse|inverses mod $n$]]. Closure under differences underlies $m\mathbb Z+n\mathbb Z=\Delta\mathbb Z$.

## 📊 Exam Execution Trace

### Manual Execution Trace
Combinations of 12, 20:

| Step / State | $(x,y)$ | $12x+20y$ |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | $(2,-1)$ | 4 = gcd |
| 2 | $(-1,1)$ | 8 |
| 3 | $(-5,3)$ | 0 |

## ⚠️ Common Mistakes
- 💡 **Existence ≠ construction** ➔ Bézout guarantees $x,y$; the [[Extended Euclidean Algorithm]] actually finds them, and they are non-unique.

## 🧠 Active Recall
> [!FAQ]- State Bézout's identity and why $\gcd(m,n)$ is the smallest positive $xm+yn$.
> - **Hint:** Shared greatest element.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\gcd(m,n)=\min\{xm+yn>0\}$ and $m\mathbb Z+n\mathbb Z=\gcd\cdot\mathbb Z$.
> > - **Why:** **Same divisors** ➔ $d\mid m,n\Rightarrow d\mid xm+yn$; the least positive combination generates and divides the set.

> [!FAQ]- What is $12\mathbb Z+20\mathbb Z$, and what coprimality corollary follows?
> - **Hint:** Multiples of the gcd.
> > [!SUCCESS]- Answer
> > - **Short answer:** $=4\mathbb Z$ (all multiples of 4); in general $\gcd=1$ iff 1 is a combination.
> > - **Why:** **Coprimality link** ➔ $xm+yn=1$ yields [[Modular Inverse|modular inverses]].
