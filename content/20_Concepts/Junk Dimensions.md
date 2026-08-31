---
unit: FIT3003
week: 6
source: [lecture, slides]
domain: C
parent: "[[Star Schema]]"
tags: [CS/Databases, DataScience/DataWarehousing, Tool/SQL]
aliases: [Junk Dimension, JunkDim, Low Cardinality Dimension]
---
# [[Junk Dimensions]]

**Context:** [[FIT3003_MOC]] · what to do when a star sprouts several two-row dimensions ➔ [[One-Attribute Dimensions]], [[Building Dimension Tables]]
**Parent Framework:** [[Star Schema]]

> [!abstract] Quick Revision
> - **🎯 Objective:** consolidate several **low-cardinality**, mutually unrelated dimensions into **one** dimension table ➔ the junk dimension is the **Cartesian product** of their members, keyed by a single `JunkID`.
> - **📦 Core Components:** $|\text{JunkDim}| = \prod_i |\text{Dim}_i|$ ➔ Real-Estate: $2 \times 2 \times 4 \times 2 = 32$ rows.
> - **⚡ Key Constraint:** *low cardinality and unrelated* are both required — a combined key (`SemesterID` $=$ year $\Vert$ semester) or a hierarchy (city $\rightarrow$ country) is **not** a junk dimension.

## 📝 How It Works
### 1. The Real-Estate case
- **Source** ➔ one large `Property` table; four of its columns are yes/no or four-valued: `Ensuite`, `Pool`, `Spa`, `Aspect_Facing` (East/North/South/West).
- **Measures** ➔ `Num_of_Property` and `Total_Price`; the analysis question is "how many properties have a pool and a spa", "which face north".
- **Option 1 — non-junk** ➔ four separate dimensions $\Rightarrow$ $\text{PropertyFACT1}(\underline{\text{EnsuiteID}^{*}, \text{PoolID}^{*}, \text{Aspect\_FacingID}^{*}, \text{SpaID}^{*}}, \text{Num\_of\_Property}, \text{Total\_Price})$ — five tables in the star.
- **Option 2 — junk** ➔ one dimension $\Rightarrow$ $\text{PropertyFACT2}(\underline{\text{JunkID}^{*}}, \text{Num\_of\_Property}, \text{Total\_Price})$ — **two** tables in the star, and the fact still holds $32$ rows.
- **Bound on size** ➔ the junk dimension's row count is never more than the fact's row count, because it is only the combinations that the fact can key on.

### 2. What is *not* a junk dimension
- **A combined key** ➔ `SemYearDIM(SemesterID, Semester, Year)` where $\text{SemesterID} = 201701$ is just year $\Vert$ semester made unique; the alternative is to **split** it into `SemesterDIM` and `YearDIM`, not to call it junk.
- **A hierarchy** ➔ `CampusDIM(CampusID, …, CityName, State, Postcode, Country)` splits into a city $\rightarrow$ country [[Dimension Hierarchies|hierarchy]] (a [[Snowflake Schema|snowflake]]) or into two independent dimensions — the attributes are **related**, so consolidating them is normal modelling.
- **The discriminator** ➔ junk needs **many members, each cheap** and **no relationship between the attributes**; both counter-examples fail the second test.

## ⚙️ Core Implementation
### 🔹 Option 1 — the non-junk build (four dimensions)
> [!code]- `select distinct` per column, then one `update` per member value
> ```sql
> create table EnsuiteDim as select distinct Ensuite from Property order by Ensuite;
> alter table EnsuiteDim add (EnsuiteID number(1));
> update EnsuiteDim set EnsuiteID = 1 where Ensuite = 'no';
> update EnsuiteDim set EnsuiteID = 2 where Ensuite = 'yes';
> -- identical shape for PoolDim, SpaDim, AspectFacingDim (4 updates: East=1, North=2, South=3, West=4)
>
> create table PropertyTempFact1 as
> select Ensuite, Pool, Aspect_Facing, Spa, Houseprice from Property;
> alter table PropertyTempFact1 add (EnsuiteID number(1));      -- + PoolID, Aspect_FacingID, SpaID
> update PropertyTempFact1 set EnsuiteID = 1 where Ensuite = 'no';
> update PropertyTempFact1 set EnsuiteID = 2 where Ensuite = 'yes';
>
> create table PropertyFact1 as
> select EnsuiteID, PoolID, Aspect_FacingID, SpaID,
>        count(*) as Num_of_Property, sum(Houseprice) as Total_Price
> from   PropertyTempFact1
> group by EnsuiteID, PoolID, Aspect_FacingID, SpaID;
> ```
> 💡 **Common Mistake:** **Filling the IDs only in the dimensions** ➔ the temp fact needs its own `alter add` $+$ `update` pass, or the final `group by` has nothing to group on.

