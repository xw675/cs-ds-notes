---
unit: FIT2014
week: 10
source: [lecture]
domain: D
parent: "[[Verifiers, Certificates and the Class NP]]"
tags: [Math/Theory, CS/Computation]
aliases: [VERTEX COVER, INDEPENDENT SET, CLIQUE, HAMILTONIAN CIRCUIT, GRAPH ISOMORPHISM, SUBGRAPH ISOMORPHISM, PARTITION, SUBSET SUM, 3-SAT, 3-COLOURABILITY]
---
# [[Standard NP Problems and Certificates]]

**Context:** [[FIT2014_MOC]] · the **named instance stock** the unit reduces between — every problem in [[Polynomial-Time Reductions]] and every NP-completeness argument is drawn from this list, so the definitions must be recallable cold

> [!abstract] Quick Revision
> - **🎯 Objective:** for each problem hold **three** things ➔ the **instance**, the **certificate**, and its **polynomial check** — that triple *is* the proof of membership of [[Verifiers, Certificates and the Class NP|$\mathrm{NP}$]].
> - **⚡ Key Constraint:** superficially twinned problems sit on **opposite sides** of the $\mathrm{P}$ frontier — 2-SAT vs 3-SAT, 2-colourable vs 3-colourable, **Eulerian** (edges, in $\mathrm{P}$) vs **Hamiltonian** (vertices, not known to be). Never generalise a $\mathrm{P}$ membership by analogy.

## 📝 Core — the three vertex-set problems
All three fix a graph $G=(V,E)$ with $\lvert V\rvert=n$ and ask for a set $X\subseteq V$; they differ only in the condition on $X$ and the direction of the size bound.

- **VERTEX COVER** $:=\{(G,k): G$ has a vertex cover of size $\le k\}$ ➔ $X$ **covers** iff **every edge has at least one endpoint in $X$**: $\forall uv\in E\ (u\in X)\vee(v\in X)$.
- **INDEPENDENT SET** $:=\{(G,k): G$ has an independent set of size $\ge k\}$ ➔ $X$ is **independent** iff **no edge has both endpoints in $X$**: $\forall uv\in E\ (u\notin X)\vee(v\notin X)$.
- **CLIQUE** $:=\{(G,k): G$ has a clique of size $\ge k\}$ ➔ $X$ is a **clique** iff **every pair inside $X$ is adjacent**: $\forall u\in X\ \forall v\in X:\ uv\in E$.
- **The two identities that drive the reductions** ➔ $X$ is a vertex cover of $G$ $\iff$ $V\setminus X$ is independent in $G$; and $X$ is independent in $G$ $\iff$ $X$ is a clique in the **complement** $\overline{G}$ (edges $\leftrightarrow$ non-edges). Both are proved by unfolding the two $\forall$-statements above.
- **Direction discipline** ➔ VERTEX COVER asks $\le k$ (small is hard to achieve), the other two ask $\ge k$ (large is hard to achieve) — which is why $k\mapsto n-k$ appears in [[Polynomial-Time Reductions|VERTEX COVER $\le_P$ INDEPENDENT SET]].

> [!example]- Lecture's 4-vertex instance — $V=\{a,b,c,d\}$, triangle $abc$ plus the edge $cd$
> | $X$ | vertex cover? | independent? | clique? |
> | :--- | :--- | :--- | :--- |
> | $\emptyset$ | ✗ | ✓ | ✓ |
> | $\{b\}$ | ✗ | ✓ | ✓ |
> | $\{a,b\}$ | ✗ *(misses $cd$)* | ✗ | ✓ |
> | $\{a,d\}$ | ✗ | ✓ *(no edge $ad$)* | ✗ |
> | $\{b,c\}$ | ✓ | ✗ | ✓ |
> | $\{c,d\}$ | ✗ | ✗ *(edge $cd$)* | ✓ |
> | $\{a,b,c\}$ | ✓ | ✗ | ✓ |
> | $\{a,b,d\}$ | ✗ | ✗ | ✗ *(no edge $ad$)* |
> - **Key move:** to refute a cover, name the **uncovered edge**; to refute independence or a clique, name the **offending pair**. A one-word "no" earns nothing.

