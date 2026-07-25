---
unit: FIT1058
parent: "[[FIT1058_MOC]]"
tags: [Math/Discrete, Math/Logic, Math/Probability]
type: cheatsheet
aliases: [FIT1058 Exam Crib, Discrete Maths Cheatsheet]
---
# [[FIT1058 Unit Cheatsheet]]

**Context:** [[FIT1058_MOC]] · the WHOLE unit in one re-read — logic → sets/functions → proofs → counting → probability → number theory/crypto → graphs. Every claim is a hand-derivable formula or rule; links for depth only.

> [!abstract] Quick Revision
> - **🎯 Objective:** match the claim's logical SHAPE to a formula or proof blueprint ➔ derive in $\begin{aligned}$ blocks, seal with Q.E.D.
> - **⚡ Key Constraint:** hypothesis discipline — every rule here has a precondition (disjointness, independence, coprimality, connectedness); marks die when a rule fires without its hypothesis.

## 1️⃣ Logic
- **Proposition** ➔ exactly one truth value (bivalence); questions/commands/self-reference are NOT propositions.
- **Connectives** ➔ truth-table-defined; $\oplus$ differs from $\vee$ only on the both-true row; $P \Rightarrow Q$ forbids exactly one case (true→false) and is **non-symmetric** — the converse never follows.
- **[[Boolean Algebra Laws]]** ➔ commutative/associative/idempotent/complement/identity/null/absorption/**two distributive**/De Morgan; identical to set algebra under $\wedge{\leftrightarrow}\cap$, $\vee{\leftrightarrow}\cup$, $\neg{\leftrightarrow}$ complement.
- **Normal forms** ➔ DNF = OR of AND-terms, read off truth-table 1-rows, up to $2^k$ terms, trivial satisfiability · CNF = AND of OR-clauses, De Morgan-dual, natural target for rule modelling and SAT.
- **Universality** ➔ NAND alone or NOR alone suffice; $\neg$ alone and $\{\wedge,\vee\}$ do NOT.
- **Quantifiers** ➔ $\exists$ = one witness proves it; $\forall$ = every case; **restriction pairs $\exists$ with $\wedge$, $\forall$ with $\Rightarrow$**. Negation flips $\exists \leftrightarrow \forall$ through EVERY quantifier, then De Morgans the body. Mixed order: $\exists\forall \Rightarrow \forall\exists$, never conversely.
- **Modus ponens** ➔ from $P$ and $P{\Rightarrow}Q$ deduce $Q$; deducing $P$ from $Q$ is the converse fallacy.

## 2️⃣ Sets, Relations, Functions
- **Set** ➔ unordered, duplicate-free, membership-determined; $|\mathcal P(A)| = 2^{|A|}$; $|A \times B| = |A||B|$ (Cartesian product not commutative); $A^0 = \{\varepsilon\} \neq \emptyset$, $A^*$ infinite.
- **Operations** ➔ $|A \cup B| = |A| + |B| - |A \cap B|$ — never blindly additive; $B \setminus A \neq A \setminus B$; $\subseteq$ is a partial order.
- **Relations** ➔ $R \subseteq A \times B$; reflexive + symmetric + transitive = **equivalence** ⟺ [[Set Partition]] (Bell numbers $B_n$); antisymmetric instead ⟹ partial order.
- **Function** ➔ total + single-valued; **injective** (distinct outputs) / **surjective** (image = codomain) / **bijective** (both ⟺ inverse exists). Finite same-set map: injective ⟺ surjective ⟺ bijective (pigeonhole).
- **Composition** ➔ $(g \circ f)(x) = g(f(x))$, not commutative; $(g \circ f)^{-1} = f^{-1} \circ g^{-1}$ (order reverses).
- **Counting maps** $|A|{=}m, |B|{=}n$ ➔ all: $n^m$ · injective: $n(n{-}1)\cdots(n{-}m{+}1)$, zero if $m{>}n$ · surjective: inclusion–exclusion.

## 3️⃣ Proofs & Induction
- **Blueprint menu** ➔ construction (one witness, proves $\exists$ **never** $\forall$) · cases (finite partition) · contradiction · symbolic manipulation · induction.
- **[[Mathematical Induction]]** ➔ BOTH obligations: basis $S(1)$ + step $S(k) \Rightarrow S(k{+}1)$; no basis ⟹ chain never starts. Strong induction assumes all of $S(1..k)$.
- **Theorem/proof discipline** ➔ finite, sequentially readable, no circular dependence; no general proof-finding algorithm exists (Gödel, Church–Turing).

