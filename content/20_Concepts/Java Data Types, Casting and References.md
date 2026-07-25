---
unit: FIT2099
domain: B
week: [1, 4]
parent: "[[OOP Building Blocks (Class, Object, Field, Method)]]"
tags: [SWE/Java, SWE/OOP]
aliases: [Primitive Types, Reference Types, Type Casting, Value vs Reference, Java Scope]
---
# [[Java Data Types, Casting and References]]

**Context:** [[FIT2099_MOC]] · what a [[OOP Building Blocks (Class, Object, Field, Method)|field/variable]] can hold and how it's stored · primitives vs objects · [[Java Static Typing|statically typed]]

> [!abstract] Quick Revision
> - **🎯 Objective:** classify a variable as primitive or reference ➔ primitives store a **value**, references store a **pointer** to a heap object.
> - **📦 Core Components:** 8 primitives + `String`/classes | value vs reference | widening (auto) vs narrowing (manual) casts | class vs local scope.
> - **⚡ Key Constraint:** the value-vs-reference distinction — `int i = 5` holds 5; `Integer i = new Integer(5)` holds an **address** to a heap block.

## 📝 How It Works
### 1. Primitive Types (store a value directly)
- **Integers** ➔ `byte`(8) · `short`(16) · `int`(32) · `long`(64) bits.
- **Floating point** ➔ `float`(32-bit IEEE) · `double`(64-bit IEEE).
- **Other** ➔ `boolean` (true/false) · `char` (single Unicode char).
- **Not classes** ➔ primitives have no attributes/methods.

### 2. Reference Types (store a pointer)
- **Classes/interfaces** ➔ `String` (capital S — a **class**, not a primitive), plus any class you define.
- **Value vs reference** ➔ a primitive variable *is* its value; a reference variable holds the **address** of a heap-allocated object that stores the attributes.
- **A class is (almost) a type** ➔ you declare variables of it: `MilkContainer mc;` (a reference, initially null).

### 3. Casting
- **Widening (automatic)** ➔ smaller → larger: `byte → short → char → int → long → float → double`; `double d = anInt;`.
- **Narrowing (manual)** ➔ larger → smaller needs an explicit cast: `int i = (int) aDouble;` (may lose data).

### 4. Scope
- **Class variable/field** ➔ declared in the class, visible to all its methods.
- **Local variable** ➔ declared inside a method/block `{}`, exists only there.

### 5. Equality: `==` vs `.equals()`
- **`==`** ➔ compares the **reference** (memory address) — are these the *same object*?
- **`.equals()`** ➔ compares the **value** (e.g. a `String`'s character sequence) — do they *mean the same*?
- **String Pool** ➔ Java shares identical string **literals**, so `"test" == "test"` is `true` (same pooled address); but `new String("test") == new String("test")` is `false` (two distinct heap objects), while `.equals()` is `true` for both.
- **Rule** ➔ for objects (especially `String`), always use `.equals()` for value comparison; reserve `==` for primitives and identity checks.

## ⚖️ Core Decision Matrix
| | Primitive (`int`) | Reference (`Integer`, `String`, your class) |
| :--- | :--- | :--- |
| **stores** | the value itself | an address (pointer) to a heap object |
| **has methods?** | no | yes (it's an object) |
| **default** | `0`/`false` | `null` |

> [!NOTE] **When It Flips:** widening is safe (no data loss) so Java does it automatically; narrowing can truncate, so Java forces you to *ask* for it with `(type)` — the cast is you accepting the risk.

## 🧠 Active Recall
> [!FAQ]- What's the difference in what an `int` variable and an `Integer` variable actually store?
> > [!SUCCESS]- Answer
> > - **Short answer:** An `int` (primitive) stores the value `5` directly in its memory slot; an `Integer` (reference type) stores an **address** pointing to a heap block that holds the object's data.
> > - **Why:** **Value vs reference** ➔ primitives are the value; objects are reached through a pointer, which matters for aliasing and equality later.

> [!FAQ]- Why is `double d = anInt;` allowed automatically but `int i = aDouble;` is not?
> > [!SUCCESS]- Answer
> > - **Short answer:** int→double is **widening** (no data lost), so it's automatic; double→int is **narrowing** (fraction lost), so it needs an explicit cast `(int)`.
> > - **Why:** **Safe vs lossy** ➔ Java auto-converts only when the larger type can hold every value of the smaller.

> [!FAQ]- `new String("test") == new String("test")` is `false`, but `.equals()` is `true`. Why?
> > [!SUCCESS]- Answer
> > - **Short answer:** `==` compares **addresses**; `new` forces two separate heap objects, so their addresses differ. `.equals()` compares the **character values**, which are identical.
> > - **Why:** **Identity vs value** ➔ literal strings are pooled (shared address, so `==` is `true`), but `new` bypasses the pool — always use `.equals()` for string value comparison.
