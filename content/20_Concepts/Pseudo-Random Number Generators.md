---
unit: FIT2086
week: 10
source: [lecture]
domain: D
parent: "[[Monte Carlo Simulation (Empirical Probabilities)]]"
tags: [Math/Probability, Tool/R]
aliases: [PRNG, pseudo-random numbers, pseudo-random number generator, random seed, seed, linear congruential generator, LCG, Mersenne Twister, reproducible simulation]
---
# [[Pseudo-Random Number Generators]]

**Context:** [[FIT2086_MOC]] · the engine under every [[Monte Carlo Simulation (Empirical Probabilities)|simulation]], [[Bootstrap]] and [[Permutation Tests|permutation test]] · R usage (`set.seed`, `runif`, `rnorm`) ➔ [[R Simulation and Random Sampling]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a deterministic recurrence $X_n\leftarrow f(X_{n-1},\dots,X_0)$ whose output **resembles** iid uniforms ➔ the seed fixes the whole sequence ➔ simulations become **exactly repeatable**.
> - **⚡ Key Constraint:** same seed + same generator ⟹ identical sequence — the advantage (reproducibility) and the disadvantage (good seeding is crucial) are the same fact.

## 📝 Core
- **Why "pseudo"** ➔ a computer is fully deterministic ⟹ no true randomness; a PRNG's sequence is **completely determined** by the process and its **state**, yet is designed to have the statistical properties of **independent** random numbers.
- **Recurrence** ➔ $X_n\leftarrow f(X_{n-1},X_{n-2},\dots,X_0)$, $f$ = transition function; the initial $X_0$ = **seed** (usually the current time, sometimes a "true" random source).
- **Uniforms first** ➔ the primitive output is $U\sim\text{Uniform}(0,1)$, $p(x)=1$ on $(0,1)$; every other distribution is built **from uniforms**.
- **Modern generator** ➔ SIMD-oriented Fast Mersenne Twister: fast, period up to $2^{216091}-1$ before repeating; R's default generator is the Mersenne Twister.
- **Other distributions** ➔ inverse-CDF procedure · Metropolis–Hastings · accept–reject · adaptive rejection sampling · slice sampling (named only) ➔ in practice call `rnorm()`, `rpois()`, `rexp()`.
- **LCG (teaching example)** ➔ $X_{n+1}=(aX_n+c)\bmod m$ — the current value alone determines the next ⟹ the first repeated value starts a **cycle**.

## 📊 Exam Execution Trace
LCG with seed $X_0=7$, $a=5$, $c=3$, $m=10$:

| $n$ | $X_n$ | $aX_n+c$ | $X_{n+1}=(aX_n+c)\bmod 10$ |
| :--- | :--- | :--- | :--- |
| $0$ | $7$ | $38$ | $8$ |
| $1$ | $8$ | $43$ | $3$ |
| $2$ | $3$ | $18$ | $8$ |
| $3$ | $8$ | $43$ | $3$ |

- **Output** ➔ $7\to8\to3\to8\to3\to\cdots$ ⟹ a repeating cycle of length $2$ — a toy period; a usable generator needs an astronomically long one.
- **R reproducibility** ➔ `set.seed(5); runif(n = 10, min = 0, max = 1)` run twice prints the **same** ten numbers; a different seed gives a different sequence.

## ⚠️ Common Mistakes
- 💡 **"Random" output called truly random** ➔ it is deterministic given the seed; that is exactly what makes a simulation repeatable.
- 💡 **Re-seeding only once** ➔ one `set.seed()` fixes the starting state; the generator advances with every draw, so a later block differs unless re-seeded ([[R Simulation and Random Sampling]]).

## 🧠 Active Recall
> [!FAQ]- Why is "same seed ⟹ same sequence" both an advantage and a disadvantage?
> > [!SUCCESS]- Answer
> > - **Short answer:** advantage — any simulation can be re-run exactly (debugging, marking, reporting); disadvantage — a poor or reused seed reproduces the same "random" numbers, so seeding must be done well.
> > - **Why:** **Deterministic recurrence** ➔ $X_n=f(X_{n-1},\dots,X_0)$ makes the whole stream a function of $X_0$.

> [!FAQ]- An LCG uses modulus $m=10$. What is the longest sequence it can produce before repeating?
> > [!SUCCESS]- Answer
> > - **Short answer:** at most $10$ distinct values — then it must cycle (the $a=5,c=3$, seed $7$ example cycles after just $2$).
> > - **Why:** **Finite state** ➔ $X_{n+1}$ depends only on $X_n\in\{0,\dots,9\}$, so the first repeated value replays the same continuation forever.
