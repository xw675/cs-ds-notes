---
unit: FIT1043
week: 6
parent: "[[Machine Learning]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Ensemble, Ensemble Models, Model Averaging]
---
# [[Ensemble Models]]

**Context:** [[FIT1043_MOC]] · combine several [[Predictive Models|models]] instead of one · addresses the unknowable truth of [[Learning Theory and Loss Functions|learning theory]] · a response to [[No Free Lunch Theorem|no free lunch]]

> [!abstract] Quick Revision
> - **🎯 Objective:** hold a **collection** of reasonable models rather than trusting one ➔ capture the realistic range of predictions.
> - **⚡ Key Constraint:** since the true model is unknown, no single fit is "correct" — an ensemble models the **variability** across plausible fits.

## 📝 Core
- **Definition** ➔ an ensemble is a **collection of possible/reasonable models**.
- **Why** ➔ given only data we don't know the truth; an ensemble shows the **variability and realistic range** of predictions.
- **Averaging** ➔ often we **average the predictions** across the ensemble's models to **improve performance**.
- **A field of its own** ➔ generating a good ensemble is a whole statistical subject.

## ⚠️ Common Mistakes
- 💡 **Not one "right" model** ➔ an ensemble deliberately keeps many fits to express uncertainty, rather than over-trusting a single one.
- 💡 **Averaging ≠ free accuracy** ➔ it reduces variance across models, but the ensemble is only as good as the models in it.

## 🧠 Active Recall
> [!FAQ]- What is an ensemble model, and why does averaging its members help?
> > [!SUCCESS]- Answer
> > - **Short answer:** An ensemble is a collection of reasonable models; averaging their predictions typically improves performance and reveals the realistic range/variability of predictions.
> > - **Why:** **Unknown truth** ➔ no single fit is guaranteed correct, so combining plausible models reduces reliance on any one and lowers prediction variance.
