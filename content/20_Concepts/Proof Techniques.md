---
unit: [FIT1058, FIT2014]
domain: D
week: [2, 3]
parent: "[[Theorem and Proof]]"
tags: [Math/Proof, Math/Logic, Math/Theory]
aliases: [proof by construction, proof by cases, proof by contradiction, exhaustion, reductio ad absurdum, subset proof, set equality]
---
# [[Proof Techniques]]

**Context:** [[FIT1058_MOC]], [[FIT2014_MOC]] · the named patterns a [[Theorem and Proof|proof]] follows · matched to the claim's [[Quantifiers (Existential and Universal)|quantifier]] · [[Mathematical Induction]] is the fifth
**Judging quality:** [[Proof Critique (Good, Bad and Ugly Proofs)]] — valid vs invalid vs merely graceless.

> [!abstract] Quick Revision
> - **🎯 Objective:** pick the argument pattern matching the claim's logical shape ➔ construction / cases / contradiction / symbolic manipulation (+ induction).
> - **📦 Core Components:** $\exists\to$ construction | $\forall\to$ cases | hard-direct $\to$ contradiction | identities $\to$ symbolic manipulation.
> - **⚡ Key Constraint:** a single example proves $\exists$ but **never** $\forall$; exhaustion needs a finite (or finitely-partitioned) domain.

## 📝 Core
### 1. Symbolic Manipulation
- **Method** ➔ a chain of law-justified equalities transforming one expression into another.
- **Freedom** ➔ start from **either** side (often the more complex, simplifying toward the other).
- **Scope** ➔ algebra, set laws (De Morgan, distributive, idempotent).

### 2. Construction (Witness)
- **Proves** ➔ an **existential** $\exists x,\ P(x)$ by exhibiting one concrete object.
- **Common mistake** ➔ a single example **never** proves a **universal** $\forall$ — it only illustrates.

### 3. Cases (Exhaustion)
- **Method** ➔ split the domain into finitely many cases that **collectively cover everything**; prove each.
- **Rules** ➔ cases **may overlap** (redundant but valid); they must be **exhaustive**; infinite domains partition (e.g. $2k$ vs $2k+1$).

### 4. Contradiction (*Reductio*)
- **Method** ➔ assume the **negation**, derive an absurdity ($0=1$), conclude the assumption false.
- **Canonical** ➔ Euclid's infinitude of primes; interesting-number (Well-Ordering); **$\sqrt{2}$ is irrational** (assume $\sqrt2=\tfrac{m}{n}$ in lowest terms $\Rightarrow 2n^{2}=m^{2}\Rightarrow m,n$ both even $\Rightarrow$ contradiction); **Cantor's diagonalisation** ([[Countability and Cantor Diagonalisation]]).
- **⚠ Don't over-apply** ➔ if a **direct** proof exists, wrapping it in contradiction makes it *ugly*, not stronger ([[Proof Critique (Good, Bad and Ugly Proofs)]]).

### 5. Proving Equalities (the two-sided strategies)
- **Set equality** $A=B$ ➔ prove **$A\subseteq B$** and **$A\supseteq B$** separately.
- **Subset relation** $A\subseteq B$ ➔ take a **general** member of $A$, **name** it, use $A$'s definition, follow the consequences, aim at $B$'s definition. *(the blueprint used for $\text{DOUBLEWORD}\subseteq\text{EVEN-EVEN}$ in [[Formal Languages (Alphabets, Words, Languages)]])*
- **Numerical equality** $A=B$ ➔ transform $A$ into $B$ algebraically if you can; if not, prove **$A\le B$** and **$A\ge B$**.

## ⚖️ Core Decision Matrix
| Claim shape | Technique | Key first move |
| :--- | :--- | :--- |
| $\exists x,\ P(x)$ | construction | exhibit one witness |
| $\forall x,\ P(x)$ (finite domain) | cases / exhaustion | partition, prove each |
| equality / identity | symbolic manipulation | transform one side |
| hard to attack directly | contradiction | assume the negation |
| $\forall n\in\mathbb N$ | [[Mathematical Induction]] | base + inductive step |

> [!NOTE] **When It Flips:** method follows the goal — the quantifier picks the pattern. Exhaustion needs a *finite* (or finitely-partitioned) domain; contradiction needs a true axiom framework, so a derived absurdity convicts only the assumed negation. Real proofs often **combine** several.

## 📊 Exam Execution Trace

### Manual Execution Trace
Matching claims to techniques:

| Step / State | Claim | Logical shape | Technique |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | "$\exists$ even prime" | existential | construction (witness 2) |
| 2 | "$n^2-n$ even $\forall n$" | universal, finite cases | cases ($2k$, $2k+1$) |
| 3 | "$\sqrt2$ irrational" | hard-direct | contradiction |

## ⚠️ Common Mistakes
- 💡 **Construction ≠ universal proof** ➔ exhibiting one witness settles $\exists$ only; a $\forall$ claim needs cases/arbitrary-element, and contradiction relies on a *true* framework so the lone false assumption is convicted.

## 🧠 Active Recall
> [!FAQ]- Match each proof method to the claim it suits, and give construction's pitfall.
> - **Hint:** Quantifier ↔ method.
> > [!SUCCESS]- Answer
> > - **Short answer:** Symbolic → identities; construction → $\exists$; cases → finite $\forall$; contradiction → hard-direct.
> > - **Why:** **One example ≠ $\forall$** ➔ a witness proves only existence; a universal needs every case or an arbitrary element.

> [!FAQ]- Outline Euclid's proof of infinitely many primes and why it is by contradiction.
> - **Hint:** Construct $q$, force a missing prime.
> > [!SUCCESS]- Answer
> > - **Short answer:** Assume finitely many $p_1,\dots,p_n$; $q=p_1\cdots p_n+1$ has remainder 1 under each $p_i$, so a prime outside the list exists.
> > - **Why:** **Contradiction** ➔ this refutes the completeness assumption (Fundamental Theorem of Arithmetic guarantees $q$ has a prime factor).

> [!FAQ]- In the "every natural is interesting" proof, which principle is used and why does it fail over $\mathbb Z$?
> - **Hint:** Well-Ordering.
> > [!SUCCESS]- Answer
> > - **Short answer:** Well-Ordering: every non-empty $\subseteq\mathbb N$ has a smallest element; the smallest "uninteresting" number is thereby interesting — contradiction.
> > - **Why:** **$\mathbb Z$ not well-ordered** ➔ it extends to $-\infty$, so a non-empty integer set need not have a least element; the construction breaks.
