---
unit: FIT2099
domain: B
week: 6
parent: "[[Encapsulation and Access Modifiers (Java)]]"
tags: [SWE/Java, SWE/Design, SWE/OOP]
type: pattern
aliases: [defensive copying, privacy leak, aliasing, mutable, immutable, escaping reference]
---
# [[Defensive Copying (Java)]]

**Context:** [[FIT2099_MOC]] · protect [[Encapsulation and Access Modifiers (Java)|encapsulation]] when a class holds a **mutable** object · stop callers reaching in through a shared reference
**Problem it solves:** a getter/setter/constructor that passes a mutable private object by reference, letting outside code mutate the class's internal state.

> [!abstract] Quick Revision
> - **🎯 Trigger:** a getter returns a reference to a **mutable** private field (or a setter/constructor stores the caller's object directly) ➔ copy it.
> - **⚡ Key Constraint:** the leak is caused by **aliasing** — two references to the *same* heap object; the caller's alias mutates the class's private state, silently breaking encapsulation.

## 🔧 Minimal Working Example
```java
// PRIVACY LEAK: getFuel() hands out the internal Fraction by reference
public class GasTank {
    private Fraction fuel = new Fraction(1, 1);
    public Fraction getFuel() { return fuel; }              // leak!
}
// caller mutates the tank's private field through the alias:
GasTank tank = new GasTank();
Fraction fuelRead = tank.getFuel();   // same object as tank.fuel
fuelRead.setNumerator(2);             // tank.fuel is now changed from OUTSIDE

// FIX: defensive copy — return a NEW object
public Fraction getFuel() { return new Fraction(fuel); }    // caller gets a copy
```
**Expected output:** with the leak, mutating `fuelRead` corrupts `tank.fuel`; with the copy, changes to the returned `Fraction` leave the original untouched.

- **Mutable vs immutable** ➔ mutable objects can change after construction (`StringBuilder`, `Date`, most of your own classes); immutable can't (`String`, `Integer`) — only **mutable** fields need defending.
- **Where to copy** ➔ any time a mutable object crosses the class boundary: **out** of a getter, **into** a setter, and **into** a constructor.
- **Why** ➔ a private field should be changed **only by its own class**; a shared reference hands that control away.

## ✍️ Practice
> [!QUESTION]- Practice 1: `Meeting` stores a `private Date start`. Its constructor and `getStart()` currently pass the `Date` by reference. Make both defensive.
> > [!SUCCESS]- Reference solution
> > ```java
> > public class Meeting {
> >     private final Date start;
> >     public Meeting(Date start) { this.start = new Date(start.getTime()); }  // copy IN
> >     public Date getStart() { return new Date(start.getTime()); }            // copy OUT
> > }
> > ```
> > - **Key move:** copy on the way **in** (so the caller can't keep a live alias) and on the way **out** (so the returned object isn't the field) — `Date` is mutable.

## ⚠️ Common Mistakes
- 💡 **Only mutable objects leak** ➔ returning a `String`/`int` is safe (immutable/value); a `Date`, array, `List`, or your own settable class is not.
- 💡 **Copy at BOTH ends** ➔ a defensive getter alone still leaks if the constructor/setter stored the caller's original object — defend every crossing.
- 💡 **Reduces connascence** ➔ a leaked reference creates hidden coupling (the caller's changes reach your internals); copying keeps the class in sole control of its state.
