---
unit: FIT2094
domain: C
week: 6
parent: "[[Database Design Life Cycle]]"
tags: [CS/Databases, SWE/Design, Ethics/Privacy]
aliases: [Data Minimisation, Privacy by Design]
---
# [[Personal Data and Privacy in Database Design]]

**Context:** [[FIT2094_MOC]] · governs *which* attributes a design should even hold · shapes nullability and [[Column Value Constraints (Check vs Lookup)|value constraints]] · a design-quality concern, not a syntax one

> [!abstract] Quick Revision
> - **🎯 Objective:** collect only what the business purpose requires ➔ minimise personal-data attributes and justify each one.
> - **⚡ Key Constraint:** the **client/business owner decides** what is stored — the designer advises but does not unilaterally add personal fields.

## 📝 Core
- **Data minimisation** ➔ only store attributes a stated business purpose needs; every personal field must have a *why*.
- **Legal frame** ➔ privacy and anti-discrimination laws regulate collection/storage of personal information.
- **Four disclosures** ➔ tell customers *what* is collected, *why*, *how used*, *how protected*.
- **Interrogate each field** ➔ title/gender (title may imply gender) · date of birth (maybe only age check needed) · language (marketing use vs bias/discrimination risk).
- **Necessity over convenience** ➔ e.g. drones rental: name/contact/email justified by rentals; DOB only if an age requirement exists.

## ⚠️ Common Mistakes
- 💡 **"Useful for marketing" ≠ justified** ➔ a field that enables profiling (e.g. language, gender) can introduce bias/discrimination; weigh benefit vs harm, don't collect by default.
- 💡 **Designer ≠ decision-maker** ➔ do not add sensitive attributes on your own judgement; confirm the business need with the client.

## 🧠 Active Recall
> [!FAQ]- A client asks to store customers' date of birth. What must you establish before adding the column?
> > [!SUCCESS]- Answer
> > - **Short answer:** The specific business purpose — if only age verification is needed, storing full DOB may be unnecessary; collect the minimum that satisfies the purpose.
> > - **Why:** **Data minimisation** ➔ personal data is regulated; each attribute needs a documented, disclosed reason, and the client owns that decision.
