---
unit: FIT1047
week: 10
parent: "[[Information Security and Cryptography]]"
tags: [CS/Security, CS/Cryptography]
aliases: [symmetric encryption, shared key, AES, Rijndael, S-box, substitution box, block chaining, CBC-MAC, Caesar cipher, Vigenere, secret key]
---
# [[Symmetric Cryptography]]

**Context:** [[Information Security and Cryptography]] · one **shared** secret scrambles + unscrambles the message · the systems view of [[Cryptosystem]] (FIT1058 number theory)

> [!abstract] Quick Revision
> - **🎯 Objective:** a single key is **shared** between principals; use it to scramble a message so it is **unreadable without the secret** ➔ **confidentiality**, very **fast**.
> - **⚡ Key Constraint:** the **key-distribution problem** — both sides must first obtain the same secret over a **secure channel**; and keys scale as $\frac{n(n-1)}{2}$, i.e. $O(n^2)$.

## 📝 Core
- **Shared key** ➔ same secret at both ends; used for **>3000 years** (Skytale, **Caesar**, **Vigenère** substitution ciphers).
- **Main idea** ➔ use the shared secret to scramble a block so it **cannot be understood without the key**.
- **Building blocks** ➔ **S-boxes (substitution boxes)** = a **look-up table** replacing part of a message block; **permutations** = reorder the message parts. Modern ciphers repeat substitution + permutation over many **rounds**.
- **AES (Advanced Encryption Standard)** ➔ open **NIST** contest (15 designs, winner 2000); winner **Rijndael** (Daemen & Rijmen); block cipher, **14 rounds** in the 256-bit version (each round: Byte Sub → Shift Row → Mix Column → Add Round Key).

## 🔗 Integrity: block chaining & CBC-MAC
- **Confidentiality only** ➔ AES on raw blocks gives secrecy but **not integrity** (blocks can be reordered, bits flipped).
- **Block chaining** ➔ start with an **initialisation vector (IV)** and combine each encrypted block with the next → wrong order won't decrypt; a **changed block disables** decryption of the next.
- **CBC-MAC** ➔ **Cipher Block Chaining** produces a **Message Authentication Code** — one final block that checks integrity of the whole message $m_1 m_2 \dots m_x$. Used by **WPA2/CCMP** (AES + CBC-MAC).

## ⚠️ Common Mistakes
- 💡 **Key distribution** ➔ you still need a **separate secure channel** to share the secret → motivates [[Key Establishment and Diffie-Hellman]] and [[Public Key Cryptography]].
- 💡 **Scalability** ➔ every **pair** needs a unique key → $\frac{n(n-1)}{2}$: 12 people = 66 keys, 1000 = 499,500, a million ≈ $5\times10^{11}$ keys.
- 💡 **No non-repudiation** ➔ both parties hold the **same** key, so a key can't prove **which** side produced a message.

## 🧠 Active Recall
> [!FAQ]- Symmetric encryption is fast and secure — so why do we still need public-key cryptography?
> > [!SUCCESS]- Answer
> > - **Short answer:** symmetric crypto has three structural weaknesses — **key distribution** (needs a pre-shared secret), **scalability** ($O(n^2)$ keys), and **no non-repudiation** — none of which are about the cipher's strength.
> > - **Why:** **Shared-secret limits** ➔ [[Public Key Cryptography]] and [[Key Establishment and Diffie-Hellman]] remove the pre-shared-secret requirement and enable signatures, while symmetric ciphers (AES) still do the **bulk encryption** afterwards.