## 4️⃣ Sequences & Series
$$
\begin{aligned}
\text{arithmetic: } S_n &= na + \tfrac{n(n-1)}{2}d, \qquad \textstyle\sum_{k=1}^{n-1} k = \tfrac{n(n-1)}{2} = \Theta(n^2)\\
\text{geometric: } S_n &= a\,\tfrac{r^n - 1}{r - 1}\ (r \neq 1), \qquad \text{converges iff } |r| < 1\\
\text{Fibonacci: } f_n &= \Theta(r_1^n),\ r_1 = \tfrac{1+\sqrt5}{2} \text{ (root of } r^2 = r + 1)
\end{aligned}
$$
- **Limit** ➔ $\forall\varepsilon\,\exists N\,\forall n{>}N: |a_n - \ell| < \varepsilon$ — quantifier ORDER is the content ("eventually", not "always").
- **[[Big-O Notation]]** ➔ dominant term, drop constants; $\Theta = O \cap \Omega$; polynomial vs exponential = tractability frontier.

## 5️⃣ Combinatorics
| Selection of $r$ from $n$ | Ordered | Unordered |
| :-- | :-- | :-- |
| with replacement | $n^r$ | stars & bars: $\binom{n+r-1}{r}$ |
| without replacement | $\frac{n!}{(n-r)!}$ | $\binom{n}{r}$ |

- **Add vs multiply** ➔ disjoint alternatives ADD, independent stages MULTIPLY — each rule's hypothesis (overlap breaks addition, dependence breaks multiplication) is what's examined.
- **Inclusion–exclusion** ➔ alternating signed sum over all $2^n - 1$ intersections; disjoint case collapses to addition.
- **Binomial identities** ➔ $\sum_k \binom{n}{k} = 2^n$ (power-set layers); pigeonhole kills injections when $m > n$.

## 6️⃣ Probability
- **Foundations** ➔ $\mathrm{Pr}(A) = \sum_{x \in A}\mathrm{Pr}(x)$; $|A|/|U|$ needs **finite AND uniform**; complement is the workhorse shortcut.
- **Conditional** ➔ $\mathrm{Pr}(A \mid B) = \frac{\mathrm{Pr}(A \cap B)}{\mathrm{Pr}(B)}$, needs $\mathrm{Pr}(B) > 0$; independence ⟺ $\mathrm{Pr}(A \mid B) = \mathrm{Pr}(A)$ ⟺ $\mathrm{Pr}(A \cap B) = \mathrm{Pr}(A)\mathrm{Pr}(B)$.
- **Mutually exclusive ≠ independent** ➔ disjoint positive-probability events are DEPENDENT.
- **Total probability + Bayes** ➔ partition $U = \bigsqcup A_i$ ⟹ $\mathrm{Pr}(B) = \sum_i \mathrm{Pr}(B \mid A_i)\mathrm{Pr}(A_i)$; then $\mathrm{Pr}(A \mid B) = \frac{\mathrm{Pr}(B \mid A)\mathrm{Pr}(A)}{\mathrm{Pr}(B)}$ — confusing the two directions is the base-rate fallacy.
- **Expectation & variance** ➔ $E(X) = \sum_k k\,\mathrm{Pr}(X{=}k)$; **linearity always** ($E(X{+}Y) = E(X) + E(Y)$, no independence needed); $E(XY) = E(X)E(Y)$ and $\mathrm{Var}(X{+}Y) = \mathrm{Var}(X) + \mathrm{Var}(Y)$ **only if independent**; $\mathrm{Var}(X) = E(X^2) - E(X)^2$.

| Distribution | pmf | Signature situation |
| :-- | :-- | :-- |
| Uniform on $[a,b]$ | $\frac{1}{b-a+1}$ | fairness or pure ignorance |
| Binomial $(n,p)$ | $\binom{n}{k}p^k(1-p)^{n-k}$ | $n$ i.i.d. Bernoulli — use the **indicator-sum trick**, $E = np$ |
| Geometric $(p)$ | $(1-p)^{k-1}p$ | trials to first success; **memoryless** (refutes "law of averages") |
| Poisson $(\mu)$ | $e^{-\mu}\mu^k/k!$ | rare events; approximates $\mathrm{Bin}(n,p)$, $\mu = np$ |

