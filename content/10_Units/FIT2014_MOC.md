---
unit: FIT2014
type: MOC
tags: [Math/Theory, CS/Computation]
---
# 📘 FIT2014: Theory of Computation

> [!INFO] Map of Content
> Index for **FIT2014 (Malaysia campus)**. Arc: languages → logic/CNF → automata → grammars → parsing → Turing machines → NP-completeness. Conventions: $\Sigma$ alphabets, $\varepsilon$ empty word, **CNF is the working form** — but **[[Conjunctive Normal Form]] (logic) ≠ [[Chomsky Normal Form]] (grammars)**; W1–2 logic notes are shared dual-unit with [[FIT1058_MOC]].

## 📊 Assessment Map
- **Practical Preparation (5%)** ➔ ongoing weekly prac work — part of the in-semester threshold hurdle.
- **Assignment 1 (10%)** ➔ Regular Expressions + Finite Automata — the W2 logic/CNF + coming automata material.
- **Mid-semester Test (15%)** ➔ everything to ~W6 ⟹ languages, logic, encoding, regex↔automata must be solid EARLY.
- **Assignment 2 (20%)** ➔ Lexical Analysis, Parsing, Computability.
- **Final exam (3h10, 50%)** ➔ whole unit; **the exam is a hurdle AND the in-semester tasks form a threshold hurdle**.
- **Reference text** ➔ Sipser (pp. 13–14 strings/languages; §0.3 pp. 17–20 definitions/theorems/proofs; pp. 14–15 and p. 302 for normal forms).
- **LO thread so far** ➔ define and manipulate formal languages; read/write propositional and predicate logic; **encode real problems in CNF** (the recurring assessable skill).

## 📅 Knowledge Index

### 🧰 Toolkit Cheatsheets
- [[Shell Toolkit (Cheatsheet)]] -> tri-unit (FIT1043 + FIT2014 + FIT2109); FIT2014 adds the `sed`/`tr`/grep-regex block (Lab 0)

### Lab 0 — Linux Tooling *(all assignment work runs in Linux)*
- [[Unix Shell (Bash)]] -> Parent Framework: [[FIT2014_MOC]] *(tri-unit — navigate/inspect/pipe/grep; grep patterns are regexes)*
- [[Text Processing with sed and tr]] -> Parent Framework: [[Unix Shell (Bash)]] *(applied bridge to [[Regular Expressions]] — POSIX BRE)*

