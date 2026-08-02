---
unit: FIT2014
parent: "[[FIT2014_MOC]]"
tags: [Math/Theory, CS/Computation]
type: cheatsheet
aliases: [FIT2014 Exam Crib, Theory of Computation Cheatsheet]
---
# [[FIT2014 Unit Cheatsheet]]

**Context:** [[FIT2014_MOC]] · the WHOLE unit in one re-read — languages → logic → automata → grammars → parsing → Turing machines → decidability → complexity → NP-completeness. Every claim is hand-derivable; links for depth only.

> [!abstract] Quick Revision
> - **🎯 Objective:** match the claim's SHAPE to a formula or proof blueprint ➔ derive in `\begin{aligned}`, seal with Q.E.D.
> - **⚠️ Key Constraint:** hypothesis discipline — every rule here has a **precondition**; marks die when a rule fires without it (infinite vs finite, regular vs context-free, decidable vs recognisable, $\le_m$ vs $\le_P$).

## 1️⃣ Languages and Words
- **[[Formal Languages (Alphabets, Words, Languages)|Alphabet & word]]** ➔ $\Sigma$ finite non-empty; a word is a finite sequence over $\Sigma$; $\varepsilon$ is the empty word **· precondition** $\emptyset\neq\{\varepsilon\}$ — the empty *language* has no words, the language $\{\varepsilon\}$ has one.
- **Closure** ➔ $\Sigma^{*}=$ all finite words including $\varepsilon$; $x^{0}=\varepsilon$; $\lvert\Sigma^{*}\rvert$ is **countably infinite** for any finite $\Sigma$.
- **Language** ➔ any $L\subseteq\Sigma^{*}$ **· precondition** membership must be *decidable by definition, not by intuition* — state the defining predicate.
- **Named test languages** ➔ EVEN-EVEN · DOUBLEWORD $\{ww\}$ · PALINDROME · EQUAL ($\#\mathtt{a}=\#\mathtt{b}$) · HALF-AND-HALF ($\mathtt{a}^{n}\mathtt{b}^{n}$-style split).

## 2️⃣ Propositional Logic → CNF Encoding
- **[[Logical Connectives|Connectives]]** ➔ $\neg,\wedge,\vee,\Rightarrow,\Leftrightarrow$; $A\Rightarrow B\equiv\neg A\vee B$ **· precondition for CNF conversion** — implications must be eliminated *before* De Morgan.
- **[[Boolean Algebra Laws|De Morgan]]** ➔ $\neg(A\wedge B)\equiv\neg A\vee\neg B$, $\neg(A\vee B)\equiv\neg A\wedge\neg B$; extends to $n$ terms **by [[Mathematical Induction|induction]]**, not by assertion.
- **[[Disjunctive Normal Form|DNF]]** ➔ OR of ANDs; read off the **True** rows of the truth table, one conjunct per row.
- **[[Conjunctive Normal Form|CNF]]** ➔ AND of ORs; read off the **False** rows, **negating each literal** — the sign flip is the whole trick.
- **[[CNF Encoding Patterns (At Least, At Most, Exactly)|At least $x$ from $n$]]** ➔ clause size $m=n-x+1$, write **all** $\binom{n}{m}$ clauses, literals **unnegated**.
- **At most $y$ from $n$** ➔ same formula on **negated** literals with $x=n-y$, giving $m=y+1$ and $\binom{n}{m}$ clauses.
- **Exactly $z$** ➔ (at least $z$) $\wedge$ (at most $z$) **· precondition** both halves must be written; one alone is a strict inequality.
- **[[Encoding Problems in Propositional Logic|Encoding a problem]]** ➔ ① variable per atomic choice ② clauses per validity rule ③ conjoin **· precondition** the *rules*, not just the certificate, must be encoded.

## 3️⃣ Predicates and Quantifiers
- **[[Predicate]]** ➔ a proposition-valued function $P(x)$; a **free** variable makes it not yet a proposition, a **bound** one does.
- **[[Quantifiers (Existential and Universal)|Pairing rule]]** ➔ $\exists$ pairs with $\wedge$, $\forall$ pairs with $\Rightarrow$ **· precondition** — $\forall x(P(x)\wedge Q(x))$ over-claims and $\exists x(P(x)\Rightarrow Q(x))$ is vacuously true.
- **Negation** ➔ $\neg\forall x\,P\equiv\exists x\,\neg P$; $\neg\exists x\,P\equiv\forall x\,\neg P$.
- **Order sensitivity** ➔ $\forall x\exists y\,P(x,y)\not\equiv\exists y\forall x\,P(x,y)$; the second is strictly stronger **· precondition** swapping is only safe for **like** quantifiers.
- **Distribution** ➔ $\forall$ distributes over $\wedge$, $\exists$ over $\vee$; the mixed pairs do **not**.

## 4️⃣ Proof Craft
- **[[Theorem and Proof|Claim shape ➔ technique]]** ➔ $\exists$: exhibit one witness · $\forall$: never by example · $\Rightarrow$: direct or contrapositive · "no such thing": contradiction.
- **[[Proof Techniques|Set equality]]** ➔ $A=B$ by **double inclusion** $A\subseteq B$ and $B\subseteq A$; each inclusion starts "let $x\in A$".
- **Contrapositive** ➔ $P\Rightarrow Q\equiv\neg Q\Rightarrow\neg P$; **contradiction** assumes $P\wedge\neg Q$ and derives absurdity (canonical: $\sqrt{2}\notin\mathbb{Q}$).
- **[[Mathematical Induction|Induction]]** ➔ base case at the **smallest** relevant $n$, then $P(n)\Rightarrow P(n+1)$ **· precondition** the hypothesis must be the *full* statement for $n$, and the smallest step must be tested (the classic failure is $n=1\to2$).
- **[[Proof Critique (Good, Bad and Ugly Proofs)|Faulty-proof tells]]** ➔ missing/ wrong base case · hypothesis assumed for $n+1$ · *ex falso* (a false premise proves anything) · example offered for a $\forall$ claim.
- **[[Countability and Cantor Diagonalisation|Countability]]** ➔ an explicit **listing** proves countable; **diagonalisation** proves $\{$languages over $\Sigma\}$ **uncountable** ⟹ some language has no description at all.

## 5️⃣ Regular Expressions and Finite Automata
- **[[Regular Expressions|Regex]]** ➔ built from $\emptyset,\varepsilon$, letters, $\cup$, concatenation, $*$ **· precondition** $R^{*}$ **includes** $\varepsilon$, and $\mathtt{ab}^{*}\neq(\mathtt{ab})^{*}$ — precedence is $*$ then concat then $\cup$.
- **[[Finding Regular Expressions|Finding one]]** ➔ describe the *shape* of an accepted word, then verify on the **shortest** strings including $\varepsilon$.
- **[[Finite Automata (DFA and NFA)|DFA]]** ➔ $(Q,\Sigma,\delta,q_0,F)$ with $\delta$ **total and single-valued**; accept iff the unique run ends in $F$.
- **NFA** ➔ $\delta$ may be multi-valued or missing, $\varepsilon$-moves allowed; accept iff **some** path ends in $F$.
- **Complement** ➔ swap Final/non-Final **· precondition DFA only** — the same swap on an NFA is wrong, because "some path accepts" does not negate pointwise.
- **[[Kleene's Theorem]]** ➔ regex $\equiv$ NFA $\equiv$ DFA; proved by the cycle regex $\to$ NFA $\to$ DFA $\to$ regex.
- **[[Converting Regular Expressions to NFA|regex $\to$ NFA]]** ➔ Thompson-style edge rewriting, one construction per operator.
- **[[NFA to DFA (Subset Construction)|NFA $\to$ DFA]]** ➔ states are **sets** of NFA states; start $=\varepsilon$-closure of $q_0$; Final iff the set meets $F$ **· cost** up to $2^{q}$ states — this is why the construction is **not** polynomial *(see §1️⃣2️⃣)*.
- **[[FA to Regular Expression (GNFA State Elimination)|FA $\to$ regex]]** ➔ GNFA state elimination; before deleting a state, relabel **every ordered pair** $(q_{\text{in}},q_{\text{out}})$ as $R_{\text{direct}}\cup\big(R_{\text{in}}R_{\text{loop}}^{*}R_{\text{out}}\big)$ **· precondition** missing a pair loses strings, and $R_{\text{direct}}$ must be kept in the union.

## 6️⃣ Limits of Regularity
- **[[DFA Minimisation (Colouring)|Minimisation]]** ➔ seed two colours (Final / non-Final), split any class whose rows disagree on successor colours, iterate **to fixpoint** **· precondition** the DFA must be **complete** first.
- **[[Lexical Analysis (Patterns, Tokens, Lexemes)|Lexing vocabulary]]** ➔ **pattern** = the regex · **token** = the name · **lexeme** = the matched text; conflicts resolved by **maximal munch**, then **first-listed rule**.
- **[[Closure Properties of Regular Languages|Closure]]** ➔ regular languages are closed under $\overline{\ \cdot\ }$, $\cup$, $\cap$, concatenation, $*$ **· note** $\cap$ is obtained via De Morgan; **subsets and supersets are NOT closed**.
- **[[Pumping Lemma for Regular Languages|Pumping Lemma]]** ➔ $L$ **infinite regular** with an $N$-state FA ⟹ $\forall w\in L,\lvert w\rvert\ge N$, $\exists x,y,z$: $w=xyz$, $y\neq\varepsilon$, $\lvert x\rvert+\lvert y\rvert\le N$, $\forall i\ge 0: xy^{i}z\in L$ **· precondition** infinite **and** regular; it is **necessary, never sufficient**.
- **[[Proving a Language Non-Regular|Non-regularity recipe]]** ➔ assume regular with pumping length $N$ ➔ choose $w$ so that $\lvert x\rvert+\lvert y\rvert\le N$ **forces $y$ into one block** (canonically $w=\mathtt{a}^{N}\mathtt{b}^{N}$) ➔ pump up **or down** ($i=0$ is legal) ➔ contradiction.
- **Closure shortcut** ➔ if $L\cap R$ is known non-regular for a **regular** $R$, then $L$ is non-regular (e.g. EQUAL $\cap\ \mathtt{a}^{*}\mathtt{b}^{*}$).

## 7️⃣ Context-Free Grammars and PDAs
- **[[Context-Free Grammars (CFG)|CFG]]** ➔ terminals, nonterminals, productions $A\to\alpha$ with **a single nonterminal on the left**, start symbol $S$; a **CFL** is any language some CFG generates.
- **[[Derivations and Parse Trees|Derivation]]** ➔ leftmost and rightmost give the **same tree and the same length**; the **prefix property** is what makes leftmost usable for parsing.
- **[[Writing a CFG|Grammar-writing stock]]** ➔ $\mathtt{a}^{n}\mathtt{b}^{n}$: $S\to\mathtt{a}S\mathtt{b}\mid\varepsilon$ · Dyck: $S\to\varepsilon\mid(S)\mid SS$ · PALINDROME: $S\to\mathtt{a}S\mathtt{a}\mid\mathtt{b}S\mathtt{b}\mid\mathtt{a}\mid\mathtt{b}\mid\varepsilon$.
- **[[Regular Grammars and the CFL Hierarchy|Regular grammar]]** ➔ every rule has a **semiword** RHS; from an NFA, $X\xrightarrow{z}Y$ becomes $X\to zY$ ⟹ $\{$regular$\}\subsetneq\{$CFL$\}$.
- **[[Pushdown Automata (PDA)|PDA]]** ➔ NFA + stack; transition $x,y\to z$ = read $x$, pop $y$, push $z$; $\$$ marks the stack bottom; accept iff **some** path reaches a Final state.
- **Equivalence** ➔ CFG $\iff$ PDA (both directions constructive); an NFA is a stackless PDA **· precondition** **deterministic** PDAs are strictly weaker — $\text{DCFL}\subsetneq\text{CFL}$.

## 8️⃣ Parsing, Chomsky Normal Form, CYK
- **[[Parsing and Shift-Reduce Parsers|Shift-reduce]]** ➔ stack + buffer; **shift** moves one token across, **reduce** applies a rule **in reverse**; accept iff stack $=S$ and buffer empty.
- **Conflicts** ➔ **shift-reduce** (both legal) and **reduce-reduce** (two rules match) both signal grammar **ambiguity**.
- **[[Lex and Yacc (Parser Generators)|Toolchain]]** ➔ Lex $\to$ `lex.yy.c` / `yylex()`; Yacc $\to$ `y.tab.c` / `yyparse()`; defaults resolve shift-reduce by **shifting** and reduce-reduce by the **first-listed** rule.
- **[[Chomsky Normal Form|Chomsky NF]]** ➔ every rule $A\to BC$ (live) or $A\to\mathtt{z}$ (dead) **· precondition** CNF generates the **non-empty** words only; $\varepsilon$ goes to the **nullability** algorithm. ⚠ not [[Conjunctive Normal Form]].
- **5-step conversion** ➔ ① eliminate $\varepsilon$-productions (to fixpoint) ② eliminate unit productions ③ isolate terminals into dead rules ④ break long RHS into binary chains ⑤ tidy unreachable/dead nonterminals.
- **[[CYK Algorithm|CYK]]** ➔ fill by increasing substring **length**; length-$\ell$ cell takes the union over the $\ell-1$ binary splits; **Accept** iff $S$ appears in the whole-string cell **· precondition** grammar in Chomsky NF **· cost** $O(n^{3})$.
- **[[Pumping Lemma for Context-Free Languages|CFL Pumping Lemma]]** ➔ CFG in CNF with $k$ nonterminals ⟹ $\forall w\in L$ with $\lvert w\rvert>2^{k-1}$, $\exists u,v,x,y,z$: $w=uvxyz$, $vy\neq\varepsilon$, $\lvert vxy\rvert\le 2^{k}$, $\forall i\ge 0: uv^{i}xy^{i}z\in L$ **· note** CNF enters via the binary-tree height argument.
- **[[Proving a Language Non-Context-Free|Non-CF recipe]]** ➔ take $w=\mathtt{a}^{N}\mathtt{b}^{N}\mathtt{a}^{N}$ or $\mathtt{a}^{N}\mathtt{b}^{N}\mathtt{c}^{N}$ ➔ case-split on which blocks $v,y$ occupy ➔ $\lvert vxy\rvert\le 2^{k}$ stops them spanning all three blocks ⟹ pumping breaks the counts.

## 9️⃣ Turing Machines
- **[[Turing Machines|TM]]** ➔ two-way infinite tape, head, finite program; **Start $=1$, Accept $=2$**; a crash (no applicable transition) **rejects**.
- **Three outcomes** ➔ $\Sigma^{*}$ partitions into $\text{Accept}(T)$, $\text{Reject}(T)$, $\text{Loop}(T)$ **· definition** $T$ is a **decider** iff $\text{Loop}(T)=\emptyset$.
- **FA $\to$ TM** ➔ 5-step conversion ⟹ **every regular language is decidable**.
- **[[Building Turing Machines|Building recipe]]** ➔ mark-and-sweep: mark leftmost unmarked $\mathtt{a}$, run right to the matching $\mathtt{b}$, mark, return, repeat; accept when a full sweep finds nothing left to match.
- **[[Computable Functions and the Church-Turing Thesis|Unary code]]** ➔ $n\mapsto\mathtt{a}^{n}$, tuples separated by $\mathtt{b}$; $f$ is computable iff some TM leaves $f(x)$ on the tape **· precondition** the **Church–Turing thesis is a thesis, not a theorem** — it cannot be cited as a proof step.
- **[[Encoding Turing Machines (Code Words)|Code words]]** ➔ one row per transition, 5 fields: state $\mathtt{a}^{n}\mathtt{b}$, 2-letter symbols, 1-letter direction; $\text{CWL}=(\mathtt{aa}^{*}\mathtt{b}\mathtt{a}\mathtt{a}^{*}\mathtt{b}(\mathtt{a}\cup\mathtt{b})^{5})^{*}$ is **regular** but strictly **larger** than the set of genuine TM codes.
- **[[Universal Turing Machine|UTM]]** ➔ takes $\langle M\rangle\,\texttt{\$}\,x$ and simulates $M$ on $x$ — programs as data, the stored-program idea.

## 🔟 Decidability and Mapping Reductions
- **[[Decidability and Decision Problems|Decidable]]** ➔ $L=\text{Accept}(M)$ for some **decider** $M$; then $\overline{L}=\text{Reject}(M)$ comes free. Synonyms: recursive, solvable.
- **Problem $\leftrightarrow$ language** ➔ a decision problem becomes the language of its YES-inputs; objects encode as $\langle O\rangle$, tuples as $\langle O_1,\dots,O_n\rangle$.
- **Closure** ➔ decidable languages are closed under $\overline{\ \cdot\ },\cup,\cap$, concatenation — proved by running deciders as **subroutines** **· precondition** subroutine calls must be shown to **terminate**, which is exactly what a decider guarantees.
- **[[Deciding Properties of FAs and CFGs|FA-Empty]]** ➔ mark the Start state, propagate **forward** along transitions to fixpoint; **Accept iff no Final state is marked**.
- **CFG-Empty** ➔ mark terminals, propagate **upward** through rules to fixpoint; **Accept iff $S$ is UNmarked**.
- **RegExpEquiv** ➔ decide emptiness of $\big(L(A)\cap\overline{L(B)}\big)\cup\big(\overline{L(A)}\cap L(B)\big)$ **· cost** requires determinisation, so decidable but **not** polynomial.
- **[[Mapping Reductions|Mapping reduction]]** ➔ computable total $f$ with $x\in K\iff f(x)\in L$, written $K\le_{m}L$ **· precondition** the certifying **iff chain** must be written both ways.
- **Transfer** ➔ $L$ decidable $\Rightarrow K$ decidable; $K$ undecidable $\Rightarrow L$ undecidable **· precondition** $\le_m$ is reflexive and transitive, **not symmetric** — direction is everything.
- **Degenerate case** ➔ reducing **from** a decidable $K$ proves nothing about $L$, and needs $L\neq\emptyset,\Sigma^{*}$ to exist at all.

## 1️⃣1️⃣ Undecidability and Recursive Enumerability
- **Existence argument** ➔ TMs are countable, languages are uncountable ⟹ undecidable languages exist **· limitation** names none of them.
- **[[Undecidability and the Halting Problem|HALT]]** ➔ $\{\langle P,x\rangle: P$ halts on $x\}$ is **undecidable**; proof builds $E$ that flips the diagonal, so the assumed decider cannot exist.
- **[[Proving Undecidability by Reduction|Input-blind gadget]]** ➔ from $M$ build $M'$ = "ignore the input, run $M$ on $\langle M\rangle$" ⟹ HALT-FOR-ZERO, ALWAYS HALTS, SOMETIMES HALTS all undecidable.
- **NEVER HALTS** ➔ obtained by the Accept/Reject swap **· precondition** the swap is **illegal on recognisers** (a loop is neither), legal only on deciders.
- **Decidable side** ➔ bounded-step halting and state-counting **are** decidable; acceptance and $\exists$-input halting are not.
- **[[Recursively Enumerable Languages|r.e.]]** ➔ $L=\text{Accept}(T)$ with $\text{Loop}(T)$ unrestricted; synonyms Turing-recognisable, type 0.
- **Bridge theorem** ➔ $L$ decidable $\iff$ $L$ **and** $\overline{L}$ are both r.e. — proved by interleaving both machines one step at a time.
- **Separation** ➔ $\text{HALT}$ is r.e. but undecidable; $\overline{\text{HALT}}$ is **not r.e.**; decidable $=$ r.e. $\cap$ co-r.e.
- **[[Enumerators and Dovetailing|Enumeration]]** ➔ $L$ r.e. $\iff$ $L$ is enumerated by some machine, using the **$k$-then-$i$ dovetailing** schedule **· precondition** a naive "run input 1 to completion first" schedule fails on a looping input.

## 1️⃣2️⃣ P, NP and Polynomial-Time Reductions
- **[[Polynomial Time and the Class P|Running time]]** ➔ $t_M(n)=\max\{t_M(x):\lvert x\rvert=n\}$ **· precondition** $M$ must be a **decider**, else the max is undefined.
- **$\mathrm{P}$** ➔ languages with an $O(n^{k})$ decider, $k$ **fixed** — $n^{\log n}$ does not qualify. Placement: regular $\subsetneq$ CFL $\subsetneq\mathrm{P}\subsetneq$ decidable.
- **Model independence** ➔ reasonable machine models simulate each other with **polynomial slowdown**, and a polynomial of a polynomial is a polynomial.
- **[[Verifiers, Certificates and the Class NP|Verifier & certificate]]** ➔ $L\in\mathrm{NP}$ iff some polynomial-time $V$ has $x\in L\iff\exists y:V(x,y)$ accepts **· precondition** the time bound is in $\lvert x\rvert$, **never** $\lvert y\rvert$.
- **4-part membership proof** ➔ ① state the certificate ② state the verifier ③ prove the **iff** ④ bound the time. All four are marked.
- **Inclusions** ➔ $\mathrm{P}\subseteq\mathrm{NP}$ (ignore the certificate) and $\mathrm{NP}\subseteq\mathrm{EXP}$ (search $\le 2^{cn^{k}}$ certificates).
- **NDTM** ➔ $\mathrm{NP}$ = languages decided by a nondeterministic TM in polynomial time **· precondition** the DFA $=$ NFA equivalence does **not** transfer — determinising costs exponential *time* here, not just states.
- **[[Standard NP Problems and Certificates|Instance stock]]** ➔ VERTEX COVER ($\le k$) · INDEPENDENT SET, CLIQUE ($\ge k$) · SAT / 2-SAT / 3-SAT · $k$-COLOURABILITY · HAMILTONIAN CIRCUIT · PARTITION · SUBSET SUM · GRAPH ISOMORPHISM.
- **[[Polynomial-Time Reductions|$\le_{P}$]]** ➔ $\le_m$ with $f$ computable in $O(n^{k})$; three marked parts: **function · iff chain · time bound**.
- **Output-length lemma** ➔ a TM emits $\le 1$ symbol per step ⟹ $f$ in time $O(n^{k})$ forces $\lvert f(x)\rvert=O(n^{k})$ **· precondition** this is the step that makes composition work; omitting it is the standard deduction.
- **Transfer** ➔ $L\in\mathrm{P}\Rightarrow K\in\mathrm{P}$; $K\notin\mathrm{P}\Rightarrow L\notin\mathrm{P}$ **· precondition** every old $\le_m$ construction must be **re-timed** — $\text{RegExpEquiv}\le_{m}\text{FA-Empty}$ is *not* $\le_{P}$.
- **Reduction stock** ➔ $\text{IS}\le_{P}\text{CLIQUE}$: $f(G,k)=(\overline{G},k)$ · $\text{VC}\le_{P}\text{IS}$: $f(G,k)=(G,n-k)$ · $\text{PARTITION}\le_{P}\text{SUBSET SUM}$: target $=\tfrac12\sum s_i$.

## 1️⃣3️⃣ NP-Completeness
- **[[NP-Completeness|Definition]]** ➔ $L$ is NP-complete iff **(a)** $L\in\mathrm{NP}$ **and (b)** $\forall K\in\mathrm{NP}:K\le_{P}L$ **· precondition** (b) alone is only **NP-hard**.
- **Master theorem** ➔ an NP-complete $L$ has a polynomial-time decider $\iff\mathrm{P}=\mathrm{NP}$; ($\Leftarrow$) spends condition (a), ($\Rightarrow$) spends (b) plus the $\le_{P}$ transfer theorem.
- **Equivalence class** ➔ for NP-complete $L$: $K\in\mathrm{NP}\iff K\le_{P}L$, and $K$ is NP-complete $\iff K\le_{P}L\wedge L\le_{P}K$.
- **[[Cook-Levin Theorem]]** ➔ SATISFIABILITY (satisfiable CNF expressions) is NP-complete **· note** the proof is **non-examinable**; part (a) — certificate = truth assignment, verify clause-by-clause — is not.
- **[[Reducing to SATISFIABILITY|Encoding recipe]]** ➔ ① variables for the certificate ② auxiliary variables ③ rules $\to$ CNF via the at-least / at-most templates of §2️⃣ ④ state as an algorithm **and count the clauses**.
- **PARTITION INTO TRIANGLES $\le_{P}$ SAT** ➔ $x_{T_i}$ per triangle; per vertex one at-least-one clause and $\neg x_{T_i}\vee\neg x_{T_j}$ per triangle pair at it **· cost** $O(n^{3})$ variables, $O(n^{5})$ clauses.
- **[[Proving NP-Completeness by Reduction|Inheritance theorem]]** ➔ $K$ NP-complete $\wedge\ L\in\mathrm{NP}\ \wedge\ K\le_{P}L\Rightarrow L$ NP-complete **· precondition** the reduction runs **from** the known-hard language; $L\le_{P}K$ proves nothing.
- **$\text{SAT}\le_{P}3\text{-SAT}$** ➔ pad clauses of size $<3$ with **fresh** $w_i$ in all sign patterns; chain clauses of size $>3$ with fresh $z_j$ links $(\dots\vee z_j)\wedge(\neg z_j\vee\dots)$.
- **$3\text{-SAT}\le_{P}\text{VERTEX COVER}$** ➔ variable-edge $(x_i,\neg x_i)$ per variable, triangle per clause, connector edge from each clause position to its literal; $k_{\phi}=2m+n$ **· precondition** $k_{\phi}$ must be the exact minimum, else the correspondence breaks.
- **Chain** ➔ $\text{SAT}\le_{P}3\text{-SAT}\le_{P}\text{VC}\le_{P}\text{IS}\le_{P}\text{CLIQUE}$ ⟹ all five NP-complete.
- **Living with it** ➔ drop exactly one of **efficient · deterministic · all-cases · exact** ⟹ exponential exact / randomised / special-case / approximation algorithm.
- **co-NP** ➔ complements of $\mathrm{NP}$ languages; $\mathrm{P}\subseteq\mathrm{NP}\cap\text{co-}\mathrm{NP}$, and whether that inclusion is equality is **open**.

## 🪜 The ladder, in one line
$$
\text{regular}\subsetneq\text{context-free}\subsetneq\mathrm{P}\subsetneq\text{decidable}\subsetneq\text{r.e.}\subsetneq\text{all languages},
\qquad
\mathrm{P}\subseteq\mathrm{NP}\subseteq\mathrm{EXP}
$$
- **Named separating inhabitants** ➔ $\mathtt{a}^{n}\mathtt{b}^{n}$ (not regular) · $\mathtt{a}^{n}\mathtt{b}^{n}\mathtt{a}^{n}$ (not context-free, still decidable) · $\text{HALT}$ (r.e., not decidable) · $\overline{\text{HALT}}$ (not r.e.).
- **The unproved links** ➔ every $\subsetneq$ in the first chain is a **theorem** with a witness above; the second chain's $\subseteq$ signs are **not known to be strict** — $\mathrm{P}\overset{?}{=}\mathrm{NP}$ is the open question, and $\mathrm{NP}$ straddles the $\mathrm{P}$/decidable frontier rather than sitting in a tier of its own.
