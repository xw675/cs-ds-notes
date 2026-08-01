---
unit: FIT2014
type: MOC
tags:
  - 2026/S2
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

## 🧰 Toolkit Cheatsheets
- [[FIT2014 Unit Cheatsheet]] -> **the whole-unit exam crib** — W1→W11 as formulas/rules with firing preconditions, in syllabus order; the single re-read before the 3h10 exam
- [[Shell Toolkit (Cheatsheet)]] -> tri-unit (FIT1043 + FIT2014 + FIT2109); FIT2014 adds the `sed`/`tr`/grep-regex block (Lab 0)

## 📅 Knowledge Index

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

### Week 7 — Turing Machines & Universality *(Lectures 18–19)*
- [[Turing Machines]] -> Parent Framework: [[Formal Languages (Alphabets, Words, Languages)]] *(**A2 material** — the model, $\text{Accept}/\text{Reject}/\text{Loop}$, deciders, FA→TM)*
- [[Building Turing Machines]] -> Parent Framework: [[Turing Machines]] *(**the exam hand skill** — the marking recipe, $\mathtt{a}^n\mathtt{b}^n$ and $\mathtt{a}^n\mathtt{b}^n\mathtt{a}^n$)*
- [[Computable Functions and the Church-Turing Thesis]] -> Parent Framework: [[Turing Machines]] *(unary codes, successor/double/addition, the thesis is **not** a theorem)*
- [[Encoding Turing Machines (Code Words)]] -> Parent Framework: [[Turing Machines]] *(**hand skill** — encode/decode a table; CWL is regular but ⊋ {TM codes})*
- [[Universal Turing Machine]] -> Parent Framework: [[Turing Machines]] *(programs as data — the stored-program idea)*
- *(Breaks the hierarchy's ceiling: $\mathtt{a}^n\mathtt{b}^n\mathtt{a}^n$ defeated the [[Pumping Lemma for Context-Free Languages|CFL pumping lemma]] yet a TM decides it — see [[Proving a Language Non-Context-Free]].)*

### Week 8 — Decidability & Mapping Reductions *(Lectures 20–21)*
- [[Decidability and Decision Problems]] -> Parent Framework: [[Turing Machines]] *(deciders, decidable = recursive = solvable, problem ⟷ language, $\langle O\rangle$ encoding, closure)*
- [[Deciding Properties of FAs and CFGs]] -> Parent Framework: [[Decidability and Decision Problems]] *(**hand skill** — FA-Empty & CFG-Empty marking, RegExpEquiv via symmetric difference)*
- [[Mapping Reductions]] -> Parent Framework: [[Decidability and Decision Problems]] *(**the exam hand skill** — $\le_m$, the transfer theorem, direction discipline)*
- *(Adds the tier above the hierarchy: regular ⊊ context-free ⊊ **decidable** ⊊ ? — the outer ring stays unnamed until undecidability.)*

### Week 9 — Undecidability & Recursive Enumerability *(Lectures 22–23)*
- [[Undecidability and the Halting Problem]] -> Parent Framework: [[Decidability and Decision Problems]] *(names the $\boxed{?}$ ring — counting + the diagonalisation/Liar proof)*
- [[Proving Undecidability by Reduction]] -> Parent Framework: [[Mapping Reductions]] *(**the exam hand skill** — the input-blind gadget $M\mapsto M'$)*
- [[Recursively Enumerable Languages]] -> Parent Framework: [[Decidability and Decision Problems]] *(decidable $=$ r.e. $\cap$ co-r.e.; $\text{HALT}$ vs $\overline{\text{HALT}}$)*
- [[Enumerators and Dovetailing]] -> Parent Framework: [[Recursively Enumerable Languages]] *(the generative characterisation + the $k$-then-$i$ schedule)*
- *(Fills in the outer ring at last: regular ⊊ context-free ⊊ decidable ⊊ **r.e.** ⊊ all languages — $\text{HALT}$ and $\overline{\text{HALT}}$ are the two named separating inhabitants.)*

### Week 10 — Complexity: P, NP & Polynomial-Time Reductions *(Lectures 24–26)*
- [[Polynomial Time and the Class P]] -> Parent Framework: [[Decidability and Decision Problems]] *(decidability is not enough — $t_M(n)$, fixed $k$, the polynomial-slowdown model-independence proof)*
- [[Verifiers, Certificates and the Class NP]] -> Parent Framework: [[Polynomial Time and the Class P]] *(**the exam hand skill** — the 4-part membership proof; $\mathrm{P}\subseteq\mathrm{NP}\subseteq\mathrm{EXP}$; NDTMs)*
- [[Standard NP Problems and Certificates]] -> Parent Framework: [[Verifiers, Certificates and the Class NP]] *(the named instance stock — VC/IS/CLIQUE, SAT family, Euler vs Hamilton, PARTITION/SUBSET SUM)*
- [[Polynomial-Time Reductions]] -> Parent Framework: [[Mapping Reductions]] *(**the exam hand skill** — $\le_P$, the output-length lemma, the transfer theorem)*
- *(Splits the decidable tier by cost: regular ⊊ context-free ⊊ **P** ⊊ decidable, with $\mathrm{NP}$ straddling the frontier — and re-times [[Mapping Reductions]], which transferred decidability but **not** tractability.)*

### Week 11 — NP-Completeness *(Lectures 27–30)*
- [[NP-Completeness]] -> Parent Framework: [[Verifiers, Certificates and the Class NP]] *(conditions (a)+(b), the master theorem poly-decider $\iff\mathrm{P}=\mathrm{NP}$, co-NP, the four engineering options)*
- [[Reducing to SATISFIABILITY]] -> Parent Framework: [[NP-Completeness]] *(**the W11 hand skill** — the 4-step recipe + PARTITION INTO TRIANGLES worked end-to-end; the W1 CNF templates re-timed)*
- [[Cook-Levin Theorem]] -> Parent Framework: [[NP-Completeness]] *(SAT is NP-complete; **proof explicitly non-examinable** — statement, part (a), and architecture only)*
- [[Proving NP-Completeness by Reduction]] -> Parent Framework: [[NP-Completeness]] *(**the exam hand skill** — inheritance theorem, SAT $\le_P$ 3-SAT, 3-SAT $\le_P$ VERTEX COVER with $k_\phi=2m+n$)*
- *(Closes the unit's arc: the [[Polynomial-Time Reductions|$\le_P$]] relation acquires a **summit** — one efficient algorithm for any NP-complete language would settle $\mathrm{P}$ vs $\mathrm{NP}$ outright.)*

## 🧭 Suggested Reading Order
*(read left→right within each week · **bold** = assessment-critical hand skill)*

- **Lab 0 — Linux:** [[Unix Shell (Bash)]] → [[Text Processing with sed and tr]] *(sed/grep = regex in practice)*
- **W1 — languages & logic:** [[Formal Languages (Alphabets, Words, Languages)]] → [[Theorem and Proof]] → [[Proposition and Truth Value]] → [[Logical Connectives]] → [[Boolean Algebra Laws]] → [[Disjunctive Normal Form]] → [[Conjunctive Normal Form]] → **[[Encoding Problems in Propositional Logic]]** *(assessable skill)* → **[[CNF Encoding Patterns (At Least, At Most, Exactly)]]** *(fastest marks)* → [[Predicate]] → **[[Quantifiers (Existential and Universal)]]** *(order sensitivity)*
- **W2 — proof craft → regex:** **[[Proof Techniques]]** *(subset-proof blueprint)* → **[[Mathematical Induction]]** *(hypothesis phrasing)* → [[Proof Critique (Good, Bad and Ugly Proofs)]] *(spot-the-flaw)* → [[Countability and Cantor Diagonalisation]] → [[Regular Expressions]] → **[[Finding Regular Expressions]]** *(A1 hand skill)*
- **W3 — automata & equivalence:** **[[Finite Automata (DFA and NFA)]]** *(trace + complement)* → [[Kleene's Theorem]] *(the cycle)* → **[[Converting Regular Expressions to NFA]]** → **[[NFA to DFA (Subset Construction)]]** → **[[FA to Regular Expression (GNFA State Elimination)]]** *(all three are A1 hand skills)*
- **W4 — minimisation → limits:** **[[DFA Minimisation (Colouring)]]** *(finishes the pipeline)* → [[Lexical Analysis (Patterns, Tokens, Lexemes)]] *(A2)* → [[Closure Properties of Regular Languages]] → **[[Pumping Lemma for Regular Languages]]** → **[[Proving a Language Non-Regular]]** *(the exam kill-shot)*
- **W5 — context-free tier:** [[Context-Free Grammars (CFG)]] → [[Derivations and Parse Trees]] *(leftmost = prefix property)* → **[[Writing a CFG]]** *(hand skill)* → [[Regular Grammars and the CFL Hierarchy]] *(regular ⊊ CFL)* → [[Pushdown Automata (PDA)]] *(NFA + stack; CFG ⟺ PDA)*
- **W6 — parsing → the CFL frontier:** **[[Parsing and Shift-Reduce Parsers]]** *(A2 trace)* → [[Lex and Yacc (Parser Generators)]] *(A2 toolchain)* → **[[Chomsky Normal Form]]** *(enables both below)* → **[[CYK Algorithm]]** *(hand skill)* → **[[Pumping Lemma for Context-Free Languages]]** → **[[Proving a Language Non-Context-Free]]** *(the exam kill-shot)*
- **W7 — Turing machines → universality:** [[Turing Machines]] *(three outcomes, deciders)* → **[[Building Turing Machines]]** *(the marking recipe)* → [[Computable Functions and the Church-Turing Thesis]] *(unary codes)* → **[[Encoding Turing Machines (Code Words)]]** *(encode/decode)* → [[Universal Turing Machine]] *(programs as data)*
- **W8 — decidability → reductions:** [[Decidability and Decision Problems]] *(halting is the point)* → **[[Deciding Properties of FAs and CFGs]]** *(marking to fixpoint)* → **[[Mapping Reductions]]** *(direction discipline)*
- **W9 — undecidability → r.e.:** **[[Undecidability and the Halting Problem]]** *(the diagonalisation proof)* → **[[Proving Undecidability by Reduction]]** *(the exam hand skill)* → [[Recursively Enumerable Languages]] *(the bridge theorem)* → [[Enumerators and Dovetailing]] *(the schedule)*
- **W10 — complexity:** [[Polynomial Time and the Class P]] *(fixed $k$, slowdown)* → **[[Verifiers, Certificates and the Class NP]]** *(4-part membership proof)* → [[Standard NP Problems and Certificates]] *(instance stock)* → **[[Polynomial-Time Reductions]]** *(the exam hand skill)*
- **W11 — NP-completeness:** [[NP-Completeness]] *(both conditions)* → **[[Reducing to SATISFIABILITY]]** *(the CNF hand skill)* → [[Cook-Levin Theorem]] *(non-examinable proof)* → **[[Proving NP-Completeness by Reduction]]** *(the exam kill-shot)*
- **SWOTVAC — whole unit:** **[[FIT2014 Unit Cheatsheet]]** *(one re-read, all 11 weeks)*

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
- **W7** ➔ 
	- define a **TM** (tape, head, program; Start $=1$, Accept $=2$; crash $=$ reject) and trace one
	- partition $\Sigma^*$ into $\text{Accept}(T)$, $\text{Reject}(T)$, $\text{Loop}(T)$; a **decider** has $\text{Loop}(T)=\emptyset$
	- convert an **FA → TM** by the 5 steps ⟹ every regular language is **decidable**
	- **build a TM** for $\mathtt{a}^n\mathtt{b}^n$ and $\mathtt{a}^n\mathtt{b}^n\mathtt{a}^n$ by the mark-and-sweep recipe
	- read the **unary code** ($n\mapsto\mathtt{a}^n$, tuples $\mathtt{b}$-separated) and define $f$ by a TM; state the **Church–Turing thesis** and why it is not a theorem
	- **encode and decode** a TM table ($\mathtt{a}^n\mathtt{b}$ states, 2-letter symbols, 1-letter direction); know $\text{CWL}=(\mathtt{aa}^*\mathtt{b}\mathtt{aa}^*\mathtt{b}(\mathtt{a}\cup\mathtt{b})^5)^*$ is regular but $\supsetneq$ {TM codes}
	- say what a **UTM** does, lay out $\langle M\rangle\,\$\,x$, and justify why UTMs exist
- **W8** ➔ 
	- define a **decider** ($\text{Loop}(M)=\emptyset$) and **decidable** ($L=\text{Accept}(M)$, so $\overline{L}=\text{Reject}(M)$ free); decidable $=$ recursive $=$ solvable
	- convert a **decision problem** to its YES-input language and back; encode objects as $\langle O\rangle$, tuples as $\langle O_1,\dots,O_n\rangle$
	- place the tier: regular ⊊ context-free ⊊ **decidable**; prove closure under $\overline{\ \cdot\ }$, $\cup$, $\cap$, concatenation by running deciders as subroutines
	- run the **FA-Empty** marking algorithm (seed Start, propagate forward, Accept iff **no** Final State marked)
	- run the **CFG-Empty** marking algorithm (seed terminals, propagate upward, Accept iff $S$ **un**marked)
	- decide **RegExpEquiv** by emptiness of $\big(L(A)\cap\overline{L(B)}\big)\cup\big(\overline{L(A)}\cap L(B)\big)$
	- define a **mapping reduction** ($f$ computable, $x\in K \iff f(x)\in L$) and write the certifying **iff chain**
	- apply the transfer theorem: $L$ decidable $\Rightarrow K$ decidable; $K$ undecidable $\Rightarrow L$ undecidable; $\le_m$ is transitive, **not** symmetric
	- build the standard reductions (EQUAL → HALF-AND-HALF by sorting, FA-Empty → No-Digraph-Path by the sink vertex $t$)
	- know why reducing **from** a decidable $L_1$ to any $L_2\neq\emptyset,\Sigma^*$ proves nothing
- **W9** ➔ 
	- argue from countability that **undecidable languages exist** (existence only — names nobody)
	- state the **Halting Problem** $\{\langle P,x\rangle : P \text{ halts on } x\}$ and its diagonal one-argument form
	- **prove undecidability**: build $E$ flipping the diagonal, say which assumption dies
	- run the **input-blind gadget** $M'$ = "ignore $x$, run $M$ on $M$" ⟹ HALT-FOR-ZERO / ALWAYS HALTS / SOMETIMES HALTS
	- get **NEVER HALTS** by the Accept/Reject swap; say why that is illegal on recognisers
	- classify: bounded-step halting and state-counting **decidable**; acceptance and $\exists$-input halting **not**
	- define **r.e.** ($\text{Accept}(T)=L$, $\text{Loop}(T)$ unrestricted) + synonyms (Turing recognisable, type 0)
	- prove **$L$ decidable $\iff$ $L$ and $\overline{L}$ both r.e.** via the one-step interleaved decider
	- prove $\text{HALT}$ is **r.e. but undecidable**, $\overline{\text{HALT}}$ is **not r.e.**; decidable $=$ r.e. $\cap$ co-r.e.
	- prove **r.e. $\iff$ enumerated**, with the $k$-then-$i$ **dovetailing** schedule
- **W10** ➔ 
	- compute $t_M(n)=\max\{t_M(x):\lvert x\rvert=n\}$ and say why it needs a **decider**
	- define **polynomial time** ($O(n^k)$, $k$ **fixed**) and $\mathrm{P}$; place regular ⊊ CFL ⊊ $\mathrm{P}$ ⊊ decidable
	- run the **polynomial-slowdown** argument for model-independence of $\mathrm{P}$
	- define **verifier** and **certificate**; bound time in $\lvert x\rvert$, never $\lvert y\rvert$
	- **prove membership of $\mathrm{NP}$** in 4 parts: certificate · verifier · iff claim · time claim (3-colourability, $O(mn)$)
	- prove $\mathrm{P}\subseteq\mathrm{NP}$ (ignore the certificate) and $\mathrm{NP}\subseteq\mathrm{EXP}$ (search $\le 2^{cn^k}$ certificates)
	- state the **NDTM** characterisation of $\mathrm{NP}$ and why DFA $=$ NFA does not transfer
	- recall instance $+$ certificate for VERTEX COVER, INDEPENDENT SET, CLIQUE, SAT/2-SAT/3-SAT, colouring, PARTITION, SUBSET SUM
	- **build a $\le_P$ reduction**: function $+$ **iff chain** $+$ **time bound**, via the one-symbol-per-step output-length lemma
	- apply the transfer theorem ($L\in\mathrm{P}\Rightarrow K\in\mathrm{P}$; $K\notin\mathrm{P}\Rightarrow L\notin\mathrm{P}$) and re-time old $\le_m$ reductions
- **W11** ➔ 
	- define **NP-complete** by both conditions and name the failure mode of each (**NP-hard** when (a) fails)
	- prove the master theorem: an NP-complete $L$ has a poly decider $\iff\mathrm{P}=\mathrm{NP}$
	- place SAT/3-SAT/VC/IS/CLIQUE, GRAPH ISOMORPHISM, and the $\mathrm{P}$ problems on the two-lobe diagram
	- **reduce a language to SAT**: certificate variables $+$ rule clauses $+$ clause count
	- state the **[[Cook-Levin Theorem]]** and prove part (a) only *(the rest is non-examinable)*
	- apply the **inheritance theorem** ($K$ NP-complete, $L\in\mathrm{NP}$, $K\le_P L$) — just one reduction
	- run $\text{SAT}\le_P3\text{-SAT}$ (fresh-variable padding and chaining) and $3\text{-SAT}\le_P\text{VERTEX COVER}$ ($k_\phi=2m+n$)
	- choose the response to NP-completeness: exponential · randomised · special-case · approximation
