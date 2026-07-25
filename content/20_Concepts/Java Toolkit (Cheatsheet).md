---
unit: FIT2099
domain: B
parent: "[[FIT2099_MOC]]"
tags: [SWE/Java, SWE/OOP, SWE/Design]
type: cheatsheet
aliases: [Java Toolkit, Java Cheatsheet, Java syntax reference, OO Java cheatsheet]
---
# [[Java Toolkit (Cheatsheet)]]

**Context:** [[FIT2099_MOC]] · the **one-note Java coding surface** — code a class from a blank editor after re-reading this. Depth lives in the linked notes.

> [!abstract] Quick Revision
> - **🎯 Objective:** write correct, well-encapsulated OO Java ➔ class anatomy + modifiers + collections + inheritance/interfaces + contracts, with the exam gotchas inline.
> - **⚡ Key Constraint:** Java is **statically typed** (types fixed at declaration, checked at **compile time**) and objects are **reference types** — most FIT2099 bugs come from **reference aliasing**, **`==` vs `.equals()`**, and **access-widening** on override.

## 🧬 Class anatomy (execution order)
```java
package game.actors;                    // 1. package — namespace, MUST be first line
import java.util.ArrayList;             // 2. imports — bring in other packages
import java.util.List;

public class Hero extends Actor implements Speaker {   // 3. class header: one extends, many implements
    public static final int MAX_HP = 100;   // 4. static final constant (class-level, assign-once)
    private int hp;                          // 5. private field — encapsulated state
    private final Armour armour;             // 6. blank final — assigned exactly once (in ctor)

    public Hero(Armour armour) {             // 7. constructor — runs on `new`; same name, no return type
        this.armour = armour;                //    `this` disambiguates field from param
        this.hp = MAX_HP;
    }
    public int getHp() { return hp; }        // 8. query (accessor) — no side effect
    public void takeDamage(int d) { hp -= d; }// 9. command (mutator) — changes state, returns void
    @Override public String speak() { return "For honour!"; }  // 10. override (interface/parent method)
}
```
*(Order on the page: package → imports → class → static fields → instance fields → constructors → methods. Compile-time type checking catches type errors before it runs — see [[Java Static Typing]], [[Java Program Structure]].)*

## 🔑 Modifiers & keywords
| Tool | Micro-syntax | Job / gotcha |
| :--- | :--- | :--- |
| **`public/private/protected`/default** | `private int x;` | visibility; **override can't narrow** access (widening only). [[Encapsulation and Access Modifiers (Java)]] |
| **`static`** | `static int count;` | one shared **class-level** copy; access via `ClassName.x`; static can't see instance members. [[Static and Final (Java)]] |
| **`final` (field)** | `final int N = 5;` | assign-once **constant**; on a **reference** the *object* stays mutable (non-transitive). |
| **`final` (class/method)** | `final class X` | blocks inheritance / overriding. |
| **`this`** | `this.x = x;` | current object; disambiguates field vs parameter. [[Java Constructors]] |
| **`super`** | `super(args); super.m();` | parent constructor / parent method; ctor call must be first line. [[Inheritance (Java)]] |
| **`@Override`** | above method | compiler-checks you really override; catches typos. |
| **`abstract`** | `abstract class`, `abstract void m();` | no-body method; class **can't be instantiated**. [[Abstract Classes (Java)]] |
| **`extends` / `implements`** | `class C extends B implements I,J` | one superclass, **many** interfaces. [[Interfaces (Java)]] |
| **`enum`** | `enum Suit { HEART, SPADE }` | type-safe named constants; fixes magic numbers/strings. [[Enumerations (Java)]] |

## 🔢 Types, casting, equality
| Tool | Micro-syntax | Job / gotcha |
| :--- | :--- | :--- |
| **Primitives** | `int long double boolean char` | value types, stored directly. [[Java Data Types, Casting and References]] |
| **Wrappers** | `Integer Double Boolean` | object versions; needed for generics; watch autoboxing/`null`. |
| **Widening cast** | `double d = anInt;` | implicit, safe. |
| **Narrowing cast** | `int i = (int) aDouble;` | explicit, may lose data. |
| **`==`** | `a == b` | **reference identity** for objects (same object?); value for primitives. |
| **`.equals()`** | `a.equals(b)` | **value equality**; override for your classes. Use for `String`! (String Pool makes `==` *sometimes* work — trap.) |
| **`String`** | `"text"` | immutable reference type. |

