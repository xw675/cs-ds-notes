---
unit: FIT2014
week: 11
source: [lecture]
domain: D
parent: "[[NP-Completeness]]"
tags: [Math/Theory, CS/Computation]
aliases: [PARTITION INTO TRIANGLES, modelling with logic, SAT solver, reduction to SAT]
---
# [[Reducing to SATISFIABILITY]]

**Context:** [[FIT2014_MOC]] · **the hand skill of Week 11** — the W1 skill of [[Encoding Problems in Propositional Logic|encoding a problem in CNF]] re-run with a **clock** attached, so the encoding is now a [[Polynomial-Time Reductions|$\le_{P}$ reduction]] and not just a modelling exercise
**Problem it solves:** given a language $L$ in $\mathrm{NP}$, build a CNF formula $\phi$ from each instance such that $\phi$ is satisfiable **iff** the instance is a Yes-instance.

> [!abstract] Quick Revision
> - **🎯 Trigger:** you must show $L\le_{P}\text{SAT}$ (or feed $L$ to a **SAT solver**) ➔ variables **describe the certificate**, clauses **enforce the validity rules**.
> - **⚡ Key Constraint:** the certificate's variables are not enough — every **rule of the language** must become clauses, and you must then **count them** to prove the construction is polynomial. A correct encoding with no time bound is an incomplete reduction.

## 📝 The four-step recipe
1. **Variables for the certificate** ➔ one Boolean per atomic choice the certificate makes ("is object $i$ selected?").
2. **Auxiliary variables** *(optional)* ➔ extra Booleans to express conditions the certificate variables cannot state directly.
3. **Rules → CNF** ➔ translate each validity condition into clauses, using the [[CNF Encoding Patterns (At Least, At Most, Exactly)|cardinality templates]]: **at least one** is a single positive disjunction; **at most one** is pairwise negative binary clauses.
4. **Assemble as an algorithm** ➔ state the construction as numbered steps on the input, take the conjunction, and **bound its running time**.

- **Why CNF specifically** ➔ $\text{SATISFIABILITY}:=\{$satisfiable Boolean expressions **in CNF**$\}$, so a formula in any other shape is not an instance of the target language.
- **Practical payoff** ➔ **SAT solvers** are mature programs; since anything $\le_{P}\text{SAT}$ can be routed through one, this recipe is how NP-hard problems actually get solved in industry.

## 🧮 Worked reduction — $\text{PARTITION INTO TRIANGLES}\le_{P}\text{SATISFIABILITY}$
> [!IMPORTANT] **PARTITION INTO TRIANGLES** $:=\{G: V(G)$ can be partitioned into 3-sets, each of which **induces a triangle** in $G\}$. Note $3\mid\lvert V(G)\rvert$ is forced, and the 3-sets must be **disjoint and cover everything** — a graph can be full of triangles and still fail.

**Step 1 — variables.** One per triangle $T_i$ **of the graph** (not per 3-set of vertices):
$$x_{T_i}=\begin{cases}\text{True} & \text{if } T_i \text{ is in the partition;}\\ \text{False} & \text{otherwise.}\end{cases}$$
- **Count** ➔ at most $\binom{n}{3}$ triangles ⟹ $O(n^{3})$ variables.

**Step 3 — the two rules.** "The chosen triangles **partition** $V(G)$" splits into exactly two conditions:

| Rule | Clause shape | One clause per | Count |
| :--- | :--- | :--- | :--- |
| every vertex is in **at least one** chosen triangle | $x_{T_1}\vee x_{T_2}\vee\dots\vee x_{T_k}$ over the triangles $T_1,\dots,T_k$ **at that vertex** | vertex | $n$ |
| no vertex is in **more than one** | $\neg x_{T_i}\vee\neg x_{T_j}$ for each **pair** $T_i,T_j$ at that vertex | vertex $\times$ triangle-pair | $\le n\left(\dfrac{d(d-1)}{2}\right)^{2}=O(n^{5})$ |

- **Recognise the templates** ➔ these are precisely **at-least-one** and **at-most-one** from [[CNF Encoding Patterns (At Least, At Most, Exactly)]]; together they say **exactly one**, which is what *partition* means.
- **Why pairs and not a counter** ➔ the pairwise form is already CNF; any arithmetic "$\sum=1$" form would need converting.

