---
unit: FIT3003
week: [1, 2, 4]
source: [lecture, slides]
domain: C
parent: "[[Data Warehouse]]"
tags: [CS/Databases, DataScience/DataWarehousing]
aliases: [Fact Table, Dimension Table, Dimensional Modelling]
---
# [[Star Schema]]

**Context:** [[FIT3003_MOC]]
**Parent Framework:** [[Data Warehouse]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a data modelling technique that maps **multidimensional decision-support data into a relational database** ➔ one central fact surrounded by qualifying dimensions.
> - **📦 Core Components:** **Facts** ➔ numeric measurements | **Dimensions** ➔ qualifying perspectives | **Attributes** ➔ properties within a dimension.
> - **⚡ Key Constraint:** picking the fact and its grain. The required *analysis questions* dictate the dimensions — derive them from the questions, never guess.

## 📝 How It Works
### 1. Why it exists
- **Core Mechanism:** **Analysis-driven design** ➔ ER modelling and [[Normalisation|normalisation]] did **not** yield a database structure serving advanced data-analysis requirements, so dimensional modelling was developed to sit on the same relational technology.
- **Structural Invariant:** **Relational underneath** ➔ the star is ordinary tables; the "cube" of the [[Data Warehouse]] is the logical view those tables present.

### 2. Facts
- **Core Mechanism:** **Numeric measurements** ➔ values representing a specific business aspect or activity (sales figures measuring product/service sales; fee amounts measuring income).
- **Structural Invariant:** **Fact table shape** ➔ $\text{FACT}(\underline{\text{DimFK}_1, \dots, \text{DimFK}_n}, \text{measure}_1, \dots)$ — the primary key is the **composite of the dimension foreign keys**; every non-key column is a measure.

### 3. Dimensions
- **Core Mechanism:** **Qualifying characteristics** ➔ perspectives added to a fact; sales viewed by sales location, sales period, sales product.
- **Structural Invariant:** **One hop only** ➔ each dimension joins directly to the fact (that is what makes the picture a star); a dimension is not further normalised into sub-tables. **W4 exception** ➔ decomposing one dimension turns the star into a [[Snowflake Schema]] — forced when the source relationship is m–m ([[Bridge Tables]]), merely optional when it is many-1 ([[Dimension Hierarchies]]).

### 4. Attributes
- **Core Mechanism:** **Properties in a dimension** ➔ the descriptive columns a dimension carries (a country attribute inside a student dimension; a level attribute inside a course dimension).
- **Structural Invariant:** **Attributes are what you group by** ➔ an analysis question can only slice on an attribute that some dimension actually stores.

### 5. Notation conventions *(W2 — must be reproduced exactly in the assignment)*
- **Naming:** **`XxxDIM` / `XxxFACT`** ➔ dimensions and the fact are named by suffix; connecting lines may be straight or bent, and the dimension under discussion is **highlighted** in the diagram.
- **Keys:** **Dimension ID is the dimension's PK** ➔ the same column appears inside the fact as **FK *and* part of the composite PK**, drawn in *bold italic* above the separator line; measures sit below it.
- **Fact content:** **Numerical only** ➔ a fact may hold only numerical values; anything descriptive belongs in a dimension ➔ [[Fact Measure Aggregation Rules]].
- **Source-side E/R notation:** **`ENTITY` capitalised**, keys marked `PK` / `FK`, Crow's-foot relationships **with participation**, associative relationship $=$ m–m, non-associative $=$ 1–m ➔ [[Entity Relationship Diagram (ERD)]], [[Cardinality (Crow's Foot Notation)]].

### 6. Transformation process
$$\text{Operational DB (E/R diagram)} \xrightarrow{\ \text{Transformation (ETL)}\ } \text{Data Warehouse (star schema)}$$
- **Direction is one-way** ➔ the star is *derived from* the operational schema; the operational database keeps running unchanged.
- **Build order** ➔ validate with [[Two-Column Table Methodology]] ➔ [[Building Dimension Tables]] ➔ [[Building Fact Tables]].

## ⚙️ Schema Layout
### 🔹 Generic star
> [!code]- Mermaid `erDiagram` skeleton
> ```mermaid
> erDiagram
>   DIM_TIME     ||--o{ FACT_SALES : qualifies
>   DIM_LOCATION ||--o{ FACT_SALES : qualifies
>   DIM_PRODUCT  ||--o{ FACT_SALES : qualifies
>   FACT_SALES {
>     NUMBER time_id FK
>     NUMBER location_id FK
>     NUMBER product_id FK
>     NUMBER sales_amount
>     NUMBER quantity_sold
>   }
>   DIM_TIME {
>     NUMBER time_id PK
>     NUMBER year
>     NUMBER semester
>   }
>   DIM_LOCATION {
>     NUMBER location_id PK
>     VARCHAR2 city
>     VARCHAR2 country
>   }
>   DIM_PRODUCT {
>     NUMBER product_id PK
>     VARCHAR2 product_name
>     VARCHAR2 category
>   }
> ```
> *(the three FKs in `FACT_SALES` jointly form its composite primary key)*
> 💡 **Common Mistake:** **Measures must be numeric and additive over the grain** ➔ a descriptive text column placed in the fact table is a dimension attribute in the wrong place.

