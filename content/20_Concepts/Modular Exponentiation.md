---
unit: FIT1058
week: 7
parent: "[[Modular Arithmetic]]"
tags: [Math/NumberTheory, CS/Algorithms, Monash/CS_DS]
---
# [[Modular Exponentiation]]

**Context:** [[FIT1058_MOC]] · computing $a^m\bmod n$ fast · square-and-multiply via binary exponent · exponent reduced by [[Euler's Theorem and Fermat's Little Theorem|Euler's theorem]]

> [!abstract] Quick Revision
> - **🎯 Objective:** compute $a^m\bmod n$ efficiently ➔ square-and-multiply, $O(\log m)$ multiplications.
> - **📦 Core Components:** binary exponent ➔ reduce mod $n$ each step ➔ reduce exponent mod $\phi(n)$.
> - **⚡ Key Constraint:** easy forward, discrete-log inverse is hard — the [[One-Way Function]] basis.

## 📝 Core
### 1. Fast Exponentiation
- **Naïve** ➔ $m-1$ multiplications.
- **Square-and-multiply** ➔ write $m$ in binary, repeatedly square ⟹ $O(\log m)$.
- **Bound** ➔ at most $2\lfloor\log_2 m\rfloor$ multiplications.

### 2. Three Savings
- **Fewer multiplications** ➔ squaring cuts $m-1\to O(\log m)$.
- **Small factors** ➔ reduce mod $n$ each step.
- **Smaller exponent** ➔ $a^m\equiv a^{m\bmod\phi(n)}$ if $\gcd(a,n)=1$ ([[Euler's Theorem and Fermat's Little Theorem]]).

### 3. One-Wayness
- **Easy** ➔ modular exponentiation.
- **Hard** ➔ inverting it (discrete logarithm) ➔ powers [[Diffie-Hellman Key Agreement]].

**Key identities:**

$$36=2^5+2^2 \Rightarrow 3^{36}=3^{32}\cdot3^4$$
$$3^2{=}9,\ 9^2\equiv6,\ 6^2\equiv11,\ 11^2\equiv21\pmod{25};\quad \phi(25)=20\Rightarrow 3^{36}\equiv3^{16}\equiv21$$

## ⚖️ Core Decision Matrix
| Trick | Effect | Cost |
| :--- | :--- | :--- |
| square-and-multiply | $m-1\to O(\log m)$ mults | binary exponent |
| reduce mod $n$ | keep factors $<n$ | per step |
| reduce exp mod $\phi(n)$ | shrink $m$ | needs $\gcd(a,n)=1$ |

> [!NOTE] **When It Flips:** three independent savings — fewer multiplications, smaller products, smaller exponent. Modular exponentiation is the workhorse of public-key cryptography precisely because it is easy forward but hard to invert (discrete log).

## 📊 Exam Execution Trace

### Manual Execution Trace
$7^{13}\bmod11$, $13=(1101)_2$:

| Step / State | Power | Value mod 11 |
| :--- | :--- | :--- |
| **0 (Init)** | $7^1$ | 7 |
| 1 | $7^2$ | 5 |
| 2 | $7^4$ | 3 |
| 3 | $7^8$ | 9 |

## ⚠️ Common Mistakes
- 💡 **Exponent reduction needs coprimality** ➔ $a^m\equiv a^{m\bmod\phi(n)}$ requires $\gcd(a,n)=1$; without it the shortcut can fail. Reduce mod $n$ at *every* step to keep numbers small.

## 🧠 Active Recall
> [!FAQ]- How does square-and-multiply compute $3^{36}$ in 6 multiplications, and the general bound?
> - **Hint:** Binary exponent.
> > [!SUCCESS]- Answer
> > - **Short answer:** $36=2^5+2^2$; five squarings ($3^2,\dots,3^{32}$) + one multiply, vs 35 naïvely.
> > - **Why:** **$O(\log m)$** ➔ at most $2\lfloor\log_2 m\rfloor$ multiplications.

> [!FAQ]- Give the two further tricks for $a^m\bmod n$ using $3^{36}\bmod25$.
> - **Hint:** Reduce products and exponent.
> > [!SUCCESS]- Answer
> > - **Short answer:** Reduce each product mod 25; reduce exponent mod $\phi(25)=20$ ⟹ $3^{36}\equiv3^{16}\equiv21$.
> > - **Why:** **Coprimality** ➔ exponent reduction valid since $\gcd(3,25)=1$.
