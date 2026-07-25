---
unit: FIT1043
week: [1, 5]
parent: "[[Data Science]]"
tags: [DataScience/Foundations, DataScience/ML]
aliases: [Machine Learning, ML]
---
# [[Machine Learning]]

**Context:** [[FIT1043_MOC]] · the hacking ∩ maths/stats region of [[Data Science|Conway's diagram]] · algorithms that *learn* from data · the Analysis step of the [[Data Science Process (Standard Value Chain)|value chain]] · learns [[Predictive Models|predictive models]] in two [[Machine Learning Styles (Supervised vs Unsupervised)|styles]]

> [!abstract] Quick Revision
> - **🎯 Objective:** build algorithms/techniques that let computers **learn** from data ➔ patterns/inference, not explicit instructions.
> - **⚡ Key Constraint:** ML earns its place only when hand-written rules fail — the task is unknown, changing, or too big/expensive for humans.

## 📝 Core
- **Definition** ➔ the study of algorithms/statistical models that perform a task **without explicit instructions**, relying on **patterns and inference** (Wikipedia); getting computers to learn and **improve over time autonomously** from data/observations (Emerj); underlying theory in **statistics**.
- **vs expert systems** ➔ rule-based expert systems are brittle when the situation keeps changing; ML adapts from data instead.
- **When ML is useful** ➔
  - **No human expertise** ➔ e.g. Martian exploration.
  - **Tacit expertise** ➔ humans can't state the rules, or they're incomplete/need tuning ➔ e.g. speech recognition.
  - **Auto-adaptation** ➔ many solutions must adapt automatically ➔ e.g. user personalisation.
  - **Changing conditions** ➔ e.g. junk-email filtering.
  - **Large data** ➔ e.g. discovering astronomical objects.
  - **Humans too expensive** ➔ e.g. handwritten zipcode recognition.

## ⚙️ Developing an ML Model
- **1. Choose a measure of success** ➔ the metric the model is judged by.
- **2. Set an evaluation protocol** ➔ how you'll test it (e.g. held-out test; see [[Predictive Models]]).
- **3. Build a benchmark model** ➔ a simple baseline to beat.
- **4. Build a better model + tune hyperparameters** ➔ improve on the baseline and adjust its settings.

## ⚠️ Common Mistakes
- 💡 **ML ≠ all of data science** ➔ it's one region of Conway's diagram (hacking ∩ maths/stats); "ML on big data" is the *narrow* definition of data science.
- 💡 **Rules vs learning** ➔ if a simple, stable rule set solves it, a rule-based system may beat ML; reach for ML when rules can't be written or won't stay valid.

## 🧠 Active Recall
> [!FAQ]- Give the agreed definition of machine learning and two situations where it beats a rule-based system.
> > [!SUCCESS]- Answer
> > - **Short answer:** ML develops algorithms/techniques that let computers learn from data (statistical foundation); it beats rules when humans can't express the expertise (speech recognition) or when conditions keep changing (junk email).
> > - **Why:** **Learn vs encode** ➔ rule-based systems fix behaviour up front; ML infers and adapts it from data, handling tacit, shifting, or high-volume problems.

> [!FAQ]- Outline the four steps to develop an ML model.
> > [!SUCCESS]- Answer
> > - **Short answer:** (1) choose a measure of success; (2) set an evaluation protocol; (3) build a benchmark/baseline model; (4) build a better model and tune its hyperparameters.
> > - **Why:** **Baseline-then-improve** ➔ a fixed metric + protocol lets you prove each model beats the last, avoiding tuning to noise.
