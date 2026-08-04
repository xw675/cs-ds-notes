---
unit: FIT1061
week: 1
source: [lecture]
parent: "[[FIT1061_MOC]]"
tags: [CS/AI]
aliases: [Three Blocks, FIT1061 Unit Map]
---
# [[AI Algorithm Blocks (Search, Uncertainty, Learning)]]

**Context:** [[FIT1061_MOC]] · the unit's replacement for the word "AI" ([[The AI Effect (Defining AI)]]) — every algorithm answers exactly one of three questions

> [!abstract] Quick Revision
> - **🎯 Objective:** match an algorithm to its question (search · uncertainty · learning) ➔ recover its block's recipe, flagship system and week.
> - **⚠️ Key Constraint:** the blocks are **questions, not techniques** ➔ a system spanning all three (an LLM) is classified component by component, never as a whole.

## 📝 Core
| Block | The question | The recipe | Flagship milestone | Weeks |
| :--- | :--- | :--- | :--- | :--- |
| **A · Search** | the answer is hidden in a space of possibilities — find it without checking everything | network proposes promising moves → tree search explores consequences → self-play feeds the network better data | **AlphaGo** (DeepMind, 2016) beat Lee Sedol $4$–$1$ at Go | W2–5 |
| **B · Uncertainty** | the right answer is probabilistic — estimate it from data and act on the estimate | estimate $P(\text{outcome} \mid \text{data})$ from past examples → combine features into one decision → audit who it gets right and wrong | **Watson** (IBM, 2011) beat the *Jeopardy!* champions; same machinery runs COMPAS | W6–9 |
| **C · Learning** | the right rule is unknown — extract it from many examples | millions of labelled examples → define a loss → nudge the weights downhill billions of times | **AlphaFold** (DeepMind, 2024 Nobel) predicts any protein's 3D shape | W10–12 |

- **Block A tools** ➔ BFS/DFS (W2) · greedy best-first (W3) · A\* · hill climbing (W4) · minimax on game trees · consolidation (W5).
- **Block B tools** ➔ probability & Bayes' rule (W6) · Naive Bayes, the spam-filter algorithm (W7) · weighted sums / perceptron, the unit cell of every neural net (W8) · fairness metrics (W9).
- **Block C tools** ➔ gradient descent in 1D and 2D (W10) · perceptron training · convolution, how machines see (W11) · deployment & model cards (W12).
- **The same recipes scale** ➔ A drives AlphaProof (IMO silver 2024), Gemini Deep Think (IMO gold 2025) and every planning agent (Cursor, Claude Code); C drives ChatGPT, Tesla Autopilot and GraphCast weather forecasting.
- **LLMs use all three** ➔ **A** agent wrappers search over actions and reasoning models over chains of thought · **B** next-token prediction *is* a conditional probability · **C** gradient descent trained the weights, RLHF polished the behaviour.
- **Critique refrain** ➔ ask of every algorithm built and every system met outside the unit: (1) how does it work? (2) when does it fail? (3) who does it affect?

## ⚠️ Common Mistakes
- 💡 **Classifying the product, not the component** ➔ "ChatGPT is Block C" drops the search and probability machinery that make it usable.
- 💡 **Reading blocks as a difficulty ladder** ➔ they are three independent questions, and Block A's 1959 shortest-path algorithm still runs in production.

## 🧠 Active Recall
> [!FAQ]- A spam filter and AlphaFold both "learn from data" — why is one Block B and the other Block C?
> > [!SUCCESS]- Answer
> > - **Short answer:** they differ in what is being computed, not in whether data is used.
> > - **Why:** **Block B estimates a probability** ➔ counts past examples to get $P(\text{spam} \mid \text{words})$, then acts on that estimate — the decision rule is given, the numbers are filled in. **Block C searches for the rule itself** ➔ a loss is defined over millions of labelled examples and the weights are nudged downhill until the mapping emerges.
