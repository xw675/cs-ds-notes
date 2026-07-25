---
unit: FIT1058
domain: D
week: 7
parent: "[[Euler Totient Function]]"
tags: [Math/NumberTheory, Math/Discrete]
---
# [[Euler's Theorem and Fermat's Little Theorem]]

**Context:** [[FIT1058_MOC]] · $x^{\phi(n)}\equiv1\pmod n$ for [[Coprimality|coprime]] $x$ · prime case $x^{p-1}\equiv1$ · lets exponents be reduced mod $\phi(n)$

> [!abstract] Quick Revision
> - **🎯 Objective:** $\gcd(x,n)=1\Rightarrow x^{\phi(n)}\equiv1\pmod n$ ➔ FLT is the prime case $x^{p-1}\equiv1$.
> - **📦 Core Components:** Euler ➔ FLT (prime) ➔ reduce exponents mod $\phi(n)$.
> - **⚡ Key Constraint:** requires coprimality; the practical payoff is shrinking exponents in [[Modular Exponentiation]].

## 📝 Core
### 1. The Theorems
- **Euler** ➔ $\gcd(x,n)=1\Rightarrow x^{\phi(n)}\equiv1\pmod n$.
- **FLT** ➔ prime case $n=p$: $x^{p-1}\equiv1\pmod p$ (using $\phi(p)=p-1$).
- **Relationship** ➔ FLT is Euler at a prime modulus.

### 2. Why It Holds
- **$\mathbb Z_n^*$ is a group** ➔ closed, associative, identity 1, [[Modular Inverse|inverses]].
- **Group fact** ➔ any element$^{|\text{group}|}$ = identity ⟹ $x^{\phi(n)}\equiv1$.

### 3. Exponent Reduction
- **Rule** ➔ $x\equiv y\pmod{\phi(n)}\Rightarrow a^x\equiv a^y\pmod n$ (for $\gcd(a,n)=1$).
- **Examples** ➔ $2^9\equiv2^{9\bmod6}=2^3\equiv1\pmod7$; $3^{36}\equiv3^{16}\equiv21\pmod{25}$.

**Key identities:**

$$\gcd(x,n)=1 \Rightarrow x^{\phi(n)}\equiv1\pmod n;\qquad x^{p-1}\equiv1\pmod p\ (p\text{ prime})$$
$$a^m\equiv a^{m\bmod\phi(n)}\pmod n$$

## ⚖️ Core Decision Matrix
| Theorem | Modulus | Exponent | Condition |
| :--- | :--- | :--- | :--- |
| Euler | any $n$ | $\phi(n)$ | $\gcd(x,n)=1$ |
| FLT | prime $p$ | $p-1$ | $p\nmid x$ |
| exponent rule | $n$ | $m\bmod\phi(n)$ | $\gcd(a,n)=1$ |

> [!NOTE] **When It Flips:** the theorem shrinks the exponent in [[Modular Exponentiation]] from $m$ to $m\bmod\phi(n)$, often turning a huge power into a small one — the algebra behind RSA and key-exchange correctness.

## 📊 Exam Execution Trace

### Manual Execution Trace
$3^{100}\bmod7$:

| Step / State | Quantity | Value |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | $\phi(7)$ | 6 |
| 2 | $100\bmod6$ | 4 |
| 3 | $3^4\bmod7$ | 4 |

## ⚠️ Common Mistakes
- 💡 **Coprimality required** ➔ without $\gcd(x,n)=1$ the powers never reach 1 (they get stuck — see [[Primitive Root]]).

## 🧠 Active Recall
> [!FAQ]- State Euler's theorem and FLT, and how one specialises to the other.
> - **Hint:** Group size exponent.
> > [!SUCCESS]- Answer
> > - **Short answer:** Euler: $x^{\phi(n)}\equiv1$ ($\gcd=1$); FLT: $x^{p-1}\equiv1$ ($p$ prime) — Euler at $n=p$.
> > - **Why:** **$\mathbb Z_n^*$ group** ➔ any element to the group size ($\phi(n)$) is the identity.

> [!FAQ]- Use the theorem to simplify $2^9\bmod7$ and give the general exponent rule.
> - **Hint:** Reduce exponent mod $\phi(n)$.
> > [!SUCCESS]- Answer
> > - **Short answer:** $9\bmod6=3$, so $2^9\equiv2^3=8\equiv1\pmod7$; generally $a^x\equiv a^{x\bmod\phi(n)}$.
> > - **Why:** **Workhorse** ➔ replaces a large exponent by a small residue in [[Modular Exponentiation]].
