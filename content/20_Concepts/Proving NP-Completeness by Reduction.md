---
unit: FIT2014
week: 11
source: [lecture]
domain: D
parent: "[[NP-Completeness]]"
tags: [Math/Theory, CS/Computation]
aliases: [Karp reduction method, 3-SAT is NP-complete, VERTEX COVER is NP-complete, inheritance theorem]
---
# [[Proving NP-Completeness by Reduction]]

**Context:** [[FIT2014_MOC]] · **the exam hand skill of Week 11** — once [[Cook-Levin Theorem|SAT is NP-complete]], condition (b) of [[NP-Completeness]] is discharged by **one** [[Polynomial-Time Reductions|$\le_{P}$ reduction]] instead of an argument over all of $\mathrm{NP}$

> [!abstract] Quick Revision
> - **🎯 Objective:** to prove $L$ NP-complete ➔ **(a)** show $L\in\mathrm{NP}$ (a verifier + certificate), **(b)** pick a **known** NP-complete $K$ and show $K\le_{P}L$. **Just one reduction.**
> - **📦 Core Components:** the **inheritance theorem** (transitivity of $\le_{P}$) | $\text{SAT}\le_{P}3\text{-SAT}$ by clause splitting | $3\text{-SAT}\le_{P}\text{VERTEX COVER}$ by the gadget graph, $k_{\phi}=2m+n$.
> - **⚡ Key Constraint:** the reduction runs **from** the known-hard language **into** yours — $K\le_{P}L$. Writing $L\le_{P}K$ proves $L$ is *easy enough*, which is the opposite of what is claimed and the single commonest zero.

## 🧮 Proof Blueprint — the inheritance theorem
> [!IMPORTANT] **Theorem.** If $K$ is NP-complete, $L\in\mathrm{NP}$, and $K\le_{P}L$, then $L$ is NP-complete.

**Strategy** ➔ *condition (a) is given; condition (b) is manufactured by composing an arbitrary language's reduction into $K$ with the given reduction $K\to L$, using transitivity of $\le_{P}$.*

> [!SUCCESS]- Derivation
> Let $H$ be **any** language in $\mathrm{NP}$.
> $$
> \begin{aligned}
> K \text{ NP-complete} &\Longrightarrow H\le_{P}K &&\text{(condition (b) of }K)\\
> &\text{and } K\le_{P}L &&\text{(given)}\\
> \le_{P}\text{ transitive} &\Longrightarrow H\le_{P}L\\
> H \text{ arbitrary} &\Longrightarrow \forall H\in\mathrm{NP}: H\le_{P}L &&\text{(condition (b) of }L)\\
> \text{with } L\in\mathrm{NP} &\Longrightarrow L\text{ is NP-complete.}\ \blacksquare
> \end{aligned}
> $$
> - **Key move:** transitivity is what makes the method finite — it silently reuses Cook-Levin's infinite family of reductions. Historically this is **R. Karp (1972)**.

- **Why it did not help for SAT** ➔ at that point **no** NP-complete language was known, so there was nothing to play the role of $K$. That is the whole reason [[Cook-Levin Theorem]] had to be generic.
- **Do not skip (a)** ➔ the theorem *assumes* $L\in\mathrm{NP}$. Without it you have proved $L$ **NP-hard** only.

## 📝 The two standard reductions
### 1. $\text{SAT}\le_{P}3\text{-SAT}$ — resize every clause to exactly 3 literals
Each clause of $\phi$ is replaced by clause(s) of size 3 doing the same job, using **fresh** variables ($w_i$, $z_j$) that appear nowhere else:

| Clause size | Replacement | Why it preserves satisfiability |
| :--- | :--- | :--- |
| $1$: $(x)$ | $(x\vee w_{i1}\vee w_{i2})\wedge(x\vee w_{i1}\vee\neg w_{i2})\wedge(x\vee\neg w_{i1}\vee w_{i2})\wedge(x\vee\neg w_{i1}\vee\neg w_{i2})$ | all four sign patterns of $(w_{i1},w_{i2})$ appear, so **some** clause loses both paddings whatever they are set to ⟹ $x$ must hold |
| $2$: $(x_1\vee x_2)$ | $(x_1\vee x_2\vee w_i)\wedge(x_1\vee x_2\vee\neg w_i)$ | one of the two loses its padding literal ⟹ pair satisfiable iff $x_1\vee x_2$ is |
| $3$ | itself | already the right size |
| $4$: $(x_1\vee x_2\vee x_3\vee x_4)$ | $(x_1\vee x_2\vee z_1)\wedge(\neg z_1\vee x_3\vee x_4)$ | $z_1$ is a **chaining** literal: setting $z_1$ True discharges the first clause but forces the second to be met by $x_3\vee x_4$ |
| $\ge 5$: $(x_1\vee\dots\vee x_5)$ | $(x_1\vee x_2\vee z_1)\wedge(\neg z_1\vee x_3\vee z_2)\wedge(\neg z_2\vee x_4\vee x_5)$ | same chain continued — bring literals in **one at a time** |