$$\text{FACT\_SALES}(\underline{\text{time\_id}^{*}, \text{location\_id}^{*}, \text{product\_id}^{*}}, \text{sales\_amount}, \text{quantity\_sold})$$

## 📊 Exam Execution Trace & Applied Exercises

### Derivation Trace — question ➔ dimension
*(the mechanical method: read each required analysis question, extract the grouping term and the measure)*

| # | Analysis question | Grouping term ➔ dimension | Measure ➔ fact column |
| :--- | :--- | :--- | :--- |
| 1 | Total income from certain **countries** | country ➔ **Country** | Total_Income |
| 2 | Total income for **postgraduate courses** in a **year** | course level ➔ **Course** · year ➔ **Enrolment Year** | Total_Income |
| 3 | Total income as a result of each **agent** | agent ➔ **Agent** | Total_Income |
| 4 | How many **payments** generated each **year** | year ➔ **Enrolment Year** | Number_of_Payments |

- **Grain falls out of the source** ➔ students pay "several times, normally once every semester, for each course" ⟹ one fact row per payment.
- **Dimensions come only from the questions** ➔ the lecture's answer set is exactly **Country, Course, Agent, Enrolment Year**; campus is *not* a dimension here because no analysis question asks for it.

### Applied Exercise — International College enrolment star
**Problem:** the admission office handles enrolment, payment and marketing for international students of a multi-campus college, some recruited through overseas educational agents. Design the star schema answering the four questions above.

> [!QUESTION]- Attempt the fact + dimensions + attributes cold, then expand.
> > [!SUCCESS]- Model answer *(as given in Chapter 2)*
> > ```mermaid
> > erDiagram
> >   COUNTRY_DIM ||--o{ COLLEGE_FACT : qualifies
> >   COURSE_DIM  ||--o{ COLLEGE_FACT : qualifies
> >   AGENT_DIM   ||--o{ COLLEGE_FACT : qualifies
> >   YEAR_DIM    ||--o{ COLLEGE_FACT : qualifies
> >   COLLEGE_FACT {
> >     VARCHAR2 Country FK
> >     NUMBER AgentNo FK
> >     VARCHAR2 CourseCode FK
> >     NUMBER EnrolmentYear FK
> >     NUMBER Number_of_Payments
> >     NUMBER Total_Income
> >   }
> >   COUNTRY_DIM {
> >     VARCHAR2 Country PK
> >   }
> >   COURSE_DIM {
> >     VARCHAR2 CourseCode PK
> >     VARCHAR2 CourseName
> >     NUMBER Duration
> >     VARCHAR2 CourseLevel
> >   }
> >   AGENT_DIM {
> >     NUMBER AgentNo PK
> >     VARCHAR2 AgentName
> >     VARCHAR2 AgentAddress
> >     VARCHAR2 AgentPhone
> >     VARCHAR2 ContactPerson
> >   }
> >   YEAR_DIM {
> >     NUMBER EnrolmentYear PK
> >   }
> > ```
> > $$\text{COLLEGEFACT}(\underline{\text{Country}^{*}, \text{AgentNo}^{*}, \text{CourseCode}^{*}, \text{EnrolmentYear}^{*}}, \text{Number\_of\_Payments}, \text{Total\_Income})$$
> > - **Fact:** two measures — `Number_of_Payments` (Q4) and `Total_Income` (Q1–3).
> > - **Key move:** `CourseLevel` must be a stored *attribute*, or question 2 ("postgraduate courses") cannot be answered at all.
> > - **Degenerate dimensions are fine** ➔ `CountryDIM` and `YearDIM` hold a single column each; they still exist so the star's axes are explicit.
> > - **Implementation** ➔ [[Building Dimension Tables]] then [[Building Fact Tables]] (Route A, direct aggregation).

## 🧠 Active Recall
> [!FAQ]- Given a case study, in what order do you decide the pieces, and why that order?
> > [!SUCCESS]- Answer
> > - **Short answer:** fact → grain → dimensions → attributes, all driven by the **required analysis questions**.
> > - **Why:** **Measure first** ➔ the fact is whatever the questions total or count, since $\text{FACT}$'s non-key columns must be numerical measurements. **Grain next** ➔ it fixes what one row means and is unrecoverable later. **Dimensions from grouping terms** ➔ every "by X" / "for each X" in a question forces a dimension keyed into the fact's composite PK. **Attributes last** ➔ each remaining qualifier in a question ("postgraduate", "country") must exist as a column inside its dimension or the query is unanswerable.

> [!FAQ]- Why is the star schema deliberately *not* normalised, given [[Third Normal Form (3NF)|3NF]] is the operational default?
> > [!SUCCESS]- Answer
> > - **Short answer:** normalisation optimises safe updating; the warehouse is loaded by [[Data Engineering|ETL]] and read, not updated in place.
> > - **Why:** **Anomaly risk is priced differently** ➔ [[Database Anomalies|update anomalies]] are the cost normalisation buys off, but a warehouse's writes are controlled bulk loads, so the redundancy in a flat dimension is harmless. **Join cost dominates** ➔ keeping every dimension one hop from the fact bounds an OLAP query to $n$ single joins regardless of hierarchy depth, which is what lets summaries be computed "on the fly".
