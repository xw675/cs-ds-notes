---
unit: FIT3003
week: 10
source: [slides, lab]
domain: [C, E]
parent: "[[Linear and Polynomial Regression]]"
tags: [CS/Databases, DataScience/DataWarehousing, Tool/SQL]
aliases: [Regression in SQL, Slope and Intercept in SQL, SQL Linear Regression, Lab 10]
type: pattern
---
# [[Linear Regression in SQL]]

**Context:** [[FIT3003_MOC]] · fit the least-squares line **inside Oracle** over two numeric columns · formula and interpretation in [[Linear and Polynomial Regression]] · technique map in [[Data Analytics for Data Warehousing]] · Lab 10 script ➔ `30_Projects/FIT3003_Labs/Lab10_regression_in_SQL.sql`
**Problem it solves:** slope, intercept and a predicted value $\hat y$ for every $x$, with no tool outside SQL.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "trend line", "best fit", "predict the measure from time" ➔ three nested layers: means ➔ slope ➔ intercept; then cross-join the one-row result back onto the data for $\hat y$.
> - **⚠️ Key Constraint:** $\bar x, \bar y$ must reach **every row** ➔ a one-row inline view **cross-joined** to `dataset` (lecture) or `avg(x) over ()` (lab); then carry them up as `max(x_bar)` — any aggregate of a constant returns the constant.

## 🔧 Minimal Working Example
$\text{DATASET}(\underline{x}, y)$ — Table 1.5, $x =$ Time, $y =$ Value: $(1,11), (2,27), (3,34), (4,38), (5,45), (6,61), (7,63)$.
```sql
select slope, y_bar_max - (slope * x_bar_max) as intercept     -- 3. b0 = ȳ − b1·x̄
from (
  select sum((x - x_bar) * (y - y_bar)) /
         sum((x - x_bar) * (x - x_bar)) as slope,                 -- 2. b1
         max(x_bar) as x_bar_max,
         max(y_bar) as y_bar_max
  from (select avg(x) as x_bar, avg(y) as y_bar
        from dataset) av, dataset                                 -- 1. one-row means × every row
);
```
**Expected output:** one row — `slope` $= 8.392857$, `intercept` $= 6.285714$.

$$
\begin{aligned}
\bar x &= 4, \qquad \bar y = 279/7 = 39.857 \\
\textstyle\sum(x_i-\bar x)(y_i-\bar y) &= (-3)(11)+(-2)(27)+(-1)(34)+0+(1)(45)+(2)(61)+(3)(63) = 235 \\
\textstyle\sum(x_i-\bar x)^2 &= 9+4+1+0+1+4+9 = 28 \\
b_1 &= 235/28 = 8.3929, \qquad b_0 = 39.857 - 8.3929 \times 4 = 6.2857
\end{aligned}
$$
- **Hand shortcut** *(arithmetic aid)* ➔ $\sum(x_i-\bar x)(y_i-\bar y) = \sum(x_i-\bar x)\,y_i$ since $\sum(x_i-\bar x) = 0$ — the line above uses it.

## 🔀 Variations
### Prediction table — CTAS with $\hat y$
```sql
create table linear_regression as
select x, y, (intercept + (slope * x)) as y_pred
from dataset,
     (select slope, y_bar_max - (slope * x_bar_max) as intercept
      from (select sum((x - x_bar) * (y - y_bar)) /
                   sum((x - x_bar) * (x - x_bar)) as slope,
                   max(x_bar) as x_bar_max,
                   max(y_bar) as y_bar_max
            from (select avg(x) as x_bar, avg(y) as y_bar
                  from dataset) av, dataset))
order by x;
```
**Expected output:** 7 rows, `y_pred` $= 14.68, 23.07, 31.46, 39.86, 48.25, 56.64, 65.04$ — the slide's "regression as discrete values"; residual at $x = 1$ is $11 - 14.68 = -3.68$.
- **Same query, new shell** ➔ the slope/intercept query drops into the `from` as a one-row view, cross-joined to `dataset` so each row sees the single $(b_1, b_0)$ pair.

