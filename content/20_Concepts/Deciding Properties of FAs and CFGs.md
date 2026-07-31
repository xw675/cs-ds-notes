---
unit: FIT2014
week: 8
source: [lecture]
domain: D
parent: "[[Decidability and Decision Problems]]"
tags: [Math/Theory, CS/Computation]
aliases: [FA-Empty, CFG-Empty, RegExpEquiv, emptiness testing, marking algorithm]
---
# [[Deciding Properties of FAs and CFGs]]

**Context:** [[FIT2014_MOC]] · the **positive** side of [[Decidability and Decision Problems]] — concrete deciders for questions *about* automata and grammars, all built from one idea: **mark, then propagate to a fixpoint**

> [!abstract] Quick Revision
> - **🎯 Objective:** given $\langle A\rangle$ or $\langle G\rangle$, decide a property of $L(A)$ / $L(G)$ ➔ **seed a mark set, close it under one rule, read the verdict off the Start symbol/state**.
> - **⚠️ Key Constraint:** **the Accept polarity is inverted.** These machines decide *"is the language EMPTY?"*, so Accept fires when the target is **not** reached. Writing "if a final state is marked, Accept" reverses the whole answer.

## 📝 The catalogue of decidable problems
| Input | Question | Decider given in lecture? |
| :--- | :--- | :--- |
| a Finite Automaton | Does it define the **empty** language? | ✅ marking (below) |
| two Regular Expressions | Do they define the **same** language? | ✅ via symmetric difference |
| a Context Free Grammar | Does it define the **empty** language? | ✅ marking (below) |
| a Finite Automaton | Does it define an **infinite** language? | ❌ stated decidable only |
| a Context Free Grammar | Does it generate an **infinite** language? | ❌ stated decidable only |
| a CFG and a string $w$ | Can $w$ be generated? | ❌ — but this **is** [[CYK Algorithm]] via [[Chomsky Normal Form]] |

- **Everything here is a property of the language, not of the syntax** ➔ two different FAs with the same language must get the same verdict, which is why the decider must *run* a construction rather than pattern-match the input string.

## 🔎 FA-Empty — reachability marking
$$\text{FA-Empty} := \{\langle A\rangle : A \text{ is a FA and } L(A)=\emptyset\}$$
1. **Mark** the Start State of $A$.
2. **Repeat until no new state gets marked:** mark any state with a transition coming into it **from an already-marked state**.
3. **If no Final State is marked, Accept; otherwise Reject.**

**Trace** — $A$ with states $1$ (Start), $2$, $3$, $4$ (Final); transitions $1\xrightarrow{\mathtt{a}}2$, $2\xrightarrow{\mathtt{b}}3$, $3\xrightarrow{\mathtt{a}}2$, $4\xrightarrow{\mathtt{a}}4$:

| Round | Rule fired | Newly marked | Marked set |
| :--- | :--- | :--- | :--- |
| 0 | seed the Start State | $1$ | $\{1\}$ |
| 1 | $1\xrightarrow{\mathtt{a}}2$, source marked | $2$ | $\{1,2\}$ |
| 2 | $2\xrightarrow{\mathtt{b}}3$, source marked | $3$ | $\{1,2,3\}$ |
| 3 | $3\xrightarrow{\mathtt{a}}2$ adds nothing — **fixpoint** | — | $\{1,2,3\}$ |

**Verdict:** Final State $4$ unmarked ⟹ **Accept** ⟹ $L(A)=\emptyset$ (state $4$ is unreachable, so no accepting path exists).

## 🔁 RegExpEquiv — reduce equality to emptiness
$$\text{RegExpEquiv} := \{\langle A,B\rangle : A,B \text{ are regular expressions and } L(A)=L(B)\}$$
1. **Construct a FA $C$** defining the **symmetric difference** $\big(L(A)\cap\overline{L(B)}\big)\cup\big(\overline{L(A)}\cap L(B)\big)$.
2. **Run the FA-Empty decider $T$** on $C$.
3. **If $T$ accepts $C$, Accept; else Reject.**

- **Why symmetric difference** ➔ it collects exactly the words on which $A$ and $B$ **disagree**, so it is empty $\iff L(A)=L(B)$ — equality is converted into an emptiness test the previous machine already settles.
- **Why step 1 is effective** ➔ every piece is a finite mechanical construction already owned by the unit: regex $\to$ NFA ([[Converting Regular Expressions to NFA]]) $\to$ DFA ([[NFA to DFA (Subset Construction)]]), complement by **swapping Final/non-Final on a DFA** ([[Finite Automata (DFA and NFA)]]), then intersection and union ([[Closure Properties of Regular Languages]]).
- **Read it twice** ➔ as a *decidability proof* it is a subroutine call; as a *[[Mapping Reductions|mapping reduction]]* $\text{RegExpEquiv}\le_{m}\text{FA-Empty}$ it is the translation $f(\langle A,B\rangle)=C$. Same construction, two readings.

## 🌱 CFG-Empty — generativity marking
$$\text{CFG-Empty} := \{\langle G\rangle : G \text{ is a CFG and } L(G)=\emptyset\}$$
1. **Mark** all **terminal** symbols.
2. **Repeat until no new symbol gets marked:** mark any nonterminal $X$ having a production whose right-hand side is **entirely marked**.
3. **If the Start Symbol is not marked, Accept; else Reject.**

