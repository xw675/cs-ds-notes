---
unit: FIT2014
week: 4
parent: "[[Kleene's Theorem]]"
tags: [Math/Theory, Math/Proof, CS/Computation, CS/Languages]
aliases: [closure, closed under, union closure, intersection closure, complement closure, concatenation closure, symmetric difference]
---
# [[Closure Properties of Regular Languages]]

**Context:** [[FIT2014_MOC]] · which operations keep you **inside** the regular languages · each proof picks the formalism ([[Regular Expressions|regex]] or [[Finite Automata (DFA and NFA)|FA]]) that makes it easy — via [[Kleene's Theorem]]

> [!abstract] Quick Revision
> - **🎯 Objective:** the class of regular languages is **closed** under **complement, union, intersection and concatenation** ➔ combining regular languages these ways always yields a regular language.
> - **⚡ Key Constraint:** there is **no $\cap$ operator on regular expressions**, so intersection cannot be proved like union — it goes through **De Morgan** on complements.

## 📝 Definition
- **Closed** ➔ if performing an operation on regular languages **always** produces another regular language, the class is **closed** under that operation.
- **Proof strategy** ➔ Kleene's Theorem lets you switch representation freely: prove each closure in whichever of regex/FA/NFA makes it trivial.

## 🧮 The four closure theorems
### 1. Complement — use the **automaton**
**Theorem.** The complement of a regular language is regular.
**Proof (outline).** $L$ regular ⟹ some regex defines it ⟹ by Kleene's Theorem some **FA** recognises it ⟹ swap Final and non-Final states to get an FA for $\overline{L}$ ⟹ by Kleene's Theorem a regex defines $\overline{L}$. $\blacksquare$

### 2. Union — use the **regular expression**
**Theorem.** $L_1\cup L_2$ is regular.
**Proof.** Let $R_1,R_2$ be regexes for $L_1,L_2$. Then $R_1\cup R_2$ **is a regular expression** by clause 3(iii) of the inductive definition ([[Regular Expressions]]), and it describes $L_1\cup L_2$. $\blacksquare$

### 3. Intersection — via **De Morgan**
**Theorem.** $L_1\cap L_2$ is regular.
- **Why not mimic union?** ➔ regular expressions have **no $\cap$ operation**, so there is nothing to write down directly.
**Proof.**
$$
\begin{aligned}
L_1,L_2 \text{ regular} &\Rightarrow \overline{L_1},\overline{L_2}\text{ regular} &&\text{(complement closure)}\\
&\Rightarrow \overline{L_1}\cup\overline{L_2}\text{ regular} &&\text{(union closure)}\\
&\Rightarrow \overline{\overline{L_1}\cup\overline{L_2}}\text{ regular} &&\text{(complement closure again)}\\
\text{and } \overline{\overline{L_1}\cup\overline{L_2}} &= \overline{\overline{L_1}}\cap\overline{\overline{L_2}} = L_1\cap L_2 &&\text{(De Morgan)}
\end{aligned}
$$
$\blacksquare$

### 4. Concatenation — use the **regular expression**
**Theorem.** $L_1L_2:=\{xy : x\in L_1,\ y\in L_2\}$ is regular.
**Proof sketch.** $R_1R_2$ is a regular expression by clause 3(ii) of the inductive definition, and it describes exactly $L_1L_2$. $\blacksquare$

## ⚖️ Summary matrix
| Operation | Closed? | Cleanest proof route |
| :--- | :--- | :--- |
| complement $\overline{L}$ | ✓ | **FA** — swap Final / non-Final |
| union $L_1\cup L_2$ | ✓ | **regex** — clause 3(iii) |
| intersection $L_1\cap L_2$ | ✓ | **De Morgan** on complements |
| concatenation $L_1L_2$ | ✓ | **regex** — clause 3(ii) |
| Kleene star $L^{*}$ | ✓ | **regex** — clause 3(iv) |
| symmetric difference $L_1\triangle L_2$ | ✓ | build from $\cup,\cap,\overline{\ \cdot\ }$ |
| **subsets** of a regular language | ✗ | any language is a subset of the regular $\Sigma^{*}$ |
| **supersets** of a regular language | ✗ | any language is a superset of the regular $\emptyset$ |

> [!NOTE] **When It Flips:** closure proofs are exercises in **choosing the right representation**. Complement is trivial on a DFA and awkward on a regex; union is trivial on a regex. Kleene's Theorem is what licenses hopping between them mid-proof.

## 🎯 Why closure matters
- **A proof technique** ➔ closure gives the fastest **non-regularity** arguments: if $L\cap(\text{regular})$ is known non-regular, then $L$ is non-regular. This is exactly how **EQUAL** is settled in [[Proving a Language Non-Regular]].
- **Symmetric difference** ➔ $L_1\triangle L_2=\{$strings in $L_1$ but not $L_2$, or in $L_2$ but not $L_1\}$ is regular, being expressible with $\cup$, $\cap$ and complement.

## ⚠️ Common Mistakes
- 💡 **No $\cap$ in the regex syntax** ➔ don't "prove" intersection closure by writing $R_1\cap R_2$; that is not a regular expression. Route it through De Morgan.
- 💡 **Subsets and supersets are NOT closed** ➔ $\Sigma^{*}$ is regular and **every** language is one of its subsets, so subset-closure would make every language regular — plainly false.
- 💡 **Complement needs a *deterministic* machine** ➔ the swap trick requires a total DFA; see the trap in [[Finite Automata (DFA and NFA)]].

## 🧠 Active Recall
> [!FAQ]- Why can't intersection closure be proved the same way as union closure?
> > [!SUCCESS]- Answer
> > - **Short answer:** the union proof works because $R_1\cup R_2$ **is itself a regular expression** (clause 3(iii) of the inductive definition). Regular expressions have **no intersection operator**, so there is no analogous expression to write down.
> > - **Why:** **De Morgan detour** ➔ instead use closure under complement and union: $L_1\cap L_2=\overline{\overline{L_1}\cup\overline{L_2}}$, where each step stays inside the regular languages.

> [!FAQ]- Are the regular languages closed under taking subsets? Justify.
> > [!SUCCESS]- Answer
> > - **Short answer:** **No.** $\Sigma^{*}$ is regular, and **every** language over $\Sigma$ is a subset of it — including non-regular ones like $\{\mathtt{a}^{n}\mathtt{b}^{n}\}$. So a subset of a regular language need not be regular.
> > - **Why:** **One counterexample suffices** ➔ closure is a universal claim, so a single non-regular subset of a regular language refutes it (and symmetrically, $\emptyset$ is regular yet every language is a superset of it).
