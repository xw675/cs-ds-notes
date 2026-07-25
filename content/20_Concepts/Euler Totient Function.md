---
unit: FIT1058
domain: D
week: 7
parent: "[[Coprimality]]"
tags: [Math/NumberTheory, Math/Discrete]
---
# [[Euler Totient Function]]

**Context:** [[FIT1058_MOC]] · $\phi(n)=$ count of integers in $[1,n)$ [[Coprimality|coprime]] to $n$ · $=|\mathbb Z_n^*|$ · multiplicative, computed from the [[Prime Number|prime factorisation]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $\phi(n)$ counts integers in $[1,n)$ coprime to $n$ ➔ $=\lvert\mathbb Z_n^*\rvert$, the invertible elements.
> - **📦 Core Components:** $\phi(p)=p-1$ ➔ $\phi(p^m)=p^{m-1}(p-1)$ ➔ multiplicative.
> - **⚡ Key Constraint:** easy *with* the factorisation, as hard as factoring *without* it.

## 📝 Core
### 1. The Function
- **Definition** ➔ $\phi(n)=\lvert\{x:0<x<n,\gcd(x,n)=1\}\rvert=\lvert\mathbb Z_n^*\rvert$.
- **Meaning** ➔ the count of elements of $\mathbb Z_n$ with a [[Modular Inverse]].
- **Examples** ➔ $\phi(6)=2$ ($\{1,5\}$), $\phi(7)=6$.

### 2. The Three Rules
- **Primes** ➔ $\phi(p)=p-1$ (max, attained iff $n$ prime).
- **Prime powers** ➔ $\phi(p^m)=p^{m-1}(p-1)$.
- **Multiplicative** ➔ $\gcd(a,b)=1\Rightarrow\phi(ab)=\phi(a)\phi(b)$ ($n=pq\Rightarrow(p-1)(q-1)$, RSA).

### 3. Product Formula
- **From factorisation** ➔ $\phi(n)=n\prod_{p\mid n}(1-\tfrac1p)$ over distinct primes.

**Key identities:**

$$\phi(p)=p-1,\quad \phi(p^m)=p^{m-1}(p-1),\quad \phi(ab)=\phi(a)\phi(b)\ (\gcd(a,b)=1)$$
$$\phi(150)=150(1-\tfrac12)(1-\tfrac13)(1-\tfrac15)=40$$

## ⚖️ Core Decision Matrix
| $n$ | $\phi(n)$ | Note |
| :--- | :--- | :--- |
| prime $p$ | $p-1$ | maximum |
| $p^m$ | $p^{m-1}(p-1)$ | prime power |
| $pq$ (distinct) | $(p-1)(q-1)$ | RSA |
| general | $n\prod(1-\tfrac1p)$ | from factorisation |

> [!NOTE] **When It Flips:** $\phi(n)=\lvert\mathbb Z_n^*\rvert$ is the size of the multiplicative group — the exponent in [[Euler's Theorem and Fermat's Little Theorem|Euler's theorem]] and the order of a [[Primitive Root|generator]]. Easy given the factorisation, hard without — the asymmetry RSA rests on.

## 📊 Exam Execution Trace

### Manual Execution Trace
$\phi(360)$, $360=2^3\cdot3^2\cdot5$:

| Step / State | Prime power | $\phi(p^k)=p^{k-1}(p-1)$ |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | $2^3$ | $4$ |
| 2 | $3^2$ | $6$ |
| 3 | $5$ | $4$ |

## ⚠️ Common Mistakes
- 💡 **"Multiplicative" needs coprimality** ➔ $\phi(ab)=\phi(a)\phi(b)$ only when $\gcd(a,b)=1$, not for all $a,b$; the product ranges over *distinct* primes.

## 🧠 Active Recall
> [!FAQ]- State the three rules for $\phi$ and compute $\phi(150)$.
> - **Hint:** Prime power + multiplicativity.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\phi(p)=p-1$, $\phi(p^m)=p^{m-1}(p-1)$, multiplicative; $\phi(150)=1\cdot2\cdot20=40$.
> > - **Why:** **Product formula** ➔ $150(1-\tfrac12)(1-\tfrac13)(1-\tfrac15)=40$.

> [!FAQ]- Why is $\phi(n)$ easy given the factorisation but believed hard in general?
> - **Hint:** Factoring-hard.
> > [!SUCCESS]- Answer
> > - **Short answer:** The rules assemble $\phi$ from the prime factorisation; without it, computing $\phi(n)$ is as hard as factoring.
> > - **Why:** **Crypto asymmetry** ➔ the legitimate party knows the factors, an attacker does not.
