---
unit: FIT2014
week: 1
parent: "[[FIT2014_MOC]]"
tags: [Math/Theory, CS/Computation]
aliases: [alphabet, word, string, formal language, Sigma star, empty word, epsilon, EVEN-EVEN, DOUBLEWORD, PALINDROMES, universal language]
---
# [[Formal Languages (Alphabets, Words, Languages)]]

**Context:** [[FIT2014_MOC]] · computation is done with **strings of symbols**, so the whole unit is built on this vocabulary · foundation for regular languages, automata and grammars later

> [!abstract] Quick Revision
> - **🎯 Objective:** alphabet $\Sigma$ (finite symbol set) ➔ **word** (finite string over $\Sigma$) ➔ **language** (a *set* of words over $\Sigma$).
> - **⚡ Key Constraint:** distinguish the **empty language** $\emptyset=\{\,\}$ from the language **containing the empty word** $\{\varepsilon\}$ — the first has $0$ elements, the second has $1$.

## 📝 Core definitions
- **Alphabet** ➔ a **finite** set of symbols, denoted $\Sigma$; members are **letters/characters**. E.g. $\{a,b\}$, $\{0,1\}$, $\{0,\dots,9\}$.
- **Word** ➔ a **finite** string of symbols; a *word over $\Sigma$* draws all symbols from $\Sigma$. The **empty word** has length $0$, written $\varepsilon$ (sometimes $\Lambda$).
- **Language** ➔ a **set of words** over $\Sigma$ — note a language is a *set*, not a string.
- **Default convention** ➔ unless stated otherwise, $\Sigma=\{a,b\}$.

## 🔢 Special languages & notation
- **Empty language** ➔ $\emptyset=\{\,\}$ — contains **no** words.
- **Language of the empty word** ➔ $\{\varepsilon\}$ — contains **exactly one** word.
- **Fixed length** ➔ $\Sigma^{k}:=\{\text{all words over }\Sigma\text{ of length }k\}$, e.g. $\{a,b\}^{2}=\{aa,ab,ba,bb\}$.
- **Universal language** ➔ $\Sigma^{*}:=\{\text{all finite words over }\Sigma\}$.
- **Repetition** ➔ $x^{k}$ concatenates $k$ copies of $x$: $a^{2}=aa$, $ab^{3}=abbb$, $(ab)^{3}=ababab$. Note $x^{0}=\varepsilon$ for any $x$ (so $(baa)^{0}=\varepsilon$).

## 📚 Three worked example languages
| Language | Definition | Members (sample) |
| :--- | :--- | :--- |
| **EVEN-EVEN** | each of $a,b$ occurs an **even** number of times | $\varepsilon, aa, bb, aaaa, aabb, abab, abba, baab,\dots$ |
| **DOUBLEWORD** | $\{xx : x\in\Sigma^{*}\}$ — a word concatenated with itself | $\varepsilon, aa, bb, aaaa, abab, baba, bbbb,\dots$ |
| **PALINDROMES** | reads the same forwards and backwards | $\varepsilon, a, b, aa, bb, aba, bab, abba,\dots$ |

- **Remember $0$ is even** ➔ $\varepsilon\in$ EVEN-EVEN.
- **$\varepsilon\varepsilon=\varepsilon$** ➔ so $\varepsilon\in$ DOUBLEWORD (take $x=\varepsilon$).

## 🧮 Formal Proof Blueprint — $\text{DOUBLEWORD}\subseteq\text{EVEN-EVEN}$
**Theorem.** $\text{DOUBLEWORD}\subseteq\text{EVEN-EVEN}$.

**Strategy (subset proof).** To prove $A\subseteq B$: take a **general** member of $A$, name things, use the definitions, and derive membership of $B$.

**Derivation.**
$$
\begin{aligned}
\text{Let } w &\in \text{DOUBLEWORD} \\
\Rightarrow\ w &= xx \quad \text{for some word } x \qquad \text{(definition of DOUBLEWORD)} \\
\#_a(w) &= 2\times \#_a(x) \quad\Rightarrow\quad \#_a(w) \text{ is even} \\
\#_b(w) &= 2\times \#_b(x) \quad\Rightarrow\quad \#_b(w) \text{ is even} \\
\Rightarrow\ w &\in \text{EVEN-EVEN}
\end{aligned}
$$
**Q.E.D.** $\blacksquare$

- **Why "proof by example" fails here** ➔ listing members of DOUBLEWORD that happen to be in EVEN-EVEN is a **non-proof**; a **universal** claim needs an argument covering *every* case.
- **The exception** ➔ an **existential** theorem ("English has a palindrome") *is* settled by one witness (`rotator`) — see [[Quantifiers (Existential and Universal)]].

## ⚠️ Common Mistakes
- 💡 **$\emptyset \neq \{\varepsilon\}$** ➔ the empty language contains nothing; $\{\varepsilon\}$ contains one (empty) word. Sizes $0$ vs $1$.
- 💡 **Language = set of words, word = string** ➔ a language is not itself a string; conflating the two breaks every later definition.
- 💡 **Proof by example is not a proof** ➔ except when the theorem only asserts **existence**. Universal statements need a general argument ([[Proof Techniques]]).

## 🧠 Active Recall
> [!FAQ]- Why is $\varepsilon$ a member of both EVEN-EVEN and DOUBLEWORD?
> > [!SUCCESS]- Answer
> > - **Short answer:** $\varepsilon$ contains $a$ **zero** times and $b$ **zero** times, and $0$ is **even**, so $\varepsilon\in$ EVEN-EVEN. Taking $x=\varepsilon$ gives $xx=\varepsilon\varepsilon=\varepsilon$, so $\varepsilon\in$ DOUBLEWORD.
> > - **Why:** **Degenerate cases satisfy definitions** ➔ the definitions quantify over counts and decompositions that are vacuously/trivially met at length $0$ — a standard exam trap.

> [!FAQ]- Why does exhibiting many DOUBLEWORD members inside EVEN-EVEN fail to prove $\text{DOUBLEWORD}\subseteq\text{EVEN-EVEN}$?
> > [!SUCCESS]- Answer
> > - **Short answer:** the claim is **universal** (*every* member of DOUBLEWORD lies in EVEN-EVEN); examples cover finitely many cases while the language is **infinite**, so they only illustrate.
> > - **Why:** **Arbitrary-element argument** ➔ take a general $w=xx$ and show $\#_a(w)=2\#_a(x)$ and $\#_b(w)=2\#_b(x)$ are even; this reasoning applies to **all** cases at once.
