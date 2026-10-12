---
unit: FIT3003
week: 11
source: [slides]
domain: C
parent: "[[PL-SQL Stored Procedures and Functions]]"
tags: [CS/Databases, Tool/SQL]
aliases: [Trigger, Database Trigger, Row-Level Trigger, Statement-Level Trigger, INSTEAD OF Trigger, ":new and :old", RAISE_APPLICATION_ERROR]
---
# [[Database Triggers (Oracle)]]

**Context:** [[FIT3003_MOC]] · the PL/SQL object the system runs for you · the engine of [[Active Data Warehousing]] · sibling of procedures and functions ➔ [[PL-SQL Stored Procedures and Functions]]
**Parent Framework:** [[PL-SQL Stored Procedures and Functions]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a self-contained routine attached to a table that runs **automatically** ("fires") when a row is inserted, updated or deleted ➔ never called directly; exam payload = choose timing $\times$ level $\times$ event, and read `:old` / `:new` correctly.
> - **📦 Core Components:** **timing** `BEFORE` / `AFTER` / `INSTEAD OF` | **level** statement (once per DML statement) / row (`FOR EACH ROW`, once per affected row) | **event** `INSERT` / `UPDATE [OF col]` / `DELETE`, combinable with `OR`.
> - **⚡ Key Constraint:** `:new` does not exist for `DELETE`, and `:old` is the row being updated or deleted ➔ an increment on insert reads `:new`, a decrement on delete reads `:old`.

## 📝 How It Works
### 1. Trigger vs procedure
- **Who runs it** ➔ trigger: executed **automatically by the system** on DML; procedure: called **explicitly** by a user program.
- **Why use one** ➔ automatic enforcement of data restrictions (only valid values reach a column) · less application maintenance: change the trigger once and **every** application using the table follows, with no recompile or re-link.

### 2. Anatomy
```sql
CREATE [OR REPLACE] TRIGGER <trigger_name>
  {BEFORE | AFTER | INSTEAD OF}
  {INSERT | UPDATE | DELETE} [OF <column>] ON <table>
  [FOR EACH ROW]
[DECLARE <locals>]
BEGIN
  <trigger body>
END <trigger_name>;
```
- **Combined events** ➔ `BEFORE INSERT OR UPDATE ON students`; **column-scoped** ➔ `AFTER … UPDATE OF deptno, sal ON emp` fires only when those columns are updated.
- **Level** ➔ omit `FOR EACH ROW` ➔ statement-level, once per triggering statement; with it ➔ row-level, and only row-level triggers see `:old` / `:new`.
- **`INSTEAD OF`** ➔ defined on a **view**; the body runs in place of the DML, translating it onto the base tables.
- **Locals** ➔ a trigger opens them with `DECLARE`, unlike a procedure.

### 3. Context variables
| Event | `:old.col` | `:new.col` |
| :--- | :--- | :--- |
| `INSERT` | no previous row | the values being inserted |
| `UPDATE` | the values before the change | the values after the change |
| `DELETE` | the row being deleted | not used |
- **Before/after comparison** ➔ `:old.deptno != :new.deptno` detects an employee changing department.
- **Writing `:new`** ➔ a `BEFORE` row trigger can set a column of the row about to be stored (`SELECT seq.nextval INTO :new.ID FROM dual`).
- **The colon** ➔ belongs to `:old` / `:new` only; locals are written bare.

### 4. Event predicates and veto
- **`INSERTING` / `UPDATING` / `DELETING`** ➔ booleans that branch a multi-event trigger by which DML fired it.
- **`RAISE_APPLICATION_ERROR(-20000, 'Cannot perform the operation')`** ➔ shows the message and **cancels** the triggering operation; placed in a `BEFORE` trigger it stops the row before it changes.
- **Inspect** ➔ `SELECT trigger_type, table_name, triggering_event FROM user_triggers WHERE trigger_name = 'TOTAL_SALARY';`.

## ⚙️ Core Implementation
### 🔹 Auto-ID from a sequence
> [!code]- `GenerateStudentID`
> ```sql
> CREATE OR REPLACE TRIGGER GenerateStudentID
>   BEFORE INSERT OR UPDATE ON students
>   FOR EACH ROW
> BEGIN
>   SELECT student_sequence.nextval INTO :new.ID FROM dual;
> END GenerateStudentID;
> ```
> 💡 **Common Mistake:** **The slide's `OR UPDATE`** ➔ every update of a student — even a name fix — overwrites `ID` with a fresh sequence value and orphans its child rows; an ID generator wants `BEFORE INSERT` only ➔ [[Surrogate Key]].

### 🔹 Keeping a summary column in step — `total_salary`
> [!code]- One trigger, three events *(slide bugs fixed)*
> ```sql
> CREATE OR REPLACE TRIGGER total_salary
>   AFTER DELETE OR INSERT OR UPDATE OF deptno, sal ON emp
>   FOR EACH ROW
> BEGIN
>   IF DELETING OR (UPDATING AND :old.deptno != :new.deptno) THEN   -- leaves old dept
>     UPDATE dept SET total_sal = total_sal - :old.sal WHERE deptno = :old.deptno;
>   END IF;
>   IF INSERTING OR (UPDATING AND :old.deptno != :new.deptno) THEN  -- joins new dept
>     UPDATE dept SET total_sal = total_sal + :new.sal WHERE deptno = :new.deptno;
>   END IF;
>   IF UPDATING AND :old.deptno = :new.deptno AND :old.sal != :new.sal THEN
>     UPDATE dept SET total_sal = total_sal - :old.sal + :new.sal WHERE deptno = :new.deptno;
>   END IF;
> END;
> ```
> 💡 **Common Mistake:** **Copying the slide verbatim** ➔ it adds `:new.deptno` (a department number) to the salary total and writes `new.sal` without its colon; the add is `:new.sal`.

### 🔹 Making an aggregate view deletable — `INSTEAD OF`
> [!code]- `room_summary_delete`
> ```sql
> CREATE VIEW room_summary AS
>   SELECT building, sum(number_seats) total_seats FROM rooms GROUP BY building;
>
> CREATE TRIGGER room_summary_delete
>   INSTEAD OF DELETE ON room_summary
>   FOR EACH ROW
> BEGIN
>   DELETE FROM rooms WHERE building = :old.building;   -- one summary row ➔ all its rooms
> END room_summary_delete;
> ```
> 💡 **Common Mistake:** **Expecting `:new` here** ➔ a delete has only `:old`, which carries the **view's** columns (`building`, `total_seats`).

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace — the four types on one `UPDATE`
`classes_BStatement` (`BEFORE UPDATE`), `classes_AStatement` (`AFTER UPDATE`), `classes_BRow` and `classes_ARow` (`… FOR EACH ROW`) each insert `(trigger_seq.NEXTVAL, '<their name>')` into `temp_table`. An `UPDATE classes …` that changes **2** rows logs, in Oracle's firing order:

| `num_col` | `char_col` | Why here |
| :--- | :--- | :--- |
| $1$ | Before Statement trigger | once, before any row is touched |
| $2$ | Before Row trigger | row 1, before its change |
| $3$ | After Row trigger | row 1, after its change |
| $4$ | Before Row trigger | row 2 |
| $5$ | After Row trigger | row 2 |
| $6$ | After Statement trigger | once, after the last row |

- **Count rule** ➔ $n$ affected rows ⟹ $2 + 2n$ log rows; an `UPDATE` matching **no** rows still logs the two statement-level lines.

## ✍️ Practice
> [!QUESTION]- Practice 1: `EMPLOYEE(FNAME, LNAME, SSN, …, DEPTNO)` and `DEPARTMENT(DNAME, DEPTNO, MGRSSN, MGRSTARTDATE)`; Wong (`333445555`) manages Research, Smith (`123456789`) manages nothing. Write a trigger that rejects deleting an employee who currently manages a department, then predict both deletes.
> > [!SUCCESS]- Reference solution
> > ```sql
> > CREATE OR REPLACE TRIGGER delete_emp
> >   BEFORE DELETE ON Employee
> >   FOR EACH ROW
> > DECLARE
> >   empCount NUMBER;
> > BEGIN
> >   SELECT COUNT(*) INTO empCount
> >   FROM   Department D
> >   WHERE  D.mgrssn = :old.ssn;
> >   IF empCount > 0 THEN
> >     RAISE_APPLICATION_ERROR(-20000, 'Cannot delete employee...');
> >   END IF;
> > END delete_emp;
> > ```
> > - **Outcomes:** `DELETE FROM Employee WHERE ssn = '333445555'` ➔ error, Wong stays · `… WHERE ssn = '123456789'` ➔ Smith deleted.
> > - **Key move:** `BEFORE DELETE` $+$ `:old.ssn` — the row is still there to inspect, and the veto lands before it goes.

## ⚠️ Common Mistakes
- 💡 **Statement-level trigger for per-row maintenance** ➔ without `FOR EACH ROW` there is no `:new`, and it fires once whether $1$ or $1000$ rows changed — a fact count would move by one per statement.
- 💡 **🔭 `COMMIT` inside a trigger** *(not in the slides)* ➔ every Chapter 18 trigger ends with `commit;`, but Oracle rejects it at run time (ORA-04092): a trigger runs inside the transaction of the DML that fired it, so that transaction commits or rolls back as a whole. Exam: follow the slides; live lab: drop the line.
- 💡 **🔭 Lower-case names in dictionary queries** *(not in the slides)* ➔ Oracle stores unquoted names in upper case, so the slides' `WHERE trigger_name = 'total_salary'` and `name = 'AddNewStudent'` return nothing; match `'TOTAL_SALARY'`, `'ADDNEWSTUDENT'`.

## 🧠 Active Recall
> [!FAQ]- Why must `GenerateStudentID` be a `BEFORE` trigger rather than `AFTER`?
> > [!SUCCESS]- Answer
> > - **Short answer:** it **writes** `:new.ID`, which is only meaningful while the row has not yet been stored.
> > - **Why:** **`BEFORE` shapes the row** ➔ assigning `:new.ID` changes what the `INSERT` writes. **`AFTER` only observes** ➔ the row is already in the table, so changing `:new` there cannot alter it; follow-on work (inserting into a fact, updating a total) belongs in `AFTER`.

> [!FAQ]- One `UPDATE` moves an employee from dept 5 to dept 4 **and** raises their salary $30000 \to 35000$. Which branches of `total_salary` fire, and what do the totals do?
> > [!SUCCESS]- Answer
> > - **Short answer:** branches 1 and 2 fire: dept 5 loses $30000$, dept 4 gains $35000$; branch 3 does not.
> > - **Why:** **Branch 1** ➔ `UPDATING` and $5 \ne 4$ ⟹ subtract `:old.sal` $= 30000$ from `:old.deptno` $= 5$. **Branch 2** ➔ same test ⟹ add `:new.sal` $= 35000$ to `:new.deptno` $= 4$. **Branch 3** ➔ needs equal departments, so it is skipped — the move already carried the new salary.

> [!FAQ]- When would you pick `INSTEAD OF` over `BEFORE` / `AFTER`?
> > [!SUCCESS]- Answer
> > - **Short answer:** when the target is a **view** whose DML the database cannot apply itself, such as an aggregate.
> > - **Why:** **An aggregated row has no single base row** ➔ deleting `room_summary`'s `'Building A'` row means nothing to Oracle. **The trigger supplies the meaning** ➔ "delete every room in that building", using `:old.building`. **`BEFORE` / `AFTER` assume the DML happens** ➔ `INSTEAD OF` replaces it.
