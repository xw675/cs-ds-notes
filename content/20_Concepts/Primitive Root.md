---
unit: FIT1058
week: 7
parent: "[[Euler's Theorem and Fermat's Little Theorem]]"
tags: [Math/NumberTheory, Math/Discrete]
---
# [[Primitive Root]]

**Context:** [[FIT1058_MOC]] · a generator of $\mathbb Z_n^*$ · powers reach $1$ only at the full exponent $\phi(n)$ · gives the largest range for a [[One-Way Function|one-way function]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $x$ whose powers reach 1 no earlier than $k=\phi(n)$ ➔ a generator of $\mathbb Z_n^*$.
> - **📦 Core Components:** order $\phi(n)$ ➔ powers exhaust $\mathbb Z_n^*$ ➔ $\phi(\phi(n))$ of them.
> - **⚡ Key Constraint:** exists only for $n=1,2,4,p^k,2p^k$; no efficient algorithm to find one.

## 📝 Core
### 1. The Definition
- **Primitive root** ➔ $x^k\not\equiv1\pmod n$ for all $k<\phi(n)$.
- **Generator** ➔ then $x,x^2,\dots,x^{\phi(n)}$ run through **all** of $\mathbb Z_n^*$.
- **Example** ➔ 3 mod 7 gives $3,2,6,4,5,1$ (all six); 2 gives $2,4,1,\dots$ (only $\{1,2,4\}$, not primitive).

### 2. Existence
- **Theorem** ➔ primitive roots exist exactly for $n=1,2,4,p^k,2p^k$ ($p$ odd prime).
- **No root** ➔ 8 has none ($\mathbb Z_8^*$ each squares to 1).
- **Must be in $\mathbb Z_n^*$** ➔ non-units' powers hit 0 and stick.

### 3. Count & Difficulty
- **How many** ➔ exactly $\phi(\phi(n))$ if any exist.
- **Finding** ➔ no known polynomial-time algorithm.

**Key identities:**

$$x \text{ primitive} \iff x^k\not\equiv1\pmod n \text{ for } k<\phi(n)$$
$$3 \bmod 7:\ 3,2,6,4,5,1\ (\text{first }1\text{ at }k=6=\phi(7)) \Rightarrow \text{primitive}$$

## ⚖️ Core Decision Matrix
| $n$ | Primitive root? | Reason |
| :--- | :--- | :--- |
| prime $p$ | yes | $\phi(p)=p-1$, maximal |
| $p^k, 2p^k$ | yes | characterisation |
| 8 ($=2^3$) | no | excluded form |
| count | $\phi(\phi(n))$ | if any exist |

> [!NOTE] **When It Flips:** a primitive root's powers cover *all* of $\mathbb Z_n^*$ — the widest spread — making $x\mapsto a^x$ hardest to invert, so a primitive root of a large prime is chosen for the [[One-Way Function]] behind [[Diffie-Hellman Key Agreement]].

## 📊 Exam Execution Trace

### Manual Execution Trace
Powers of 2 mod 11 ($\phi=10$):

| Step / State | $k$ | $2^k\bmod11$ |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | 1–5 | 2,4,8,5,10 |
| 2 | 6–10 | 9,7,3,6,1 |
| 3 | first 1 | $k=10=\phi(11)$ |

## ⚠️ Common Mistakes
- 💡 **Existence restricted** ➔ only $n=1,2,4,p^k,2p^k$ have primitive roots; 8 does not (all of $\mathbb Z_8^*$ have order $\le2<4$).

## 🧠 Active Recall
> [!FAQ]- Define a primitive root and verify 3 is one mod 7 but 2 is not.
> - **Hint:** Order = $\phi(n)$.
> > [!SUCCESS]- Answer
> > - **Short answer:** Powers reach 1 only at $k=\phi(n)$; $3\bmod7$ gives all six, $2$ hits 1 at $k=3<6$.
> > - **Why:** **Generator** ➔ 3's powers exhaust $\mathbb Z_7^*$; 2's cover only $\{1,2,4\}$.

> [!FAQ]- Why does 8 have no primitive root, and why are primitive roots wanted in cryptography?
> - **Hint:** Existence form + max range.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\mathbb Z_8^*$ each square to 1 (order $\le2<4$); only $1,2,4,p^k,2p^k$ have roots.
> > - **Why:** **Widest spread** ➔ powers span all of $\mathbb Z_n^*$, making $a^x$ hardest to invert.