### Means by window — `avg(x) over ()` (Lab 10)
$\text{GLUCOSEALBUMIN}(\text{Glucose}, \text{Albumin})$ — the 17 patients of Table 1.6, both `number(18,6)`.
```sql
select slope, y_bar_max - x_bar_max * slope as intercept
from (
  select sum((Glucose - x_bar) * (Albumin - y_bar)) /
         sum((Glucose - x_bar) * (Glucose - x_bar)) as slope,
         max(x_bar) as x_bar_max,
         max(y_bar) as y_bar_max
  from (select Glucose, avg(Glucose) over () as x_bar,
               Albumin, avg(Albumin) over () as y_bar
        from GlucoseAlbumin) s
);
```
**Expected output:** `slope` $= 0.0077$, `intercept` $= 2.4959$ ➔ Albumin rises $0.0077$ per unit of Glucose.
- **Empty `over ()`** ➔ the window is the whole result set, so the grand mean repeats on every row ➔ no second copy of the table, no cross join.
- **Lecture vs lab form** ➔ same three layers, same answer; the window form reads one source table, the cross-join form works without window functions.

## ✍️ Practice
> [!QUESTION]- Practice 1: by hand, fit the line to $(1,2), (2,4), (3,5), (4,4), (5,5)$ and predict $y$ at $x = 6$.
> > [!SUCCESS]- Reference solution
> > $$
> > \begin{aligned}
> > \bar x &= 3, \qquad \bar y = 4 \\
> > b_1 &= \frac{(-2)(2)+(-1)(4)+0+(1)(4)+(2)(5)}{4+1+0+1+4} = \frac{6}{10} = 0.6 \\
> > b_0 &= 4 - 0.6 \times 3 = 2.2, \qquad \hat y(6) = 2.2 + 0.6 \times 6 = 5.8
> > \end{aligned}
> > $$
> > - **Key move:** intercept **after** slope — $b_0$ needs $b_1$.

> [!QUESTION]- Practice 2: build `dataset` from `SalesFact` as MEL's monthly total sales, ready for the regression query.
> > [!SUCCESS]- Reference solution
> > ```sql
> > create table dataset as
> > select row_number() over (order by S.TimeID) as x,
> >        sum(Total_Sales) as y
> > from   SalesFact S
> > where  S.LocationID = 'MEL'
> > group by S.TimeID;
> > ```
> > - **Key move:** `group by` first (one row per month), then index the months $1, 2, 3, \dots$ — `TimeID` codes are not evenly spaced numbers ($201812 \to 201901$ jumps $89$).

> [!QUESTION]- Practice 3 (Lab 10 Task 4–5): load the 49 $(\text{Age}, \text{WBC})$ points into `Age_WBC` with `Age numeric(3,0)` as the lab does, fit the line, and explain why Oracle returns intercept $20.1574$, slope $-0.0919$ when the same points fit in Python give $20.1455$, $-0.0918$.
> > [!SUCCESS]- Reference solution
> > ```sql
> > select slope, y_bar_max - x_bar_max * slope as intercept
> > from (
> >   select sum((Age - x_bar) * (WBC - y_bar)) /
> >          sum((Age - x_bar) * (Age - x_bar)) as slope,
> >          max(x_bar) as x_bar_max,
> >          max(y_bar) as y_bar_max
> >   from (select Age, avg(Age) over () as x_bar,
> >                WBC, avg(WBC) over () as y_bar
> >         from Age_WBC) s
> > );
> > ```
> > - **Key move:** `numeric(3,0)` has scale $0$, so Oracle **rounds** $56.3 \to 56$ on insert — no error, a different $x$ ➔ the lab's check values belong to integer ages; `number(4,1)` keeps the decimal and gives $20.1455$, $-0.0918$ (verified by recomputation).
> > - **Reading:** negative slope ➔ white-blood-cell count falls about $0.09$ per year of age.

## ⚠️ Common Mistakes
- 💡 **`group by x, y` inside the means view** ➔ the lab solution does this; it collapses repeated $(x, y)$ points to one, silently reweighting the fit — harmless on Lab 10's all-distinct pairs, wrong on real fact rows ➔ drop it.
- 💡 **Bare `x_bar` beside `sum(...)`** ➔ a non-aggregated column with no `group by` raises ORA-00937; `max(x_bar)` is the legal carrier.
- 💡 **Adding a join condition to `av, dataset`** ➔ there is no shared key; the comma-list **is** the intended Cartesian product of a one-row view.
- 💡 **Slope alias in its own layer** ➔ `slope` is invisible beside its definition; the intercept needs the outer `select`.