> [!EXAMPLE]- Worked instance — the 6-vertex graph with triangles $abc, abd, bde, def$
> **Variables:** $x_{abc},\,x_{abd},\,x_{bde},\,x_{def}$.
> **At-least-one clauses**, one per vertex:
> $$
> \begin{aligned}
> a&: x_{abc}\vee x_{abd} & d&: x_{abd}\vee x_{bde}\vee x_{def}\\
> b&: x_{abc}\vee x_{abd}\vee x_{bde} & e&: x_{bde}\vee x_{def}\\
> c&: x_{abc} & f&: x_{def}
> \end{aligned}
> $$
> **At-most-one clauses**, per vertex per pair of triangles at it:
> $$
> \begin{aligned}
> a&: \neg x_{abc}\vee\neg x_{abd}\\
> b&: (\neg x_{abc}\vee\neg x_{bde})\wedge(\neg x_{abd}\vee\neg x_{bde})\quad[\,\neg x_{abc}\vee\neg x_{abd}\text{ already listed at }a\,]\\
> d&: (\neg x_{abd}\vee\neg x_{def})\wedge(\neg x_{bde}\vee\neg x_{def})
> \end{aligned}
> $$
> - **Key move:** vertices $c$ and $f$ each lie in only **one** triangle, so their at-least-one clauses are **unit clauses** $(x_{abc})$ and $(x_{def})$ — these force $x_{abc}=x_{def}=\text{True}$, which then kills $x_{abd}$ and $x_{bde}$ through the negative clauses. $\phi$ is satisfiable, and the partition is $\{a,b,c\},\{d,e,f\}$.
> - **Duplicate clauses cost nothing** ➔ a pair shared between two vertices is listed once; the conjunction is idempotent.

**Step 4 — the algorithm and its cost.**
```
Input: graph G
1. for each triangle Ti of G:            create a new variable x_Ti
2. for each vertex v of G:               let T1..Tk be the triangles at v
                                         emit clause  x_T1 v x_T2 v ... v x_Tk
3. for each pair Ti,Tj sharing a vertex: emit clause  ¬x_Ti v ¬x_Tj
4. φ := conjunction of all clauses
5. output φ
```
**Cost** ➔ the dominating factor is step 3, **the number of triangle pairs sharing a vertex**, which is $O(n^{5})$; each pair costs $O(1)$–$O(n)$ work ⟹ the whole construction is **polynomial**, and by the output-length lemma $\lvert\phi\rvert$ is polynomial too.
**Correctness** ➔ $\phi$ is satisfiable $\iff$ some set of triangles hits every vertex exactly once $\iff$ $G\in\text{PARTITION INTO TRIANGLES}$.

## 🔀 Other languages set as exercises
- **3-COLOURABILITY** ➔ variables $x_{v,c}$ (vertex $v$ has colour $c$); exactly-one-colour per vertex, plus $\neg x_{u,c}\vee\neg x_{v,c}$ per edge per colour. *(Set as an exercise — construction not given in the handout.)*
- **CUBIC SUBGRAPH** ➔ graphs containing a subgraph in which **every** vertex has degree exactly 3.
- **HAMILTONIAN CIRCUIT** · **FA-Nonempty** ➔ the FA exercise asks for variables representing **the letter at each position of the input string**, so that $\phi$ models the automaton's *execution* — the same idea the [[Cook-Levin Theorem]] applies to a Turing machine.

## ⚠️ Common Mistakes
- 💡 **Encoding only the certificate** ➔ variables alone make every assignment legal. The marks are in the **rule clauses**; without the at-most-one family, a vertex could sit in two triangles and $\phi$ would still be satisfiable.
- 💡 **Skipping the time bound** ➔ a [[Polynomial-Time Reductions|$\le_{P}$]] proof has three marked parts — function, **iff**, and cost. Counting variables and clauses *is* the cost argument here.
- 💡 **Leaving the formula out of CNF** ➔ writing $x_{T_i}\Rightarrow\neg x_{T_j}$ is not an instance of SATISFIABILITY until it is rewritten as $\neg x_{T_i}\vee\neg x_{T_j}$.
- 💡 **Making a variable per 3-set instead of per triangle** ➔ blows the variable count up with 3-sets that are not triangles at all, and forces extra clauses to rule them out.
- 💡 **Proving one direction** ➔ "a partition gives a satisfying assignment" must be matched by "a satisfying assignment gives a partition", or the reduction may map a No-instance to a satisfiable $\phi$.

## 🧠 Active Recall
> [!FAQ]- Which W1 skill is this, and what has been added to it?
> > [!SUCCESS]- Answer
> > - **Short answer:** it is [[Encoding Problems in Propositional Logic]] plus a **complexity budget** — the encoding must now be produced by a polynomial-time algorithm.
> > - **Why:** **the cardinality templates are unchanged** ➔ *at least one* is still one positive clause of length $k$, *at most one* still $\binom{k}{2}$ negative binary clauses. What Week 11 adds is that the CNF is the **output of a reduction**, so its size and construction time must be counted in $n$ — which is exactly why the $O(n^{5})$ clause count is written down.

> [!FAQ]- How does the recipe generalise from PARTITION INTO TRIANGLES to *every* language in $\mathrm{NP}$?
> > [!SUCCESS]- Answer
> > - **Short answer:** by encoding the **verifier's computation** instead of the problem's combinatorics — variables for the machine's state, tape contents and head position at every timestep, clauses forbidding every illegal transition.
> > - **Why:** **that is the [[Cook-Levin Theorem]]** ➔ every $L\in\mathrm{NP}$ has a polynomial-time verifier by definition, so if a machine's run can be written in CNF, one construction covers all of $\mathrm{NP}$ at once. The FA-Nonempty exercise is the training-wheels version: model an automaton's execution rather than a Turing machine's.
