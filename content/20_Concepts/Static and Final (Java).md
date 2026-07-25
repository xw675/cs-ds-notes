---
unit: FIT2099
week: [2, 3]
parent: "[[OOP Building Blocks (Class, Object, Field, Method)]]"
tags: [SWE/Java, SWE/OOP]
aliases: [static, final, constant, blank final, non-access modifiers, static final]
---
# [[Static and Final (Java)]]

**Context:** [[FIT2099_MOC]] · the two **non-access** modifiers · `static` = belongs to the class not the object · `final` = assign once, never again

> [!abstract] Quick Revision
> - **🎯 Objective:** **static** ➔ one shared copy at the class level (no object needed); **final** ➔ a binding that can be assigned **exactly once**.
> - **⚡ Key Constraint:** a `static` method can access **only** static fields / its own params/locals — never instance fields or `this`; a `final` **reference** can't be re-pointed, but the object it points to **can still mutate**.

## 📝 Core
### `static` — class-level
- **One copy** ➔ a `static` field is shared by **all** instances; changing `Student.university` once updates what **every** `Student` sees (lives in the class area, not per-object heap).
- **No object needed** ➔ call via the class: `Math.PI`, `Student.university`; this is why [[Java Program Structure|`main`]] is `static`.
- **Access rule** ➔ inside a `static` method there is **no `this`**, so it can touch only static members, parameters, and local variables.
- **Why use it** ➔ meta-object work (count instances, validate before creating), operations tied to the class not any object, and lighter heap use.
- **Why carefully** ➔ breaks pure OO/encapsulation (state escapes any single object), risks conflicts under multiple threads, and **stays in memory until the app terminates**.

#### Static ↔ instance access matrix (same class)
| Caller | Instance method | Instance field | Static method | Static field |
| :--- | :---: | :---: | :---: | :---: |
| **Instance method** | ✔ | ✔ | ✔ | ✔ |
| **Static method** | ✘ | ✘ | ✔ | ✔ |

### `final` — assign once
- **final variable** ➔ can be assigned **once**; a later reassignment is a compile error.
- **Constant** ➔ `static final` in ALL_UPPERCASE: `public static final double PI = 3.14159;` — one shared, immutable, named value.
- **Blank final** ➔ a `final` field left unassigned at declaration **must** be set in **every** constructor path.
- **final reference ≠ deep-frozen** ➔ `final int[] a = {1,2};` — can't rebind `a`, but `a[0] = 9;` is fine (the object's internals still change).
- **final class / method** ➔ `final class` cannot be [[Inheritance (Java)|extended]]; a `final` method cannot be overridden.

## ⚠️ Common Mistakes
- 💡 **static touching instance state** ➔ referencing an instance field (or `this`) from a `static` method won't compile — there may be no object.
- 💡 **"final = immutable object"** ➔ false; `final` freezes the **binding**, not the referenced object's contents.
- 💡 **Blank final unset in a constructor** ➔ if any constructor path leaves a blank final unassigned, it won't compile.

## 🧠 Active Recall
> [!FAQ]- A field is `final`. Does that guarantee the object it refers to cannot change? Why or why not?
> > [!SUCCESS]- Answer
> > - **Short answer:** No. `final` prevents **reassigning the variable** to a different object, but the referenced object's own fields/elements can still be mutated (e.g. `final List` can still `.add(...)`).
> > - **Why:** **Reference non-transitivity** ➔ `final` constrains the binding (the arrow), not the heap object at the other end.