## 📚 Catalogue — instance, certificate, check
| Problem | Instance | Certificate $y$ | Polynomial check | Status |
| :--- | :--- | :--- | :--- | :--- |
| **2-SAT** | [[Conjunctive Normal Form\|CNF]] formula, exactly 2 literals/clause | truth assignment $f$ | evaluate every clause | **in $\mathrm{P}$** |
| **SATISFIABILITY** | any CNF formula | truth assignment $f$ | evaluate every clause | $\mathrm{NP}$, not known in $\mathrm{P}$ |
| **3-SAT** | CNF, exactly 3 literals/clause | truth assignment $f$ | evaluate every clause | $\mathrm{NP}$, not known in $\mathrm{P}$ |
| **2-COLOURABILITY** | graph $G$ | $f:V\to\{\text{B},\text{W}\}$ | scan edges for $f(u)\neq f(v)$ | **in $\mathrm{P}$** |
| **3-COLOURABILITY** | graph $G$ | $f:V\to\{\text{R},\text{W},\text{B}\}$ | scan edges, $O(mn)$ | $\mathrm{NP}$, not known in $\mathrm{P}$ |
| **GRAPH COLOURING** | $(G,k)$ | $f:V\to\{1,\dots,k\}$ | scan edges | $\mathrm{NP}$, not known in $\mathrm{P}$ |
| **COMPOSITE** | $x\in\mathbb{N}$; $\exists y,z$ with $1<y,z<x,\ x=yz$ | a factor $y$ | one division | **in $\mathrm{P}$** *(PRIMES, AKS 2004)* |
| **INTEGER FACTORISATION** | integer + bound | a factor | one division | $\mathrm{NP}$, not known in $\mathrm{P}$ |
| **EULERIAN** | graph $G$ | an **[[Euler Tour\|Euler tour]]** — closed walk using **each edge exactly once** | walk is closed, edges used once each | **in $\mathrm{P}$** |
| **HAMILTONIAN CIRCUIT** | graph $G$ | a circuit visiting **each vertex exactly once** | consecutive pairs adjacent, all $n$ vertices hit | $\mathrm{NP}$, not known in $\mathrm{P}$ |
| **GRAPH ISOMORPHISM** | $(G,H)$ | bijection $f:V(G)\to V(H)$ | $uv\in E(G)\iff f(u)f(v)\in E(H)$, all pairs | $\mathrm{NP}$, not known in $\mathrm{P}$ |
| **SUBGRAPH ISOMORPHISM** | $(G,H)$: is $G$ isomorphic to a **subgraph** of $H$? | injection $f:V(G)\to V(H)$ | image pairs adjacent in $H$ | $\mathrm{NP}$, not known in $\mathrm{P}$ |
| **VERTEX COVER** | $(G,k)$, cover of size $\le k$ | the set $X$ | $\lvert X\rvert\le k$; every edge meets $X$ | $\mathrm{NP}$, not known in $\mathrm{P}$ |
| **INDEPENDENT SET** | $(G,k)$, ind. set of size $\ge k$ | the set $X$ | $\lvert X\rvert\ge k$; no edge inside $X$ | $\mathrm{NP}$, not known in $\mathrm{P}$ |
| **CLIQUE** | $(G,k)$, clique of size $\ge k$ | the set $X$ | $\lvert X\rvert\ge k$; all $\binom{\lvert X\rvert}{2}$ pairs adjacent | $\mathrm{NP}$, not known in $\mathrm{P}$ |
| **PARTITION** | $(s_1,\dots,s_n)$: $\exists J$ with $\sum_{i\in J}s_i=\sum_{i\notin J}s_i$ | the index set $J$ | add both sides, compare | $\mathrm{NP}$, not known in $\mathrm{P}$ |
| **SUBSET SUM** | $(s_1,\dots,s_n,t)$: $\exists J$ with $\sum_{i\in J}s_i=t$ | the index set $J$ | add and compare with $t$ | $\mathrm{NP}$, not known in $\mathrm{P}$ |

- **Reading the Status column** ➔ "not known in $\mathrm{P}$" is a **statement about human knowledge**, not a proven exclusion; every entry is in $\mathrm{NP}$ and therefore decidable in exponential time. If $\mathrm{P}=\mathrm{NP}$ the column collapses.
- **Isomorphism vocabulary** ➔ $G\cong H$ iff some bijection $f:V(G)\to V(H)$ satisfies "$u$ adjacent $v$ in $G$ $\iff$ $f(u)$ adjacent $f(v)$ in $H$" ⟹ *the same graph up to renaming vertices*. The bijection is the **isomorphism**, and it is exactly the certificate.

## ⚠️ Common Mistakes
- 💡 **Euler/Hamilton mix-up** ➔ Euler traverses **every edge** once (in $\mathrm{P}$); Hamilton visits **every vertex** once (not known in $\mathrm{P}$). The words are similar, the complexity is not.
- 💡 **Flipping the size bound** ➔ "vertex cover of size $\ge k$" and "clique of size $\le k$" are **trivial** problems — the hardness lives entirely in minimising the cover and maximising the clique.
- 💡 **Certificate that is not checkable in isolation** ➔ "a certificate that $G$ is *not* 3-colourable" has no known short form; $\mathrm{NP}$ certifies **Yes**-instances only.
- 💡 **Confusing GRAPH with SUBGRAPH ISOMORPHISM** ➔ the first needs a **bijection** preserving adjacency **both ways**; the second only an **injection** into $H$ with images adjacent. Different certificate types.
- 💡 **Assuming the 2-versus-3 pattern is a rule** ➔ 2-SAT and 2-COLOURABILITY are in $\mathrm{P}$ by *specific* algorithms, not because "2 is easy". No such argument transfers.

## 🧠 Active Recall
> [!FAQ]- Give the certificate and the polynomial check for CLIQUE, and state its relationship to INDEPENDENT SET.
> > [!SUCCESS]- Answer
> > - **Short answer:** certificate $=$ the vertex set $X$; check $\lvert X\rvert\ge k$ and that **every** pair in $X$ is adjacent — $\binom{\lvert X\rvert}{2}=O(n^{2})$ lookups. $X$ is a clique in $G$ **iff** $X$ is independent in the complement $\overline{G}$.
> > - **Why:** **Complementation swaps the edge predicate** ➔ "all pairs adjacent in $G$" becomes "no pair adjacent in $\overline{G}$", which is independence verbatim; building $\overline{G}$ costs $O(n^{2})$, giving [[Polynomial-Time Reductions|INDEPENDENT SET $\le_P$ CLIQUE]] with the parameter $k$ untouched.

> [!FAQ]- Both ask for a tour of a graph, so why is EULERIAN in $\mathrm{P}$ while HAMILTONIAN CIRCUIT is not known to be?
> > [!SUCCESS]- Answer
> > - **Short answer:** an Euler tour constrains **edges** and admits a local characterisation checkable by degree counting; a Hamiltonian circuit constrains **vertices** and no such local test is known — only a certificate to verify, never an efficient way to find one.
> > - **Why:** **Both are in $\mathrm{NP}$ with the tour as certificate** ➔ verification is trivial in each case, so the split is entirely about **deciding**, not verifying. This pair is the standard illustration that membership of $\mathrm{NP}$ says nothing about membership of $\mathrm{P}$.