## 🔁 Control flow & arrays
```java
if (x > 0) {...} else if (...) {...} else {...}
String s = (x > 0) ? "pos" : "neg";          // ternary
switch (day) { case MON: ...; break; default: ...; }   // break to avoid fall-through
for (int i = 0; i < a.length; i++) {...}     // index loop
for (int v : a) {...}                        // for-each (read)
while (cond) {...}   do {...} while (cond);
int[] a = new int[5];  int[] b = {1,2,3};    // .length, 0-based
```
*(Details: [[Java Control Flow (Conditionals and Loops)]], [[Java Arrays]].)*

## 📦 Collections + generics
| Tool | Micro-syntax | Job / gotcha |
| :--- | :--- | :--- |
| **List** | `List<T> l = new ArrayList<>();` | ordered, **duplicates OK**, index access. |
| **Set** | `Set<T> s = new HashSet<>();` | **no duplicates**, no order (needs `equals`/`hashCode`). |
| **Map** | `Map<K,V> m = new HashMap<>();` | key→value, unique keys. |
| **Ops** | `add / get(i) / contains / size / remove / put / keySet` | `get` is `get(key)` on Map, `get(index)` on List. |
| **Iterate** | `for (T x : list)` · `for (var e : map.entrySet())` | |
| **Program to interface** | declare `List`, instantiate `ArrayList` | swap implementation freely. [[Java Collections (List, Set, Map)]] |

## 🧱 Inheritance · polymorphism · abstraction
| Tool | Micro-syntax | Job / gotcha |
| :--- | :--- | :--- |
| **Inheritance** | `class Dog extends Animal` | **is-a**; reuse + override. [[Inheritance (Java)]] |
| **Override** | `@Override String speak()` | runtime dispatch picks the subclass version. |
| **Upcast** | `Animal a = new Dog();` | polymorphic variable; base type **hides** subclass-only methods. [[Polymorphism (Java)]] |
| **Dynamic dispatch** | `a.speak()` → Dog's | decided at **runtime** by actual object. |
| **Downcast** | `((Dog) a).fetch()` | needs `instanceof` check; **`instanceof` in logic = smell**. [[SOLID Principles (Java)]] |
| **Abstract class** | `abstract class Shape { abstract double area(); }` | shared code + contract; not instantiable. [[Abstract Classes (Java)]] |
| **Interface** | `interface Drawable { void draw(); default void hi(){} }` | pure capability; multiple; `default` methods. [[Interfaces (Java)]] |

## 🛡️ Contracts, errors & robustness
| Tool | Micro-syntax | Job / gotcha |
| :--- | :--- | :--- |
| **throw** | `throw new IllegalArgumentException("msg");` | fail fast on bad **client input** (precondition breach). [[Exceptions, Assertions and Validation (Java)]] |
| **try/catch** | `try {...} catch (SpecificException e) {...}` | catch the **specific** type; keep follow-up (e.g. `i++`) inside `try`. |
| **custom exception** | `class FooException extends Exception {...}` | carry business message/data. |
| **assert** | `assert cond : "msg";` | dev-time **bug** check; **disabled in prod** — never validate user input with it. |
| **Design by Contract** | pre/post/invariant | client meets **pre**, supplier guarantees **post**; invariant holds between calls. [[Design by Contract (Java)]] |
| **Command-Query Separation** | command=`void`, query=returns, no side effect | never both; keeps contract checks safe. [[Command-Query Separation (Java)]] |
| **Scanner trap** | `Integer.parseInt(sc.nextLine())` | `nextInt()` leaves `\n`; mixing with `nextLine()` "skips". |

