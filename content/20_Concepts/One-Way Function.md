---
unit: FIT1058
domain: [D, F]
week: 7
parent: "[[Modular Exponentiation]]"
tags: [Math/NumberTheory, CS/Cryptography]
---
# [[One-Way Function]]

**Context:** [[FIT1058_MOC]] · easy to compute, hard to invert · modular-exp-with-fixed-base and its inverse, the Discrete Logarithm · used for password storage and [[Diffie-Hellman Key Agreement|key exchange]]

> [!abstract] Quick Revision
> - **🎯 Objective:** easy to compute, hard to invert "usually" ➔ candidate: $x\mapsto a^x\bmod n$.
> - **📦 Core Components:** easy forward ([[Modular Exponentiation]]) ➔ hard inverse (Discrete Log).
> - **⚡ Key Constraint:** believed to exist, **none proven**; security rests on assumed hardness.

## 📝 Core
### 1. One-Wayness
- **Definition** ➔ easy to compute, hard to invert "usually".
- **Status** ➔ believed to exist; none proven (proving one would settle a major open problem).
- **Candidate** ➔ modular exponentiation with fixed base $a<n$: $x\mapsto a^x\bmod n$.

### 2. The Hard Inverse
- **Discrete Logarithm** ➔ given $y$, find $x$ with $a^x\equiv y$ ($x=\log_a y$).
- **Primitive-root base** ➔ powers cover all of $\mathbb Z_n^*$ ⟹ largest search space.
- **Hardness** ➔ no known fast algorithm, comparable to factorisation.

### 3. Application
- **Password storage** ➔ store $(U_i,f(P_i))$; accept if $f(P)=f(P_i)$.
- **Not encryption** ➔ no key, no intended recipient recovering $P_i$.

**Key identities:**

$$\text{forward: } x\mapsto a^x\bmod n\ (\text{easy, square-and-multiply})$$
$$\text{inverse: } \text{given } y, \text{ find } x=\log_a y\ (\text{Discrete Log, believed hard})$$

## ⚖️ Core Decision Matrix
| Direction | Problem | Difficulty |
| :--- | :--- | :--- |
| forward | $a^x\bmod n$ | easy ($O(\log x)$) |
| inverse | discrete log | believed hard |
| base choice | primitive root | maximises search |
| modulus | large prime | $\phi(p)=p-1$ largest |

> [!NOTE] **When It Flips:** the asymmetry (cheap forward, infeasible backward) is the whole point — protecting information that must stay quickly verifiable. Password hashing is keyless (no recipient recovers $P_i$), unlike a [[Cryptosystem]].

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Solve the discrete log $2^x\equiv6\pmod{11}$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
2^x\bmod11 &= 2,4,8,5,10,9,7,3,6,1 \\
2^x\equiv6 &\Rightarrow x=9\ (\log_2 6=9)
\end{aligned}
$$
**Final Extracted Output:** forward is one squaring chain; inverting needs a table search giving $x=9$ — infeasible for a large prime.

## ⚠️ Common Mistakes
- 💡 **Belief, not proof** ➔ security rests on the *assumed* hardness of Discrete Log/factorisation; a fast algorithm would break these schemes.

## 🧠 Active Recall
> [!FAQ]- What makes a function one-way, and why is modular exponentiation with a primitive-root base a candidate?
> - **Hint:** Easy/hard asymmetry.
> > [!SUCCESS]- Answer
> > - **Short answer:** Easy forward, hard inverse; $a^x\bmod n$ easy but discrete log believed hard.
> > - **Why:** **Primitive root** ➔ powers cover all of $\mathbb Z_n^*$, maximising the search space.

> [!FAQ]- How do one-way functions make password storage safer, and why is it not encryption?
> - **Hint:** Store the hash, not the password.
> > [!SUCCESS]- Answer
> > - **Short answer:** Store $f(P_i)$; verify $f(P)=f(P_i)$; stealing $f(P_i)$ needs inverting $f$ (infeasible).
> > - **Why:** **No key/recipient** ➔ $f$ is a fixed non-invertible transform, not a reversible cipher.