### 🔹 Option 2 — the junk build (one dimension, sequence-keyed)
> [!code]- Cartesian product by `select distinct`, `nextval` for the key, correlated `update` for the fact
> ```sql
> create table JunkDim as
> select distinct Ensuite, Pool, Aspect_Facing, Spa from Property
> order by Ensuite, Pool, Aspect_Facing, Spa;                   -- 32 combinations
> alter table JunkDim add (JunkID number(2));
>
> drop sequence Seq_ID;
> create sequence Seq_ID start with 1 increment by 1 maxvalue 99999999 minvalue 1 nocycle;
> update JunkDim set JunkID = Seq_ID.nextval;                   -- one statement keys all 32 rows
>
> create table PropertyTempFact2 as
> select Ensuite, Pool, Aspect_Facing, Spa, Houseprice from Property;
> alter table PropertyTempFact2 add (JunkID number(2));
>
> update PropertyTempFact2 TF set TF.JunkID =                   -- fill in a loop, without a cursor
>   (select J.JunkID from JunkDim J
>    where J.Ensuite = TF.Ensuite and J.Pool = TF.Pool
>    and   J.Aspect_Facing = TF.Aspect_Facing and J.Spa = TF.Spa);
>
> create table PropertyFact2 as
> select JunkID, count(*) as Num_of_Property, sum(Houseprice) as Total_Price
> from   PropertyTempFact2 group by JunkID;
> ```
> 💡 **Common Mistake:** **Writing $32$ hand-typed `update … set JunkID = n where <4 predicates>` statements** ➔ that is the "update one-by-one" route the chapter shows first; the correlated subquery (or a PL/SQL `cursor` loop over `JunkDim`) does the same job once and does not rot when a member is added.

## ⚖️ Core Decision Matrix
| Aspect | Non-junk (one dimension per attribute) | Junk (one consolidated dimension) |
| :--- | :--- | :--- |
| Tables in the star | $1 + n$ | $1 + 1$ |
| Fact key | composite of $n$ FKs | single `JunkID` |
| Simple filter query | `PropertyFact1 PF, PoolDim P, SpaDim S` — **3** tables, **2** join conditions | `PropertyFact2 PF, JunkDim J` — **2** tables, **1** join condition |
| Nested "features of the dearest property" | **5** tables, **4** join conditions | `select *` from the fact alone, or fact $+$ `JunkDim` for the labels |
| Adding an attribute later | a new dimension and a new FK in the fact | rebuild `JunkDim` — every `JunkID` is renumbered |
| Readability of the fact | keys are self-describing | `JunkID = 17` means nothing without the join |

> [!NOTE] **When It Flips:** consolidate as soon as the attributes are unrelated **and** their cardinalities are small enough that $\prod_i |\text{Dim}_i|$ stays comfortably below the fact's row count. If any one dimension is large, or two of them are related, the product explodes or the model lies — keep them separate.

## 🧠 Active Recall
> [!FAQ]- The junk dimension holds the same $32$ combinations the four separate dimensions could produce. What has actually been gained?
> > [!SUCCESS]- Answer
> > - **Short answer:** the star becomes two tables instead of five, and every query loses $n-1$ joins.
> > - **Why:** **The star is simpler** ➔ four spokes each carrying one yes/no column contribute no analytical structure, only diagram noise. **The query is less complex** ➔ the nested "which features has the most expensive property" question drops from five tables and four join conditions to a single `select *` against the fact. **Nothing is lost** ➔ the combinations are the same set; only their addressing changed from four keys to one.

> [!FAQ]- `SemYearDIM(SemesterID, Semester, Year)` merges two columns under one identifier. Why is that not a junk dimension?
> > [!SUCCESS]- Answer
> > - **Short answer:** because `Semester` and `Year` are **related** — `SemesterID` is their concatenation acting as a unique identifier, not a Cartesian product of unrelated flags.
> > - **Why:** **Junk requires independence** ➔ `Pool` and `Aspect_Facing` say nothing about each other, so enumerating every pair is meaningful; a semester belongs to a year. **The correct remedy differs** ➔ a combined dimension is **split** into `SemesterDIM` and `YearDIM`, or kept as a [[Dimension Hierarchies|hierarchy]] when the relationship is many-1 (city $\rightarrow$ country in `CampusDIM`). **Same surface, opposite move** ➔ junk consolidates, a combined dimension decomposes.