## 🧩 Design constructs (apply the principles)
| Tool | Micro-syntax / idea | Job / gotcha |
| :--- | :--- | :--- |
| **Encapsulation** | `private` field + accessor | hide state; expose behaviour. [[Encapsulation and Access Modifiers (Java)]] |
| **Composition** | class holds another as a field | **has-a**; prefer over inheritance for reuse. [[Client-Supplier Relationship (Java)]] |
| **Dependency Injection** | pass collaborators via constructor | client depends on an **interface**, not a `new`. [[Dependency Injection (Java)]] |
| **Defensive copying** | copy mutable in ctor & getter | stops **privacy leaks** via aliasing. [[Defensive Copying (Java)]] |
| **Factory Method** | `static Card create(int age)` returns base type | centralise creation; kills `instanceof` ladders. [[Factory Method Pattern (Java)]] |
| **SOLID** | SRP·OCP·LSP·ISP·DIP | the design vocabulary. [[SOLID Principles (Java)]] · [[Design Rationale (FIT2099)]] |

## 🔧 Smell ➔ Java refactoring (quick-map)
| Smell | Java fix |
| :--- | :--- |
| **Type checking** (`switch(type)`) | Replace Conditional with **Polymorphism** (subclass + override) |
| **Data clumps / primitive obsession** | **Extract Class** (group fields into an object) |
| **Feature envy** | **Move Method** to the class owning the data |
| **Shotgun surgery** | consolidate rule into one `private` query / Move Method |
| **Long method / God class** | **Extract Method / Extract Class** (SRP) |
*(Full catalogue: [[Design Smells (Java)]]; discipline: [[Refactoring (Java)]].)*

## ✍️ Integration Practice
> [!QUESTION]- Practice 1: Model `Pet` so cats/dogs each make their own sound, with a factory that builds one from a `String` code, and no `switch(type)` anywhere. (uses: abstract class + polymorphism + Factory Method + collections)
> > [!SUCCESS]- Reference solution
> > ```java
> > abstract class Pet { abstract String sound(); }
> > class Cat extends Pet { String sound() { return "miau"; } }
> > class Dog extends Pet { String sound() { return "guau"; } }
> > class PetFactory {
> >     static Pet create(String code) {
> >         switch (code) { case "C": return new Cat(); case "D": return new Dog();
> >                         default: throw new IllegalArgumentException("bad code"); }
> >     }
> > }
> > List<Pet> zoo = new ArrayList<>();
> > zoo.add(PetFactory.create("C"));  zoo.add(PetFactory.create("D"));
> > for (Pet p : zoo) System.out.println(p.sound());   // miau / guau (dynamic dispatch)
> > ```
> > - **Key move:** the `switch` lives **only** in the factory; behaviour is chosen by **polymorphism**, so a new `Pet` = one subclass + one `case`, no client edits (OCP).

> [!QUESTION]- Practice 2: A `BankAccount` must reject a negative deposit, keep its balance private and un-leakable, and expose a side-effect-free `getBalance()`. (uses: encapsulation + validation/exception + CQS + defensive copy of a mutable field)
> > [!SUCCESS]- Reference solution
> > ```java
> > class BankAccount {
> >     private double balance;
> >     private final List<Transaction> log;
> >     public BankAccount(List<Transaction> initial) {
> >         this.log = new ArrayList<>(initial);          // defensive copy IN
> >     }
> >     public void deposit(double amt) {                 // command
> >         if (amt <= 0) throw new IllegalArgumentException("amount must be > 0");
> >         balance += amt;
> >     }
> >     public double getBalance() { return balance; }    // query — no side effect (CQS)
> >     public List<Transaction> getLog() {
> >         return new ArrayList<>(log);                   // defensive copy OUT — no privacy leak
> >     }
> > }
> > ```
> > - **Key move:** `throw` on precondition breach (fail fast), **command vs query** kept separate, and the mutable `log` is copied both **in and out** so callers can't alias internal state.

## ⚠️ Common Mistakes (top of the deduction list)
- 💡 **`==` on objects/Strings** ➔ compares references; use `.equals()` for value equality.
- 💡 **Access-widening on override** ➔ an override may only **keep or widen** visibility, never narrow.
- 💡 **`instanceof`/`switch(type)` in logic** ➔ a smell — replace with polymorphism.
- 💡 **Returning a mutable field directly** ➔ privacy leak; return a copy.
- 💡 **`assert` for user input** ➔ disabled in prod; use exceptions for client-facing validation.
