---
unit: [FIT1058, FIT2014]
week: 3
parent: "[[Logical Implication]]"
tags: [Math/Logic, Math/Proof, Monash/CS_DS]
---
# [[Modus Ponens]]

**Context:** [[FIT1058_MOC]], [[FIT2014_MOC]] · the core rule of inference · turns $P$ and $P\Rightarrow Q$ into $Q$ · justifies each "logical consequence" step of a [[Theorem and Proof|proof]]

> [!abstract] Quick Revision
> - **🎯 Objective:** from $P$ and $P\Rightarrow Q$, deduce $Q$ ➔ the engine of every "logical consequence" proof step.
> - **📦 Core Components:** fact $P$ ➔ implication $P\Rightarrow Q$ ➔ conclusion $Q$.
> - **⚡ Key Constraint:** **both** premises required; deducing $P$ from $Q$ and $P\Rightarrow Q$ is the converse fallacy.

## 📝 Core
### 1. The Rule (Affirming the Antecedent)
- **Statement** ➔ if $P$ established **and** $P\Rightarrow Q$ established, then $Q$ deducible.
- **Layout** ➔ $\dfrac{P,\ \ P\Rightarrow Q}{\therefore\ Q}$.
- **Role** ➔ justifies each "logical consequence" step of a [[Theorem and Proof|proof]].

### 2. Usage & Limits
- **Both needed** ➔ $P$ alone or $P\Rightarrow Q$ alone is insufficient.
- **Converse error** ➔ from $Q$ and $P\Rightarrow Q$ you may **not** conclude $P$.
- **Drives induction** ➔ base $S(1)$ + step $S(k)\Rightarrow S(k+1)$ fires modus ponens repeatedly.

**Key identities:**

$$P:\ X\in\mathcal P(A)\ (\text{true}),\qquad P\Rightarrow Q:\ \text{definition of } \mathcal P(A)$$
$$\therefore\ Q:\ X\subseteq A \quad(\text{modus ponens})$$

## ⚖️ Core Decision Matrix
| Have | Rule | Conclude | Valid? |
| :--- | :--- | :--- | :--- |
| $P$ and $P\Rightarrow Q$ | modus ponens | $Q$ | ✅ |
| $Q$ and $P\Rightarrow Q$ | (affirming consequent) | $P$ | ❌ converse fallacy |
| $\neg Q$ and $P\Rightarrow Q$ | modus tollens | $\neg P$ | ✅ |

> [!NOTE] **When It Flips:** so natural it is rarely named in prose — "we have $P$, and $P$ implies $Q$, therefore $Q$" is just "a deduction". Its premises must themselves be established (definition/axiom/prior theorem/earlier step).

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Given "$6\mid 12$" and "if $6\mid n$ then $2\mid n$", deduce a conclusion.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
P &:\ 6\mid 12 && \text{(established fact)} \\
P\Rightarrow Q &:\ 6\mid n \Rightarrow 2\mid n && \text{(given implication)} \\
\therefore\ Q &:\ 2\mid 12 && \text{(modus ponens)}
\end{aligned}
$$
**Final Extracted Output:** $2\mid 12$ by modus ponens; from $Q$ one may not conclude $P$ (converse fallacy).

## ⚠️ Common Mistakes
- 💡 **Don't affirm the consequent** ➔ having $Q$ and $P\Rightarrow Q$ does *not* give $P$ (converse fallacy); you need the antecedent $P$ itself.

## 🧠 Active Recall
> [!FAQ]- State modus ponens and explain why both premises are essential.
> - **Hint:** Fact + conditional.
> > [!SUCCESS]- Answer
> > - **Short answer:** From $P$ and $P\Rightarrow Q$ deduce $Q$; the implication is inert without its antecedent holding.
> > - **Why:** **Converse fallacy** ➔ deducing $P$ from $Q$ and $P\Rightarrow Q$ is invalid.

> [!FAQ]- How does modus ponens appear in a power-set subset proof?
> - **Hint:** Definition as the implication.
> > [!SUCCESS]- Answer
> > - **Short answer:** With $P:\ X\in\mathcal P(A)$ and definitional $P\Rightarrow Q$ ($Q:\ X\subseteq A$), modus ponens yields $X\subseteq A$.
> > - **Why:** **Membership = subset** ➔ the [[Power Set]] definition supplies the conditional the rule consumes.
