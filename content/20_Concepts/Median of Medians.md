---
unit: FIT2004
domain: A
week: 3
source: [lecture]
parent: "[[Quickselect]]"
tags: [CS/Algorithms, CS/Complexity]
aliases: [MoM, Median of Medians Pivot, BFPRT]
---
# [[Median of Medians]]

**Context:** [[FIT2004_MOC]] · the **deterministic** pivot rule that converts [[Quickselect]]'s $\Theta(N)$ *expected* into $\Theta(N)$ *worst case* — and [[Quick Sort]]'s $\Theta(N^{2})$ worst case into $\Theta(N\log N)$ *(**scope:** lecturer-flagged as **not examinable in the final exam** historically, but live in the weekly quiz — learn the core concepts and the recurrence, do not drill it like a `[P]` hand skill)*

> [!abstract] Quick Revision
> - **🎯 Objective:** spend $\Theta(N)$ **choosing** a pivot that is provably near the middle ➔ every partition splits at worst $30/70$, so the recursion can never degenerate.
> - **⚡ Key Constraint:** it is a **guarantee, not a speed-up** — the constant factor is large enough that a random pivot beats it in practice; reach for it only when a worst-case *bound* is the requirement.

## 📝 Core
- **Procedure** ➔ split into $\lceil N/5\rceil$ groups of $5$ ➔ sort each group by [[Sorting Problem|insertion sort]] and take its median ($O(1)$ per group, $5$ items) ➔ **recursively** [[Quickselect]] the median of those $\lceil N/5\rceil$ medians ➔ use it as the partition pivot.
- **The split guarantee** ➔ at least half the group medians are $\ge$ the median-of-medians $M$, and each such group contributes $3$ elements $\ge$ its own median ⟹ $\ge\tfrac{3N}{10}$ elements sit on each side ⟹ neither side exceeds $\tfrac{7N}{10}$.
- **The recurrence and why it closes** ➔ pivot-finding costs $T(N/5)$, the surviving side costs $T(7N/10)$, partitioning costs $\Theta(N)$:
$$
T(N)=T\!\left(\tfrac{N}{5}\right)+T\!\left(\tfrac{7N}{10}\right)+cN,\qquad \tfrac15+\tfrac{7}{10}=\tfrac{9}{10}<1 \;\Longrightarrow\; T(N)=\Theta(N)
$$
- **Sub-unit shrinkage is the whole proof** ➔ the two subproblems consume only $\tfrac{9}{10}$ of the input, so the per-level work forms a decaying [[Geometric Series]] with $r=\tfrac{9}{10}$, summing to $10cN$ — **root-dominated**, hence linear.
- **Why groups of $5$** ➔ groups of $3$ give $T(N/3)+T(2N/3)+cN$ with $\tfrac13+\tfrac23=1$ ⟹ all levels equal ⟹ $\Theta(N\log N)$; the fractions must sum to **strictly less than $1$**, and $5$ is the smallest odd group size that achieves it.
- **Where it plugs in** ➔ as [[Quickselect]]'s pivot ⟹ $\Theta(N)$ worst-case selection; as [[Quick Sort]]'s pivot ⟹ $\Theta(N\log N)$ worst-case sorting, i.e. the answer to "how do you ensure the worst case **never** occurs?"

## ⚠️ Common Mistakes
- 💡 **Forgetting the recursive call** ➔ finding the median of the $\lceil N/5\rceil$ medians is itself a selection problem; scanning or sorting them instead costs $\Theta(N\log N)$ and destroys the linear bound.
- 💡 **Selling it as "faster quickselect"** ➔ it is strictly **slower** on typical input; the deliverable is the removal of the $\Theta(N^{2})$ tail, nothing else.
- 💡 **Claiming the pivot is the true median** ➔ it is only guaranteed to lie between the $30$th and $70$th percentile — a **constant-fraction** split, which is all the recurrence needs.

## 🧠 Active Recall
> [!FAQ]- Why must the two recursive fractions sum to strictly less than $1$, and what breaks at exactly $1$?
> - **Hint:** Write the per-level work as a series and read the ratio.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\tfrac15+\tfrac{7}{10}=\tfrac{9}{10}<1$ makes the level work **decay** ⟹ root-dominated $\Theta(N)$; at exactly $1$ every level costs $cN$ ⟹ $\Theta(N\log N)$.
> > - **Why:** **The ratio is the regime** ➔ total work is $cN\sum_i r^{i}$ with $r$ the surviving fraction; $r<1$ sums to the constant $\tfrac{1}{1-r}=10$, $r=1$ sums to the number of levels ➔ [[Solving Recurrences (Telescoping)]]. Groups of $3$ land exactly on $r=1$, which is why $5$ is the textbook choice.

> [!FAQ]- A random pivot already gives $\Theta(N)$ expected time. What does [[Median of Medians]] actually buy?
> - **Hint:** Name what an expectation does not rule out.
> > [!SUCCESS]- Answer
> > - **Short answer:** It converts a claim about the **average over pivot choices** into a claim about **every** run on **every** input.
> > - **Why:** **Expected $\ne$ bounded** ➔ randomisation stops an adversary from *constructing* a bad input, but an unlucky sequence of pivots is still possible; a deterministic $30/70$ guarantee removes the bad case from the algorithm rather than from the input distribution ➔ [[Algorithmic Complexity]].
