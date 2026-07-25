---
unit: FIT2094
domain: C
parent: "[[FIT2094_MOC]]"
tags: [CS/Databases]
type: cheatsheet
aliases: [FIT2094 Exam Crib, Databases Cheatsheet]
---
# [[FIT2094 Unit Cheatsheet]]

**Context:** [[FIT2094_MOC]] · the WHOLE unit in one re-read — design pipeline → relational theory → normalisation → SQL decision rules → transactions → NoSQL. Full SQL syntax lives in [[Oracle SQL Toolkit (Cheatsheet)]] — this sheet carries the theory + the rules that decide marks.

> [!abstract] Quick Revision
> - **🎯 Objective:** the assignment IS the unit ➔ every deliverable is a pipeline stage: brief → conceptual ERD → logical schema → normalised 3NF → Oracle DDL/DML/SELECT.
> - **⚡ Key Constraint:** M:N cannot exist relationally; every FK matches a FULL PK or is NULL; DDL auto-commits — three rules behind most lost marks.

## 1️⃣ Design Pipeline (requirements → physical)
- **Life cycle** ➔ requirements → conceptual → logical → physical; technology-independence DECREASES down the stages; requirements errors cascade — capture EXACTLY the brief, nothing missing, nothing invented.
- **Conceptual (Crow's Foot)** ➔ entities (keyed boxes) + attributes + relationships; cardinality shows **both min and max** per end, min comes from business rules; weak entity = parent key IN its own key + identifying relationship.
- **Crow's Foot cannot** ➔ attach attributes to a relationship (⟹ [[Associative Entity]]) or draw multivalued attributes (⟹ separate weak entity).
- **Identifying vs non-identifying** ➔ solid line = parent PK enters child's composite PK; dashed = plain FK. Circular identification = a PK depending on itself — fatal.
- **Logical mapping rules** ➔ entity → relation · 1:M → FK on the M side · **M:N → bridge relation** (two 1:M) · 1:1 total → consolidate · 1:M unary → recursive FK (the ONLY renameable FK) · ternary ≠ three binaries. Relationships are NOT relations.
- **Keys** ➔ super key (unique) ⊇ candidate key (MINIMAL super key) ∋ primary key (chosen, underlined: $\text{TABLE}(\underline{\text{PK}}, \text{Attr}, \text{FK}^*)$); carry the NATURAL key through the design, surrogate only at the last step + keep the natural key UNIQUE or the business rule is lost.
- **Privacy by design** ➔ collect only what the purpose requires; the client decides what is stored, the designer advises.

## 2️⃣ Relational Theory
- **Relation** ➔ heading (schema, degree $n$ fixed) + body (SET of tuples, cardinality $m$ varies); access by CONTENT never position; atomic values = 1NF; classical model has **no NULLs** (NULL is SQL's marker: ≠ 0 ≠ empty string).
- **Integrity trio** ➔ entity (PK unique + non-NULL) · referential (FK = full PK or NULL; NULL FK = optional participation) · column (domain/CHECK) — declared once, enforced on every DML.
- **[[Relational Algebra]]** ➔ procedural + **closed** (every result is a relation ⟹ composable): $\sigma$ filters rows, $\pi$ keeps columns (deduplicates!), $\bowtie$ = product + select (**derived** from $\times$, not primitive), $\cup, \cap, -$ need union-compatibility, $A - B \neq B - A$, $\rho$ renames.

## 3️⃣ Normalisation Pipeline (UNF → 3NF)
- **Anomalies** ➔ insert/update/delete problems; root cause = one table mixing independent subjects; [[Functional Dependency]] $A \to B$ is the diagnostic tool.

| Step | Kill | Test |
| :-- | :-- | :-- |
| UNF | — | raw client form; NOT a valid relation, no PK yet — don't flatten |
| 1NF | repeating groups | valid relation + PK; list the partial dependencies HERE |
| 2NF | **partial** FDs | every non-key fully depends on each candidate key; single-attribute key ⟹ auto-2NF |
| 3NF | **transitive** FDs | no non-key determines another non-key; each relation = ONE subject |

- **Each removal spins off** a new relation with a PK/FK pair; goal is minimal (not zero) redundancy. **Synthesis** merges 3NF relations from multiple forms — done LAST.

## 4️⃣ SQL Decision Rules (syntax ⟹ [[Oracle SQL Toolkit (Cheatsheet)]])
- **Logical execution order** ➔ FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY — why aliases work in ORDER BY but not WHERE/GROUP BY.
- **Sublanguages** ➔ DDL **auto-commits** (never write COMMIT after it) · DML transactional (COMMIT/ROLLBACK) · DCL grants. CREATE order: referenced parents first; circular FKs ⟹ create-then-ALTER. CTAS copies **data, not constraints**.
- **NULL logic** ➔ three-valued (TRUE/FALSE/UNKNOWN): comparisons with NULL are UNKNOWN, only TRUE rows return; Oracle sorts NULLs LARGEST; NVL replacement must match the column type; INNER joins DROP no-match rows (NULL FK) ⟹ OUTER to keep them.
- **GROUP BY law** ➔ every SELECT/ORDER BY column is in GROUP BY or inside an aggregate; WHERE filters rows before grouping, HAVING filters groups after; $\text{COUNT}(col)$ skips NULLs, $\text{COUNT}(*)$ doesn't.
- **Subquery shape decides operator** ➔ scalar ⟹ $=, <, >$ · one column many rows ⟹ IN/ANY/ALL · many columns ⟹ $(a,b)$ IN. Correlated = references outer row ⟹ runs once PER outer row (same answer as nested, higher cost).
- **Join traps** ➔ NATURAL JOIN with no common column silently = Cartesian product; UPPERCASE ANSI joins throughout (Domain C); self join = same table aliased twice.
- **DML traps** ➔ UPDATE/DELETE without WHERE hits every row; date literals need TO_DATE; NEXTVAL before CURRVAL; hand-typed FK literals = mark-losing manual lookup (subquery them).
- **CHECK vs lookup table** ➔ CHECK = small fixed set, schema change to extend; lookup table = a join for open extensibility. $\text{CHAR}(n)$ fixed/padded vs $\text{VARCHAR2}(n)$ variable.
- **Views** ➔ store the query DEFINITION, not data — re-executed per reference. Optimiser: Explain-Plan COST is RELATIVE — compare versions of the same query only.

## 5️⃣ Transactions & Recovery
- **[[Database Transaction]]** ➔ all-or-nothing DML bundle; mid-transaction state is inconsistent — partial commit never allowed.
- **[[ACID Properties]]** ➔ Atomicity + Durability enforced by the **transaction log**; Isolation by **locks**; Consistency by the rest.
- **Concurrency** ➔ the **lost update** is the canonical interleaving failure; fix = shared/exclusive locks under two-phase locking; cost = [[Deadlock]] (cyclic wait, "deadly embrace") — prevent, avoid, or detect+recover.
- **Recovery** ➔ replay the log: REDO vs UNDO decided by write policy + whether the transaction had COMMITted at crash.

## 6️⃣ NoSQL & MongoDB
- **Why NoSQL** ➔ the 3 Vs overwhelm an RDBMS on ingest AND query; NoSQL drops rigid schema/FKs/JOINs/full ACID to scale **out** (horizontal, commodity servers) vs SQL's **up**.
- **Four models by access pattern** ➔ key-value / document / column-family = aggregation-oriented (whole record fast, relationships dear) · graph = traversal-oriented.
- **MongoDB** ➔ document = JSON/BSON, whole entity without JOIN; **embed** when read-together + stable, **reference** when large/shared/independently updated; update needs `$set` (else replaces the WHOLE document); **no ROLLBACK** — `deleteMany({})` is permanent.

## ⚠️ Top Cross-Unit Traps
- 💡 **π deduplicates, SQL SELECT doesn't** ➔ relational algebra is set-based; SQL needs DISTINCT.
- 💡 **Candidate-key definitions of 2NF/3NF** ➔ quote them over the simplified PK-only versions — the general form is the assessed one.
- 💡 **FK must match the FULL composite PK** ➔ half a composite key is not a valid FK.
- 💡 **DDL is irreversible** ➔ auto-commit means DROP/ALTER can't be rolled back; referenced parents need CASCADE CONSTRAINTS.
- 💡 **Correlated ≠ wrong, just dear** ➔ know when the optimiser question wants "same result, different cost".
