---
unit: FIT2086
domain: [E, G]
week: 2
source: [applied, lab]
parent: "[[R for Data Science]]"
tags: [Tool/R, DataScience/Statistics]
type: pattern
aliases: [factor, table, contingency table, cross-tabulation, prop.table, pie chart in R, categorical variables in R, stringsAsFactors]
---
# [[Categorical Summaries and Cross-Tabulation in R]]

**Context:** [[FIT2086_MOC]] · summarising **categorical** variables, where mean/sd are meaningless · the cat–cat half of [[Association Between Variables]] · extends [[R Toolkit (Cheatsheet)]] · studio data: `heart.csv`, `Mushroom.csv`
**Problem it solves:** count the levels of a categorical variable, and detect whether two categorical variables are associated.

> [!abstract] Quick Revision
> - **🎯 Trigger:** a column of labels (or numeric **codes** standing for labels) ➔ make it a `factor`, then `table()` it; two such columns ➔ `table(a, b)` for a **contingency table**.
> - **⚡ Key Constraint:** association is read from **how the row distribution changes across columns**, not from raw cell counts — a big cell in a big row means nothing. Convert to proportions before judging.

## 🔧 Minimal Working Example
```r
mush <- read.csv("Mushroom.csv", header = TRUE, stringsAsFactors = TRUE)

tab <- table(mush$cap.shape)     # one-way frequency table
pie(tab)                          # relative frequencies, visually

table(mush$class, mush$odor)      # contingency table: rows = class, cols = odor
```
**Expected output** (`n = 8124`; 4208 edible, 3916 poisonous):

| class | almond | anise | creosote | fishy | foul | musty | none | pungent | spicy |
| :--- | --: | --: | --: | --: | --: | --: | --: | --: | --: |
| **edible** | 400 | 400 | 0 | 0 | 0 | 0 | 3408 | 0 | 0 |
| **poisonous** | 0 | 0 | 192 | 576 | 2160 | 36 | 120 | 256 | 576 |

- **Reading it** ➔ every odour except `none` is **entirely** one class ➔ `odor` is by far the strongest predictor of `class` in this dataset; knowing the odour almost determines edibility.
- **Contrast a weak variable** ➔ `table(mush$class, mush$cap.shape)` splits `convex` $1948$/$1708$ and `flat` $1596$/$1556$ — close to the overall $52\%/48\%$ base rate ⟹ **little** association, though `bell` ($404$/$48$) leans edible and `knobbed` ($228$/$600$) leans poisonous.

## 🔀 Variations
### Recoding numeric codes as factors
```r
heart <- read.csv("heart.csv", header = TRUE, stringsAsFactors = TRUE)
table(heart$SEX)          # 0: 97, 1: 206  — unreadable without labels

heart$SEX <- factor(heart$SEX, labels = c("MALE","FEMALE"), levels = c(0,1))
heart$HD  <- factor(heart$HD,  labels = c("NO","YES"),      levels = c(0,1))
table(heart$SEX, heart$HD)
```
**Expected output** (`n = 303`):

| | NO | YES |
| :--- | --: | --: |
| **MALE** *(code 0)* | 72 | 25 |
| **FEMALE** *(code 1)* | 92 | 114 |

- **`levels` = the values present, `labels` = what to call them** ➔ positionally paired; the $i$-th label names the $i$-th level.
- **Why bother** ➔ `table()` on a raw numeric column prints bare codes; a factor prints meaning, and R will treat it as categorical in every later model.

### Proportions instead of counts
```r
tab <- table(mush$class)
prop.table(tab)                       # overall proportions: 0.518 edible, 0.482 poisonous
prop.table(table(mush$class, mush$odor), margin = 2)   # column-wise proportions
```
- **`margin = 1`** rows sum to 1 · **`margin = 2`** columns sum to 1 · **omitted** the whole table sums to 1 ➔ pick the margin that answers the question ("given the odour, how likely is poison?" = column-wise).

## ✍️ Practice
> [!QUESTION]- Practice 1: Load `Mushroom.csv` and cross-tabulate `class` against `habitat`. Which habitats would make you suspect a mushroom is poisonous?
> > [!SUCCESS]- Reference solution
> > ```r
> > mush <- read.csv("Mushroom.csv", header = TRUE, stringsAsFactors = TRUE)
> > table(mush$class, mush$habitat)
> > ```
> > | class | grasses | leaves | meadows | paths | urban | waste | woods |
> > | :--- | --: | --: | --: | --: | --: | --: | --: |
> > | **edible** | 1408 | 240 | 256 | 136 | 96 | 192 | 1880 |
> > | **poisonous** | 740 | 592 | 36 | 1008 | 272 | 0 | 1268 |
> >
> > - **Key move:** compare each column against the $52\%$ edible base rate — `paths` ($136$ vs $1008$) and `urban` ($96$ vs $272$) are strongly poisonous, `meadows` ($256$ vs $36$) and `waste` (all edible) strongly edible. `woods` and `grasses` are near the base rate and carry little signal.

> [!QUESTION]- Practice 2: In `heart.csv`, tabulate heart disease by sex **as proportions within each sex**, so the two groups are comparable despite unequal sizes.
> > [!SUCCESS]- Reference solution
> > ```r
> > heart <- read.csv("heart.csv", header = TRUE, stringsAsFactors = TRUE)
> > heart$SEX <- factor(heart$SEX, labels = c("MALE","FEMALE"), levels = c(0,1))
> > heart$HD  <- factor(heart$HD,  labels = c("NO","YES"),      levels = c(0,1))
> > prop.table(table(heart$SEX, heart$HD), margin = 1)   # each ROW sums to 1
> > ```
> > - **Key move:** the raw counts ($25$ vs $114$ "YES") are incomparable because the groups differ in size ($97$ vs $206$); row proportions give $\approx0.26$ vs $\approx0.55$, which is the actual comparison. **`margin = 1` is what makes unequal groups comparable.**

## ⚠️ Common Mistakes
- 💡 **Comparing raw counts across unequal groups** ➔ a larger group produces larger cells everywhere; always `prop.table(..., margin=)` before claiming association.
- 💡 **`labels`/`levels` is an assertion, not a lookup** ➔ R applies whatever mapping you give it, silently. Get the coding backwards and every downstream table, plot and model is mislabelled while looking perfectly plausible — verify the codebook first.
- 💡 **Forgetting `stringsAsFactors = TRUE`** ➔ text columns load as plain character, so R will not treat them as categorical; specify it on **every** `read.csv` of a dataset with labels.
- 💡 **`pie()` for many levels** ➔ human eyes compare angles badly; a pie with 9 slices (mushroom `odor`) hides exactly the differences the table makes obvious (see [[Data Visualisation (Chart Types)]]).
