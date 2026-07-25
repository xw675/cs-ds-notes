---
unit: FIT2099
week: 4
parent: "[[Three Core Design Principles (Java)]]"
tags: [SWE/Java, SWE/OOP, Monash/CS_DS]
type: pattern
aliases: [enum, enumeration, named constants, magic number, magic string]
---
# [[Enumerations (Java)]]

**Context:** [[FIT2099_MOC]] · a type-safe fixed set of named constants · the proper fix for the [[Three Core Design Principles (Java)|"avoid excessive literals"]] smell (magic numbers/strings)
**Problem it solves:** represent a value that is one of a small, fixed, unchanging set (seasons, directions, statuses) with compile-time safety.

> [!abstract] Quick Revision
> - **🎯 Trigger:** a variable can only be one of a fixed set of options ➔ an **enum**, not raw int/String literals.
> - **⚡ Key Constraint:** magic numbers/strings have **no compile-time check** — a wrong `2` or a typo `"Burned"` compiles fine and silently breaks logic; an enum makes the compiler reject invalid values.

## 🔧 Minimal Working Example
```java
enum Season { SUMMER, AUTUMN, WINTER, SPRING }   // constants: implicitly public static final

public class Main {
    public static void main(String[] args) {
        Season current = Season.SPRING;
        switch (current) {
            case SUMMER: System.out.println("It's too hot!"); break;
            case SPRING: System.out.println("Magpie swooping season!"); break;   // no "Season." prefix
            default:     System.out.println("Other season"); break;
        }
    }
}
```
**Expected output:** `Magpie swooping season!` — the compiler guarantees `current` is a valid `Season`.

- **Constants are `public static final`** ➔ accessible everywhere, no instance needed, immutable; name them `ALL_UPPERCASE`.
- **`switch` on an enum** ➔ use the bare constant (`case SPRING:`), **not** `Season.SPRING` — Java infers the type.
- **Use for fixed sets** ➔ months, days, directions, statuses — values known at compile time.

## 🔀 Variations — the smell it replaces
- **Magic number** ➔ `if (status == 0)` — `0` has no meaning; a mistaken `2` compiles but inflicts the wrong status.
- **Magic string** ➔ `if (status.equals("burned"))` — still a literal; `"Burned"` (capital B) silently fails, and renaming means find-replace across files.
- **Enum fix** ➔ `if (status == Status.BURNED)` — one source of truth, compiler-checked, rename-safe.

## ⚙️ UML Notation
- **Stereotype** ➔ mark the box `<<enumeration>>` above the name; list constants inside.
- **Relationship** ➔ a class *using* an enum has a **dependency** (dashed open arrow) on it — treat an enum like a simple `DataType` (as you would `Integer`). *FIT2099 note:* you may **omit enums** from class diagrams unless asked, since they're value types.

## ✍️ Practice
> [!QUESTION]- Practice 1: Replace a magic-number status system (`0`=BURNED, `1`=PETRIFIED, `2`=CONFUSED) with an `enum` and a `switch` that prints each effect.
> > [!SUCCESS]- Reference solution
> > ```java
> > enum Status { BURNED, PETRIFIED, CONFUSED }
> > void describe(Status s) {
> >     switch (s) {
> >         case BURNED:    System.out.println("Losing HP over time"); break;
> >         case PETRIFIED: System.out.println("Paralysed with fear"); break;
> >         case CONFUSED:  System.out.println("Hurts themselves"); break;
> >     }
> > }
> > ```
> > - **Key move:** `Status.BURNED` replaces `0`; passing a non-`Status` value now fails to compile instead of silently misbehaving.

## ⚠️ Common Mistakes
- 💡 **`==` vs `.equals()` on the discarded String approach** ➔ comparing strings with `==` tests *identity*, not value — always `.equals()` for strings (see [[Java Data Types, Casting and References]]). Enums sidestep this: `==` is correct and safe for enum constants.
- 💡 **Enum ≠ just prettier ints** ➔ its real value is the **compile-time guarantee**; a typo or out-of-range value can't reach runtime.
