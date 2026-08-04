---
unit: FIT1061
week: 2
source: [lecture, applied]
domain: A
parent: "[[Search Problem Formulation]]"
tags: [CS/AI, CS/Algorithms, Math/GraphTheory]
aliases: [BFS, DFS, Breadth-First Search, Depth-First Search, Blind Search]
---
# [[Uninformed Search (BFS and DFS)]]
**Context:** [[FIT1061_MOC]] · Block A's two **blind** searches — no sense of direction, only an ordering rule
**Parent Framework:** [[Search Problem Formulation]]

> [!abstract] Quick Revision
> - **🎯 Objective:** ONE loop, ONE parameter ➔ the **frontier's discipline** — FIFO ([[Queue (ADT)]]) gives BFS, LIFO ([[Stack (ADT)]]) gives DFS.
> - **📦 Core Components:** **frontier** ➔ nodes waiting · **visited** ➔ stops re-exploration · **came_from** ➔ records the path · **nodes_expanded** ➔ the comparison metric.
> - **⚠️ Key Constraint:** BFS's shortest-path guarantee needs **FIFO order AND uniform step cost** — lose either and it evaporates.

## 📝 How It Works
### 1. The Shared Skeleton
- **One loop, four moves** ➔ take a node off the frontier ➔ count it ➔ goal-test it ➔ push its unvisited neighbours on.
- **Only the frontier differs** ➔ every other line of BFS and DFS is character-identical; the data structure *is* the algorithm.
- **Domain-blind** ➔ needs only the successor function, so grid, maze and road network run the same code ([[Search Problem Formulation]]).
- **Termination** ➔ goal dequeued ➔ reconstruct path · frontier empties ➔ **failure** (goal unreachable), not "no path exists yet".

### 2. Frontier = Queue ➔ BFS
- **FIFO ordering** ➔ nodes discovered first are expanded first ➔ all of depth $d$ before any of depth $d+1$.
- **Shape** ➔ radiates outward in layers, like ripples in a pond.
- **Shortest-path guarantee** ➔ nodes are reached in nondecreasing distance order, so the **first** arrival at any node is via a shortest path — every shorter route was already checked.
- **The price** ➔ it explores nearly every open cell before the goal surfaces, and the fraction explored *grows* with grid size.

### 3. Frontier = Stack ➔ DFS
- **LIFO ordering** ➔ the newest node is popped ➔ commits to one branch and drives it to the wall before backtracking.
- **Shape** ➔ a snaking corridor, not a wave.
- **No guarantee** ➔ swapping FIFO for LIFO destroys the layer ordering that *produced* optimality — DFS finds **a** path, not the shortest.
- **Why keep it** ➔ it is the engine of backtracking search, topological sort and cycle detection, and its frontier stays thin.

### 4. The Two Bookkeeping Structures
- **`visited` (a set)** ➔ membership test before enqueueing; **initialise with `start`**. Without it a cyclic graph re-enqueues forever and the frontier never empties.
- **`came_from` (a dict)** ➔ `came_from[B] = A` records *B was reached from A*; walk it backwards from the goal and reverse ➔ the path.
- **Mark on discovery, not on expansion** ➔ add to `visited` at the moment of enqueue/push; marking at pop lets one node enter the frontier many times.
- **Handout variant** ➔ the handout drops `visited` and tests `neighbour not in came_from` instead — `came_from`'s **keys are** the visited set, since every discovered node gets an entry. Both forms are correct; the lecture's explicit set is the traceable one.

## ⚙️ Core Implementation
### 🔹 BFS — unit pseudocode, final form
> [!code]- Pseudocode
> ```text
> function BFS(start, goal):
>     frontier ← Queue()
>     frontier.enqueue(start)
>     visited ← {start}
>     came_from ← {start: nil}
>     nodes_expanded ← 0
>     while frontier is not empty:
>         current ← frontier.dequeue()
>         nodes_expanded ← nodes_expanded + 1
>         if current = goal:
>             return reconstruct_path(came_from, start, goal)
>         for each neighbour of current:
>             if neighbour not in visited:
>                 visited.add(neighbour)
>                 came_from[neighbour] ← current
>                 frontier.enqueue(neighbour)
>     return failure
> ```
> 💡 **Common Mistake:** **Goal-testing at enqueue** ➔ tempting and faster, but it desynchronises `nodes_expanded` from the trace the tutor marks; test at **dequeue**, as written.

### 🔹 DFS — the three-line diff
> [!code]- The entire change
> ```text
> frontier ← Stack()      # was Queue()
> frontier.push(start)    # was enqueue
> current ← frontier.pop()  # was dequeue
> ```
> 💡 **Common Mistake:** **Rewriting the loop** ➔ any other edit means the comparison is no longer controlled, and the lab's BFS-vs-DFS numbers stop being about the frontier.

### 🔹 Path reconstruction
> [!code]- Walk the links backwards
> ```python
> def reconstruct_path(came_from, start, goal):
>     path = []
>     current = goal
>     while current is not None:      # came_from[start] is nil
>         path.append(current)
>         current = came_from[current]
>     # reverse in place — no library sort
>     i, j = 0, len(path) - 1
>     while i < j:
>         path[i], path[j] = path[j], path[i]
>         i, j = i + 1, j - 1
>     return path
> ```
> 💡 **Common Mistake:** **Forgetting the reverse** ➔ the links run goal→start, so an unreversed list is the path backwards.

## ⚖️ Complexity
| Resource | BFS | DFS |
| :--- | :--- | :--- |
| Nodes expanded (worst case) | $\approx b^d$ | $\approx b^d$ |
| Frontier size | a **whole layer** $\approx b^d$ ➔ memory grows with width | **one branch** $\approx b\cdot d$ ➔ thin |
| `visited` + `came_from` | $O(\lvert V\rvert)$ | $O(\lvert V\rvert)$ |
| Optimal (unweighted) | ✅ shortest | ❌ any path |

