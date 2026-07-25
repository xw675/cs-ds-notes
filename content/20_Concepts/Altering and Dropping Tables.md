---
unit: FIT2094
week: 6
parent: "[[DDL Table Creation]]"
tags: [CS/Databases, SQL/Oracle, Monash/CS_DS]
type: pattern
aliases: [ALTER TABLE, DROP TABLE]
---
# [[Altering and Dropping Tables]]

**Context:** [[FIT2094_MOC]] · evolve or remove an existing schema · the DDL you run **after** [[DDL Table Creation|initial creation]]
**Problem it solves:** modify a live table's columns/constraints, or remove a table, without violating [[Foreign Key and Referential Integrity|referential integrity]].

> [!abstract] Quick Revision
> - **🎯 Trigger:** need to add a column/constraint, retype a column, or delete a table ➔ reach for ALTER TABLE / DROP TABLE.
> - **⚡ Key Constraint:** dropping a **referenced** parent fails on referential integrity ➔ needs `CASCADE CONSTRAINTS`; all of this is DDL (auto-committed, irreversible).

## 🔧 Minimal Working Example
```sql
-- add a column with a default value
ALTER TABLE training ADD train_type CHAR(1) DEFAULT 'P';

-- add a named CHECK constraint (restrict valid values)
ALTER TABLE training ADD CONSTRAINT chk_train_type CHECK (train_type IN ('P','F'));

-- modify an existing column to mandatory
ALTER TABLE training MODIFY train_type NOT NULL;

-- drop a constraint by name
ALTER TABLE cust_train DROP CONSTRAINT training_cust_train_fk;
```
**Expected output:** `training` gains a defaulted, value-checked, now-mandatory `train_type`; the named FK is removed from `cust_train`.

- **`DEFAULT` fills on insert** ➔ new rows omitting `train_type` get `'P'`.
- **`ENABLE`/`DISABLE`** ➔ toggle enforcement (`ALTER TABLE t DISABLE CONSTRAINT c;`) — a diagnostic tool only.

## 🔀 Variations
- **Plain `DROP`** ➔ `DROP TABLE customer PURGE;` — `PURGE` skips the recycle bin (immediate, unrecoverable).
- **Referenced parent** ➔ `DROP TABLE customer CASCADE CONSTRAINTS PURGE;` first removes FK constraints *pointing at* `customer`, then drops it; the old `cust_id` values survive as plain attributes in ex-child tables.

## ✍️ Practice
> [!QUESTION]- Practice 1: `training` has a `train_type` column that should only ever be `'P'` or `'F'`, and must never be null. Add both rules with named/mandatory constraints.
> > [!SUCCESS]- Reference solution
> > ```sql
> > ALTER TABLE training ADD CONSTRAINT chk_train_type CHECK (train_type IN ('P','F'));
> > ALTER TABLE training MODIFY train_type NOT NULL;
> > ```
> > - **Key move:** `CHECK` is a named table constraint (`chk_...`); `NOT NULL` is applied by `MODIFY`, left unnamed.

## ⚠️ Common Mistakes
- 💡 **`DISABLE CONSTRAINT` on a live DB is dangerous** ➔ Oracle stops enforcing that relationship, so violating rows can be inserted while it is off; never disable on an active production database.
- 💡 **Dropping a referenced table needs `CASCADE CONSTRAINTS`** ➔ a bare `DROP` fails while any FK references its PK; `CASCADE CONSTRAINTS` clears those FKs first.
