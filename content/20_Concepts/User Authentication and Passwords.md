---
unit: FIT1047
domain: F
week: 11
parent: "[[Information Security and Cryptography]]"
tags: [CS/Security]
aliases: [authentication, user authentication, passwords, authentication factors, something you know, salted hash, rainbow table, password storage]
---
# [[User Authentication and Passwords]]

**Context:** [[Information Security and Cryptography]] · authenticating a **human to a system** (login) — distinct from [[Authentication, Certificates and PKI|certificate-based]] machine authentication · the first step of [[Access Control]]

> [!abstract] Quick Revision
> - **🎯 Objective:** prove **who** wants access ➔ at **login** (who may use the system) and again for **critical transactions** (re-check); the answer feeds [[Access Control]].
> - **⚡ Key Constraint:** **never store passwords in cleartext**; a plain hash is still beaten by **rainbow tables**, so the exam-critical answer is a **per-user salted hash**.

## 📝 Authentication factors
- **Three factor types** ➔ **something you know** (password, PIN) · **something you have** (phone, hardware token) · **something you are / other** (fingerprint, location).
- **Passwords dominate** ➔ still the **most common** mechanism despite known weaknesses.
- **Two moments** ➔ **identify at login** (who can use the computer/app) + **authenticate particular transactions** (re-check for critical actions, e.g. bank transfers).

## ⚠️ Problems with passwords
- **Reuse** ➔ one breach cascades across sites.
- **Weak passwords** ➔ guessable / brute-forceable.
- **Theft** ➔ **phishing** or **malware** capture them.
- **Stored passwords** ➔ a leaked password database exposes everyone if stored badly.
- **Usability** ➔ hard to remember → weak **reset** processes become the attack surface.

## 🔐 Storing passwords safely
- **Cleartext** ➔ ❌ never — a database leak hands over every account.
- **Plain hash** ([[Cryptographic Hash Functions]]) ➔ better (one-way), **but** attackers precompute **rainbow tables** (hash → password lookups) and can test guesses.
- **Salted hash** ➔ ✅ add a **unique random salt per user** before hashing → identical passwords get **different hashes**, defeating rainbow tables and forcing per-account brute force.
- **Where it lives** ➔ the OS checks the password at login inside **kernel mode** (see [[Operating Systems and Multi-Processing|user vs kernel mode]]); access control + process **separation** protect the stored hashes from user processes.

## ⚠️ Common Mistakes
- 💡 **Salt ≠ secret** ➔ the salt need not be secret; its job is to be **unique per user** so precomputed tables don't apply — not to hide.
- 💡 **Hashing ≠ encryption** ➔ password hashes are **not decrypted** on login; the system **re-hashes the entered password (with the stored salt)** and compares digests.

## 🧠 Active Recall
> [!FAQ]- Passwords are hashed, so why add a salt — isn't a secure hash already irreversible?
> > [!SUCCESS]- Answer
> > - **Short answer:** an **unsalted** hash is deterministic, so attackers precompute **rainbow tables** once and instantly reverse *every* matching hash, and identical passwords share a hash. A **per-user salt** makes each hash unique, so those tables and cross-account shortcuts fail.
> > - **Why:** **Forced per-account work** ➔ salting means an attacker must brute-force **each** account separately with its own salt, hugely raising cost even for a leaked database.
