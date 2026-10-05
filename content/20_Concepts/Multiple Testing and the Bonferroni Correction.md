---
unit: FIT2086
week: [8, 9]
source: [lecture, applied]
domain: [D, E]
parent: "[[Hypothesis Testing]]"
tags: [Math/Probability, DataScience/Modelling]
aliases: [Multiple Testing, Multiple Hypothesis Testing, Multiple-Testing Problem, Bonferroni, Bonferroni Procedure, FWER, Family-Wise Error Rate, FDR, False Discovery Rate, Benjamini-Hochberg, Marginal Screening, Data Dredging]
---
# [[Multiple Testing and the Bonferroni Correction]]

**Context:** [[FIT2086_MOC]] · what breaks when [[Hypothesis Testing]] is used to **select predictors** for a [[Linear Regression (FIT2086)|regression]] · the same false-positive logic motivates RIC in [[Model Selection and Information Criteria (AIC, BIC)]] · drilled on the gene data in Studio 8 ([[Penalized Regression in R (glmnet)]])

> [!abstract] Quick Revision
> - **🎯 Objective:** $p$ tests at level $\alpha$ with every null true ⟹ $\alpha p$ false positives expected ➔ Bonferroni rejects only when $p\text{-value}<\alpha/p$ ⟹ $\mathbb{P}(\text{at least one false rejection})\le\alpha$.
> - **⚠️ Key Constraint:** divide by the **number of tests** $p$ (every transformation and interaction tried counts), and remember Bonferroni controls the **FWER**, not the FDR.

## 📝 Core
- **Coefficient test** ➔ $H_0:\beta_j=0$ vs $H_A:\beta_j\neq0$; inside a **multiple** regression it asks whether predictor $j$ contributes **after accounting for the other predictors** in that model.
- **Marginal screening** ➔ fit $p$ separate one-predictor regressions, keep $x_j$ if its $p$-value is small ➔ simple, but **marginal association ≠ conditional importance** in the multiple regression.
- **The multiple-testing problem** ➔ one test falsely rejects a true null with probability $\alpha$; $p$ tests with all nulls true ⟹ expected $p$-values below $\alpha$ $=\alpha p$ ➔ $\alpha=0.05$, $p=1000$ ⟹ $\approx50$ false positives on average.
- **Data dredging** ➔ the same problem arising when many transformations or interactions are tried.
- **Bonferroni procedure** ➔ reject $H_{0,j}$ only when $p_j<\dfrac{\alpha}{p}$ ⟹ $\mathbb{P}(\text{at least one false rejection})\le\alpha$, **without requiring the tests to be independent** ➔ $\alpha=0.05$, $p=1000$ ⟹ threshold $5\times10^{-5}$.
- **FWER** ➔ family-wise error rate $=\mathbb{P}(\ge1$ false positive across the family of tests$)$ ➔ Bonferroni controls it: strong protection, but **very conservative** when many hypotheses are tested.
- **FDR** ➔ false discovery rate $=$ expected **proportion** of discoveries that are false ➔ procedures such as **Benjamini–Hochberg** control it and usually have **more power** to identify genuinely associated predictors.
- **Joint-fit weakness (Studio 8)** ➔ predictors carrying **overlapping** information share credit in one big fit ⟹ each $p$-value is inflated relative to fitting it alone ⟹ Bonferroni on a joint fit can reject **everything**.
- **RIC = Bonferroni as a criterion** ➔ stepwise with $L+k\log p$, i.e. R's `step(…, k = 2*log(p))`, is the information-criterion version of the Bonferroni idea, built for large $p$.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace
Studio 8, gene data: $n=200$, $p=100$ SNP predictors, full `glm` logistic fit (rerun on the studio files):

| Step | Rule | Threshold | Predictors passing | Reading |
| :--- | :--- | :--- | :--- | :--- |
| 1 | naive $\alpha=0.05$ | $0.05$ | $12$ (smallest: SNP56 $0.0056$, SNP11 $0.0114$, SNP96 $0.0116$, SNP12 $0.0129$) | vs $\alpha p=5$ expected by chance alone |
| 2 | Bonferroni | $0.05/100=0.0005$ | $0$ | too strict once credit is shared in the joint fit |
| 3 | RIC stepwise, `k = 2*log(100)` $=9.21$ | — | SNP56 only | refitted alone: $\hat\beta=1.253$, $p=0.0018$ |
| 4 | Bonferroni on the RIC model | $0.0005$ | still $0$ | $0.0018>0.0005$ ⟹ fails, even though RIC kept it |

- **Test-set payoff** ($10{,}000$ rows) ➔ full 100-SNP model: CA $0.535$, AUC $0.552$, log-loss $18112$ · RIC's SNP56-only model: CA $0.623$, AUC $0.623$, log-loss $6463$ — better than the full fit and than BIC's two-SNP model ($6678$).
- **Reading** ➔ 12 "significant" SNPs when ~5 are expected by noise ⟹ most are likely false discoveries; Bonferroni and RIC agree the signal is thin — at most one SNP, and one SNP predicts best.

## ⚠️ Common Mistakes
- 💡 **Keeping $\alpha$ fixed across many predictors** ➔ noise alone produces $\alpha p$ "significant" predictors.
- 💡 **Dividing by $n$ instead of $p$** ➔ the Bonferroni divisor is the count of **tests**, not the sample size.
- 💡 **Calling Bonferroni an FDR method** ➔ it bounds the probability of **any** false rejection; FDR bounds the **proportion** of false discoveries.
- 💡 **Counting the intercept** ➔ `coefficients(summary(fit))[,4]` includes the `(Intercept)` row; use `[-1]` when counting predictors.

## 🧠 Active Recall
> [!FAQ]- $p=100$ predictors, none associated with the target, each tested at $\alpha=0.05$. How many false discoveries are expected, and what threshold does Bonferroni use?
> > [!SUCCESS]- Answer
> > - **Short answer:** $0.05\times100=5$ predictors declared significant by chance; Bonferroni uses $0.05/100=0.0005$.
> > - **Why:** **Per-test error adds up** ➔ each true null rejects with probability $\alpha$, so $p$ tests give $\alpha p$ on average; the stricter per-test threshold $\alpha/p$ holds the FWER at $\alpha$.

> [!FAQ]- With $p$ in the thousands, why might an FDR procedure be preferred to Bonferroni?
> > [!SUCCESS]- Answer
> > - **Short answer:** $\alpha/p$ becomes so strict that genuine predictors are missed; FDR control accepts a small **proportion** of false discoveries in exchange for more power.
> > - **Why:** **FWER vs FDR** ➔ FWER penalises even one false positive in the whole family; Benjamini–Hochberg targets the false fraction of what is discovered.

> [!FAQ]- Why did the gene data's joint fit pass zero SNPs under Bonferroni, and what does RIC do instead?
> > [!SUCCESS]- Answer
> > - **Short answer:** With 100 correlated-in-effect predictors fitted together, individual $p$-values are inflated, so none reach $0.0005$; RIC searches models with a $\log p$ penalty per term and keeps SNP56 alone.
> > - **Why:** **Shared credit** ➔ overlapping information splits each effect across predictors; RIC applies the Bonferroni-style $\log p$ price to **adding a term**, not to one joint table of $p$-values.
