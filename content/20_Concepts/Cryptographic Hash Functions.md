---
unit: FIT1047
domain: F
week: [10, 11]
parent: "[[Information Security and Cryptography]]"
tags: [CS/Security, CS/Cryptography]
aliases: [hash function, cryptographic hash, MD5, SHA-1, SHA-256, MAC, message authentication code, collision resistance, digest]
---
# [[Cryptographic Hash Functions]]

**Context:** [[Information Security and Cryptography]] · maps **arbitrary-length** input to a **fixed-length** fingerprint · the integrity + password-storage workhorse (distinct from a [[Hash Table]], which is for lookup)

> [!abstract] Quick Revision
> - **🎯 Objective:** a **one-way** ([[One-Way Function]]) fixed-length digest that is **infeasible to invert** and **collision-resistant** ➔ detect changes, store passwords, build signatures.
> - **⚡ Key Constraint:** a **bare hash cannot protect integrity in transit** — hashes are **public**, so an attacker who changes the message just recomputes the hash. Integrity over a channel needs a **keyed MAC**.

## 📝 Core
- **Definition** ➔ maps input of **any length** → **fixed-length** output; cryptographic hashes are **infeasible to invert**.
- **Uses** ➔ digital signatures (sign the hash, not the whole message), **password storage/comparison**, message authentication codes.
- **Ideal properties** ➔
  - **Fast + cheap** to compute a digest.
  - **Pre-image resistance** ➔ given a hash, infeasible to find the original (except brute force).
  - **Avalanche** ➔ small input change ⇒ **large, uncorrelated** hash change.
  - **Collision resistance** ➔ infeasible to find two messages with the same hash.
- **Common functions** ➔ **MD5** (broken, still seen for integrity); **SHA-1** (weak — attacks faster than brute force, dropped for signatures); **current: SHA-256, SHA-384, SHA-512**.

## 🔐 Hash vs MAC (integrity over a channel)
- **Plain hash fails** ➔ publicly known algorithm → attacker changes message **and** recomputes a valid hash.
- **MAC works** ➔ a **Message Authentication Code** needs a **secret key**; without the key an attacker **cannot forge** a valid MAC for a changed message → protects integrity. (Symmetric MACs: e.g. **CBC-MAC**, see [[Symmetric Cryptography]].)

## ⚠️ Common Mistakes
- 💡 **Hash ≠ MAC** ➔ exam trap: "protect integrity of a message in transit" ⇒ answer is **MAC** (keyed), *not* SHA-256 — an unkeyed hash gives no protection against an active attacker.
- 💡 **Hash function ≠ [[Hash Table]]** ➔ cryptographic hashes optimise **irreversibility + collision resistance**; hash-table hashes optimise **uniform, fast bucketing** and are deliberately cheap/reversible-friendly.

## 🧠 Active Recall
> [!FAQ]- To protect a message's integrity in transit, why use a MAC rather than just SHA-256?
> > [!SUCCESS]- Answer
> > - **Short answer:** hash functions are **publicly computable**, so an attacker who alters the message can simply **recompute** a matching hash — no protection. A **MAC requires a secret key** the attacker lacks, so a forged message fails verification.
> > - **Why:** **Keyed integrity** ➔ the MAC binds the message to a shared secret; only holders of the key can produce a valid tag, giving tamper-evidence a bare digest cannot.