- **Coupon collector** ➔ $E(Z) = nH_n \approx n\ln n$ — the LAST coupons dominate.

## 7️⃣ Number Theory & Cryptography
- **Division** ➔ $n = qd + r$, $0 \le r \le d{-}1$; negative $n$ rounds the quotient DOWN ($-6 \bmod 5 = 4$).
- **[[Euclidean Algorithm]]** ➔ iterate $(a,b) \to (b, a \bmod b)$ until $b \mid a$; terminates because $b$ strictly decreases. **Extended** version tracks each value as $xm + yn$ ⟹ Bézout coefficients ⟹ [[Modular Inverse]].
- **Inverse & coprimality** ➔ $x$ invertible in $\mathbb Z_n$ **iff** $\gcd(x,n) = 1$; prime modulus ⟹ field (all nonzero invertible); division = multiply by inverse, never "divide".
- **[[Modular Exponentiation]]** ➔ square-and-multiply, $O(\log m)$ multiplications; easy forward, discrete log hard — the [[One-Way Function]] candidate (believed, never proven).
- **Euler/Fermat** ➔ $\gcd(x,n) = 1 \Rightarrow x^{\phi(n)} \equiv 1 \pmod n$; FLT is the prime case $x^{p-1} \equiv 1$; payoff = shrink exponents mod $\phi(n)$. $\phi(n) = |\mathbb Z_n^*|$: easy WITH the factorisation, as hard as factoring without.
- **[[Diffie-Hellman Key Agreement]]** ➔ public $g, n$; exchange $g^a, g^b$; shared $g^{ab}$ — security = discrete log; $g$ must be a [[Primitive Root]] (exists only for $n = 1,2,4,p^k,2p^k$). A [[Cryptosystem]]'s $e_k$ must be bijective or decryption is ambiguous.

## 8️⃣ Graph Theory
- **Graph** ➔ $G = (V,E)$, edges as unordered pairs ⟹ simple by construction; adjacency = symmetric irreflexive relation.
- **Walk ⊇ trail ⊇ path** ➔ repeat anything / no repeat edge / no repeat vertex; shortest walk = shortest path (defines distance).
- **Handshaking** ➔ $\sum_v \deg(v) = 2m$ — **necessary, not sufficient** for a degree sequence.
- **Connectivity** ➔ component = MAXIMAL connected subgraph; connected ≠ adjacent.
- **[[Euler Tour]]** ➔ closed trail using every edge once ⟺ connected + all degrees even (Königsberg: four odd ⟹ impossible).
- **Bipartite** ➔ 2-colourable ⟺ **no odd cycle**; $K_3$ = smallest non-bipartite.
- **Trees & forests** ➔ tree = connected + acyclic ⟺ $n - 1$ edges; forest = acyclic, componentwise. Every connected graph has a [[Spanning Tree]]; **Kruskal**: repeatedly add cheapest cycle-free edge — greedy provably optimal (rare!).
- **Planarity** ➔ Euler's formula $n - m + f = 2$; bounds $m \le 3n - 6$ (triangle-free: $2n - 4$) DISPROVE planarity only — passing the bound proves nothing; $K_5, K_{3,3}$ minimal obstructions.
- **Representations** ➔ matrix: $n^2$ bits, $O(1)$ edge test · lists: compact for sparse.

## ⚠️ Top Cross-Unit Traps
- 💡 **One example never proves $\forall$** ➔ a witness proves $\exists$ only; the marker looks for exactly this slip.
- 💡 **Linearity vs independence** ➔ $E$ adds always; $\mathrm{Var}$ adds only when independent.
- 💡 **Restriction connectives** ➔ "$\forall x \in S$" unfolds with $\Rightarrow$; "$\exists x \in S$" with $\wedge$ — swapped connectives silently change the claim.
- 💡 **Necessary vs sufficient** ➔ handshaking, planarity bounds, degree tests: all one-directional — quote the direction.
- 💡 **$-6 \bmod 5 = 4$** ➔ remainder is never negative; quotient rounds down.
