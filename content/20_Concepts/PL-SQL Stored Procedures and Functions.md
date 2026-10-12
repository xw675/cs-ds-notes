---
unit: FIT3003
week: 11
source: [slides]
domain: C
parent: "[[SQL Sublanguages (DDL, DML, DCL)]]"
tags: [CS/Databases, Tool/SQL]
aliases: [PL/SQL, PLSQL, Stored Procedure, Stored Function, PL/SQL Block, Cursor FOR Loop, "%TYPE"]
---
# [[PL-SQL Stored Procedures and Functions]]

**Context:** [[FIT3003_MOC]] · the W11 *PL/SQL Revision* deck · the language every trigger in [[Active Data Warehousing]] is written in · the third stored object ➔ [[Database Triggers (Oracle)]] · the cursor-loop route also appears in [[Junk Dimensions]]
**Parent Framework:** [[SQL Sublanguages (DDL, DML, DCL)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** PL/SQL groups SQL statements with procedural syntax (variables, `IF`, loops, cursors) in a `DECLARE … BEGIN … END;` block ➔ stored as a named schema object: a **procedure** (a statement on its own), a **function** (part of an expression, returns a value) or a **trigger** (fired by DML).
> - **📦 Core Components:** `IN` ➔ read only | `OUT` ➔ write only | `IN OUT` ➔ both.
> - **⚡ Key Constraint:** `SELECT … INTO` must find **exactly one** row ➔ none raises `NO_DATA_FOUND`, which ends the block unless an `EXCEPTION` handler catches it.

## 📝 How It Works
### 1. The block
- **Shape** ➔ `DECLARE` locals · `BEGIN` body · optional `EXCEPTION WHEN … THEN` · `END;`.
- **Assignment** ➔ `v_Counter := 7;` — `:=` assigns, `=` compares.
- **Anchored type** ➔ `v_Firstname student.first_name%type` follows the column if it is retyped (`VARCHAR2(20)` ➔ `VARCHAR2(25)`); a hard-coded `VARCHAR2(20)` would truncate or fail. Syntax: `<variable> <table>.<column>%type`.
- **Debug output** ➔ `dbms_output.put_line('Data inserted …');` prints only after `SQL> set serveroutput on;`.
- **Body contents** ➔ `IF`-`THEN`-`ELSE`, loops, cursor fetching, and `INSERT` / `UPDATE` / `DELETE`.

### 2. Control flow
- **Branch** ➔ `IF c THEN … ELSIF c THEN … ELSE … END IF;` (a nested `IF` inside `ELSE` is equivalent).
- **Simple loop** ➔ `LOOP … IF v_Counter > 50 THEN EXIT; END IF; END LOOP;` — the exit test is yours to write.
- **While loop** ➔ `WHILE v_Counter <= 50 LOOP … END LOOP;` — tested before each pass.

### 3. Cursors
- **Context area** ➔ memory Oracle allocates per statement: rows processed, a pointer to the parsed statement, and for a query the **active set** (its result rows).
- **Cursor** ➔ a handle (pointer) to that context area, declared as `CURSOR c IS SELECT …;` among the locals; it may use the procedure's parameters in its `WHERE`.
- **Cursor `FOR` loop** ➔ `FOR rec IN c LOOP … rec.column … END LOOP;` — one pass per active-set row; `rec` is not declared.

### 4. Stored procedures
- **What** ➔ a self-contained schema object grouping SQL statements to perform **one specific task**; called with parameters, it acts, then returns to the caller.
- **Header** ➔ `CREATE [OR REPLACE] PROCEDURE name (p [IN | OUT | IN OUT] type, …) AS` — locals sit between `AS` and `BEGIN`, **no `DECLARE`**; parameters may be anchored (`p_ID students.id%TYPE`).
- **Run / remove** ➔ `EXECUTE name(args);` · `DROP PROCEDURE name;`.
- **Design rules** ➔ one focused task per procedure; never duplicate functionality the database language already provides.

### 5. Stored functions
- **Header** ➔ `CREATE [OR REPLACE] FUNCTION name (…) RETURN type IS` locals `BEGIN … RETURN value; END name;`.
- **Call site** ➔ a procedure call is a statement by itself; a function call sits **inside an expression** — a `SELECT` list (`SELECT department, ClassInfo(department, course) FROM classes;`) or an `IF` test in another block.
- **`RETURN`** ➔ hands control back to the caller **with a value**; the first one reached ends the function.

### 6. Data dictionary
- **List** ➔ `SELECT * FROM user_objects WHERE object_type = 'PROCEDURE';` · **source** ➔ `user_source` · **compile errors** ➔ `user_errors`, each filtered `WHERE name = '…'`.

## ⚙️ Core Implementation
### 🔹 Parameter modes — `ModeTest`
> [!code]- What each mode allows
> ```sql
> CREATE OR REPLACE PROCEDURE ModeTest (
>   p_InParameter    IN     NUMBER,
>   p_OutParameter   OUT    NUMBER,
>   p_InOutParameter IN OUT NUMBER) AS
>   v_LocalVariable NUMBER;
> BEGIN
>   v_LocalVariable  := p_InParameter;     -- legal:   read an IN
>   p_InParameter    := 7;                 -- ILLEGAL: write an IN
>   p_OutParameter   := 7;                 -- legal:   write an OUT
>   v_LocalVariable  := p_OutParameter;    -- illegal per the slides: read an OUT
>   v_LocalVariable  := p_InOutParameter;  -- legal
>   p_InOutParameter := 7;                 -- legal
> END ModeTest;
> ```
> 💡 **Common Mistake:** **Writing to an `IN` parameter** ➔ a compile error, not a silent copy; take a local copy first.

### 🔹 Exception as control flow — `credit_account`
> [!code]- Update if the row exists, insert if `NO_DATA_FOUND`
> ```sql
> CREATE PROCEDURE credit_account (acct NUMBER, credit NUMBER) AS
>   old_balance NUMBER;
>   new_balance NUMBER;
> BEGIN
>   SELECT balance INTO old_balance
>   FROM   accounts WHERE acct_id = acct
>   FOR UPDATE OF balance;                       -- lock the row being changed
>   new_balance := old_balance + credit;
>   UPDATE accounts SET balance = new_balance WHERE acct_id = acct;
> EXCEPTION
>   WHEN NO_DATA_FOUND THEN                      -- account absent: create it
>     INSERT INTO accounts (acct_id, balance) VALUES (acct, credit);
> END credit_account;
> ```
> 💡 **Common Mistake:** **Testing existence with an `IF` after the `SELECT … INTO`** ➔ execution never reaches it; the failed fetch jumps straight to `EXCEPTION`. The active-DW triggers get the same find-or-insert with `select count(*) into IsFound`, which never raises.

### 🔹 Cursor loop inside a procedure — `CheckStudentCompletion`
> [!code]- One pass per student
> ```sql
> CREATE OR REPLACE PROCEDURE CheckStudentCompletion AS
>   CURSOR c_student IS
>     SELECT id, last_name, total_current_credits FROM students;
> BEGIN
>   FOR v_StudentRecord IN c_student LOOP
>     IF v_StudentRecord.total_current_credits > 300 THEN
>       INSERT INTO temp_table (desc_col)
>       VALUES (v_StudentRecord.id || v_StudentRecord.last_name || ' final semester student!');
>     END IF;
>   END LOOP;
> END CheckStudentCompletion;
> ```

### 🔹 Function and its caller — `ClassInfo`
> [!code]- Function body $+$ a procedure that calls it
> ```sql
> CREATE OR REPLACE FUNCTION ClassInfo (
>   p_Department classes.department%TYPE,
>   p_Course     classes.course%TYPE)
>   RETURN VARCHAR2 IS
>   v_CurrentStudents NUMBER;
>   v_MaxStudents     NUMBER;
>   v_PercentFull     NUMBER;
> BEGIN
>   SELECT current_students, max_students INTO v_CurrentStudents, v_MaxStudents
>   FROM   classes WHERE department = p_Department AND course = p_Course;
>   v_PercentFull := v_CurrentStudents / v_MaxStudents * 100;
>   IF    v_PercentFull = 100 THEN RETURN 'Full';
>   ELSIF v_PercentFull > 80  THEN RETURN 'Some Room';
>   ELSIF v_PercentFull > 60  THEN RETURN 'More Room';
>   ELSIF v_PercentFull > 0   THEN RETURN 'Lots of Room';
>   ELSE                           RETURN 'Empty';
>   END IF;
> END ClassInfo;
>
> CREATE OR REPLACE PROCEDURE RecordFullClasses AS
>   CURSOR c_Classes IS SELECT department, course FROM classes;
> BEGIN
>   FOR v_ClassRecord IN c_Classes LOOP
>     IF ClassInfo(v_ClassRecord.department, v_ClassRecord.course) = 'Some Room' THEN
>       INSERT INTO temp_table (char_col)
>       VALUES (v_ClassRecord.department || ' ' || v_ClassRecord.course || ' is almost full!');
>     END IF;
>   END LOOP;
> END RecordFullClasses;
> ```

## ⚖️ Core Decision Matrix
| Object | Invoked by | Header | Hands back | Typical job |
| :--- | :--- | :--- | :--- | :--- |
| Procedure | an explicit call — `EXECUTE`, or a statement in another block | `CREATE PROCEDURE … AS` | `OUT` / `IN OUT` parameters | one focused task (`AddNewStudent`) |
| Function | an **expression** — a `SELECT` list, an `IF` test | `CREATE FUNCTION … RETURN type IS` | one value via `RETURN` | a computed value or label per row (`ClassInfo`) |
| Trigger | the **system**, on `INSERT` / `UPDATE` / `DELETE` of its table | `CREATE TRIGGER … {BEFORE \| AFTER \| INSTEAD OF} … ON t` | nothing — acts through DML | enforce rules, maintain derived tables ➔ [[Database Triggers (Oracle)]] |

| Mode | Caller passes | Body may read | Body may write |
| :--- | :--- | :--- | :--- |
| `IN` | a value | ✅ | ❌ |
| `OUT` | a variable to fill | ❌ *(per the slides)* | ✅ |
| `IN OUT` | an initialised variable | ✅ | ✅ |

> [!NOTE] **When It Flips:** need the result **inside a query** ➔ function; need several results, or the work itself is the point ➔ procedure with `OUT` parameters; no one should have to remember to call it ➔ trigger.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace — `ClassInfo` boundaries ($\text{max\_students} = 50$)
| current_students | $v\_PercentFull$ | First true branch | Returns |
| :--- | :--- | :--- | :--- |
| $50$ | $100$ | $= 100$ | `'Full'` |
| $45$ | $90$ | $> 80$ | `'Some Room'` |
| $40$ | $80$ | $> 60$ — $80$ is **not** $> 80$ | `'More Room'` |
| $30$ | $60$ | $> 0$ — $60$ is **not** $> 60$ | `'Lots of Room'` |
| $0$ | $0$ | `ELSE` | `'Empty'` |

- **Boundary reading** ➔ strict `>` sends an exact $80\%$ or $60\%$ **down** a band; `ELSIF` stops at the first true test, so order the tests from the highest threshold down.

## ⚠️ Common Mistakes
- 💡 **`DECLARE` inside a procedure or function** ➔ their locals go after `AS` / `IS`; `DECLARE` belongs to anonymous blocks and triggers.
- 💡 **Unquoted `object_type = PROCEDURE`** ➔ the slide's form is read as a column name and fails; quote it: `'PROCEDURE'`.

## 🧠 Active Recall
> [!FAQ]- `ClassInfo` can appear in a `SELECT` list; `AddNewStudent` cannot. Why?
> > [!SUCCESS]- Answer
> > - **Short answer:** a function returns a value and is called **as part of an expression**; a procedure returns nothing and is a **statement on its own**.
> > - **Why:** **A `SELECT` list is a list of expressions** ➔ each item must evaluate to a value per row, which `RETURN VARCHAR2` guarantees. **A procedure hands results back through parameters** ➔ there is no value to place in a column, so it is run with `EXECUTE` or as a line in another block.

> [!FAQ]- Why declare `v_Firstname student.first_name%type` instead of `VARCHAR2(20)`?
> > [!SUCCESS]- Answer
> > - **Short answer:** `%type` ties the variable to the column's current definition, so a later `ALTER` cannot break the code.
> > - **Why:** **Hard-coded types go stale** ➔ widening `first_name` to `VARCHAR2(25)` leaves a `VARCHAR2(20)` variable too small for new values. **Anchoring is resolved at compile time** ➔ recompiling picks up the new type with no edit. **Same idea in triggers** ➔ `Degree Student.DegreeCode%type` in [[Active Data Warehousing]].

> [!FAQ]- `credit_account(999, 50)` runs when account 999 does not exist. Trace what happens.
> > [!SUCCESS]- Answer
> > - **Short answer:** the `SELECT … INTO` finds no row, raises `NO_DATA_FOUND`, and the handler inserts account 999 with balance $50$.
> > - **Why:** **The fetch is the existence test** ➔ the `UPDATE` line is skipped entirely, because control jumps to `EXCEPTION` the moment the fetch fails. **The handler is the else-branch** ➔ insert-if-absent, update-if-present in one procedure with no `IF`.
