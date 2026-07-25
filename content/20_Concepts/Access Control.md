---
unit: FIT1047
week: 11
parent: "[[Information Security and Cryptography]]"
tags: [CS/Security]
aliases: [access control, access rights, ACL, access control list, Kerberos, Active Directory, single sign-on, SSO, privilege escalation, ticket-based]
---
# [[Access Control]]

**Context:** [[Information Security and Cryptography]] · *who* (persons, processes, devices) may do *what* to which resources · the step **after** [[User Authentication and Passwords|authentication]]

> [!abstract] Quick Revision
> - **🎯 Objective:** decide **who has access to which resources** (read/write/execute) once identity is known ➔ enforce it manageably at scale.
> - **⚡ Key Constraint:** raw **ACLs don't scale** ($1000$ staff × $200$ apps ≈ **2 million** entries); the fix is **ticket/token-based** control (Kerberos, Active Directory) — but that central server becomes the prime target.

## 📝 Access rights
- **What users may do** ➔ **read, write/change, execute** (many variants).
- **Granularity** ➔ can be per **user**, per **group**, or by **role / attributes** (e.g. "all Monash students may access this site").
- **ACLs (Access Control Lists)** ➔ list **who is allowed to do what**; simple but **scale badly** — the $1000 \times 200 = 2\,000\,000$ entries must be maintained across the network.

## 🎫 Making it manageable
- **Ticket / token-based** ➔ a **central server** checks authenticity and issues a **ticket** carrying identity info and possibly **restricted capabilities**. Examples: **Kerberos**, **Microsoft Active Directory**.
- **Kerberos flow** ➔ client → **Authentication Server (AS)**: request access, get ticket → client → **Service Server (SS)**: show ticket → response.
- **Single sign-on (SSO)** ➔ log in **once**, access many services (e.g. Monash). **Pro:** high usability. **Con:** a **single point of failure** — a top target for intruders, so it needs a secure implementation.

## 🛡️ Why it matters & how it fails
- **Goal** ➔ **limit the damage** any user/group can do; **privilege escalation** is a core attacker objective.
- **Circumvention** ➔ software/interface/protocol weaknesses; **physical attacks** (pull the disk, tap internal buses); **race conditions / feature interaction**; **plugging in devices (USB)**; **social engineering**.
- **Extra mechanisms** ➔ disk encryption, backups, security updates, **reduce services/complexity**, **Trusted Computing** (security hardware), disconnect critical devices.

## ⚠️ Common Mistakes
- 💡 **Authentication ≠ authorisation** ➔ proving *who you are* ([[User Authentication and Passwords]]) is separate from *what you may do* (access control); an exam answer must keep them distinct.
- 💡 **SSO convenience = concentrated risk** ➔ one login for everything means one compromise exposes everything → it demands the strongest protection, not the weakest.

## 🧠 Active Recall
> [!FAQ]- Why do large organisations move from ACLs to ticket-based systems like Kerberos?
> > [!SUCCESS]- Answer
> > - **Short answer:** ACLs require an entry **per (user × resource)**, exploding to millions of entries ($1000$ staff × $200$ apps) that must be maintained network-wide — unmanageable and error-prone.
> > - **Why:** **Central issuance** ➔ a ticket server authenticates once and issues **capability-bearing tickets**, so services trust the ticket instead of each holding a giant list — at the cost of a **single high-value target** needing strong protection.
