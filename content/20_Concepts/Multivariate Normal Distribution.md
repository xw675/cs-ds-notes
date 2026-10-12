---
unit: FIT2086
week: 11
source: [lecture]
domain: D
parent: "[[Gaussian Distribution]]"
tags: [Math/Probability, DataScience/Modelling]
aliases: [multivariate Gaussian, multivariate normal, MVN, covariance matrix, bivariate normal, spherical covariance, diagonal covariance, elliptical covariance]
---
# [[Multivariate Normal Distribution]]

**Context:** [[FIT2086_MOC]] · W11 · the [[Gaussian Distribution]] in $q$ dimensions with **correlation** between attributes · $\Sigma$ entries are the [[Expectations and Covariance (FIT2086)|covariances]] · the class model inside [[Mixture Models (EM Algorithm)]] · the correlation engine of multivariate-normal [[Missing Data Imputation and Recommender Systems|imputation]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $\mathbf{Y}=(Y_1,\dots,Y_q)\sim N(\boldsymbol\mu,\boldsymbol\Sigma)$ ➔ $\mu_j$ is the mean of $Y_j$, $\Sigma_{i,j}=\operatorname{cov}(Y_i,Y_j)$ ➔ read a scatter's **centre, spread per axis, and tilt** straight off $\boldsymbol\mu$ and $\boldsymbol\Sigma$.
> - **⚡ Key Constraint:** diagonal entries are **variances**, not standard deviations ($\Sigma_{1,1}=2\Rightarrow\operatorname{sd}=\sqrt2$); off-diagonals are covariances and $\boldsymbol\Sigma$ is symmetric.

## 📝 Core
- **Density** ➔ $p(\mathbf{y}\mid\boldsymbol\mu,\boldsymbol\Sigma)=\left(\dfrac{1}{2\pi}\right)^{q/2}\sqrt{\lvert\boldsymbol\Sigma^{-1}\rvert}\,\exp\!\left(-\tfrac12(\mathbf{y}-\boldsymbol\mu)'\boldsymbol\Sigma^{-1}(\mathbf{y}-\boldsymbol\mu)\right)$.
- **Reduces to the univariate normal** ➔ $q=1$, $\boldsymbol\Sigma=\sigma^2$: $\sqrt{1/\sigma^2}=1/\sigma$ ⟹ $\frac{1}{\sqrt{2\pi}\,\sigma}e^{-(y-\mu)^2/(2\sigma^2)}$.
- **Why it matters** ➔ an individual's attributes are related (height ↔ weight); separate univariate models per attribute cannot express that, $\boldsymbol\Sigma$ can.
- **Covariance structures** ➔ diagonal, all variances equal (**spherical**, $1$ variance parameter) · diagonal, variances differ ($q$) · arbitrary (**elliptical**, $q(q+1)/2$) ➔ each more flexible but with more parameters to estimate.
- **Quadratic form = distance** ➔ $(\mathbf{y}-\boldsymbol\mu)'\boldsymbol\Sigma^{-1}(\mathbf{y}-\boldsymbol\mu)$ is the Mahalanobis-type distance a Gaussian mixture uses in place of Euclidean.

## 📊 Reading $\boldsymbol\Sigma$ from a scatter
![[mvn-covariance-shapes.png]]

| $\boldsymbol\mu$ | $\boldsymbol\Sigma$ | Cloud shape |
| :--- | :--- | :--- |
| $(0,0)$ | $\begin{pmatrix}1&0\\0&1\end{pmatrix}$ | circle at the origin |
| $(2,0)$ | $\begin{pmatrix}1&0\\0&1\end{pmatrix}$ | same circle shifted right — $\boldsymbol\mu$ moves, shape fixed |
| $(0,0)$ | $\begin{pmatrix}2&0\\0&1\end{pmatrix}$ | stretched along $y_1$ |
| $(0,0)$ | $\begin{pmatrix}1&0\\0&1.5\end{pmatrix}$ | stretched along $y_2$ |
| $(0,0)$ | $\begin{pmatrix}1&0.6\\0.6&1\end{pmatrix}$ | ellipse tilted up-right (positive covariance) |
| $(0,0)$ | $\begin{pmatrix}1&-0.9\\-0.9&1\end{pmatrix}$ | thin ellipse tilted down-right (strong negative) |

## ⚠️ Common Mistakes
- 💡 **Reading $\Sigma_{j,j}$ as an sd** ➔ it is $\operatorname{Var}(Y_j)$; R's `rnorm` wants the sd, $\boldsymbol\Sigma$ holds variances.
- 💡 **Zero off-diagonals read as "no structure"** ➔ only the tilt disappears; unequal diagonals still stretch the cloud along an axis.

## 🧠 Active Recall
> [!FAQ]- When does a mixture of multivariate normals beat one with independent univariate normals per attribute, and what does it cost?
> > [!SUCCESS]- Answer
> > - **Short answer:** when attributes are correlated within a class (tilted clusters); an arbitrary $\boldsymbol\Sigma$ captures the tilt but costs $q(q+1)/2$ covariance parameters per class instead of $q$.
> > - **Why:** **Flexibility vs complexity** ➔ the extra parameters must pay for themselves in fit under the [[Model Selection and Information Criteria (AIC, BIC)|information criterion]].
