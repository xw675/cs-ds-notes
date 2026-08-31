---
unit: FIT2004
week: 5
source: [lecture]
domain: A
parent: "[[Directed Acyclic Graph (DAG)]]"
tags: [CS/Algorithms, Math/GraphTheory]
aliases: [Topological Sorting, Topological Order, Kahn's Algorithm]
---
# [[Topological Sort]]

**Context:** [[FIT2004_MOC]] · linearise a [[Directed Acyclic Graph (DAG)|DAG]] so every edge points **forward** — two $\Theta(V+E)$ routes, both reductions of [[Uninformed Search (BFS and DFS)|traversal]]
**Parent Framework:** [[Directed Acyclic Graph (DAG)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** output a permutation of $V$ in which $u$ precedes $v$ for **every** edge $\langle u,v\rangle$ ➔ a legal execution order for the dependencies.
> - **📦 Core Components:** **Kahn's** ➔ repeatedly emit an in-degree-$0$ vertex | **modified DFS** ➔ push each vertex on **finish**, then read the stack top-down.
> - **⚠️ Key Constraint:** the answer is **not unique** — incomparable vertices may come in either order, so a marker's differing answer is not a contradiction.

## 📝 How It Works
### 1. What "Valid" Means
- **The obligation** ➔ for every edge $\langle u,v\rangle$, position of $u$ $<$ position of $v$. Nothing else is constrained.
- **Incomparable vertices are free** ➔ with no edge between $V$ and $W$, both orders are legal ➔ many valid outputs per DAG.
- **Checking an answer** ➔ scan the edge list once and test each edge against the emitted positions; $\Theta(E)$, and the fastest way to mark your own trace.
- **Cycle $\Rightarrow$ nothing** ➔ if fewer than $V$ vertices are emitted, the leftovers form a [[Cycle (Graph Theory)|cycle]] and **no** valid order exists.

### 2. Kahn's Algorithm — peel the sources
- **Idea** ➔ a vertex with **no incoming edge** owes nothing, so it can go next; emit it, delete its out-edges, and whatever that frees becomes emittable.
- **Bookkeeping** ➔ one `incoming_edges` count per vertex, built in $\Theta(V+E)$; a `process` collection holding every currently-zero vertex.
- **Queue or stack** ➔ `process` may be either; the rule fixes only *which* vertices are eligible, not which eligible one you pick ➔ different choices give different valid orders.
- **Decrement, do not rescan** ➔ each edge is decremented **once**, which keeps the total at $\Theta(V+E)$ rather than $\Theta(VE)$.

### 3. Modified DFS — push on finish
- **The observation** ➔ raw [[Uninformed Search (BFS and DFS)|DFS]] visit order is **not** a topological order: after hitting a dead end it returns to an earlier vertex that must appear *early*. On the lecture DAG, DFS visits $A,B,D,C,E$, which is invalid.
- **The repair** ➔ push $u$ onto a stack only **after** every out-neighbour has finished (post-order); the topological order is the stack **popped**, i.e. the **reverse** of the push order.
- **Why it works** ➔ $u$ finishes after all of its descendants, so its push is deeper in the stack than theirs ➔ on popping, $u$ emerges first.

## ⚙️ Core Implementation
### 🔹 Kahn's algorithm
> [!code]- Code
> ```python
> def kahn(graph):
>     incoming = [0] * len(graph.vertices)          # O(V)
>     for u in graph.vertices:                      # O(V + E)
>         for (v, _w) in u.edges:                   # edge <u,v>
>             incoming[v.id] += 1
>
>     process = []                                  # queue or stack - either is valid
>     for u in graph.vertices:                      # O(V)
>         if incoming[u.id] == 0:
>             process.append(u)
>
>     sorted_list = []
>     while len(process) > 0:                       # O(V) pops
>         u = process.pop()
>         sorted_list.append(u)
>         for (v, _w) in u.edges:                   # O(E) over the whole run
>             incoming[v.id] -= 1
>             if incoming[v.id] == 0:
>                 process.append(v)
>
>     if len(sorted_list) < len(graph.vertices):
>         raise ValueError("cycle detected - no topological order exists")
>     return sorted_list
> ```
> 💡 **Common Mistake:** **Decrementing the wrong index** ➔ the counter belongs to the edge's **head** `v`, not to the served `u`; the slide snippet writes `incoming_edges[vertex_v]` where it means `incoming_edges[edge.vertex_v]`, and the resulting order looks plausible while being wrong.

### 🔹 Modified DFS
> [!code]- Code
> ```python
> def dfs_topological(graph):
>     stack = []
>     for u in graph.vertices:                      # cover every component
>         if not u.visited:
>             dfs_aux(u, stack)
>     i, j = 0, len(stack) - 1                      # popping == reversing
>     while i < j:
>         stack[i], stack[j] = stack[j], stack[i]
>         i, j = i + 1, j - 1
>     return stack                                  # now in topological order
>
> def dfs_aux(u, stack):
>     u.visited = True
>     for (v, _w) in u.edges:
>         if not v.visited:
>             dfs_aux(v, stack)
>     stack.append(u)                               # push AFTER all descendants
> ```
> 💡 **Common Mistake:** **Printing the stack as built** ➔ the push order is the **reverse** of the answer; pop it, or reverse it, before submitting.
> 💡 **Common Mistake:** **Starting from one vertex** ➔ a DAG can have several sources, so a single seeded DFS misses whole components; loop over all vertices, and push the seed itself.

## ⚖️ Complexity
| Variant | Time | Auxiliary space | Cycle detection | Order it tends to produce |
| :--- | :--- | :--- | :--- | :--- |
| **Kahn's** | $\Theta(V+E)$ | $\Theta(V)$ — counts $+$ `process` | **free**: emitted $<V$ ⟹ cycle | sources first; natural for "what can I start now" |
| **Modified DFS** | $\Theta(V+E)$ | $\Theta(V)$ — stack $+$ recursion depth | needs an extra `in-progress` mark to spot a back edge | sinks first, then reversed |
| Brute force (try permutations) | $\Theta(V!\cdot E)$ | $\Theta(V)$ | — | never do this |

- **Where the $\Theta(V+E)$ comes from** ➔ every vertex enters and leaves the working collection exactly once ($V$), and every edge is inspected exactly once ($E$) — identical accounting to [[Uninformed Search (BFS and DFS)|BFS/DFS]].
- **Recursion is not free** ➔ the DFS variant's stack depth is $\Theta(V)$ in the worst case (a path graph), so it is **not** in-place ([[Analysing Recursive Algorithms (Time and Auxiliary Space)]]).

## ⚖️ Core Decision Matrix
| Need | Pick | Why |
| :--- | :--- | :--- |
| Detect a cycle as a by-product | **Kahn's** | the count of emitted vertices *is* the certificate — no extra state |
| Already have a recursive DFS in the codebase | **modified DFS** | one line added: push on finish |
| Iterative code required (deep graph, no recursion) | **Kahn's** | explicit collection, no call stack to overflow |
| "Which tasks can run in parallel right now" | **Kahn's** | each round of zero-in-degree vertices is one parallel layer |

> [!NOTE] **When It Flips:** the two agree on cost, so the choice is driven by **what else you need** — a cycle certificate and layering favour Kahn's; an existing DFS traversal favours the post-order push.

## 📊 Exam Execution Trace & Applied Exercises
Lecture DAG: $A\!\to\!B$, $A\!\to\!C$, $B\!\to\!D$, $C\!\to\!D$, $C\!\to\!E$, $E\!\to\!D$. In-degrees $A{:}0$, $B{:}1$, $C{:}1$, $D{:}3$, $E{:}1$.

### Manual Execution Trace
Kahn's, `process` used as a **stack** (`pop()` from the end).

| Step | Popped | Decremented to | `process` after | `sorted_list` |
| :--- | :--- | :--- | :--- | :--- |
| **0** | — | — | $[A]$ | $[\ ]$ |
| $1$ | $A$ | $B{:}0$ ✅, $C{:}0$ ✅ | $[B,C]$ | $[A]$ |
| $2$ | $C$ | $D{:}2$, $E{:}0$ ✅ | $[B,E]$ | $[A,C]$ |
| $3$ | $E$ | $D{:}1$ | $[B]$ | $[A,C,E]$ |
| $4$ | $B$ | $D{:}0$ ✅ | $[D]$ | $[A,C,E,B]$ |
| $5$ | $D$ | — | $[\ ]$ | $[A,C,E,B,D]$ |

**Final Extracted Output:** $A,C,E,B,D$ · all $5$ vertices emitted ⟹ the graph **is** a DAG.

### Applied Exercise
**Problem:** which of $\;1.\ A,B,C,E,D\;$ $\;2.\ A,C,B,E,D\;$ $\;3.\ A,C,E,B,D\;$ $\;4.\ A,B,E,C,D\;$ is **not** a valid topological sort?
$$
\text{constraints}: A<B,\; A<C,\; B<D,\; C<D,\; C<E,\; E<D; \qquad \text{option }4:\ \text{pos}(E)=3<\text{pos}(C)=4 \text{ violates } \langle C,E\rangle
$$
**Final Extracted Output:** **option 4** is invalid; $1$–$3$ each satisfy all six constraints, differing only in the order of incomparable pairs — exactly the non-uniqueness the definition permits.

### Applied Exercise
**Problem:** DFS from $A$ (neighbours in alphabetical order) — give the visit order and the topological order, and explain why they differ.
$$
\text{visit (pre-order)}: A, B, D, C, E \qquad \text{finish (push)}: D, B, E, C, A \qquad \text{pop (reverse)}: A, C, E, B, D
$$
**Final Extracted Output:** the visit order is **invalid** ($D$ precedes $C$, yet $\langle C,D\rangle$ exists); the pop order is valid. Pre-order records *when we arrived*, post-order *when everything downstream was settled* — only the second respects the dependencies.

## ⚠️ Common Mistakes
- 💡 **Emitting the DFS visit order** ➔ the single highest-frequency error; DFS **pre**-order has no ordering guarantee, only the reversed **post**-order does.
- 💡 **Claiming "the" topological sort** ➔ say *a* topological sort, and if the question demands determinism, state your tie-break rule before tracing.
- 💡 **Reporting success on a cyclic graph** ➔ Kahn's terminates happily with a **short** `sorted_list`; the check is `len(sorted_list) == V`.

## 🧠 Active Recall
> [!FAQ]- Why does pushing on **finish** produce a valid order when pushing on **discovery** does not?
> > [!SUCCESS]- Answer
> > - **Short answer:** a vertex finishes only after every vertex it points to has finished, so it is pushed **below** all of them and pops **before** all of them.
> > - **Why:** **Discovery order carries no dependency information** ➔ DFS may reach a deep vertex $D$ long before it discovers $C$, even though $\langle C,D\rangle$ exists. **Finish order inverts the edges** ➔ for every edge $\langle u,v\rangle$ on a DAG, $v$ finishes strictly before $u$. **Acyclicity is load-bearing** ➔ on a cyclic graph $v$ may still be in progress when $u$ finishes — that unfinished-but-visited vertex is precisely the back edge a cycle check looks for.

> [!FAQ]- Both algorithms are $\Theta(V+E)$. On what grounds would you still prefer Kahn's in a build system?
> > [!SUCCESS]- Answer
> > - **Short answer:** it hands you cycle detection and parallel layering for free, and it needs no call stack.
> > - **Why:** **A build system must *diagnose* circular dependencies, not just fail** ➔ Kahn's leftover set is the offending vertices, ready to print. **Each zero-in-degree round is a parallel batch** ➔ its members have no dependency between them, which is the schedule a build runner wants. **Deep dependency chains overflow recursion** ➔ the iterative form has no depth limit, whereas the DFS variant's stack is $\Theta(V)$.
