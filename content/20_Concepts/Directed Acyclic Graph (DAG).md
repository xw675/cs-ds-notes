---
unit: FIT2004
week: 5
source: [lecture]
domain: A
parent: "[[Types of Graphs]]"
tags: [CS/Algorithms, Math/GraphTheory]
aliases: [DAG, Directed Acyclic Graph]
---
# [[Directed Acyclic Graph (DAG)]]

**Context:** [[FIT2004_MOC]] · directed $+$ **no [[Cycle (Graph Theory)|cycle]]** ➔ the graph class on which "$A$ before $B$" is globally consistent, so it can be [[Topological Sort|sorted]]

> [!abstract] Quick Revision
> - **🎯 Objective:** an edge $\langle A,B\rangle$ asserts a **one-way dependency** ➔ acyclicity is what makes the dependencies simultaneously satisfiable.
> - **⚠️ Key Constraint:** acyclicity is the *whole* content — the instant one [[Cycle (Graph Theory)|cycle]] exists, no [[Topological Sort|topological order]] exists and the model is unsatisfiable.

## 📝 Core
- **Definition** ➔ a [[Types of Graphs|directed]] [[Graph]] $G=(V,E)$ containing no directed [[Cycle (Graph Theory)|cycle]]; edges are ordered pairs $\langle u,v\rangle$, so $\langle u,v\rangle\ne\langle v,u\rangle$.
- **What one edge $\langle A,B\rangle$ means** ➔ four readings of the same fact: $A$ is a **prerequisite** of $B$ · $A$ is an **ancestor** of $B$ · $A$ is a **subset** of $B$ · $A$ is **ordered before** $B$. The last is what licenses [[Topological Sort]].
- **Models it fits** ➔ unit prerequisite chains (FIT1045 ➔ FIT1008 ➔ FIT2004) · project-management task dependencies · skill/talent trees · the DAG built to solve **longest common subsequence**.
- **Models it does not** ➔ anything mutually dependent: `JOB ⇄ EXPERIENCE` is a $2$-cycle, so no order satisfies both edges — this is the exam's canonical non-DAG.
- **A [[Tree]] is a DAG** ➔ acyclic, with the root the unique vertex having **no incoming edge**; a DAG generalises it by allowing a vertex several parents.
- **Detecting it** ➔ run [[Topological Sort]]: a run that cannot place all $V$ vertices is a **cycle certificate**, at $\Theta(V+E)$ — the same cost as confirming the DAG.
- **Detecting it directly** ➔ a three-state [[Cycle Detection|DFS]] (unvisited / **active** / inactive) also decides it in $\Theta(V+E)$; a DAG is exactly a digraph with **no back edge** — no edge into a vertex still on the current search path.

## ⚠️ Common Mistakes
- 💡 **"Directed and no undirected cycle"** ➔ only **directed** cycles are forbidden. $A\!\to\!B$, $A\!\to\!C$, $B\!\to\!D$, $C\!\to\!D$ has an undirected cycle $A,B,D,C,A$ and is still a perfectly good DAG.
- 💡 **Assuming a unique root** ➔ a DAG may have many sources (in-degree $0$) and many sinks (out-degree $0$); only a [[Tree]] is promised one root.

## 🧠 Active Recall
> [!FAQ]- Why is acyclicity the precondition for ordering, rather than just a tidy property?
> > [!SUCCESS]- Answer
> > - **Short answer:** a cycle asserts $u<v$ and $v<u$ at once, so no permutation can satisfy every edge.
> > - **Why:** **The edge relation must be a strict partial order** ➔ $\langle u,v\rangle$ means $u$ precedes $v$, and a directed cycle makes that relation non-antisymmetric. **Hence "is it a DAG" and "does a [[Topological Sort]] exist" are the same question** ➔ one algorithm answers both in $\Theta(V+E)$.

> [!FAQ]- Give a real dependency that is *not* a DAG, and say what modelling move repairs it.
> > [!SUCCESS]- Answer
> > - **Short answer:** "need a job to get experience, need experience to get a job" — a $2$-cycle; split the vertices over **time** to break it.
> > - **Why:** **Cycles usually signal a missing time index** ➔ $\text{experience}_{t}\rightarrow\text{job}_{t+1}\rightarrow\text{experience}_{t+1}$ is acyclic. **The same trick underlies DP-on-a-DAG** ➔ indexing subproblems by size makes the dependency graph acyclic, which is why LCS becomes a DAG problem.
