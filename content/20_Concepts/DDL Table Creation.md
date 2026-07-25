---
unit: FIT2094
week: 6
parent: "[[SQL Sublanguages (DDL, DML, DCL)]]"
tags: [CS/Databases, SQL/Oracle, Monash/CS_DS]
type: pattern
aliases: [CREATE TABLE, ALTER ADD CONSTRAINT]
---
# [[DDL Table Creation]]

**Context:** [[FIT2094_MOC]] · turn a [[Logical Modelling (ER Mapping)|logical model]] into Oracle tables · the physical-design deliverable
**Problem it solves:** given relations with PKs/FKs, emit `CREATE TABLE` + `ALTER TABLE` DDL that builds them in a valid order with named constraints.

> [!abstract] Quick Revision
> - **🎯 Trigger:** any schema $\text{TABLE}(\underline{\text{PK}},\text{Attr},\text{FK}^{*})$ to implement ➔ columns + NOT NULL inline, **every other constraint via ALTER**.
> - **⚡ Key Constraint:** creation order — a table referenced by an FK must exist first; circular references force the split-then-`ALTER` method.

## 🔧 Minimal Working Example
*(Unit-required method: `CREATE` holds only columns + `NOT NULL`; `PRIMARY KEY`, `UNIQUE`, `FOREIGN KEY` are all named table constraints added by `ALTER`.)*
```sql
CREATE TABLE cust_train (
    ct_id           NUMBER(4)  NOT NULL,
    train_code      CHAR(5)    NOT NULL,
    cust_id         NUMBER(4)  NOT NULL,
    ct_date_start   DATE       NOT NULL
);

ALTER TABLE cust_train ADD CONSTRAINT cust_train_pk PRIMARY KEY (ct_id);
ALTER TABLE cust_train ADD CONSTRAINT cust_train_uq UNIQUE (train_code, cust_id, ct_date_start);
ALTER TABLE cust_train ADD CONSTRAINT training_cust_train_fk
    FOREIGN KEY (train_code) REFERENCES training (train_code);
ALTER TABLE cust_train ADD CONSTRAINT customer_cust_train_fk
    FOREIGN KEY (cust_id)    REFERENCES customer (cust_id);
```
**Expected output:** `cust_train` with 1 PK, 1 business-rule UNIQUE, 2 FKs — created only *after* `training` and `customer` exist.

- **Naming rules** ➔ PK `tablename_pk` · FK `onesidetable_manysidetable_fk` · UNIQUE `tablename_uq` · CHECK `chk_columnname`.
- **PK vs UNIQUE roles** ➔ PK = entity integrity (row identity); UNIQUE = a **business rule** (no duplicate training per customer per day).
- **NOT NULL is the exception** ➔ it stays inline as a column constraint and is left **unnamed**; omit it entirely for nullable columns.

## 🔀 Variations
- **Circular FK (`EMPLOYEE`⇄`DEPARTMENT`)** ➔ neither can be `CREATE`d with its FK first. Fix: `CREATE` **both** with columns+`NOT NULL` only → `ALTER ADD` both PKs → `ALTER ADD` both FKs.
- **Composite FK** ➔ one FK references a whole composite PK, **not** three separate FKs:
```sql
ALTER TABLE rental ADD CONSTRAINT cust_train_rental_fk
    FOREIGN KEY (train_code, cust_id, ct_date_start)
    REFERENCES cust_train (train_code, cust_id, ct_date_start);
```

## ✍️ Practice 
> [!QUESTION]- Practice 1: Implement $\text{TRAINING}(\underline{\text{train\_code}},\text{train\_desc},\text{train\_hrs})$ then $\text{CUST\_TRAIN}(\underline{\text{ct\_id}},\text{train\_code}^{*},\dots)$ using the unit method, in a valid order.
> > [!SUCCESS]- Reference solution
> > ```sql
> > CREATE TABLE training (
> >     train_code  CHAR(5)       NOT NULL,
> >     train_desc  VARCHAR2(100) NOT NULL,
> >     train_hrs   NUMBER(2)     NOT NULL
> > );
> > ALTER TABLE training ADD CONSTRAINT training_pk PRIMARY KEY (train_code);
> > -- cust_train created AFTER training, then:
> > ALTER TABLE cust_train ADD CONSTRAINT training_cust_train_fk
> >     FOREIGN KEY (train_code) REFERENCES training (train_code);
> > ```
> > - **Key move:** parent (`training`) exists before the child's FK is added.

## ⚠️ Common Mistakes
- 💡 **Constraints via `ALTER`, not inline** ➔ this unit requires every constraint except `NOT NULL` to be a **named table constraint** added by `ALTER TABLE` — inline PK/FK loses marks.
- 💡 **Child before parent = error** ➔ referencing a table that does not yet exist fails; order parents first, or use the split-then-`ALTER` method for cycles.
