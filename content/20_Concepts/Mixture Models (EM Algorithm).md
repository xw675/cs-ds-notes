---
unit: FIT2086
week: 11
source: [lecture]
domain: [E, D]
parent: "[[Machine Learning Styles (Supervised vs Unsupervised)]]"
tags: [DataScience/Modelling, DataScience/ML, Math/Probability]
aliases: [mixture model, mixture modelling, finite mixture model, Gaussian mixture model, GMM, EM algorithm, expectation-maximisation, soft clustering, soft assignment, responsibilities, posterior class membership, mixing weights, intrinsic classification, minimum message length, MML]
---
# [[Mixture Models (EM Algorithm)]]

**Context:** [[FIT2086_MOC]] · W11 · the probabilistic fix for [[k-means Clustering]]'s weaknesses · each class carries its own [[Parametric Probability Distributions|distribution]], often a [[Multivariate Normal Distribution]] · soft membership is [[Bayes' Theorem]] · $K$ chosen by [[Model Selection and Information Criteria (AIC, BIC)|information criterion]] · fitted by weighted [[Maximum Likelihood Estimation|ML]] · the Pima fit is the joint-modelling classifier from [[Classification and Conditional Class Probabilities]]
**Parent Framework:** [[Machine Learning Styles (Supervised vs Unsupervised)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** model the data as $K$ weighted sub-populations $p(\mathbf{y}_i)=\sum_{k}\alpha_kp(\mathbf{y}_i\mid\boldsymbol\theta_k)$ ➔ **soft**-assign each item by its posterior $r_{i,k}$ ➔ fit by **EM** for fixed $K$, choose $K$ by information criterion.
> - **📦 Core Components:** mixing weights $\boldsymbol\alpha$ ➔ class prevalence | class models $\boldsymbol\theta_{k,j}$ ➔ any family per attribute | EM ➔ E-step soft assign, M-step weighted ML | IC / MML ➔ picks $K$.
> - **⚡ Key Constraint:** the posterior is **weight × likelihood, normalised** — ranking classes by $p_k(\mathbf{y}_i)$ alone ignores prevalence, and the unnormalised products give the class but not its probability.

## 📝 How It Works
### 1. The Model
- **Mixture density** ➔ $p(\mathbf{y}_i)=\sum_{k=1}^{K}\alpha_k\,p(\mathbf{y}_i\mid\boldsymbol\theta_k)$ · $K$ classes · $\boldsymbol\alpha=(\alpha_1,\dots,\alpha_K)$ mixing (population) weights · $\boldsymbol\theta_k$ parameters of class $k$'s joint distribution.
- **Class = cluster** ➔ $\alpha_k$ is the fraction of the population in sub-population $k$; each class has its own distribution per attribute (normal, inverse Gaussian, Poisson, …).
- **Simple form (conditional independence within class)** ➔ $p_k(\mathbf{y}_i)=\prod_{j=1}^{q}p(y_{i,j}\mid\boldsymbol\theta_{k,j})$ ⟹ $K\times q$ univariate models.
- **Mixed attribute types** ➔ each column takes its own family (Pima: predictors Gaussian, diabetes status Bernoulli) — the case k-means handles badly.
- **Related attributes** ➔ swap the product for a [[Multivariate Normal Distribution]] per class (height and weight correlate within a person).

### 2. Soft Membership
- **Posterior by Bayes** ➔ $r_{i,k}=\dfrac{\alpha_k\,p_k(\mathbf{y}_i)}{\sum_{l=1}^{K}\alpha_l\,p_l(\mathbf{y}_i)}$ · $\alpha_k$ = *a priori* probability of class $k$ · $p_k(\mathbf{y}_i)$ = probability of $\mathbf{y}_i$ under class $k$.
- **Partial assignment** ➔ each item belongs to every class with probability $r_{i,k}$, $\sum_kr_{i,k}=1$; a hard label, if wanted, is the highest posterior.
- **$-\log p_k(\mathbf{y}_i)$ as dissimilarity** ➔ equal **spherical** Gaussians ⟹ comparing $p_k$ ≡ comparing Euclidean distance to centroids (k-means) · general Gaussian ⟹ **Mahalanobis**-type distance · Bernoulli, Poisson, … ⟹ their own model-appropriate measures.

### 3. Estimation by EM (fixed $K$)
1. **Initialise** ➔ random class memberships or random starting parameters.
2. **E-step** ➔ soft-assign every individual: $r_{i,k}$ from the current parameters.
3. **M-step** ➔ re-estimate every $\boldsymbol\theta_{k,j}$ ($k=1..K$, $j=1..q$) by **weighted ML**, item $i$ counting with weight $r_{i,k}$ toward class $k$.
4. **Repeat** until the estimates stabilise.
- **Generalises k-means** ➔ k-means is EM with 0/1 weights and spherical equal-variance Gaussians.

### 4. Choosing $K$
- **Score** ➔ information criterion $=$ goodness of fit $+$ complexity penalty on classes/parameters ➔ smallest wins ➔ [[Model Selection and Information Criteria (AIC, BIC)]].
- **MML** ➔ minimum message length (C.S. Wallace, Monash): compress the data using the model; the model giving the **shortest compressed data** wins.
- **Search** ➔ non-convex, many local minima ⟹ each iteration: remove classes with too few points · try splitting every class · try combining pairs · randomly reassign and re-estimate ➔ refit with EM, score, keep the lowest, repeat.

### 5. Lecture Examples
- **1-D, two normals** ➔ $\alpha_1=0.6,\ N(\mu=4.3,\sigma=0.4)$ and $\alpha_2=0.4,\ N(\mu=6.2,\sigma=0.5)$ — a bimodal density no single normal fits.
- **2-D** ➔ $K=4$ discovered with $\alpha=0.5,0.4,0.08,0.02$ — tiny classes survive if they buy enough fit.
- **Galaxy velocities** ($n=82$) ➔ $K=4$: $8.9\%\ N(9.71,0.2)$, $23\%\ N(19.74,0.3)$, $62\%\ N(22,5.25)$, $4\%\ N(33.04,1.27)$.
- **Pima diabetes** ($768$ people, $268$ diabetic; 12% of exposure cells missing, INS $48.7\%$, SKIN $29.5\%$) ➔ criterion $I_4=18{,}719.1$, $I_5=\mathbf{18{,}713.0}$, $I_6=18{,}714.7$, $I_7=18{,}732.7$ ⟹ $K=5$.

| Class | $\hat\alpha_k$ | PREG | PLAS | BMI | AGE | DIA $=\mathbb{P}(\text{diabetic}\mid k)$ |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| $1$ | $0.13$ | $2.5$ | $150$ | $37$ | $33$ | $0.82$ |
| $2$ | $0.23$ | $7.6$ | $141$ | $35$ | $43$ | $0.78$ |
| $3$ | $0.25$ | $2.0$ | $104$ | $27$ | $24$ | $0.02$ |
| $4$ | $0.19$ | $2.7$ | $112$ | $36$ | $26$ | $0.20$ |
| $5$ | $0.18$ | $6.4$ | $110$ | $30$ | $42$ | $0.06$ |

- **Reading** ➔ high glucose drives both diabetic classes; class 2 is older with more pregnancies, class 1 younger and heavier · class 3 (young, low glucose, low BMI) is the low-risk profile.
- **Slide inconsistency** ➔ the summary infographic (slide 49b) prints class 1 as $0.52$ and calls class 2 the highest; the means table gives $0.82$ — table used here, confirm on the forum.

## 🔬 Model
- **Data** ➔ $\mathbf{Y}\in\mathbb{R}^{n\times q}$, row $\mathbf{y}_i$ = item, column = attribute; no column is nominated as target (DIA in Pima is just another attribute).
- **Parameters** ➔ $\alpha_k\ge0$, $\sum_{k}\alpha_k=1$; $\{\boldsymbol\theta_{k,j}\}$ ➔ $K-1$ free weights $+$ the per-class model parameters.
- **Objective (fixed $K$)** ➔ maximise the likelihood ⟺ minimise $L=-\sum_{i=1}^{n}\log\sum_{k=1}^{K}\alpha_k\,p_k(\mathbf{y}_i)$ — log of a **sum**, so no closed form ⟹ EM.
- **Objective over $K$** ➔ $\hat K=\arg\min_K\big[L(\hat{\mathcal{M}}_K)+\text{penalty}(K)\big]$.

## ⚖️ Core Decision Matrix
| Method | Assignment | Similarity | Attribute types | Choosing $K$ | Statistical reading |
| :--- | :--- | :--- | :--- | :--- | :--- |
| [[k-means Clustering]] | **hard**, one cluster | squared Euclidean to centroid | continuous; mixed types awkward | outside the method (prior knowledge / trial) | none |
| **Mixture model** | **soft**, $r_{i,k}$ | $-\log p_k(\mathbf{y}_i)$, model-based | any family per column | inside: IC / MML score | explicit: prevalence $\alpha_k$, class distributions |

> [!NOTE] **When It Flips:** equal spherical Gaussians with hard 0/1 weights ⟹ the mixture **is** k-means; elongated or correlated clusters, mixed attribute types, overlapping classes, or a need for "how sure?" ⟹ mixture model.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace
Lecture Q2: $\alpha_1=0.3$, $\alpha_2=0.7$, $p_1(\mathbf{y}_i)=0.20$, $p_2(\mathbf{y}_i)=0.05$.

| Step | Class 1 | Class 2 | Note |
| :--- | :--- | :--- | :--- |
| prior $\alpha_k$ | $0.30$ | $0.70$ | class 2 more common |
| likelihood $p_k(\mathbf{y}_i)$ | $0.20$ | $0.05$ | data favour class 1 |
| product $\alpha_kp_k$ | $0.060$ | $0.035$ | sum $=0.095$ |
| posterior $r_{i,k}$ | $0.060/0.095\approx\mathbf{0.632}$ | $\approx0.368$ | assign to class 1 — still $0.368$ for class 2 |

### Applied Exercise
**Problem:** the 1-D lecture mixture ($0.6\,N(4.3,0.4^2)$, $0.4\,N(6.2,0.5^2)$). Posterior class probabilities for $y=5$.
$$
\begin{aligned}
p_1(5) &= \tfrac{1}{0.4\sqrt{2\pi}}e^{-(5-4.3)^2/(2\cdot0.16)} = 0.9974\,e^{-1.531} = 0.2157 \\
p_2(5) &= \tfrac{1}{0.5\sqrt{2\pi}}e^{-(5-6.2)^2/(2\cdot0.25)} = 0.7979\,e^{-2.88} = 0.0448 \\
\alpha_1p_1 &= 0.1294,\qquad \alpha_2p_2 = 0.0179 \\
r_{1} &= \tfrac{0.1294}{0.1294+0.0179} = 0.878,\qquad r_{2}=0.122
\end{aligned}
$$
**Final Extracted Output:** $y=5$ belongs to class 1 with probability $0.878$ — $1.75\sigma_1$ from $\mu_1$ but $2.4\sigma_2$ from $\mu_2$, and class 1 is also more prevalent.

## ⚠️ Common Mistakes
- 💡 **Dropping $\alpha_k$** ➔ $p_1/(p_1+p_2)=0.8$ in the trace above, not $0.632$ — prevalence is half the answer.
- 💡 **Reporting only the label** ➔ the point of a mixture is the probability; "class 1 ($0.632$)" earns what "class 1" does not.
- 💡 **Choosing $K$ by likelihood** ➔ more classes always fit better; only the penalised score can stop at $K=5$.

## 🧠 Active Recall
> [!FAQ]- Name three weaknesses of k-means and say how a mixture model removes each.
> > [!SUCCESS]- Answer
> > - **Short answer:** hard assignment ➔ soft $r_{i,k}$; mixed continuous/discrete attributes ➔ a separate family per column; no statistical interpretation or way to pick $K$ from the data ➔ an explicit likelihood scored by an information criterion.
> > - **Why:** **Explicit probability model** ➔ $p(\mathbf{y}_i)=\sum_k\alpha_kp(\mathbf{y}_i\mid\boldsymbol\theta_k)$ gives both the posterior (Bayes) and a fit term to penalise.

> [!FAQ]- In what sense is EM a generalisation of k-means?
> > [!SUCCESS]- Answer
> > - **Short answer:** both alternate "assign" and "re-estimate"; k-means assigns hard to the nearest centroid and re-estimates means, EM assigns softly by posterior and re-estimates every parameter by weighted ML.
> > - **Why:** **Spherical equal-variance Gaussians** ➔ $-\log p_k(\mathbf{y}_i)$ reduces to squared Euclidean distance (plus a constant), and forcing $r_{i,k}\in\{0,1\}$ recovers k-means exactly.

> [!FAQ]- The Pima criterion scores are $I_5=18{,}713.0$ and $I_6=18{,}714.7$. Is $K=5$ clearly better than $K=6$?
> > [!SUCCESS]- Answer
> > - **Short answer:** no — a gap of $1.7$ is below the $\approx3$ rule of thumb, so the two are comparable; $K=5$ is kept as the minimum and the simpler model, while $K=4$ ($+6.1$) and $K=7$ ($+19.7$) are clearly worse.
> > - **Why:** **Score differences, not ranks** ➔ see [[Model Selection and Information Criteria (AIC, BIC)]].

> [!TIP]- 🔭 Beyond the lecture *(not in the slides)*
> - **Gaussian M-step in closed form** ➔ $\hat\alpha_k=\tfrac1n\sum_ir_{i,k}$ · $\hat{\boldsymbol\mu}_k=\dfrac{\sum_ir_{i,k}\mathbf{y}_i}{\sum_ir_{i,k}}$ · $\hat{\boldsymbol\Sigma}_k=\dfrac{\sum_ir_{i,k}(\mathbf{y}_i-\hat{\boldsymbol\mu}_k)(\mathbf{y}_i-\hat{\boldsymbol\mu}_k)'}{\sum_ir_{i,k}}$ — the ordinary MLEs with each item counted $r_{i,k}$ times.
> - **Monotone** ➔ each EM iteration never increases $L$, so it converges — but only to a local minimum, hence the restarts.
