---
unit: FIT1043
week: 11
parent: "[[Data Management and Data Governance]]"
tags: [DataScience/Governance, DataScience/Ethics, Monash/CS_DS]
aliases: [Privacy, Confidentiality, Security, Implicit Data, Explicit Data]
---
# [[Privacy, Confidentiality, and Security]]

**Context:** [[FIT1043_MOC]] · the protection concerns of [[Data Management and Data Governance|data governance]] · three distinct ideas often confused · links to [[Impact of Data Science|datafication]]

> [!abstract] Quick Revision
> - **🎯 Objective:** separate three protection concepts ➔ privacy (control of self), confidentiality (info about you), security (protecting the data).
> - **📦 Core Components:** privacy | confidentiality | security | implicit vs explicit data.
> - **⚡ Key Constraint:** **implicit data** — facts *inferred* from your data (not given) — is the sneaky threat to confidentiality (pregnancy from purchases, traits from "likes").

## 📝 How It Works
### 1. The Three Concepts
- **Privacy** ➔ having **control over how one shares oneself** with others (e.g. closing the blinds in your living room).
- **Confidentiality** ➔ **information privacy** — how information *about* an individual is treated/shared (e.g. excluding others from your search/browse history).
- **Security** ➔ the **protection of data**, preventing improper use (e.g. stopping hackers stealing credit-card data).

### 2. Implicit vs Explicit Data
- **Explicit data** ➔ information a consumer **actively provides** (name, gender, email, home address — e.g. at signup).
- **Implicit data** ➔ **not explicitly stored** but **inferred with reasonable precision** from available data.

### 3. Loss of Confidentiality (social media)
- **Prediction** ➔ retailers predicting pregnancy from purchases; many traits inferred from Facebook **"likes"** ("curly fry conundrum").
- **Consumer control** ➔ often you must **accept a data-sharing policy** or can't fully use a service; ideally an agent asks "share your health data with company X?".

## ⚖️ Core Decision Matrix
| Term | Protects | Example |
| :--- | :--- | :--- |
| **Privacy** | control of self-disclosure | closing the blinds |
| **Confidentiality** | information *about* you | hiding browse history |
| **Security** | the data itself | blocking a hacker |

> [!NOTE] **When It Flips:** the three chain together — **security** failures (a breach) expose **confidential** information, which erodes **privacy**; and **implicit** inference can breach confidentiality even with no explicit data leaked.

## 🧠 Active Recall
> [!FAQ]- Distinguish privacy, confidentiality, and security with an example of each.
> > [!SUCCESS]- Answer
> > - **Short answer:** Privacy = control over how you share yourself (closing the blinds); confidentiality = how information about you is treated/shared (hiding browse history); security = protecting the data from improper use (blocking a hacker).
> > - **Why:** **Self / info / data** ➔ privacy is about *you*, confidentiality about *information on you*, security about *the stored data*.

> [!FAQ]- What is implicit data, and why does it threaten confidentiality?
> > [!SUCCESS]- Answer
> > - **Short answer:** Implicit data is inferred (not explicitly provided) from available data with reasonable precision — e.g. predicting pregnancy from purchases or traits from "likes".
> > - **Why:** **Inference, not disclosure** ➔ sensitive facts can be derived without you ever sharing them, bypassing explicit consent.