**Trace** — $S\to AB$; $A\to \mathtt{a}A \mid \mathtt{a}$; $B\to \mathtt{b}C$; $C\to \mathtt{c}C\mid \mathtt{c}$:

| Round | Rule fired | Newly marked | Marked set |
| :--- | :--- | :--- | :--- |
| 0 | seed all terminals | $\mathtt{a},\mathtt{b},\mathtt{c}$ | $\{\mathtt{a},\mathtt{b},\mathtt{c}\}$ |
| 1 | $A\to\mathtt{a}$ and $C\to\mathtt{c}$ have fully marked RHS | $A, C$ | $+\{A,C\}$ |
| 2 | $B\to\mathtt{b}C$ now fully marked | $B$ | $+\{B\}$ |
| 3 | $S\to AB$ now fully marked | $S$ | $+\{S\}$ |

**Verdict:** Start Symbol $S$ **is** marked ⟹ **Reject** ⟹ $L(G)\neq\emptyset$. *(Delete $C\to\mathtt{c}$ and the chain stalls at round 1: $C$, then $B$, then $S$ stay unmarked and the machine Accepts.)*

- **A marked symbol means "derives some terminal word"** ➔ marking is **bottom-up generativity**, the exact opposite direction from FA-Empty's **top-down reachability**. Same fixpoint skeleton, mirrored orientation.

## 🧮 Proof Blueprint — why a marking algorithm decides
> [!IMPORTANT] **Theorem.** FA-Empty and CFG-Empty are decidable.

**Strategy** ➔ show the marking loop (i) **terminates** and (ii) **computes exactly** the intended set; then the verdict test is a single lookup.

> [!SUCCESS]- Derivation
> $$
> \begin{aligned}
> \textbf{Termination} &: \text{marks are only ever \textbf{added}, never removed, and the symbol/state set is \textbf{finite}}\\
> &\Rightarrow \text{at most } |Q| \text{ (resp. } |V\cup\Sigma|) \text{ productive rounds} \Rightarrow \textbf{halts on every input}\\
> \textbf{Soundness} &: \text{each rule fires only on a genuine transition / production} \Rightarrow \text{marked} \Rightarrow \text{reachable (resp. productive)}\\
> \textbf{Completeness} &: \text{induct on path length (resp. derivation height)} \Rightarrow \text{reachable (resp. productive)} \Rightarrow \text{marked}\\
> \textbf{Verdict} &: L(A)=\emptyset \iff \text{no Final State reachable};\quad L(G)=\emptyset \iff S \text{ not productive}
> \end{aligned}
> $$
> Halting on **every** input is what upgrades this from an accepter to a **decider**. $\blacksquare$
> - **Key move:** "marks only grow in a finite universe" is the termination argument for *every* fixpoint algorithm in this unit — reuse it verbatim for closure computations and [[DFA Minimisation (Colouring)|colouring]].

## ⚠️ Common Mistakes
- 💡 **Inverted Accept** ➔ both algorithms Accept when the target is **un**marked, because the language being decided is the set of **empty**-language machines. Quote the language definition before writing the last step.
- 💡 **Marking the wrong direction in CFG-Empty** ➔ it seeds **terminals** and grows **upward** to $S$; seeding $S$ and expanding downward computes *reachability of symbols*, a different (also useful) set that answers a different question.
- 💡 **"$L(A)=\emptyset$" is not "$A$ has no Final State"** ➔ an FA can have Final States that no path reaches; the whole point of step 2 is to test **reachability**, not presence.
- 💡 **Don't "just compare the two regexes"** ➔ $L(A)=L(B)$ is a property of the *languages*; $\mathtt{(ab)^*}$ and $\varepsilon\cup\mathtt{ab(ab)^*}$ are textually unlike and equal. Only the construction settles it.

## 🧠 Active Recall
> [!FAQ]- Emptiness of a regular language is decidable, yet a regular language can be infinite. How can a machine settle a question about infinitely many words in finite time?
> > [!SUCCESS]- Answer
> > - **Short answer:** it never touches the words. The decider inspects the **finite object** $\langle A\rangle$ — $|Q|$ states and their transitions — and asks a **structural** question (is a Final State reachable?) whose answer is equivalent to the infinite semantic one.
> > - **Why:** **Finite description, infinite denotation** ➔ this is the recurring move of the whole unit ([[Pumping Lemma for Regular Languages]] exploits the same finiteness). A property becomes decidable precisely when it can be re-expressed as a fixpoint over the finite syntax.

> [!FAQ]- RegExpEquiv's decider does not test equality directly. What does it test instead, and why is that legitimate?
> > [!SUCCESS]- Answer
> > - **Short answer:** it tests **emptiness of the symmetric difference** $\big(L(A)\cap\overline{L(B)}\big)\cup\big(\overline{L(A)}\cap L(B)\big)$, the set of words the two expressions disagree on. That set is empty **iff** the languages are equal, so the two questions have the same answer on every input.
> > - **Why:** **Translate, then call an existing decider** ➔ legitimacy needs two things — the translation must be **computable** (regex→NFA→DFA→complement→intersection are all finite constructions) and the equivalence must be an **iff**, not a one-way implication. Those two conditions are exactly the definition of a [[Mapping Reductions|mapping reduction]], which is why this proof is reused verbatim as $\text{RegExpEquiv}\le_{m}\text{FA-Empty}$.
