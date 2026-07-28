---
unit: [FIT2094, FIT3003]
domain: C
week: [1, 6]
source: [lecture, applied, lab]
parent: "[[DDL Table Creation]]"
tags: [CS/Databases, Tool/SQL]
type: pattern
aliases: [ALTER TABLE, DROP TABLE, DROP COLUMN, MODIFY]
---
# [[Altering and Dropping Tables]]

**Context:** [[FIT2094_MOC]], [[FIT3003_MOC]] · evolve or remove an existing schema · the DDL you run **after** [[DDL Table Creation|initial creation]]
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

## 🔀 Column-Level ALTER (three verbs, one per statement)
| Verb | Syntax | Effect |
| :--- | :--- | :--- |
| `ADD` | `ALTER TABLE student ADD (StreetAddress VARCHAR2(70), Suburb VARCHAR2(40));` | appends columns (parenthesised list ⟹ several at once), all NULL in existing rows |
| `MODIFY` | `ALTER TABLE student MODIFY (City VARCHAR2(40));` | retypes/resizes an existing column |
| `DROP` | `ALTER TABLE student DROP (CiTTy);` or `DROP COLUMN CiTTy;` | removes the column **and its data**, irreversibly |

- **One verb per statement** ➔ you cannot `ADD` one column and `DROP` another in a single `ALTER TABLE`; each verb takes its own statement.
- **`CHAR(n)` vs `VARCHAR2(n)`** ➔ `CHAR` is **fixed length**, blank-padding every value to $n$ bytes; `VARCHAR2` is **variable length**, storing only the characters supplied. Use `CHAR` only for genuinely fixed-width codes (state code, `Y`/`N`), `VARCHAR2` for everything else.
- **Identifiers are case-insensitive** ➔ a column created as `CiTTy` is stored and referenced as `CITTY`; the case you typed is cosmetic (unlike string *values*, which are case-sensitive).

## 🔀 Variations
- **Plain `DROP`** ➔ `DROP TABLE customer PURGE;` — `PURGE` skips the recycle bin (immediate, unrecoverable).
- **Referenced parent** ➔ `DROP TABLE customer CASCADE CONSTRAINTS PURGE;` first removes FK constraints *pointing at* `customer`, then drops it; the old `cust_id` values survive as plain attributes in ex-child tables.
- **FK blocks a bare drop** ➔ if `carsales` holds an FK to `car`, `DROP TABLE car;` fails; drop `carsales` first, or use `CASCADE CONSTRAINTS`.

## ✍️ Practice
> [!QUESTION]- Practice 1: `training` has a `train_type` column that should only ever be `'P'` or `'F'`, and must never be null. Add both rules with named/mandatory constraints.
> > [!SUCCESS]- Reference solution
> > ```sql
> > ALTER TABLE training ADD CONSTRAINT chk_train_type CHECK (train_type IN ('P','F'));
> > ALTER TABLE training MODIFY train_type NOT NULL;
> > ```
> > - **Key move:** `CHECK` is a named table constraint (`chk_...`); `NOT NULL` is applied by `MODIFY`, left unnamed.

> [!QUESTION]- Practice 2 (FIT3003 Lab 1, Q9–Q11): `STUDENT` has a misspelt `CiTTy VARCHAR2(40)`. Replace it with a correctly spelt `City VARCHAR2(40)`.
> > [!SUCCESS]- Reference solution
> > ```sql
> > ALTER TABLE STUDENT DROP (CiTTy);
> > ALTER TABLE STUDENT ADD (City CHAR(40));
> > ALTER TABLE STUDENT MODIFY (City VARCHAR2(40));
> > ```
> > - **Key move:** three separate statements — Oracle has no rename-and-retype in one ALTER, and the dropped column's data is gone for good.

## ⚠️ Common Mistakes
- 💡 **`DROP COLUMN` destroys data silently** ➔ no confirmation, no rollback (DDL auto-commits); re-adding the column gives you NULLs, not the old values.
- 💡 **`DISABLE CONSTRAINT` on a live DB is dangerous** ➔ Oracle stops enforcing that relationship, so violating rows can be inserted while it is off; never disable on an active production database.
- 💡 **Dropping a referenced table needs `CASCADE CONSTRAINTS`** ➔ a bare `DROP` fails while any FK references its PK; `CASCADE CONSTRAINTS` clears those FKs first.
