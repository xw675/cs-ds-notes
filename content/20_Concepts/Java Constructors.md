---
unit: FIT2099
week: 1
parent: "[[OOP Building Blocks (Class, Object, Field, Method)]]"
tags: [SWE/Java, SWE/OOP, Monash/CS_DS]
type: pattern
aliases: [Constructor, this keyword, Declaration Instantiation Initialisation]
---
# [[Java Constructors]]

**Context:** [[FIT2099_MOC]] · how an [[OOP Building Blocks (Class, Object, Field, Method)|object]] is built and initialised · runs on `new` · sets the [[Java Data Types, Casting and References|fields]]
**Problem it solves:** create an object and initialise its fields, optionally offering several ways to construct it.

> [!abstract] Quick Revision
> - **🎯 Trigger:** need to build/initialise an object ➔ define a constructor (same name as the class, **no return type**).
> - **⚡ Key Constraint:** a constructor runs **every time** you `new` an object; if you write none, Java gives a **default zero-argument** one that does nothing.

## 🔧 Minimal Working Example
```java
class CoffeeMachine {
    String brand;

    CoffeeMachine() {}                    // 1. empty (zero-arg) constructor
    CoffeeMachine(String newBrand) {      // 2. with an argument (overload)
        this.brand = newBrand;            // this.brand = the current object's field
    }
}
// usage
CoffeeMachine defaultCM = new CoffeeMachine();          // calls #1
CoffeeMachine nespresso = new CoffeeMachine("Nespresso"); // calls #2
```
**Expected output:** two objects; `nespresso.brand` = `"Nespresso"`, `defaultCM.brand` = `null`.

- **Name & return** ➔ a constructor is a **special method named exactly like the class**, with **no return type** (not even `void`).
- **Default** ➔ every class has a zero-arg constructor; Java supplies one if you don't — but adding a parameterised one **removes** the free default (add it back explicitly).
- **`this`** ➔ refers to the **current object**; `this.brand = newBrand` disambiguates the field from the parameter.
- **Overloading** ➔ multiple constructors with different parameter lists — pick the one whose arguments match.

## 🔀 Variations
- **The three D's** ➔ **Declaration** (`Integer x;` — name + type), **Instantiation** (`new Integer(42)` — build the object), **Initialisation** (assign it: `x = new Integer(42)`).
- **All in one line** ➔ `Integer theAnswer = new Integer(42);`.

## ✍️ Practice
> [!QUESTION]- Practice 1: A `Student` has a `name` and an `id`. Provide a no-arg constructor and one that sets both fields.
> > [!SUCCESS]- Reference solution
> > ```java
> > class Student {
> >     String name;
> >     int id;
> >     Student() {}
> >     Student(String name, int id) {
> >         this.name = name;
> >         this.id = id;
> >     }
> > }
> > ```
> > - **Key move:** overloaded constructors; `this.field = param` to store the arguments.

## ⚠️ Common Mistakes
- 💡 **No return type on a constructor** ➔ writing `void CoffeeMachine()` makes it a *method*, not a constructor — the object won't initialise as expected.
- 💡 **Declared but not initialised = crash/error** ➔ `Integer x; System.out.println(x);` fails ("might not have been initialized"); declaration alone reserves the name, not a value.
