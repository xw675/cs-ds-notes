---
unit: FIT1061
type: MOC
tags:
  - 2026/S2
---
# 📘 FIT1061: Introduction to Artificial Intelligence

> [!INFO] Map of Content
> Index for **FIT1061 Introduction to Artificial Intelligence** — the unit refuses "AI" as a definition and teaches **algorithms** in three blocks: how machines search (W2–5), decide under uncertainty (W6–9), and learn (W10–12). Every algorithm is drilled against three questions: how does it work, when does it fail, who does it affect.

## 📊 Assessment Map
- **Format** ➔ tiered portfolio, submitted via **OnTrack**; Pass tasks **P1–P10** plus optional Credit / Distinction / HD extensions. You pick the tier and may raise or lower it any time before **W13**.
- **The ladder** ➔ **Pass 50–59** implement each algorithm with scaffolding, engage with the milestone (~8 h/wk) · **Credit 60–69** Pass + 4 Credit extensions, less scaffolding (~10–12 h) · **Distinction 70–79** Credit + 4 tasks incl. A\*, perceptron training, adversarial tournament (~12 h) · **HD 80+** Distinction + one comprehensive project: define → implement → interview (~12–15 h).
- **Task outcomes** ➔ **Complete** (locked in) or **Fix and Resubmit** ➔ unlimited good-faith attempts until W13; a tutor may pause resubmissions that stop engaging with feedback.
- **⚠️ HURDLE — Week 10 test** ➔ 30–40 min, paper, **no code, no devices**; short answer + hand-computation; covers Pass tasks **2–9 only (W1 excluded)**. Resit W12, supplementary W14 capped at Pass. **The unit cannot be passed without it.**
- **What the hurdle actually tests** ➔ hand-traces of search algorithms · hand-computed Bayes' rule · confusion-matrix arithmetic · gradient-descent step calculations ➔ every by-hand sub-task already done in the portfolio, so **hand-execution is the revision priority all semester**.
- **Kialo debates** ➔ W2 (Deep Blue), W7 (COMPAS), W11 (face recognition); each is prompt → response → counter-argument → reply and feeds that week's reflective response. Citing optional in W2, expected in W7 and W11.
- **AI use** ➔ cited at every tier (tool, prompt, date). Permission scales: Pass concept questions only · Credit debug your own code · Distinction pair-programming · HD critical evaluation expected. Never submit code or an argument you cannot trace in discussion.

## 📅 Knowledge Index

### Week 1 — Milestone: ELIZA to ChatGPT
- [[Turing Test (Imitation Game)]] -> Parent Framework: [[FIT1061_MOC]] *(the criterion, and the three cases that test it)*
- [[The AI Effect (Defining AI)]] -> Parent Framework: [[FIT1061_MOC]] *(why the label slips — the ten-system boundary spectrum)*
- [[AI Algorithm Blocks (Search, Uncertainty, Learning)]] -> Parent Framework: [[FIT1061_MOC]] *(the unit map: question → recipe → flagship → weeks)*

### Week 2 — Milestone: Deep Blue vs Kasparov
- [[Search Problem Formulation]] -> Parent Framework: [[AI Algorithm Blocks (Search, Uncertainty, Learning)]] *(the four parts + why $b^d$ forbids exhaustion)*
- [[Uninformed Search (BFS and DFS)]] -> Parent Framework: [[Search Problem Formulation]] *(hurdle hand-trace)*
- [[Deep Blue vs Kasparov]] -> Parent Framework: [[Turing Test (Imitation Game)]] *(Kialo motion + reflective response)*

## 🎯 Learning Outcomes
- **W1** ➔ 
	- state Turing's substitution: an unanswerable question ⟹ a text-only imitation game
	- reject a "Turing test passed" claim by naming its format conditions
	- explain the AI effect and why the label tracks novelty, not capability
	- classify a system by machinery — does it learn, does it plan — not by label
	- map any unit algorithm to its block, recipe and flagship system
	- apply the refrain: how does it work · when does it fail · who does it affect
- **W2** ➔ 
	- formulate any problem as states, actions, successor function and goal test
	- compute states at depth $d$ from a branching factor $b$ and argue why exhaustion fails
	- hand-trace BFS, writing the frontier, visited set and `came_from` at every step
	- reconstruct a path backwards from `came_from` and report `nodes_expanded`
	- convert BFS to DFS by the single frontier swap ([[Queue (ADT)]] ➔ [[Stack (ADT)]])
	- state BFS's shortest-path guarantee **with both** its preconditions
	- argue the Kialo motion by naming the machinery, not the scoreboard
