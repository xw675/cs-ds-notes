---
unit: FIT1047
week: 10
parent: "[[Information Security and Cryptography]]"
tags: [CS/Security, CS/Cryptography]
aliases: [public key cryptography, asymmetric cryptography, RSA, key pair, digital signature, non-secret encryption, public private key]
---
# [[Public Key Cryptography]]

**Context:** [[Information Security and Cryptography]] · each principal owns a **key pair** — one **public**, one **private** · the systems view of [[Cryptosystem]] and RSA ([[Modular Exponentiation]], FIT1058)

> [!abstract] Quick Revision
> - **🎯 Objective:** "**non-secret encryption**" — a **key pair** where the **private key cannot be derived** from the public key without solving a **hard math problem** ➔ removes the shared-secret requirement of [[Symmetric Cryptography]].
> - **⚡ Key Constraint:** **slow** vs symmetric, and there is **no global PKI for everybody** — so in practice public-key is used to **establish** a symmetric session key, then AES does the bulk work.

## 📝 Core
- **Key pair** ➔ based on a **hard problem** + a large random number; **private key** kept secret, **public key** published. Devised by **Diffie–Hellman (1976)** and **RSA (Rivest, Shamir, Adleman, 1977)**.
- **Three uses** ➔
  - **Encryption** ➔ encrypt with the **recipient's public key**; only their **private key** decrypts → confidentiality.
  - **Digital signature / authenticity** ➔ **sign with your private key**; anyone verifies with your public key → authenticity + non-repudiation.
  - **Key establishment** ➔ derive a shared secret using both parties' keys → [[Key Establishment and Diffie-Hellman]].
- **Direction matters** ➔ public-key **can** keep a message secret (encrypt with the public key); it is *not* "public = readable by all".

## 🔑 RSA in brief
- **Keys** ➔ private $d$; public $(e, n)$.
- **Operations** ➔ $\text{cipher} = \text{message}^{e} \bmod n$ · $\text{message} = \text{cipher}^{d} \bmod n$ (see [[Modular Exponentiation]]).
- **Key generation** ➔ pick primes $p, q$ ([[Prime Number]]); $n = pq$, $m = \Phi(n) = (p-1)(q-1)$ ([[Euler Totient Function]]); pick $e$ with $\gcd(e,m)=1,\ 1<e<m$; find $d$ with $e \cdot d \bmod m = 1$ ([[Modular Inverse]]); publish $(e,n)$, keep $d, m$ secret.

## 📏 Recommended key lengths
- **AES (symmetric)** ➔ **128 bit** secure now; **256 bit** long-term (post-2030).
- **RSA (public key)** ➔ **2048 bit** secure now; **3072 bit** recommended after 2020/2030. NIST, NSA, German BSI differ in detail.
- **Random numbers** ➔ all crypto needs good randomness (key gen, protocol nonces, IVs); many real attacks exploited **bad randomness**.

## ⚠️ Common Mistakes
- 💡 **Plain RSA has no integrity** ➔ ciphertext is **malleable** (can be multiplied then decrypted) → use a **MAC** or signature, not RSA alone, to protect integrity.
- 💡 **RSA key length ≫ AES** ➔ 2048-bit RSA ≈ 128-bit AES security; they are **not** comparable bit-for-bit (different hard problems).

## 🧠 Active Recall
> [!FAQ]- Can public-key cryptography keep a message secret, given the key is public?
> > [!SUCCESS]- Answer
> > - **Short answer:** **yes** — encrypt with the recipient's **public** key; the matching **private** key (held only by the recipient) is the sole way to decrypt.
> > - **Why:** **Trapdoor asymmetry** ➔ the public key locks, the private key unlocks; deriving the private key from the public one requires solving the underlying **hard problem** (factoring for RSA), which is infeasible for large $n$.
