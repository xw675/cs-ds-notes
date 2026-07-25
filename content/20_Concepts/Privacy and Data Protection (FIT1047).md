---
unit: FIT1047
week: 12
parent: "[[Information Security and Cryptography]]"
tags: [CS/Security, Ethics/Professional]
aliases: [privacy, PETs, privacy enhancing technologies, you are the product, cookie pop-ups, ring signatures, data profiling, tracking]
---
# [[Privacy and Data Protection (FIT1047)]]

**Context:** [[Information Security and Cryptography]] · the closing theme — protecting **personal data** in the big-data age · the systems/ethics view (cf. [[Privacy, Confidentiality, and Security]], [[Personal Data and Privacy in Database Design]])

> [!abstract] Quick Revision
> - **🎯 Objective:** in the **big-data** age companies build vast **cross-linked profiles** ➔ minimise what you expose; **privacy** and **cybersecurity** reinforce each other.
> - **⚡ Key Constraint:** strong **PETs exist but are rarely used** (enterprises **want** the data), and **cookie pop-ups target compliance, not traceability** — the protection gap is by design.

## 📝 The privacy problem
- **Big data** ➔ companies build **large user profiles**; **cross-company linking** amplifies them; **one photo** can identify you and link profiles.
- **"You are the product"** ➔ if a commercial product is **"free"**, your **data** is what's being sold.
- **Profile contents** ➔ name/age/address history, shopping/travel/**location**, friends, likes, political opinion, hobbies, education, **emails read, sites visited, form data (even unsubmitted)**, medical history…

## 🔐 Privacy enhancing technologies (PETs)
- **Exist but underused** ➔ strong PETs are available; enterprises' data appetite means they're **usually not deployed**.
- **Advanced cryptography** ➔ **group/ring signatures** give **authenticity while preserving privacy** (prove membership without revealing identity).
- **Cookie pop-ups** ➔ built for **legal compliance**, **not** to reduce tracking.

## 🛠️ What you can do
- **Browser controls** ➔ don't auto-load external email images; **block third-party/non-essential cookies** (delete on exit); use plugins (**NoScript**, Facebook Container).
- **Privacy-oriented tools** ➔ e.g. **Signal** over WhatsApp.
- **Awareness + choice** ➔ know where data is collected (fitness trackers, reward points, app permissions); **decline** some services.

## 🔗 Privacy ⟷ cybersecurity
- **Same direction** ➔ many privacy choices **also improve security** — **smaller attack surface**, **less data to misuse/leak**.

## ⚠️ Common Mistakes
- 💡 **Compliance ≠ protection** ➔ a cookie banner satisfies the law but **doesn't reduce traceability**; don't mistake consent theatre for privacy.
- 💡 **Privacy is not opposed to security** ➔ data minimisation shrinks both the **privacy** exposure and the **breach** impact — they align, not conflict.

## 🧠 Active Recall
> [!FAQ]- How can privacy-protecting choices simultaneously improve an organisation's cybersecurity?
> > [!SUCCESS]- Answer
> > - **Short answer:** collecting and retaining **less personal data** means a **smaller attack surface** and **less data available to be stolen or misused** if a breach occurs — a privacy win *is* a security win.
> > - **Why:** **Data minimisation** ➔ every profile field not stored is one an attacker cannot exfiltrate; PETs (e.g. **ring signatures**) further limit linkable identity, reducing both privacy harm and breach impact.
