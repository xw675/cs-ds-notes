---
unit: FIT1047
domain: F
week: 10
parent: "[[FIT1047_MOC]]"
tags: [CS/Security, CS/Cryptography]
aliases: [information security, CIA, confidentiality integrity availability, security goals, cryptography overview, security mechanisms, non-repudiation]
---
# [[Information Security and Cryptography]]

**Context:** [[FIT1047_MOC]] · the security half of the unit (W10–12) — this note is the **hub** for the crypto cluster · frames *what* we protect and *which tool* provides it

> [!abstract] Quick Revision
> - **🎯 Objective:** every bit is **changeable**, every host **reachable worldwide**, every device **potentially hackable** ➔ security = achieving specific **goals** (confidentiality, integrity, authenticity, non-repudiation) despite an active attacker.
> - **⚡ Key Constraint:** match the **goal to the mechanism** — encryption ⇒ confidentiality, hashes/MACs/signatures ⇒ integrity + authenticity. Using the wrong primitive (e.g. a plain hash for tamper-proofing) fails.

## 📝 Security goals
- **Confidentiality** ➔ keep data **secret** from eavesdroppers → provided by **encryption** ([[Symmetric Cryptography]], [[Public Key Cryptography]]).
- **Integrity** ➔ **detect any change** to a message in transit → provided by **MACs / hashes / signatures** ([[Cryptographic Hash Functions]]).
- **Authenticity** ➔ know **whom you are talking to** → **digital signatures + certificates** ([[Authentication, Certificates and PKI]]).
- **Non-repudiation** ➔ a signer **cannot deny** having signed → only **public-key signatures** provide it (symmetric keys can't — both sides hold the same key).

## 🧰 Three algorithm families
- **Symmetric encryption** ➔ one **shared** secret key; fast; the key-distribution problem → [[Symmetric Cryptography]].
- **Public-key (asymmetric)** ➔ a **key pair** (public + private); solves distribution + enables signatures → [[Public Key Cryptography]].
- **Hash functions** ➔ **one-way** fixed-length fingerprints; underpin integrity, signatures, password storage → [[Cryptographic Hash Functions]].

## 🛡️ Countermeasures (beyond crypto)
- **Mechanisms** ➔ **cryptography**, **firewalls**, **multi-factor authentication** — plus knowing risks/threats, building secure systems, designing secure networks, and the **human aspect**.
- **Roadmap** ➔ W10 crypto + protocols; W11 network security (firewalls, access control, SSO/MFA); W12 threats, risk, attacks, malware.

## ⚠️ Common Mistakes
- 💡 **Goal ≠ mechanism** ➔ encryption alone gives **confidentiality but not integrity** — AES ciphertext can still be reordered/flipped; you need a **MAC** for tamper-detection.
- 💡 **Non-repudiation is asymmetric-only** ➔ a shared symmetric key can prove *a message came from one of us*, never *which one* — so it cannot bind a signer.

## 🧠 Active Recall
> [!FAQ]- Why isn't "encrypt everything" a complete security solution?
> > [!SUCCESS]- Answer
> > - **Short answer:** encryption targets **confidentiality** only; it does **not** guarantee integrity, authenticity, or non-repudiation, so an attacker can still **tamper** with ciphertext or **impersonate** a party.
> > - **Why:** **Goal decomposition** ➔ each goal needs its own primitive — **MAC/hash** for integrity, **signature + certificate** for authenticity, **public-key signature** for non-repudiation — layered on top of the cipher.
