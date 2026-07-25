---
unit: FIT2094
week: 10
parent: "[[SQL Joins (ANSI)]]"
tags: [CS/Databases, Tool/SQL]
type: pattern
aliases: [Self Join, Outer Join, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN]
---
# [[SQL Self Join and Outer Join]]

**Context:** [[FIT2094_MOC]] · advanced forms of the [[SQL Joins (ANSI)|ANSI join]] · a table joined to itself, and joins that **keep unmatched rows**
**Problem it solves:** resolve a recursive FK (manager) or return rows that have no match on the other side.

> [!abstract] Quick Revision
> - **🎯 Trigger:** a table's FK points to its own PK ➔ self-join with two aliases; must keep unmatched rows ➔ OUTER join.
> - **⚡ Key Constraint:** an INNER/NATURAL join **drops** rows with no match (e.g. a manager-less employee whose `mgrno` is NULL); use LEFT/RIGHT/FULL OUTER to retain them.

## 🔧 Minimal Working Example
```sql
-- self join: e1 = employee, e2 = that employee's manager (same table)
SELECT e1.empno, e1.empname, e1.mgrno, e2.empname AS manager
FROM   payroll.employee e1
JOIN   payroll.employee e2 ON e1.mgrno = e2.empno
ORDER BY e1.empname;
```
**Expected output:** each employee beside their manager's name; KING (NULL `mgrno`) is **excluded** by the inner join.

- **Self join** ➔ join a table to itself; give each copy a **distinct alias** (`e1`, `e2`) so columns are unambiguous.
- **Recursive FK** ➔ classic use: `mgrno` in `EMPLOYEE` references `EMPLOYEE.empno`.
- **INNER (default)** ➔ `JOIN`/`NATURAL JOIN` return **only matched** rows.
- **OUTER** ➔ keep unmatched rows from one/both sides — LEFT / RIGHT / FULL.

## 🔀 Variations
| Join | Keeps | Drops |
| :--- | :--- | :--- |
| **INNER** | matched rows only | all unmatched |
| **LEFT OUTER** | all left + matched right | unmatched right |
| **RIGHT OUTER** | all right + matched left | unmatched left |
| **FULL OUTER** | all rows both sides | nothing |

- **Keep KING** ➔ swap to `LEFT OUTER JOIN payroll.employee e2 ON e1.mgrno = e2.empno` so the manager-less employee is retained (manager shows NULL).

## ✍️ Practice 
> [!QUESTION]- Practice 1: List every employee with their manager's name, **including** those with no manager.
> > [!SUCCESS]- Reference solution
> > ```sql
> > SELECT e1.empname, e2.empname AS manager
> > FROM   payroll.employee e1
> > LEFT OUTER JOIN payroll.employee e2 ON e1.mgrno = e2.empno
> > ORDER BY e1.empname;
> > ```
> > - **Key move:** LEFT OUTER keeps every `e1` row even when `mgrno` has no match (KING → NULL manager).

## ⚠️ Common Mistakes
- 💡 **Self join needs distinct aliases** ➔ without `e1`/`e2` Oracle can't tell which copy a column belongs to.
- 💡 **INNER silently hides unmatched rows** ➔ if a "list everyone" query is missing people, a NULL FK was dropped — switch to an OUTER join.
