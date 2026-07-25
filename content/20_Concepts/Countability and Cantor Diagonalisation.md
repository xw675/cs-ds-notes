---
unit: FIT2014
week: 2
parent: "[[Formal Languages (Alphabets, Words, Languages)]]"
tags: [Math/Theory, Math/Proof, CS/Computation, Monash/CS_DS]
aliases: [countable, uncountable, countably infinite, bijection, Cantor, diagonalisation, diagonal argument, uncountability of languages]
---
# [[Countability and Cantor Diagonalisation]]

**Context:** [[FIT2014_MOC]] · how big are infinite sets? · the argument that there are **more languages than descriptions** — the seed of undecidability later in the unit

> [!abstract] Quick Revision
> - **🎯 Objective:** a set is **countable** if it is finite **or** in bijection with $\mathbb{N}$ ➔ $\mathbb{N},\mathbb{Z},\Sigma^{*}$ are countable, but the set of **all languages** is **uncountable**.
> - **⚡ Key Constraint:** the consequence — since descriptions (programs, regexes, grammars) form a **countable** set but languages are **uncountable**, **most languages have no finite description at all**.

## 📝 Countability
- **Definition** ➔ a set is **countable** if **either** it is finite, **or** it can be put in **one-to-one correspondence (bijection)** with $\mathbb{N}$.
- **$\mathbb{N}$ is countable** ➔ trivially, by the identity correspondence $1\leftrightarrow1,\ 2\leftrightarrow2,\dots$
- **$\mathbb{Z}$ is countable** ➔ interleave the signs: $1\leftrightarrow0,\ 2\leftrightarrow1,\ 3\leftrightarrow-1,\ 4\leftrightarrow2,\ 5\leftrightarrow-2,\dots$ — every integer is reached.
- **$\Sigma^{*}$ is countable** ➔ list words in **length order**, alphabetically within each length: $\varepsilon,\mathtt{a},\mathtt{b},\mathtt{aa},\mathtt{ab},\dots$ — every finite word appears at a finite position.
- **Key idea** ➔ "countable" means **listable**: you can enumerate the elements $x_1,x_2,x_3,\dots$ so that every element eventually appears.

## 🧮 Formal Proof Blueprint — the set of all languages is uncountable
**Theorem (Cantor).** The set of all languages (over a fixed $\Sigma$) is **uncountable**.

**Strategy.** Proof by **contradiction** + **diagonalisation**: assume a listing exists, then construct a language that cannot be anywhere on it.

**Derivation.**
$$
\begin{aligned}
\text{Suppose} &\ \{\text{all languages}\}\text{ is countable.} \\
\Rightarrow&\ \text{it is not finite, so there is a bijection with }\mathbb{N}: \text{ list them } L_1,L_2,L_3,\dots \\
\text{Also}&\ \Sigma^{*}\text{ is countable, so list all words } x_1,x_2,x_3,\dots \\
\text{Define } \hat{L}\ \text{by}&\ \forall n\in\mathbb{N}:\ x_n\in\hat{L} \iff x_n\notin L_n \qquad\text{(flip the diagonal)} \\
\Rightarrow&\ \hat{L}\text{ differs from } L_n \text{ on the word } x_n,\ \text{for every } n \\
\Rightarrow&\ \hat{L}\neq L_n \text{ for all } n,\ \text{yet } \hat{L}\text{ IS a language} \\
&\Rightarrow\ \text{contradiction — the list was supposed to contain every language.}
\end{aligned}
$$
**Therefore** the set of all languages is uncountable. $\blacksquare$

- **Why "diagonal"** ➔ picture rows $L_1,L_2,\dots$ against columns $x_1,x_2,\dots$ with a tick when $x_n\in L_m$; $\hat{L}$ is built by walking the **main diagonal** and **inverting** every entry, guaranteeing a mismatch with row $n$ at column $n$.

## 💥 Why this matters
- **Descriptions are countable** ➔ regular expressions, grammars and programs are **finite strings** over a finite alphabet, so they form a countable set.
- **Languages are uncountable** ➔ therefore **no description system can capture every language** — there are strictly more languages than finite descriptions.
- **Foreshadowing** ➔ this counting gap is the reason unsolvable problems exist at all; it returns as **undecidability** and the halting problem later in the unit.

## ⚠️ Common Mistakes
- 💡 **Countable ≠ finite** ➔ countable includes **countably infinite** ($\mathbb{N},\mathbb{Z},\Sigma^{*}$ are all infinite yet countable). The contrast is countable vs **uncountable**.
- 💡 **$\Sigma^{*}$ is countable but $\{$languages$\}$ is not** ➔ the *words* are listable; the **sets of words** are not. A language is a **subset** of $\Sigma^{*}$, and the powerset jumps in size.
- 💡 **The diagonal language must be genuinely new** ➔ the force of the argument is that $\hat{L}$ is a perfectly legitimate language yet provably absent from the list; if you only showed it differed from *some* $L_n$, there'd be no contradiction.

## 🧠 Active Recall
> [!FAQ]- $\Sigma^{*}$ is countable. Why doesn't that make the set of all languages countable too?
> > [!SUCCESS]- Answer
> > - **Short answer:** a language is a **subset** of $\Sigma^{*}$, so the set of all languages is the **powerset** of $\Sigma^{*}$. Cantor's diagonal argument shows this powerset cannot be listed — given any listing $L_1,L_2,\dots$, the language $\hat{L}$ defined by $x_n\in\hat{L}\iff x_n\notin L_n$ differs from every $L_n$.
> > - **Why:** **Listing words ≠ listing sets of words** ➔ enumerating elements is strictly easier than enumerating subsets; the diagonal construction always escapes any proposed enumeration of the subsets.

> [!FAQ]- What does uncountability of languages imply about regular expressions and programs?
> > [!SUCCESS]- Answer
> > - **Short answer:** every regex/grammar/program is a **finite string**, so descriptions are **countable**; languages are **uncountable**; hence **almost all languages have no finite description** — no regex, no grammar, no program decides them.
> > - **Why:** **Cardinality mismatch** ➔ a countable set cannot surject onto an uncountable one, so any description formalism necessarily misses (uncountably) many languages — the counting foundation of later **undecidability** results.