### Week 1 — Languages, Propositional & Predicate Logic *(Lectures 1–3)*
- [[Formal Languages (Alphabets, Words, Languages)]] -> Parent Framework: [[FIT2014_MOC]]
- [[Theorem and Proof]] -> Parent Framework: [[FIT1058_MOC]] *(shared with FIT1058 — existential vs universal claims, "proof by example is not a proof")*
- [[Proposition and Truth Value]] -> Parent Framework: [[FIT1058_MOC]] *(shared)*
- [[Logical Connectives]] -> Parent Framework: [[Proposition and Truth Value]] *(shared — $\neg,\wedge,\vee,\Rightarrow,\Leftrightarrow$, truth tables, De Morgan)*
- [[Boolean Algebra Laws]] -> Parent Framework: [[Logical Connectives]] *(shared — tautology, logical equivalence, distributive laws)*
- [[Disjunctive Normal Form]] -> Parent Framework: [[Boolean Algebra Laws]] *(Smart Merged: dual-unit + the True-row/False-row two-table routine)*
- [[Conjunctive Normal Form]] -> Parent Framework: [[Boolean Algebra Laws]] *(Smart Merged: dual-unit + FIT2014's CNF-dominance framing)*
- [[Encoding Problems in Propositional Logic]] -> Parent Framework: [[Conjunctive Normal Form]]
- [[CNF Encoding Patterns (At Least, At Most, Exactly)]] -> Parent Framework: [[Conjunctive Normal Form]]
- [[Predicate]] -> Parent Framework: [[FIT1058_MOC]] *(Smart Merged: dual-unit + free/bound variables, predicates vs functions)*
- [[Quantifiers (Existential and Universal)]] -> Parent Framework: [[Theorem and Proof]] *(Smart Merged: dual-unit + multiple quantifiers, order sensitivity, distribution laws)*

### Week 2 — Proof Craft & Regular Expressions *(Lectures 4–6)*
- [[Proof Techniques]] -> Parent Framework: [[Theorem and Proof]] *(Smart Merged: dual-unit + set/numerical equality strategies, $\sqrt{2}$ canonical)*
- [[Mathematical Induction]] -> Parent Framework: [[Proof Techniques]] *(Smart Merged: dual-unit + correct hypothesis phrasing, extended De Morgan)*
- [[Proof Critique (Good, Bad and Ugly Proofs)]] -> Parent Framework: [[Proof Techniques]]
- [[Countability and Cantor Diagonalisation]] -> Parent Framework: [[Formal Languages (Alphabets, Words, Languages)]]
- [[Regular Expressions]] -> Parent Framework: [[Formal Languages (Alphabets, Words, Languages)]] *(**A1 material**)*
- [[Finding Regular Expressions]] -> Parent Framework: [[Regular Expressions]] *(**A1 hand skill**)*

### Week 3 — Finite Automata & Kleene's Theorem *(Lectures 7–9)*
- [[Finite Automata (DFA and NFA)]] -> Parent Framework: [[Formal Languages (Alphabets, Words, Languages)]] *(**A1 material** — DFA/NFA clustered as variants + complement construction)*
- [[Kleene's Theorem]] -> Parent Framework: [[Formal Languages (Alphabets, Words, Languages)]] *(the equivalence + the four-leg conversion cycle)*
- [[Converting Regular Expressions to NFA]] -> Parent Framework: [[Kleene's Theorem]] *(**A1 hand skill**)*
- [[NFA to DFA (Subset Construction)]] -> Parent Framework: [[Kleene's Theorem]] *(**A1 hand skill**)*
- [[FA to Regular Expression (GNFA State Elimination)]] -> Parent Framework: [[Kleene's Theorem]] *(**A1 hand skill**)*

### Week 4 — Minimisation, Lexical Analysis & the Limits of Regularity *(Lectures 10–11)*
- [[DFA Minimisation (Colouring)]] -> Parent Framework: [[Finite Automata (DFA and NFA)]] *(completes the regex → NFA → DFA → **simplify** pipeline)*
- [[Lexical Analysis (Patterns, Tokens, Lexemes)]] -> Parent Framework: [[Finite Automata (DFA and NFA)]] *(**A2 material** — the application of FAs)*
- [[Closure Properties of Regular Languages]] -> Parent Framework: [[Kleene's Theorem]] *(complement/union/intersection/concatenation; the De Morgan route)*
- [[Pumping Lemma for Regular Languages]] -> Parent Framework: [[Finite Automata (DFA and NFA)]] *(circuits + the pigeonhole proof)*
- [[Proving a Language Non-Regular]] -> Parent Framework: [[Pumping Lemma for Regular Languages]] *(**the exam hand skill** — HALF-AND-HALF, PALINDROME, EQUAL)*
- *(Closes the standing question: $\{$regular languages$\}$ is a **proper subset** of $\{$all languages$\}$ — see [[Kleene's Theorem]] and [[Countability and Cantor Diagonalisation]].)*

### Week 5 — Context-Free Grammars & Pushdown Automata *(Lectures 12–14)*
- [[Context-Free Grammars (CFG)]] -> Parent Framework: [[Formal Languages (Alphabets, Words, Languages)]] *(terminals/nonterminals/productions, BNF, CFL definition)*
- [[Derivations and Parse Trees]] -> Parent Framework: [[Context-Free Grammars (CFG)]] *(leftmost/rightmost, the prefix property)*
- [[Writing a CFG]] -> Parent Framework: [[Context-Free Grammars (CFG)]] *(**hand skill** — Dyck, PALINDROME, $\mathtt{a}^n\mathtt{b}^n$)*
- [[Regular Grammars and the CFL Hierarchy]] -> Parent Framework: [[Context-Free Grammars (CFG)]] *(NFA→grammar; regular ⊊ context-free)*
- [[Pushdown Automata (PDA)]] -> Parent Framework: [[Context-Free Grammars (CFG)]] *(NFA + stack; CFG ⟺ PDA)*
- *(Picks up the pumping-lemma escapees: EQUAL, HALF-AND-HALF, PALINDROME are all **context-free** — see [[Proving a Language Non-Regular]].)*

### Week 6 — Parsing, Chomsky Normal Form & the CFL Frontier *(Lectures 15–17)*
- [[Parsing and Shift-Reduce Parsers]] -> Parent Framework: [[Derivations and Parse Trees]] *(**A2 material** — stack/buffer trace + shift-reduce & reduce-reduce conflicts)*
- [[Lex and Yacc (Parser Generators)]] -> Parent Framework: [[Parsing and Shift-Reduce Parsers]] *(**A2 toolchain** — `lex.yy.c`/`yylex()`, `y.tab.c`/`yyparse()`)*
- [[Chomsky Normal Form]] -> Parent Framework: [[Context-Free Grammars (CFG)]] *(the 5-step conversion + nullability; ⚠ not [[Conjunctive Normal Form]])*
- [[CYK Algorithm]] -> Parent Framework: [[Chomsky Normal Form]] *(**hand skill** — the length-ordered table, $O(n^3)$)*
- [[Pumping Lemma for Context-Free Languages]] -> Parent Framework: [[Context-Free Grammars (CFG)]] *($uvxyz$, $|w|>2^{k-1}$; the two-lemma contrast table)*
- [[Proving a Language Non-Context-Free]] -> Parent Framework: [[Pumping Lemma for Context-Free Languages]] *(**the exam hand skill** — $\mathtt{a}^n\mathtt{b}^n\mathtt{a}^n$, $\mathtt{a}^n\mathtt{b}^n\mathtt{c}^n$)*
- *(Closes the hierarchy picture: regular ⊊ context-free ⊊ all languages — $\mathtt{a}^n\mathtt{b}^n\mathtt{a}^n$ escapes even the CFLs.)*

### 🔭 Coming later in the unit *(from the Lecture 1 roadmap — no notes yet)*
- Turing machines · computability & decidability · computational complexity · classes **P** and **NP** · **NP-completeness**.

## 🧭 Suggested Reading Order
*(read left→right within each week · **bold** = assessment-critical hand skill)*

- **Lab 0 — Linux:** [[Unix Shell (Bash)]] → [[Text Processing with sed and tr]] *(sed/grep = regex in practice)*
- **W1 — languages & logic:** [[Formal Languages (Alphabets, Words, Languages)]] → [[Theorem and Proof]] → [[Proposition and Truth Value]] → [[Logical Connectives]] → [[Boolean Algebra Laws]] → [[Disjunctive Normal Form]] → [[Conjunctive Normal Form]] → **[[Encoding Problems in Propositional Logic]]** *(assessable skill)* → **[[CNF Encoding Patterns (At Least, At Most, Exactly)]]** *(fastest marks)* → [[Predicate]] → **[[Quantifiers (Existential and Universal)]]** *(order sensitivity)*
- **W2 — proof craft → regex:** **[[Proof Techniques]]** *(subset-proof blueprint)* → **[[Mathematical Induction]]** *(hypothesis phrasing)* → [[Proof Critique (Good, Bad and Ugly Proofs)]] *(spot-the-flaw)* → [[Countability and Cantor Diagonalisation]] → [[Regular Expressions]] → **[[Finding Regular Expressions]]** *(A1 hand skill)*
- **W3 — automata & equivalence:** **[[Finite Automata (DFA and NFA)]]** *(trace + complement)* → [[Kleene's Theorem]] *(the cycle)* → **[[Converting Regular Expressions to NFA]]** → **[[NFA to DFA (Subset Construction)]]** → **[[FA to Regular Expression (GNFA State Elimination)]]** *(all three are A1 hand skills)*
- **W4 — minimisation → limits:** **[[DFA Minimisation (Colouring)]]** *(finishes the pipeline)* → [[Lexical Analysis (Patterns, Tokens, Lexemes)]] *(A2)* → [[Closure Properties of Regular Languages]] → **[[Pumping Lemma for Regular Languages]]** → **[[Proving a Language Non-Regular]]** *(the exam kill-shot)*
- **W5 — context-free tier:** [[Context-Free Grammars (CFG)]] → [[Derivations and Parse Trees]] *(leftmost = prefix property)* → **[[Writing a CFG]]** *(hand skill)* → [[Regular Grammars and the CFL Hierarchy]] *(regular ⊊ CFL)* → [[Pushdown Automata (PDA)]] *(NFA + stack; CFG ⟺ PDA)*
- **W6 — parsing → the CFL frontier:** **[[Parsing and Shift-Reduce Parsers]]** *(A2 trace)* → [[Lex and Yacc (Parser Generators)]] *(A2 toolchain)* → **[[Chomsky Normal Form]]** *(enables both below)* → **[[CYK Algorithm]]** *(hand skill)* → **[[Pumping Lemma for Context-Free Languages]]** → **[[Proving a Language Non-Context-Free]]** *(the exam kill-shot)*

## 🎯 Learning Outcomes (key skills per week)

- **Lab 0 (Linux)** ➔ 
	- navigate the filesystem (`pwd`/`ls`/`cd`/`mkdir`) 
	- pipe & redirect (`|`, `>`, `>>`, `<`) 
	- transform text with `sed 's/pat/rep/g'` (backrefs `\(...\)`/`\1`, char classes, anchors), `tr` (map/`-d`/`-s`), `grep` regex 
	- know `sed`/`grep` use **POSIX BRE** (escaped `\(...\)`) — the applied face of [[Regular Expressions]]
- **W1** ➔ 
	- define $\Sigma$/word/language ($\emptyset \neq \{\varepsilon\}$, $\Sigma^*$, $x^0 = \varepsilon$) 
	- decide EVEN-EVEN / DOUBLEWORD / PALINDROMES membership 
	- one example proves $\exists$, never $\forall$ 
	- truth-table the connectives + prove equivalence via the Boolean laws 
	- DNF from True rows, CNF from False rows 
	- encode problems in CNF + cardinality templates ($m = n - x + 1$ literals, $\binom{n}{m}$ clauses) 
	- quantifier discipline ($\exists{+}\wedge$ / $\forall{+}\Rightarrow$, order, negation)
- **W2** ➔ 
	- pick the proof technique from the claim's shape 
	- prove $A = B$ by double inclusion 
	- phrase the inductive hypothesis correctly + test the smallest step 
	- diagnose faulty inductions and *ex falso* traps 
	- listings prove countable; Cantor diagonalisation proves $\{$languages$\}$ uncountable 
	- read/write regexes ($\mathtt{ab}^* \neq (\mathtt{ab})^*$; $R^*$ includes $\varepsilon$) 
	- find a regex from a description, checking the smallest strings
- **W3** ➔ 
	- define an FA both ways (state diagram + transition table) 
	- trace acceptance + state the language 
	- complement a DFA by swapping Final states (fails for NFAs) 
	- define an NFA (accept iff SOME path) 
	- state Kleene's cycle Regexp → NFA → FA → Regexp 
	- run the three conversions by hand (regex→NFA edge rewriting 
	- NFA→DFA subset construction with $\varepsilon$-closure 
	- FA→regex GNFA state elimination)
- **W4** ➔ 
	- minimise a DFA by colouring (Final/non-Final seed; split when row colour-patterns differ; iterate to fixpoint) 
	- implement an FA from its table 
	- distinguish **pattern** (regex) vs **token** (name) vs **lexeme** (text); lexer conventions **maximal munch** then **first-listed** 
	- prove closure under complement/union/**intersection via De Morgan**/concatenation (subsets & supersets are NOT closed) 
	- state + prove the **Pumping Lemma** from the circuit/pigeonhole argument, quantifiers exact 
	- **prove non-regularity**: choose $w$ so $|x|+|y| \le N$ leaves one case ($\mathtt{a}^N\mathtt{b}^N$), pump up or **down**, or use the closure shortcut (EQUAL $\cap\ \mathtt{a}^*\mathtt{b}^*$ = HALF-AND-HALF)
- **W5** ➔ 
	- define a **CFG** (terminals/nonterminals/productions, start symbol) + read/write **BNF** 
	- give the **language generated**; a **CFL** is what some CFG generates 
	- build a **derivation** and its **parse tree**, distinguish **leftmost/rightmost** (same tree, same length) and use the **prefix property** 
	- **write a grammar** from an inductive definition (Dyck $S\to\varepsilon\mid(S)\mid SS$; PALINDROME; $\mathtt{a}^n\mathtt{b}^n$ via $S\to\mathtt{a}S\mathtt{b}\mid\varepsilon$) 
	- recognise a **regular grammar** (semiword rules) and build one from an NFA ($X\xrightarrow{z}Y \Rightarrow X\to zY$); know **{regular} ⊊ {CFL}** 
	- define a **PDA** (NFA + stack; transition $x,y\to z$ = read/pop/push; $\$$ bottom-marker; accept iff some path reaches Final) and know **CFG ⟺ PDA** (both construction directions), that NFA = stackless PDA, and that **deterministic PDAs are weaker**
- **W6** ➔ 
	- run a **shift-reduce** trace (stack + buffer; reduce = rule in reverse; accept iff stack $=S$, buffer empty) 
	- diagnose **shift-reduce** vs **reduce-reduce** conflicts and read them as grammar **ambiguity**; know $\text{DCFL}\subsetneq\text{CFL}$ 
	- set up **Lex** (`lex.yy.c`, `yylex()`) + **Yacc** (`y.tab.c`, `yyparse()`) and their conflict defaults (shift; first-listed rule) 
	- convert a grammar to **[[Chomsky Normal Form]]** by the 5 steps and decide $\varepsilon$ by **nullability** 
	- fill a **[[CYK Algorithm|CYK]]** table by increasing substring length; state $O(n^3)$ 
	- state the **CFL pumping lemma** ($w=uvxyz$, $|w|>2^{k-1}$, $vy\neq\varepsilon$, $|vxy|\le 2^k$) and where CNF enters its proof 
	- **prove non-context-freeness**: pick $w=\mathtt{a}^N\mathtt{b}^N\mathtt{a}^N$, split on where $v,y$ sit, kill straddling cases by repeated boundary patterns
