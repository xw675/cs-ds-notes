---
unit: FIT2094
week: 2
parent: "[[Conceptual Model]]"
tags: [CS/Databases, SWE/Design, Monash/CS_DS]
---
# [[Database Design Life Cycle]]

**Context:** [[FIT2094_MOC]] · the four design stages from requirements to physical storage · increasing technology-dependence down the stages · frames where the [[Conceptual Model]] sits

> [!abstract] Quick Revision
> - **🎯 Objective:** refine requirements → conceptual → logical → physical ➔ each stage more implementation-specific.
> - **📦 Core Components:** Requirements ➔ Conceptual (tech-independent) | Logical (DB type) ➔ Physical (DBMS).
> - **⚡ Key Constraint:** technology-independence **decreases** down the stages; requirements errors cascade.

## 📝 Core
### 1. The Four Stages
- **Requirements Definition** ➔ gather data, operations, constraints from stakeholders.
- **Conceptual Design** ➔ high-level [[Conceptual Model]] (entities/attributes/relationships), tech-independent.
- **Logical Design** ➔ map to a **database type** (relational) — [[Conceptual vs Logical Model]].
- **Physical Design** ➔ storage for a specific **DBMS** (tables, files, indexes, access methods).

### 2. Independence Gradient
- **Requirements/Conceptual** ➔ fully technology-independent (*what*, not *how*).
- **Logical** ➔ depends on DB **type**, **not** vendor (same on Oracle/SQL Server).
- **Physical** ➔ depends on the specific **DBMS**.

### 3. Requirements & Views
- **Three forms** ➔ natural language | structured docs | formal/conceptual (business rules, use cases).
- **One central DB** ➔ many stakeholder *views*, no data duplication (each unit/enrolment stored once).

## ⚖️ Core Decision Matrix
| Stage | Deliverable | Depends on |
| :--- | :--- | :--- |
| Requirements | data/ops/constraints | nothing (tech-free) |
| Conceptual | [[Conceptual Model]] / ERD | nothing (tech-free) |
| Logical | relations + keys | DB **type** |
| Physical | storage structures | specific **DBMS** |

> [!NOTE] **When It Flips:** the technology-independent stages let business stakeholders agree on *meaning* before any platform commitment, postponing vendor lock-in to physical design. A single integrated database backs all user views.

## 📊 Exam Execution Trace

### Manual Execution Trace
Classifying dependence per stage:

| Step / State | Stage | Tech-independent? | Bound to |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | Requirements | yes | — |
| 2 | Conceptual | yes | — |
| 3 | Logical | no | DB type |
| 4 | Physical | no | DBMS |

## ⚠️ Common Mistakes
- 💡 **Logical = type-dependent, Physical = vendor-dependent** ➔ a relational logical design is identical on Oracle vs SQL Server; only physical storage differs per DBMS.

## 🧠 Active Recall
> [!FAQ]- Name the four stages and their technology-dependence.
> - **Hint:** Independence decreases down the stages.
> > [!SUCCESS]- Answer
> > - **Short answer:** Requirements + Conceptual (tech-free); Logical (DB type); Physical (specific DBMS).
> > - **Why:** **What vs how** ➔ conceptual states *what* data matter; physical states *how* stored.

> [!FAQ]- Why does the logical model depend on the database type but not the vendor, while the physical depends on the DBMS?
> - **Hint:** Constructs vs storage.
> > [!SUCCESS]- Answer
> > - **Short answer:** Logical uses a type's constructs (relations, PK/FK) — identical across vendors; physical concerns file org/indexes, which each DBMS implements differently.
> > - **Why:** **Vendor-free logic** ➔ an Oracle vs SQL Server relational design is the same at the logical level.
