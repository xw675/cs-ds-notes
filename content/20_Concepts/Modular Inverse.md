---
unit: FIT1058
week: 7
parent: "[[Modular Arithmetic]]"
tags: [Math/NumberTheory, Math/Discrete, Monash/CS_DS]
---
# [[Modular Inverse]]

**Context:** [[FIT1058_MOC]] · division in $\mathbb Z_n$ · $x^{-1}$ exists iff $x$ is [[Coprimality|coprime]] to $n$ · found via the [[Extended Euclidean Algorithm]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $x^{-1}$ with $x\,x^{-1}\equiv1\pmod n$ ➔ division in $\mathbb Z_n$ = multiply by the inverse.
> - **📦 Core Components:** exists iff $\gcd(x,n)=1$ ➔ $\mathbb Z_n^*$ ➔ computed by [[Extended Euclidean Algorithm]].
> - **⚡ Key Constraint:** prime modulus ⟹ every nonzero element invertible (a field).

## 📝 Core
### 1. The Inverse
- **Definition** ➔ $x^{-1}$ with $x\,x^{-1}\equiv1\pmod n$ — the modular reciprocal.
- **Division** ➔ dividing means multiplying by the inverse.
- **Examples** ➔ $\mathbb Z_7$: $2^{-1}=4$; $\mathbb Z_6$: only $1,5$ invertible.

### 2. Existence Theorem
- **Iff coprime** ➔ $x$ invertible in $\mathbb Z_n\Leftrightarrow\gcd(x,n)=1$.
- **Forward** ➔ $x\,x^{-1}+kn=1$ ⟹ Bézout ⟹ coprime.
- **Backward** ➔ coprime ⟹ $yx+zn=1$ ⟹ $x^{-1}=y\bmod n$.

### 3. Computing It
- **Method** ➔ run [[Extended Euclidean Algorithm]] on $x,n$; if $\gcd=1$, inverse $=y\bmod n$.
- **Sets** ➔ $\mathbb Z_6^*=\{1,5\}$, $\mathbb Z_7^*=\{1,\dots,6\}$.

## ⚖️ Core Decision Matrix
| Element | Invertible in $\mathbb Z_n$? | Reason |
| :--- | :--- | :--- |
| $0$ | never | $\gcd(0,n)=n$ |
| $1$ | always (self) | $\gcd=1$ |
| $x$, $\gcd(x,n)=1$ | yes | Bézout |
| $x$ sharing a factor | no | $\gcd>1$ |

> [!NOTE] **When It Flips:** invertibility is governed entirely by [[Coprimality]] with $n$; $\lvert\mathbb Z_n^*\rvert=\phi(n)$ ([[Euler Totient Function]]). The inverse, when it exists, is unique in $\mathbb Z_n$.

## 📊 Exam Execution Trace

### Manual Execution Trace
$3^{-1}$ in $\mathbb Z_7$:

| Step / State | $z$ | $3z\bmod7$ | Inverse? |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | 1 | 3 | no |
| 2 | 3 | 2 | no |
| 3 | 5 | 1 | **yes** |

## ⚠️ Common Mistakes
- 💡 **$0$ never invertible, prime modulus special** ➔ if $n=p$ prime, every nonzero element is coprime to $p$ ⟹ all invertible ($\mathbb Z_p^*=\{1,\dots,p-1\}$, a field); composite $n$ leaves some elements non-invertible.

## 🧠 Active Recall
> [!FAQ]- For which $x$ does an inverse exist in $\mathbb Z_n$, and why does $\mathbb Z_6$ lack one for 2 while $\mathbb Z_7$ has one for every nonzero element?
> - **Hint:** Coprimality condition.
> > [!SUCCESS]- Answer
> > - **Short answer:** Invertible iff $\gcd(x,n)=1$; $\gcd(2,6)=2$ (none), but every nonzero mod 7 is coprime.
> > - **Why:** **Prime field** ➔ $\mathbb Z_p^*=\{1,\dots,p-1\}$.

> [!FAQ]- How do you actually compute $x^{-1}$ in $\mathbb Z_n$?
> - **Hint:** Extended Euclid.
> > [!SUCCESS]- Answer
> > - **Short answer:** Run EEA on $x,n$; if $\gcd=1$ it gives $yx+zn=1$, so $x^{-1}=y\bmod n$.
> > - **Why:** **Constructive Bézout** ➔ turns the existence proof into an algorithm.
