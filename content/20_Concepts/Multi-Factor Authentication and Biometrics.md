---
unit: FIT1047
week: 11
parent: "[[User Authentication and Passwords]]"
tags: [CS/Security]
aliases: [MFA, multi-factor authentication, 2FA, biometrics, hardware token, authenticator app, TAN, SIM swap, transaction authentication]
---
# [[Multi-Factor Authentication and Biometrics]]

**Context:** [[User Authentication and Passwords]] · what to use **instead of / in addition to** passwords · combining factor types for stronger login

> [!abstract] Quick Revision
> - **🎯 Objective:** strengthen authentication by **combining ≥2 factor types** (know / have / are) ➔ compromising one factor is not enough.
> - **⚡ Key Constraint:** each alternative trades **usability vs security**, and a "second factor" on the **same device** as the first is barely a second factor.

## 📝 Alternatives to passwords
- **Biometrics** (something you are) ➔ fingerprint, voice, iris. **Pro:** high usability. **Cons:** **not really secret**, **cannot be revoked/replaced** (you can't change your fingerprint), **no anonymous/pseudonymous** access, and **fakeable** (voice **deep-fakes**).
- **Hardware tokens** (something you have) ➔ YubiKey, RSA SecurID. **Pro:** high security. **Cons:** extra hardware, may not work across devices, expensive, **recovery** needed if lost.
- **Authenticator apps** ➔ e.g. Okta Verify. **Pro:** good usability + a second factor. **Con:** security is **limited if run on the same device** as the login.

## 🔑 Multi-factor authentication
- **Definition** ➔ combine **different** authentication types (e.g. Monash = **password** + **authenticator app / hardware token**).
- **Rule** ➔ "**do not rely on a single factor for everything that matters**".

## 🏦 Transaction authentication
- **Why** ➔ critical actions (e.g. **bank transfers**) re-authenticate the *transaction*, not just the login.
- **TANs** ➔ transaction numbers, usually **not linked** to a specific transaction.
- **SMS TAN** ➔ can show transaction info + is a second factor, **but** SMS is insecure and numbers are stealable via **SIM swap**.
- **TAN generator** ➔ reads a **barcode from screen**, generating a TAN **linked to the transaction** (more secure) but **less usable**.

## ⚠️ Common Mistakes
- 💡 **Same-device "MFA" isn't** ➔ an authenticator app on the phone you're logging in from collapses two factors into one device → one compromise defeats both.
- 💡 **Biometrics are identifiers, not secrets** ➔ they can't be changed after a leak and can be spoofed; best as a **convenience factor**, not a sole credential for high-value access.

## 🧠 Active Recall
> [!FAQ]- Why are biometrics a poor *sole* authentication method despite being unique to each person?
> > [!SUCCESS]- Answer
> > - **Short answer:** biometrics are **not secret** (you leave fingerprints everywhere, your voice is recordable), **cannot be revoked** if copied, and can be **faked** (deep-fakes) — uniqueness doesn't imply secrecy.
> > - **Why:** **Unchangeable credential** ➔ once a biometric template is compromised it's compromised forever, so it belongs in an **MFA combination** (something you are + something you know/have), not alone.
