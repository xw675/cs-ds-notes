---
unit: FIT1043
domain: E
week: 5
parent: "[[Data Science Process (Standard Value Chain)]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Model, Predictive Model, Classifier, Feature Space]
---
# [[Predictive Models]]

**Context:** [[FIT1043_MOC]] · the **Analysis** stage of the [[Data Science Process (Standard Value Chain)|value chain]] · learnt by [[Machine Learning]] · evaluated on held-out test data

> [!abstract] Quick Revision
> - **🎯 Objective:** map input **features** → an output prediction ➔ classifier (categorical) or regression (real-valued).
> - **📦 Core Components:** model (understand + predict) | prediction type (binary/categorical/real/vector) | train vs test.
> - **⚡ Key Constraint:** a model is only as good as its performance on **unseen test** data — never the training data it memorised.

## 📝 How It Works
### 1. What is a Model?
- **Two purposes** ➔ (1) help us **understand** how something works, (2) help us **predict** the unknown.
- **Predictive model** ➔ any model that makes a prediction, usually from a set of **features** describing an object.
- **Mechanism** ➔ uses equations/rules to map input features → output values.

### 2. Prediction Types
- **Binary** ➔ spam / not-spam.
- **Categorical** ➔ bass / tuna / other.
- **Real value** ➔ the age (or weight) of the fish.
- **Vector of reals** ➔ probabilities (e.g. P(bass), P(tuna)).
- **Classifier vs regression** ➔ binary/categorical output ⇒ **classifier**; real-valued output ⇒ **regression** (others: ranking, translation).

### 3. Training & Testing
- **Learnt from examples** ➔ built from **training data**, then applied to new instances.
- **Feature space** ➔ each training instance is a point; class shown by colour; many classifiers **partition the space** into same-class regions.
- **Reality** ➔ classes **overlap** and there are **many feature dimensions** (some more useful than others).
- **Testing** ➔ evaluate on **test instances not used in training** — that measures real predictive ability.

## ⚖️ Core Decision Matrix
| Output | Model type | Example |
| :--- | :--- | :--- |
| **binary / categorical** | classifier | spam?; fish species |
| **real value** | regression | fish age; car price |
| **vector of reals** | (prob.) classifier | P(bass), P(tuna) |

> [!NOTE] **When It Flips:** more **training data** improves test performance, and (with enough data) more **features** helps too — but only up to a limit; beyond it, extra features stop paying off.

## 🧠 Active Recall
> [!FAQ]- What separates a classifier from a regression model, and why evaluate on test (not training) data?
> - **Hint:** Output type + generalisation.
> > [!SUCCESS]- Answer
> > - **Short answer:** A classifier predicts a category (binary/categorical); regression predicts a real value. We test on unseen instances because performance on training data doesn't show whether the model **generalises**.
> > - **Why:** **Held-out test** ➔ a model can memorise training points; only new data reveals true predictive quality.

> [!FAQ]- How do a classifier's decisions relate to the feature space?
> - **Hint:** Region partitioning.
> > [!SUCCESS]- Answer
> > - **Short answer:** Each instance is a point in feature space; classification algorithms divide that space into regions of the same class, so a new point is labelled by the region it lands in.
> > - **Why:** **Overlap + dimensionality** ➔ real classes overlap and span many features, making clean separation hard.
