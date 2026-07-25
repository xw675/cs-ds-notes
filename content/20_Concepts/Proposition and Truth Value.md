---
unit: FIT1058
week: [1, 4]
parent: "[[Logical Connectives]]"
tags: [Math/Logic, Math/Discrete]
---
# [[Proposition and Truth Value]]

**Context:** [[FIT1058_MOC]] · the atoms of logic · two truth values (T/F, or bits 1/0) · combined by [[Logical Connectives]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a statement that is either true or false ➔ the truth-valued atom all of logic is built on.
> - **📦 Core Components:** proposition ➔ truth value $\{$T,F$\}$ ➔ Boolean variable (a name for one).
> - **⚡ Key Constraint:** **bivalence** — exactly one truth value; questions, commands, and self-referential paradoxes are **not** propositions.

## 📝 Core
### 1. The Proposition (Truth-Valued Atom)
- **Definition** ➔ a declarative statement that is **either true or false**, never both, never neither.
- **Truth value** ➔ one of $\{$T,F$\}$ a proposition takes ➔ may be *unknown* yet still definite.
- **Boolean variable** ➔ a variable ranging over $\{$T,F$\}$ ➔ often a *name* for a proposition ("let $X$ be $1+1=2$", so $X=$T").

### 2. Truth Values ↔ Bits
- **Two-state abstraction** ➔ T/F abstracts any two-state phenomenon (off/on, unmagnetised/magnetised).
- **Bit map** ➔ $0=$F, $1=$T ➔ lets logic be reasoned about independently of hardware.

### 3. What Fails to Be a Proposition
- **Command** ➔ "Come and work for us!" ➔ no truth value.
- **Question** ➔ not an assertion.
- **Paradox** ➔ "This statement is false" ➔ self-referential, neither T nor F.

## ⚖️ Core Decision Matrix
| Category | Truth value? | Proposition? | Example |
| :--- | :--- | :--- | :--- |
| declarative, definite | exactly one | **yes** | $1+1=2$ |
| declarative, currently unknown | definite (unknown) | **yes** | "it will rain tomorrow" |
| command / question | none | **no** | "close the door" |
| self-referential paradox | none consistent | **no** | "this statement is false" |

> [!NOTE] **When It Flips:** **bivalence** — every proposition has *exactly one* truth value — is the assumption the whole module rests on. A Boolean *variable* ranges over $\{$T,F$\}$; a *proposition* has a fixed (possibly unknown) value.

## 📊 Exam Execution Trace

### Manual Execution Trace
Classifying statements:

| Step / State | Statement | Declarative? | Proposition? | Value |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — | — |
| 1 | $1+1=2$ | yes | yes | T |
| 2 | "Close the door." | no (command) | no | — |
| 3 | "This statement is false." | no (paradox) | no | — |
| 4 | "It will rain tomorrow." | yes | yes | unknown |

## ⚠️ Common Mistakes
- 💡 **"Unknown" ≠ "not a proposition"** ➔ "it will rain tomorrow" is a proposition (definite truth value, merely unknown now); only commands, questions, and paradoxes are excluded.

## 🧠 Active Recall
> [!FAQ]- What makes a statement a proposition, and why are "Come and work for us!" and "This statement is false" excluded?
> - **Hint:** Definite truth value required.
> > [!SUCCESS]- Answer
> > - **Short answer:** A proposition is a declarative statement with exactly one truth value; a command has none, a paradox has no consistent one.
> > - **Why:** **Bivalence** ➔ "this statement is false" is T ⟺ F, so no consistent assignment exists.

> [!FAQ]- How do truth values relate to bits, and what is a Boolean variable?
> - **Hint:** T/F ↔ 1/0.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\{$T,F$\}$ correspond to bits $\{1,0\}$; a Boolean variable ranges over $\{$T,F$\}$ and often names a proposition.
> > - **Why:** **Hardware-independent** ➔ logic operations mirror operations on $1/0$, which is why digital hardware computes logic.