- **Neither scales to chess** ➔ $b\approx35$, so depth $10$ is $\approx2.7\times10^{15}$ nodes $\approx9$ years at $10^7$ nodes/s — **for either algorithm**. Blind search is the problem, not the choice between these two.

## ⚖️ Core Decision Matrix
| Frontier | Trigger condition | Pro | Con | Exploration shape |
| :--- | :--- | :--- | :--- | :--- |
| **Queue (FIFO)** ➔ BFS | shortest path required, edges unweighted | provably optimal; finds a path if one exists | explores broadly; frontier holds a full layer | radial wave |
| **Stack (LIFO)** ➔ DFS | any path suffices; deep/narrow space; backtracking base | tiny frontier; sometimes far fewer expansions | no optimality; can walk long dead-end corridors | snaking corridor |

> [!NOTE] **When It Flips:** on a **dead-end grid** DFS commits to the corridor, dead-ends and backtracks ➔ a longer path. On a **corridor-shaped** space with the goal deep along one branch, DFS reaches it after $\approx d$ expansions while BFS pays for the entire radius. Uniform cost is the hinge — introduce edge weights and BFS's guarantee dies too.

## 📊 Exam Execution Trace & Applied Exercises
Lecture $3\times3$ grid, one wall at the centre. Nodes are walkable cells; edges join $4$-neighbours.
```text
S  1  2
3  ■  4
5  6  G
```
**Neighbour order fixed as right → down → left → up.** Exploration order is undefined without it — state your order before tracing.

### Manual Execution Trace
BFS, queue written front→back.
| Step | Dequeued | Unvisited neighbours enqueued | Queue after | `came_from` added |
| :--- | :--- | :--- | :--- | :--- |
| $1$ | `S` | `1`, `3` | `[1, 3]` | `1←S`, `3←S` |
| $2$ | `1` | `2` | `[3, 2]` | `2←1` |
| $3$ | `3` | `5` | `[2, 5]` | `5←3` |
| $4$ | `2` | `4` | `[5, 4]` | `4←2` |
| $5$ | `5` | `6` | `[4, 6]` | `6←5` |
| $6$ | `4` | `G` | `[6, G]` | `G←4` |
| $7$ | `6` | — (`G` already visited) | `[G]` | — |
| $8$ | `G` | **goal** ➔ reconstruct | — | — |

**Reconstruction:** `G ← 4 ← 2 ← 1 ← S` ➔ path $S,1,2,4,G$ · **length $4$ edges** · **nodes_expanded $=8$**.

DFS on the identical grid, stack written bottom→top.
| Step | Popped | Pushed | Stack after |
| :--- | :--- | :--- | :--- |
| $1$ | `S` | `1`, `3` | `[1, 3]` |
| $2$ | `3` | `5` | `[1, 5]` |
| $3$ | `5` | `6` | `[1, 6]` |
| $4$ | `6` | `G` | `[1, G]` |
| $5$ | `G` | **goal** | — |

**Reconstruction:** `G ← 6 ← 5 ← 3 ← S` ➔ path $S,3,5,6,G$ · **length $4$ edges** · **nodes_expanded $=5$**.

- **Read the result honestly** ➔ DFS matched BFS's length here **because this grid is symmetric**, and expanded $5$ nodes against $8$. DFS lacks the *guarantee*, which is not the same as always producing a worse path — the dead-end grid in the lab is engineered to make the gap appear.

## ⚠️ Common Mistakes
- 💡 **Omitting the visited check** ➔ `S, A, B, D` get re-enqueued after processing, the queue grows without bound and on a cyclic graph the search **never terminates** — this is exactly what the lecture's first trace exposed.
- 💡 **Returning `success` instead of a path** ➔ at the moment `G` is dequeued every step that led there is gone; the deliverable is the move sequence, not a boolean.
- 💡 **Exporting BFS optimality to weighted graphs** ➔ FIFO orders by **hop count**; roads with different travel times break the guarantee immediately.

## 🧠 Active Recall
> [!FAQ]- BFS and DFS differ by one data structure, yet only one guarantees the shortest path. Where exactly does the guarantee come from, and which line destroys it?
> > [!SUCCESS]- Answer
> > - **Short answer:** from FIFO order plus uniform step cost; `Queue()` → `Stack()` destroys it.
> > - **Why:** **FIFO expands in nondecreasing distance** ➔ everything at distance $k$ leaves the queue before anything at $k+1$, so the first arrival at a node is via a shortest path and no shorter route can still be pending. **LIFO expands the newest node** ➔ a node discovered deep on branch one is expanded before shallow nodes discovered earlier, so a node's first arrival carries no distance meaning. **Uniform cost is the second leg** ➔ "fewest hops" only equals "cheapest" when every edge costs the same.

> [!FAQ]- Both algorithms explore $\approx b^d$ nodes. Why is `nodes_expanded` still the number the lab asks you to record?
> > [!SUCCESS]- Answer
> > - **Short answer:** $b^d$ is the worst case; `nodes_expanded` is what actually happened on *this* graph shape.
> > - **Why:** **The bound is shape-blind** ➔ it assumes a full tree, whereas a grid with walls, a corridor or a dead-end produces wildly different real counts. **It is the only controlled comparison available** ➔ with the loop identical and the frontier the sole variable, a difference in `nodes_expanded` is caused by FIFO-vs-LIFO and nothing else. **It exposes BFS's price** ➔ pairing it with path length shows optimality bought with breadth, which is precisely the trade heuristics attack next week.