- **Two different tricks** ➔ short clauses are **padded** with all sign patterns of throwaway variables; long clauses are **chained** with $z_j/\neg z_j$ links. Both need every auxiliary variable to be **fresh per clause**.
- **Cost** ➔ a clause of length $\ell$ becomes $O(\ell)$ clauses with $O(\ell)$ new variables ⟹ **linear** in $\lvert\phi\rvert$.
- **Same padding idea as W10** ➔ the size-2 row is exactly the $2\text{-SAT}\le_{P}3\text{-SAT}$ construction in [[Polynomial-Time Reductions]].

### 2. $3\text{-SAT}\le_{P}\text{VERTEX COVER}$ — the gadget graph
**(a) $\text{VERTEX COVER}\in\mathrm{NP}$** ➔ easy; certificate is the cover $X$, checked in $O(\lvert E\rvert)$ *(see [[Standard NP Problems and Certificates]])*.

**(b) The construction.** Given $\phi$ in CNF with **exactly 3 literals per clause**, variables $x_1,\dots,x_n$ and clauses $C_1,\dots,C_m$, build $(G_{\phi},k_{\phi})$:

| Piece | Vertices | Edges |
| :--- | :--- | :--- |
| **variable-edges** | $x_1,\neg x_1,\dots,x_n,\neg x_n$ | $(x_i,\neg x_i)$ — each literal joined to its partner |
| **clause-triangles** | $C_{i1},C_{i2},C_{i3}$ for each clause $C_i$ | all three pairs, so each clause is a **separate triangle** |
| **connector edges** | — | for the literal in position $j$ of clause $C_i$: $(C_{ij},x_k)$ if that literal is $x_k$, else $(C_{ij},\neg x_k)$ |

$$k_{\phi}:=2m+n$$

**Why that budget is forced** ➔ every variable-edge needs $\ge 1$ vertex; every triangle needs $\ge 2$; all these pieces are **disjoint**, so *any* vertex cover has size $\ge 2m+n$. Setting $k_{\phi}$ to the minimum forces **exactly one** vertex per variable-edge and **exactly two** per triangle — no slack anywhere.

**The dictionary** ➔ choosing which end of variable-edge $i$ enters the cover $\iff$ assigning a truth value to $x_i$; **vertex chosen $\iff$ literal True**.

> [!SUCCESS]- The iff chain
> A chosen (True) literal already covers every connector edge running up from it to its clause positions. So if literal $x_k$ is True and sits at position $j$ of clause $C_i$, the edge $(x_k,C_{ij})$ is covered from below and $C_{ij}$ **need not** join the cover — leaving the triangle for $C_i$ coverable by its other two vertices.
> Conversely, if a clause-triangle contributes only two vertices, the **omitted** vertex marks a position whose connector edge must have been covered from the literal end — i.e. that literal is True.
> $$
> \begin{aligned}
> \text{the assignment satisfies }\phi &\iff \text{every clause has a true literal}\\
> &\iff \text{the cover meets every clause-triangle exactly twice}\\
> &\iff \text{the cover has size}\le k_{\phi}\\
> \therefore\quad \phi\in3\text{-SAT} &\iff (G_{\phi},k_{\phi})\in\text{VERTEX COVER}.\ \blacksquare
> \end{aligned}
> $$
> - **Key move:** the budget $2m+n$ is what converts a *counting* fact into a *logical* one — with one spare vertex the third triangle vertex could be bought and the correspondence with satisfaction would break.

**Cost** ➔ $2n+3m$ vertices and $n+3m+3m$ edges, all readable off $\phi$ in one pass ⟹ polynomial (*fairly routine*).

