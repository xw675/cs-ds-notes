---
unit: FIT2086
week: [8, 9]
source: [lecture]
domain: E
parent: "[[Model Selection and Information Criteria (AIC, BIC)]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [CV, K-fold CV, K-Fold Cross-Validation, Repeated K-fold CV, Leave-One-Out, LOO CV, LOOCV, MSPE, Mean Squared Prediction Error, Cross Validation, Complexity Parameter]
---
# [[Cross-Validation]]

**Context:** [[FIT2086_MOC]] · the resampling alternative to [[Model Selection and Information Criteria (AIC, BIC)|information criteria]] · generalises the single train/test split of [[Plug-in Prediction and Held-Out Evaluation]] · picks $\lambda$ in [[Penalized Regression (Ridge and Lasso)]], $L$ in [[Decision Tree Learning (Likelihood Splits, Pruning, CV)|trees]], $k$ in [[k-Nearest Neighbours]]

> [!abstract] Quick Revision
> - **🎯 Objective:** estimate a model's **prediction error on future data** from the fitting data alone ➔ fit on part, score on the held-out rest, repeat, average ➔ choose the complexity $\gamma$ with the **smallest CV error**.
> - **⚠️ Key Constraint:** every score must come from data the fit **never saw**; the cost is one fit per fold, so CV is slow when fitting is expensive.

## 📝 Core
- **Target quantity** ➔ ideally pick the model minimising error on future data $y'_1,\dots,y'_m$: $\text{MSPE}(\hat{\mathcal{M}}(\mathbf{y}))=\dfrac1m\sum_{i=1}^{m}\big(y'_i-\hat y_i(\hat{\mathcal{M}}(\mathbf{y}))\big)^2$ ➔ needs the test data **in advance**, which we never have.
- **Key idea** ➔ the fitting data $\mathbf{y}$ came from the **same process** as future data ⟹ **estimate** the MSPE from $\mathbf{y}$ itself.
- **Procedure** ➔ (1) randomly partition $\mathbf{y}$ into $\mathbf{y}_{\text{train}}$ and $\mathbf{y}_{\text{test}}$; (2) fit $\mathcal{M}$ to $\mathbf{y}_{\text{train}}$; (3) compute its MSPE on $\mathbf{y}_{\text{test}}$; (4) repeat and **average** ➔ run for every candidate model, keep the smallest.
- **Complexity parameter $\gamma$ (W9)** ➔ write the candidates as $\hat{\mathcal{M}}(\gamma)$ ➔ $\gamma$ = number of predictors (linear/logistic) · $\lambda$ (ridge/lasso) · number of leaves $L$ (trees) · $k$, distance and kernel (kNN) ➔ one CV recipe sizes them all.
- **$K$-fold CV** ➔ split into $K$ equal-sized, **disjoint** random folds $\mathbf{y}^{(1)},\dots,\mathbf{y}^{(K)}$; for $k=1,\dots,K$ fit $\mathcal{M}(\gamma)$ to every fold except $k$, predict $\mathbf{y}^{(k)}$, accumulate errors ➔ $\text{CV}(\gamma)=\dfrac1K\sum_{k=1}^{K}\text{Error}_k(\gamma)$ ➔ $\gamma^*=\arg\min_\gamma\text{CV}(\gamma)$.
- **Repeated $K$-fold CV** ➔ outer loop $i=1..m$ reruns the whole $K$-fold procedure with new random partitions ➔ average $m\times K$ scores; **larger $m$ ⟹ more stable** estimate (but slower).
- **Leave-one-out (LOO) CV** ➔ train on $n-1$ samples, test on the remaining one, for all $n$ held-out samples ⟹ $n$ fits ➔ the lecture's tuner for kNN, where "fitting" is free.
- **Any score works** ➔ squared error, accuracy, or log-loss ([[Logarithmic Loss]]) can be the per-fold score.
- **LOO ↔ AIC** ➔ asymptotically related, but they can **differ substantially for small samples**.
- **Worked selection** ➔ Model 1 fold errors $0.47,0.45,0.45,0.45$ (mean $\approx0.45$) vs Model 2 $0.32,0.33,0.32,0.31$ (mean $0.32$) ⟹ choose **Model 2**.
- **Refit at the end** ➔ CV only chooses $\gamma^*$; the final model is refitted with $\gamma^*$ on **all** the data (final tree with $L^*$ leaves, final lasso at $\lambda^*$).

## ⚖️ Core Decision Matrix
| Variant | Fits required | Stability of the estimate | Reach for it when |
| :--- | :--- | :--- | :--- |
| **$K$-fold** | $K$ | depends on the one random partition | default — good balance of bias and variance |
| **Repeated $K$-fold** | $m\times K$ | improves as $m$ grows | the $K$-fold estimate moves between reruns |
| **LOO** | $n$ | can be unstable | $n$ is small, or each fit is cheap (kNN has no fit at all) |

> [!NOTE] **When It Flips:** LOO's cost grows with $n$ while $K$-fold's is fixed at $K$ ➔ as fitting gets expensive or $n$ grows, $K$-fold wins.

## ⚠️ Common Mistakes
- 💡 **Scoring on the training folds** ➔ in-sample error always favours the most complex model — the exact failure CV exists to avoid.
- 💡 **Choosing on a single random split** ➔ one partition is noisy; average over folds (and repeats).
- 💡 **Comparing models on different partitions** ➔ use the same partitioning rule across the fits being compared so differences reflect the models, not the splits (`foldid` in [[Penalized Regression in R (glmnet)|glmnet]]).

## 🧠 Active Recall
> [!FAQ]- Why can CV estimate prediction error on future data without ever seeing future data?
> > [!SUCCESS]- Answer
> > - **Short answer:** The held-out fold plays the role of future data — it comes from the same process and was not used in the fit.
> > - **Why:** **Same generating process** ➔ held-out MSPE estimates the future-data $\text{MSPE}$; averaging over folds (and repeats) makes that estimate more stable.

> [!FAQ]- When would you prefer LOO over 5-fold CV, and what does it cost?
> > [!SUCCESS]- Answer
> > - **Short answer:** When $n$ is small, so leaving out a fifth of the data wastes too much; the cost is $n$ fits and an estimate that can be unstable.
> > - **Why:** **Fits scale with $n$** ➔ LOO needs $n$ fits versus $K$ for $K$-fold.

> [!FAQ]- Name the complexity parameter $\gamma$ that CV tunes for subset regression, ridge/lasso, a tree, and kNN.
> > [!SUCCESS]- Answer
> > - **Short answer:** number of predictors · $\lambda$ · number of leaves $L$ · $k$ (plus distance and kernel).
> > - **Why:** **One recipe** ➔ each is a dial from simple to complex; $\gamma^*=\arg\min_\gamma\text{CV}(\gamma)$, then refit on all the data.
