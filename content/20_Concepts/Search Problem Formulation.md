---
unit: FIT1061
week: 2
source: [lecture, applied]
domain: A
parent: "[[AI Algorithm Blocks (Search, Uncertainty, Learning)]]"
tags: [CS/AI, CS/Algorithms]
aliases: [Problem Formulation, State Space Search, Game Tree, Branching Factor]
---
# [[Search Problem Formulation]]

**Context:** [[FIT1061_MOC]] · Block A's shared vocabulary ([[AI Algorithm Blocks (Search, Uncertainty, Learning)]]) — every W2–W5 algorithm inherits this structure and differs only in **strategy**

> [!abstract] Quick Revision
> - **🎯 Objective:** name states · actions · successor · goal test ➔ any puzzle, route or game collapses to a [[Graph]] one algorithm can search.
> - **⚠️ Key Constraint:** the tree is **never built** ➔ states are generated on demand, because $b^d$ makes storage impossible past trivial depth.

## 📝 Core
- **States $s$** ➔ configurations of the world — a board position, a grid cell, a road intersection.
- **Actions $a$** ➔ legal transitions out of a state — a legal chess move, a tile slide, driving one edge.
- **Successor function** ➔ which state $a$ lands in; the **only** operation an algorithm needs is *given a node, return its neighbours*.
- **Goal test** ➔ predicate deciding "done" — checkmate? tiles sorted? at $F$?
- **Path cost** ➔ price of the route taken; uniform $1$ per step this week — edge weights and $g(n)$ arrive with weighted search.
- **Game tree** ➔ node $=$ state, edge $=$ action, root $=$ start position, **leaf** $=$ state with no move left (someone wins, or the board is full).
- **Branching factor $b$** ➔ actions available per state ➔ depth-$d$ level holds $\approx b^d$ states.
- **Grids are graphs** ➔ each walkable cell is a node, each edge a step to a $4$-neighbour; walls are simply nodes that do not exist. Direction is irrelevant — the graph is undirected.

### Three instantiations
| Problem | States | Actions | Goal test | Cost |
| :--- | :--- | :--- | :--- | :--- |
| **8-puzzle** | $3\times3$ tile configurations | slide blank up/down/left/right | tiles in sorted order? | $1$ per slide |
| **GPS routing** | intersections $A$–$F$ | drive along an edge | at $F$? | edge travel time |
| **Chess** | board positions | legal moves ($b\approx35$) | checkmate? | $1$ per move |

### Why the tree explodes
| Depth | Tic-tac-toe (shrinking $b\le9$) | Chess ($b\approx35$) |
| :--- | :--- | :--- |
| $1$ | $9$ | $35$ |
| $2$ | $9\times8=72$ | $35^2=1{,}225$ |
| $4$ | $9\times8\times7\times6=3{,}024$ | $35^4\approx1.5\times10^6$ |
| full / $10$ | $9!=362{,}880$ (whole game) | $35^{10}\approx2.7\times10^{15}$ |

- **Solved vs unsearchable** ➔ at $10^7$ ops/s all $362{,}880$ tic-tac-toe leaves take $\approx0.04$ s — **tic-tac-toe is solved**; $35^{10}$ takes $\approx9$ years, and a real game runs $\approx40$ moves deep.
- **Consequence** ➔ exhaustive checking is off the table ➔ every later algorithm is a rule for **deciding what to explore first**.

## ⚠️ Common Mistakes
- 💡 **Formulating the algorithm, not the problem** ➔ "use BFS" earns nothing; marks come from naming states, actions and goal test *for this domain*.
- 💡 **Reading $b^d$ as the tree size** ➔ $b^d$ is the count at **one** depth; the tree to depth $d$ is $\sum_{i=0}^{d} b^i$, dominated by the last layer.
- 💡 **Assuming constant $b$** ➔ tic-tac-toe's branching *shrinks* ($9,8,7,\dots$); $b$ is an average, and the chess figure $35$ is an estimate.

## 🧠 Active Recall
> [!FAQ]- Why does one formulation cover chess, the 8-puzzle and GPS routing — three problems with nothing physical in common?
> > [!SUCCESS]- Answer
> > - **Short answer:** the algorithm never sees the domain, only the successor function.
> > - **Why:** **Interface, not content** ➔ BFS asks exactly one question — *given this node, what are its neighbours?* — so any domain that can answer it is searchable. **The four parts are that interface** ➔ states supply the nodes, actions plus successor supply the edges, the goal test supplies termination, path cost supplies the ranking. Swapping chess for a grid changes the neighbour lookup and nothing else.

> [!FAQ]- Deep Blue evaluated $2\times10^8$ positions per second and still could not search a chess game to the end. Why is more hardware not the fix?
> > [!SUCCESS]- Answer
> > - **Short answer:** the tree grows exponentially in depth, hardware grows linearly.
> > - **Why:** **Exponent beats constant** ➔ each extra ply multiplies the work by $b\approx35$, so a $35\times$ faster machine buys **one** extra move of lookahead. **Depth $10$ of a $40$-move game is $2.7\times10^{15}$ positions** ➔ $\approx9$ years at $10^7$ nodes/s, and the full game is unimaginably larger. The escape is a better *strategy* — heuristics and pruning — not a bigger machine.
