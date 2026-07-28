---
unit: FIT3003
week: 1
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
> - **⚡ Critical Bottleneck:** picking the fact and its grain. The required *analysis questions* dictate the dimensions — derive them from the questions, never guess.

## 📝 Dashboard Blueprint
### 1. Why it exists
- **Core Mechanism:** **Analysis-driven design** ➔ ER modelling and [[Normalisation|normalisation]] did **not** yield a database structure serving advanced data-analysis requirements, so dimensional modelling was developed to sit on the same relational technology.
- **Structural Invariant:** **Relational underneath** ➔ the star is ordinary tables; the "cube" of the [[Data Warehouse]] is the logical view those tables present.

### 2. Facts
- **Core Mechanism:** **Numeric measurements** ➔ values representing a specific business aspect or activity (sales figures measuring product/service sales; fee amounts measuring income).
- **Structural Invariant:** **Fact table shape** ➔ $\text{FACT}(\underline{\text{DimFK}_1, \dots, \text{DimFK}_n}, \text{measure}_1, \dots)$ — the primary key is the **composite of the dimension foreign keys**; every non-key column is a measure.

### 3. Dimensions
- **Core Mechanism:** **Qualifying characteristics** ➔ perspectives added to a fact; sales viewed by sales location, sales period, sales product.
- **Structural Invariant:** **One hop only** ➔ each dimension joins directly to the fact (that is what makes the picture a star); a dimension is not further normalised into sub-tables.

### 4. Attributes
- **Core Mechanism:** **Properties in a dimension** ➔ the descriptive columns a dimension carries (a country attribute inside a student dimension; a level attribute inside a course dimension).
- **Structural Invariant:** **Attributes are what you group by** ➔ an analysis question can only slice on an attribute that some dimension actually stores.

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
> 💡 **Exam Pitfall:** **Measures must be numeric and additive over the grain** ➔ a descriptive text column placed in the fact table is a dimension attribute in the wrong place.

$$\text{FACT\_SALES}(\underline{\text{time\_id}^{*}, \text{location\_id}^{*}, \text{product\_id}^{*}}, \text{sales\_amount}, \text{quantity\_sold})$$

## 📊 Exam Execution Trace & Applied Exercises

### Derivation Trace — question ➔ dimension
*(the mechanical method: read each required analysis question, extract the grouping term and the measure)*

| # | Analysis question | Grouping term ➔ dimension | Measure ➔ fact column |
| :--- | :--- | :--- | :--- |
| 1 | Total income from certain **countries** | country ➔ **Student** (attribute `country`) | income |
| 2 | Total income for **postgraduate courses** in a **year** | course level ➔ **Course** · year ➔ **Time** | income |
| 3 | Total income as a result of each **agent** | agent ➔ **Agent** | income |
| 4 | How many **payments** generated each **year** | year ➔ **Time** | payment count |

- **Grain falls out of the source** ➔ students pay "several times, normally once every semester, for each course" ⟹ one fact row per payment.
- **Campus is a dimension too** ➔ the College is multi-campus and courses are offered at different campuses, so campus is a legitimate perspective even though no listed question demands it yet.

### Applied Exercise — International College enrolment star
**Problem:** the admission office handles enrolment, payment and marketing for international students, some recruited through overseas educational agents (typically only for a student's *first* course). Design the star schema answering the four questions above.

> [!QUESTION]- Attempt the fact + dimensions + attributes cold, then expand.
> > [!SUCCESS]- Model answer *(derived from the four analysis questions — check against the lab solution)*
> > ```mermaid
> > erDiagram
> >   DIM_STUDENT ||--o{ FACT_PAYMENT : qualifies
> >   DIM_COURSE  ||--o{ FACT_PAYMENT : qualifies
> >   DIM_CAMPUS  ||--o{ FACT_PAYMENT : qualifies
> >   DIM_AGENT   ||--o{ FACT_PAYMENT : qualifies
> >   DIM_TIME    ||--o{ FACT_PAYMENT : qualifies
> >   FACT_PAYMENT {
> >     NUMBER student_id FK
> >     NUMBER course_id FK
> >     NUMBER campus_id FK
> >     NUMBER agent_id FK
> >     NUMBER time_id FK
> >     NUMBER fee_amount
> >     NUMBER num_payments
> >   }
> >   DIM_STUDENT {
> >     NUMBER student_id PK
> >     VARCHAR2 student_name
> >     VARCHAR2 country
> >   }
> >   DIM_COURSE {
> >     NUMBER course_id PK
> >     VARCHAR2 course_name
> >     VARCHAR2 course_level
> >   }
> >   DIM_CAMPUS {
> >     NUMBER campus_id PK
> >     VARCHAR2 campus_name
> >   }
> >   DIM_AGENT {
> >     NUMBER agent_id PK
> >     VARCHAR2 agent_name
> >     VARCHAR2 agent_country
> >   }
> >   DIM_TIME {
> >     NUMBER time_id PK
> >     NUMBER year
> >     NUMBER semester
> >   }
> > ```
> > $$\text{FACT\_PAYMENT}(\underline{\text{student\_id}^{*}, \text{course\_id}^{*}, \text{campus\_id}^{*}, \text{agent\_id}^{*}, \text{time\_id}^{*}}, \text{fee\_amount}, \text{num\_payments})$$
> > - **Fact:** payment/income — the only numeric measurement the four questions ask to total or count.
> > - **Grain:** one row per student payment per course per semester (given directly by the case text).
> > - **Key move:** `course_level` must be a stored *attribute*, or question 2 ("postgraduate courses") cannot be answered at all.
> > - **Agent nuance:** subsequent courses are usually *not* agent-handled, so `agent_id` needs a "no agent" member rather than a NULL FK.

## 🧠 Active Recall
> [!FAQ]- Given a case study, in what order do you decide the pieces, and why that order?
> > [!SUCCESS]- Answer
> > - **Direct Criterion:** fact → grain → dimensions → attributes, all driven by the **required analysis questions**.
> > - **Technical Justification:** **Measure first** ➔ the fact is whatever the questions total or count, since $\text{FACT}$'s non-key columns must be numeric measurements. **Grain next** ➔ it fixes what one row means and is unrecoverable later. **Dimensions from grouping terms** ➔ every "by X" / "for each X" in a question forces a dimension keyed into the fact's composite PK. **Attributes last** ➔ each remaining qualifier in a question ("postgraduate", "country") must exist as a column inside its dimension or the query is unanswerable.

> [!FAQ]- Why is the star schema deliberately *not* normalised, given [[Third Normal Form (3NF)|3NF]] is the operational default?
> > [!SUCCESS]- Answer
> > - **Direct Criterion:** normalisation optimises safe updating; the warehouse is loaded by [[Data Engineering|ETL]] and read, not updated in place.
> > - **Technical Justification:** **Anomaly risk is priced differently** ➔ [[Database Anomalies|update anomalies]] are the cost normalisation buys off, but a warehouse's writes are controlled bulk loads, so the redundancy in a flat dimension is harmless. **Join cost dominates** ➔ keeping every dimension one hop from the fact bounds an OLAP query to $n$ single joins regardless of hierarchy depth, which is what lets summaries be computed "on the fly".