### 3. The inheritance chain
$$\text{SAT}\ \le_{P}\ 3\text{-SAT}\ \le_{P}\ \text{VERTEX COVER}\ \le_{P}\ \text{INDEPENDENT SET}\ \le_{P}\ \text{CLIQUE}$$
- **The last two legs are already proved** ➔ built in [[Polynomial-Time Reductions]] as $f(G,k)=(G,n-k)$ and $f(G,k)=(\overline{G},k)$. Each is in $\mathrm{NP}$, so **INDEPENDENT SET and CLIQUE are NP-complete for free**.
- **Five NP-complete languages from one theorem** ➔ this is the leverage the inheritance theorem provides.
- **Set as exercises** ➔ **3-COLOURABILITY** NP-complete by reduction from INDEPENDENT SET · **4-SAT** NP-complete · the complexity of **VACCINATION** (input $G,v,k$: can $v$ vertices be "vaccinated" so every connected unvaccinated subgraph has $\le k$ vertices?).

## ⚠️ Common Mistakes
- 💡 **Reducing the wrong way** ➔ you need $K\le_{P}L$ with $K$ known hard. $L\le_{P}\text{SAT}$ is true for **every** $L\in\mathrm{NP}$ and proves nothing about hardness.
- 💡 **Omitting part (a)** ➔ without $L\in\mathrm{NP}$ the inheritance theorem does not apply and the result is only **NP-hard**. It is usually two lines — write them.
- 💡 **Re-using an auxiliary variable across clauses** ➔ in $\text{SAT}\le_{P}3\text{-SAT}$ each $w_i$ and $z_j$ must be **fresh**; sharing couples independent clauses and destroys the iff.
- 💡 **Choosing $k_{\phi}$ loosely** ➔ any $k>2m+n$ lets a cover buy the third triangle vertex without satisfying the clause, so satisfiability is no longer forced. The value must be the exact lower bound.
- 💡 **Forgetting the connector edges** ➔ with only variable-edges and triangles the graph is disconnected from $\phi$'s content and every $\phi$ maps to a Yes-instance.
- 💡 **Skipping the time bound** ➔ *"fairly routine"* still has to be **asserted**; the three marked parts of a $\le_{P}$ proof are the function, the iff chain, and the cost.

## 🧠 Active Recall
> [!FAQ]- Why does $k_{\phi}=2m+n$ have to be exactly the minimum possible cover size?
> > [!SUCCESS]- Answer
> > - **Short answer:** because the correspondence "clause satisfied $\iff$ triangle covered by only two vertices" only holds when the budget leaves **zero slack**.
> > - **Why:** **the $n$ variable-edges and $m$ triangles are pairwise disjoint** ➔ they independently demand $1$ and $2$ vertices, so $2m+n$ is a hard floor. At exactly that value every triangle gets **exactly** two vertices, forcing each clause's third connector edge to be covered from the **literal** end — which is precisely the statement that the clause contains a true literal. Give one extra vertex and an unsatisfied clause can be patched, breaking the ($\Leftarrow$) direction.

> [!FAQ]- You must prove a new language $L$ NP-complete. Write the checklist.
> > [!SUCCESS]- Answer
> > - **Short answer:** ① $L\in\mathrm{NP}$ — state certificate, verifier, iff, polynomial time. ② choose a known NP-complete $K$ whose structure resembles $L$. ③ give $f$ mapping instances of $K$ to instances of $L$. ④ prove the **iff chain both ways**. ⑤ bound the time to compute $f$. ⑥ cite the inheritance theorem.
> > - **Why:** **steps ①–⑤ are the marked parts; ⑥ is the one-line justification that they suffice** ➔ the theorem converts $K$'s condition (b) into $L$'s by transitivity of $\le_{P}$, which is exactly why one reduction replaces an argument about all of $\mathrm{NP}$.

> [!FAQ]- Given VERTEX COVER is NP-complete, how do INDEPENDENT SET and CLIQUE come along free?
> > [!SUCCESS]- Answer
> > - **Short answer:** both are in $\mathrm{NP}$, and $\text{VERTEX COVER}\le_{P}\text{INDEPENDENT SET}\le_{P}\text{CLIQUE}$ were built in Lecture 26 — apply the inheritance theorem twice.
> > - **Why:** **the reductions are parameter arithmetic, not new gadgets** ➔ $X$ is a cover of $G$ **iff** $V\setminus X$ is independent, giving $f(G,k)=(G,n-k)$; and an independent set of $G$ is a clique of $\overline{G}$, giving $f(G,k)=(\overline{G},k)$. Both are $O(n^{2})$, so NP-completeness propagates along the chain *(details in [[Polynomial-Time Reductions]])*.
