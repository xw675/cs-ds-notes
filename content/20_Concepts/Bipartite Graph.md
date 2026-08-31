---
unit: [FIT1058, FIT2004]
week: [5, 11]
source: [lecture, applied]
domain: [A, D]
parent: "[[Graph]]"
tags: [Math/GraphTheory, Math/Discrete, CS/Algorithms]
aliases: [Two-Colourable, 2-Colouring, Graph Two-Colouring, Bipartiteness Testing]
---
# [[Bipartite Graph]]

**Context:** [[FIT1058_MOC]] · vertices split into two sides with edges only across · equivalent to 2-colourability and to having no odd [[Cycle (Graph Theory)|cycle]] · [[FIT2004_MOC]] · the W5 applied **decision problem** — testing it is one [[Uninformed Search (BFS and DFS)|DFS]] in $\Theta(V+E)$, and counting the colourings is $2^{\#\text{components}}$
**Parent Framework:** [[Graph]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $V=A\sqcup B$, every edge crosses ➔ a two-sided graph ➔ decided by a **greedy** traversal, because the first colour in a [[Connectivity|component]] forces every other one.
> - **📦 Core Components:** three equivalent views — **parts** / **2-colouring** / **no odd cycle** | test ➔ $\Theta(V+E)$ DFS | count ➔ $2^{c}$ for $c$ components.
> - **⚡ Key Constraint:** a single odd [[Cycle (Graph Theory)|cycle]] disproves it, and the triangle $K_3$ is the smallest non-bipartite graph — to **prove** bipartite exhibit the colouring, to **disprove** exhibit one odd cycle.

## 📝 How It Works
### 1. The Definition
- **Bipartite** ➔ $V=A\sqcup B$ with every edge having one end in $A$ and one in $B$.
- **Partition** ➔ if $G$ has an edge, both parts are nonempty ([[Set Partition]]).

### 2. Three Equivalent Views
- **Parts** ➔ $A\sqcup B$.
- **2-colouring** ➔ adjacent vertices differ; the parts are the colour [[Inverse Function|preimages]].
- **No odd cycle** ➔ equivalently, no odd closed walk.

$$\text{bipartite} \iff \text{2-colourable} \iff \text{no odd closed walk} \iff \text{no odd cycle}$$

### 3. Bipartite $\iff$ Two-Colourable — the Two-Way Argument *(applied P8)*
- **Bipartite $\Rightarrow$ 2-colourable** ➔ colour every vertex of $A$ white and every vertex of $B$ black; every edge runs between the parts, so no edge joins two vertices of one colour.
- **2-colourable $\Rightarrow$ bipartite** ➔ take $A=$ the white vertices and $B=$ the black ones; no edge joins two whites or two blacks, so every edge crosses ⟹ the colouring **is** the partition.
- **Consequence for the exam** ➔ "determine whether $G$ is bipartite" and "determine whether $G$ is two-colourable" are the **same question**, so the same $\Theta(V+E)$ algorithm answers both — say this explicitly rather than inventing a second algorithm.

### 4. Why No Odd Cycle
- **Walks alternate** ➔ $A,B,A,B,\dots$ ⟹ a closed walk must have even length.
- **Distance-parity colouring** ➔ colour each vertex by the parity of its distance from a ground vertex in its component.

### 5. Testing It — the Greedy DFS Colouring *(applied P1)*
- **The forcing observation** ➔ once one vertex is coloured, **all** of its neighbours' colours are determined, and theirs in turn ⟹ after the first choice there are **no further decisions** to make; the algorithm is therefore purely greedy, never a search.
- **The first choice is free** ➔ starting a component white instead of black just swaps every colour in it, so it never changes *whether* a valid colouring exists — which is what licenses picking arbitrarily.
- **The algorithm** ➔ [[Uninformed Search (BFS and DFS)|DFS]] over all vertices; for each still-uncoloured $u$ pick a colour and recursively colour every neighbour the **opposite**. If a neighbour already carries the **same** colour as the vertex being expanded, no valid colouring exists ⟹ return False.
- **What the failure means** ➔ the clash is a closed walk of odd length, i.e. the odd [[Cycle (Graph Theory)|cycle]] obstruction, surfaced constructively.
- **The outer loop is mandatory** ➔ a disconnected graph has several components, each needing its own seed colour; a single seeded DFS reports on one component only.
- **[[Uninformed Search (BFS and DFS)|BFS]] works equally well** ➔ colour by the parity of `distance`, matching the distance-parity argument in §4; the FIT2004 sheet writes it as DFS.

### 6. Counting the Valid Two-Colourings *(applied P2)*
- **Step 1** ➔ run §5. If the graph is **not** two-colourable the count is $\mathbf{0}$ — no partial credit for components that would have worked.
- **Step 2** ➔ within a component, fixing one vertex fixes every other, so each component admits exactly **two** colourings: the one you found and its complete swap.
- **Step 3** ➔ components are coloured **independently**, so the choices multiply:
$$\#\text{two-colourings}=2^{\,c},\qquad c=\#\text{connected components}$$
- **Getting $c$** ➔ the same [[Uninformed Search (BFS and DFS)|DFS]] — count how many times the **outer** loop has to start a fresh traversal ➔ [[Connectivity]].
- **Isolated vertices count** ➔ a degree-$0$ vertex is its own component and doubles the answer; forgetting them is the standard arithmetic slip.
- **Total cost** ➔ still $\Theta(V+E)$: one traversal decides colourability and counts components in the same pass.

## ⚙️ Core Implementation
### 🔹 `TWO_COLOUR` — decide and colour in one DFS
> [!code]- Pseudocode
> ```text
> function TWO_COLOUR(G = (V, E))
>     Set colour[1..n] = null
>     for each vertex u = 1 to n do              # every component needs a seed
>         if colour[u] = null then
>             if DFS(u, BLACK) = False then
>                 return False
>     return True, colour[1..n]
>
> # Returns true if the component was successfully coloured
> function DFS(u, c)
>     colour[u] = c
>     for each vertex v adjacent to u do
>         if colour[v] = c then                  # a neighbour matches us -> odd cycle
>             return False
>         else if colour[v] = null and DFS(v, opposite(c)) = False then
>             return False
>     return True
> ```
> 💡 **Common Mistake:** **Returning False when `colour[v]` is merely non-null** ➔ an *already coloured* neighbour is fine and expected; only one carrying the **same** colour as $u$ is a contradiction.
> 💡 **Common Mistake:** **Backtracking over the colour choice** ➔ there is nothing to search. The first colour is arbitrary and everything after it is forced, so a failure is a genuine proof of non-bipartiteness, not a dead end to retry.

### 🔹 Counting the colourings
> [!code]- Pseudocode
> ```text
> function COUNT_TWO_COLOURINGS(G = (V, E))
>     if TWO_COLOUR(G) = False then
>         return 0
>     c = 0
>     Set visited[1..n] = False
>     for each vertex u = 1 to n do
>         if visited[u] = False then
>             c = c + 1                          # one fresh traversal = one component
>             DFS_MARK(u, visited)
>     return 2^c
> ```
> 💡 **Common Mistake:** **Counting components before checking colourability** ➔ a graph with one bad component and nine good ones has $0$ colourings, not $2^{9}$.

## ⚖️ Complexity
| Task | Traversal | Time | Auxiliary space | Output |
| :--- | :--- | :--- | :--- | :--- |
| Is $G$ bipartite / two-colourable? | one DFS or BFS | $\Theta(V+E)$ | $\Theta(V)$ colour array $+$ stack | boolean $+$ a witness colouring |
| Exhibit the parts $A,B$ | the same run | $\Theta(V+E)$ | $\Theta(V)$ | the two colour classes |
| Count the two-colourings | the same run | $\Theta(V+E)$ | $\Theta(V)$ | $2^{c}$, or $0$ |
| Disprove bipartiteness by hand | — | — | — | **one** odd cycle suffices |

- **Adjacency-list bound** ➔ on an [[Graph Representations|adjacency matrix]] the neighbour scan makes it $\Theta(V^{2})$.
- **Nothing is paid for the colouring** ➔ the colour array is $O(1)$ work per vertex on a traversal already costing $\Theta(V+E)$ ➔ [[Uninformed Search (BFS and DFS)]].

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace
2-colour $C_4$ by distance parity from vertex $1$:

| Step / State | Vertex | Distance parity | Colour |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | 1 (ground) | even | Black |
| 1 | 2 | odd | White |
| 2 | 3 | even | Black |
| 3 | 4 | odd | White |

### Applied Exercise
**Problem:** $G$ has $12$ vertices in three components — a $6$-cycle, a $4$-vertex path, and two isolated vertices. How many valid two-colourings?
$$
\begin{aligned}
\text{$6$-cycle} &: \text{even cycle} \Rightarrow \text{bipartite} \\
\text{path} &: \text{acyclic} \Rightarrow \text{bipartite} \\
c &= 1 + 1 + 2 = 4 \quad\text{(each isolated vertex is its own component)} \\
\#\text{colourings} &= 2^{4} = 16
\end{aligned}
$$
**Final Extracted Output:** $\mathbf{16}$. Replace the $6$-cycle with a $5$-cycle and the answer collapses to $\mathbf{0}$ — one odd cycle anywhere in the graph kills **every** colouring, not just its own component's.

## ⚠️ Common Mistakes
- 💡 **One odd cycle disproves it** ➔ to prove bipartite exhibit the parts / 2-colouring; to disprove, exhibit an odd cycle (e.g. a triangle).
- 💡 **Treating an already-coloured neighbour as a failure** ➔ the test is *same colour as me*, not *coloured at all*; the looser test rejects every graph with a cycle, even an even one.
- 💡 **Seeding the colouring at one vertex** ➔ a disconnected graph needs a fresh arbitrary colour per component, and the component count is also what the counting question needs.
- 💡 **Forgetting isolated vertices in $2^{c}$** ➔ a degree-$0$ vertex is a component and doubles the count.

## 🧠 Active Recall
> [!FAQ]- Give the three equivalent characterisations of a bipartite graph.
> - **Hint:** Parts / colouring / odd cycle.
> > [!SUCCESS]- Answer
> > - **Short answer:** (1) $V=A\sqcup B$ edges crossing; (2) 2-colourable; (3) no odd cycle.
> > - **Why:** **Distance parity** ➔ colour by distance parity; odd cycle is the obstruction.

> [!FAQ]- How do you prove/disprove bipartiteness, and what's the smallest non-bipartite graph?
> - **Hint:** Colouring vs odd cycle.
> > [!SUCCESS]- Answer
> > - **Short answer:** Prove by exhibiting parts/2-colouring; disprove with one odd cycle; smallest non-bipartite is $K_3$.
> > - **Why:** **Three mutually adjacent** ➔ a triangle needs three colours.

> [!FAQ]- Two-colouring sounds like a search over $2^{V}$ assignments. Why is a single greedy traversal enough, and why is the arbitrary first colour not a gamble?
> > [!SUCCESS]- Answer
> > - **Short answer:** after the first vertex of a component is coloured, every other colour in that component is **forced**, so there is exactly one decision and its two options are mirror images.
> > - **Why:** **Adjacency determines the neighbour's colour** ➔ "different from mine" leaves no freedom with only two colours, so the colouring propagates deterministically across the component. **The two options are complements** ➔ swapping white and black maps any valid colouring to another valid one, so if the greedy run fails from black it would fail identically from white. **Failure is therefore a proof** ➔ a clash means *every* assignment fails, which is exactly the odd-cycle obstruction; the algorithm never needs to backtrack, and it runs in $\Theta(V+E)$.

> [!FAQ]- Why is the number of valid two-colourings $2^{c}$ rather than $2^{V}$ or $2$?
> > [!SUCCESS]- Answer
> > - **Short answer:** each [[Connectivity|component]] contributes exactly two colourings, and components are independent, so the choices multiply to $2^{c}$.
> > - **Why:** **Within a component the freedom is one bit** ➔ fixing any single vertex fixes all the rest by forcing, so a component has its colouring and the swap, and nothing else — not $2^{\lvert V_i\rvert}$. **Across components there is no constraint** ➔ no edge joins them, so every combination of per-component choices is valid, giving a product of $c$ twos. **The precondition is global** ➔ if any component fails, the whole count is $0$, so colourability is tested first and the exponent is only reached on success.
