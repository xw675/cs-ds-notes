---
unit: FIT1047
domain: F
week: 10
parent: "[[Information Security and Cryptography]]"
tags: [CS/Security, CS/Cryptography]
aliases: [key establishment, key agreement, Diffie-Hellman, DH key exchange, shared secret, discrete logarithm, key exchange]
---
# [[Key Establishment and Diffie-Hellman]]

**Context:** [[Information Security and Cryptography]] · agree a **shared symmetric key over open communication** while an eavesdropper listens · systems view of [[Diffie-Hellman Key Agreement]] (FIT1058 number theory)

> [!abstract] Quick Revision
> - **🎯 Objective:** two parties who **never met** derive a **common secret** over a public channel ➔ feed it to [[Symmetric Cryptography|AES]] for fast bulk encryption.
> - **⚡ Key Constraint:** **DH has no authentication** — it secures the channel against passive eavesdroppers but not an active **man-in-the-middle**, which is why [[Authentication, Certificates and PKI|certificates]] are needed.

## 📝 Why key agreement
- **Not just public keys** ➔ public-key encryption is **slow** and there is **no global PKI**; we still need a **symmetric** session key.
- **Requirement** ➔ agree a secret **over open communication**, at **scale**, between partners who **never communicated before** and **without** an online trusted third party.

## 🎨 The Diffie–Hellman idea (paint analogy)
- **Common paint** (public) + each party's **secret colour** → mix; **exchange** mixtures publicly; each adds their **own secret colour** again → both reach the **same common secret**. Assumption: **un-mixing (separation) is expensive**.

## 🔢 Simple DH (worked example)
- **1. Public params** ➔ base $g$ and modulus $n$, where $g$ is a **primitive root mod $n$** ([[Primitive Root]]). Example $g=5,\ n=47$.
- **2. Secrets** ➔ Alice picks $a=3$: $A = g^{a} \bmod n = 5^{3} \bmod 47 = 31$. Bob picks $b=7$: $B = g^{b} \bmod n = 5^{7} \bmod 47 = 11$.
- **3. Exchange** ➔ send $A=31$ and $B=11$ in the clear.
- **4. Shared key** ➔ $K = B^{a} \bmod n = A^{b} \bmod n = g^{ab} \bmod n$:
$$
\begin{aligned}
\text{Alice: } B^{a} \bmod n &= 11^{3} \bmod 47 = 1331 \bmod 47 = 15 \\
\text{Bob: } A^{b} \bmod n &= 31^{7} \bmod 47 = 15
\end{aligned}
$$

## 🔒 Why it is secure
- **Public** ➔ $A=g^{a}\bmod n$ and $B=g^{b}\bmod n$. **Secret** ➔ $a, b, g^{ab}$.
- **Hard problem** ➔ recovering $a$ from $g^{a}\bmod n$ is the **discrete logarithm** ([[One-Way Function]]) — infeasible for large numbers.

## ⚠️ Common Mistakes
- 💡 **No authentication** ➔ DH alone gives a shared secret but **not with a verified partner** → man-in-the-middle can agree a key with *each* side. Signing $A, B$ only **shifts** the problem to authenticating the signing keys → certificates.
- 💡 **$g$ must be a primitive root** ➔ otherwise the reachable values don't cover the group and the exchange weakens.

## 🧠 Active Recall
> [!FAQ]- Diffie–Hellman lets strangers agree a secret over a public channel — what does it *not* protect against?
> > [!SUCCESS]- Answer
> > - **Short answer:** it defends against a **passive eavesdropper** (who faces the discrete-log problem) but **not an active man-in-the-middle**, because the protocol never verifies **who** is on the other end.
> > - **Why:** **Missing authentication** ➔ each side would happily complete DH with the attacker; the fix is to **certify public keys** so a party's identity is bound to its key → [[Authentication, Certificates and PKI]].
