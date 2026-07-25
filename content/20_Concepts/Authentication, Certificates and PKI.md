---
unit: FIT1047
week: 10
parent: "[[Information Security and Cryptography]]"
tags: [CS/Security, CS/Cryptography, Monash/CS_DS]
aliases: [authentication, certificate, PKI, certification authority, CA, X509, certificate revocation, CRL, OCSP, OCSP stapling]
---
# [[Authentication, Certificates and PKI]]

**Context:** [[Information Security and Cryptography]] · "how do I know whom I am talking to?" · closes the **authentication gap** left by [[Key Establishment and Diffie-Hellman]]

> [!abstract] Quick Revision
> - **🎯 Objective:** bind a **public key to an identity** so a verified partner is known ➔ a **certification authority (CA)** signs *(public key + identity)* to make a **certificate**.
> - **⚡ Key Constraint:** certificates only **move** trust, not remove it — you must trust the **CA**, handle **revocation** of compromised keys, and remember a certificate proves **identity, not that the server is safe**.

## 📝 The authentication gap
- **DH's flaw** ➔ the original protocol gives a shared secret but **no proof of partner identity** (man-in-the-middle).
- **Signatures don't fully fix it** ➔ signing the exchanged values $A, B$ just **shifts** the problem to authenticating the **signature verification keys**.
- **Solution** ➔ **certify public keys**: a trusted **CA** signs the public key together with identity information → a **certificate**.

## 📜 Certificate contents
- **A certificate = extra trusted info for a public key** ➔ **owner** of the matching private key · **validity** (expiry date/time) · **subject name** · **issuer name** (the CA) · other parameters.

## ♻️ Revocation & limits
- **Compromise** ➔ private keys can leak → the certificate must be **revoked** before expiry.
- **Mechanisms** ➔ **Certificate Revocation Lists (CRLs)**; **Online Certificate Status Protocol (OCSP)** and **OCSP stapling** (server attaches a fresh signed status).
- **Weaknesses** ➔ **name misinterpretation** (special/look-alike characters); **anyone can buy a certificate** — its existence means the identity was checked, **not** that the server is secure/benign.

## ⚠️ Common Mistakes
- 💡 **A valid certificate ≠ a safe site** ➔ malicious operators can obtain legitimate certificates; the lock icon proves an **authenticated identity + encrypted channel**, not trustworthiness of the operator.
- 💡 **Trust is transitive to the CA** ➔ security rests on the CA's honesty and key security; a compromised or careless CA undermines every certificate it issued.

## 🧠 Active Recall
> [!FAQ]- Signing the Diffie–Hellman values with digital signatures seems to authenticate them — why do we still need certificates?
> > [!SUCCESS]- Answer
> > - **Short answer:** a signature only helps if you already **trust the verification key**; without that, an attacker can sign with **their own** key, so the problem is merely **displaced** to authenticating the signing key.
> > - **Why:** **Anchoring trust** ➔ a **CA-issued certificate** binds a public key to an identity via a signature you can trace to a trusted root, terminating the regress — provided revocation (CRL/OCSP) keeps compromised keys out.
