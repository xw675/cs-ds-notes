---
unit: FIT1043
domain: E
week: 11
parent: "[[Data Management and Data Governance]]"
tags: [DataScience/Governance, Ethics/Data]
aliases: [Compliance, PDPA, GDPR, PCI, Data Regulations]
---
# [[Data Compliance and Regulations (PDPA, GDPR)]]

**Context:** [[FIT1043_MOC]] · the legal side of [[Data Management and Data Governance|governance]] · enforces [[Privacy, Confidentiality, and Security|confidentiality]] · the "legal objective" that conflicts with business value

> [!abstract] Quick Revision
> - **🎯 Objective:** meet the laws protecting personal data ➔ **ethics** (moral handling) enforced via **compliance** with regulations.
> - **📦 Core Components:** PCI (payment cards) | PDPA (9 obligations) | GDPR (stricter EU law).
> - **⚡ Key Constraint:** **GDPR is stricter than PDPA** — 72-hour breach notification and penalties up to **4% of global turnover / €20M**.

## 📝 How It Works
### 1. Ethics & Compliance
- **Ethics** ➔ the **moral handling** of data.
- **Compliance** ➔ the process of **ensuring you meet regulations** (which exist to protect confidentiality).
- **PCI (Payment Card Industry)** ➔ reduces credit-card fraud, e.g. card data stored **only encrypted**; handlers must comply; **audited annually**.

### 2. PDPA — Nine Obligations
- **Consent** ➔ needed before personal data is collected/used/disclosed.
- **Purpose limitation** ➔ inform of purpose; don't use data beyond it.
- **Notification** ➔ notify individuals of the purpose before consent.
- **Access & correction** ➔ individuals may access and correct their data.
- **Accuracy** ➔ reasonable effort to keep data accurate/complete.
- **Protection** ➔ reasonable security against unauthorised access/use/disclosure/modification/disposal.
- **Retention limitation** ➔ keep data only for a period, then delete permanently.
- **Transfer limitation** ➔ no cross-border transfer unless the recipient country has comparable protection.
- **Do Not Call Registry** ➔ registered numbers may not receive unsolicited marketing.

### 3. PDPA vs GDPR
- **GDPR** ➔ EU regulation (approved 2016, effect **25 May 2018**); **stricter** consent rules.
- **Breach notification** ➔ notify authorities/affected parties within **72 hours** of awareness.
- **Penalties** ➔ up to **4% of annual global turnover or €20 million** (whichever is greater).

### 4. Australia (OAIC)
- **Privacy Act 1988** ➔ Australia's core privacy law; the **OAIC** (Office of the Australian Information Commissioner) issues guidance on the "reasonable steps" entities must take to secure personal information.
- **Notifiable Data Breaches (NDB) Act 2017** ➔ requires eligible data breaches to be **notified** to the OAIC and affected individuals — Australia's counterpart to GDPR's breach-notification duty.
- *(Applied session lab: `30_Projects/FIT1043_Labs/Week11-NoSQL-Privacy.pdf`.)*

## ⚖️ Core Decision Matrix
| Aspect | PDPA | GDPR (EU) |
| :--- | :--- | :--- |
| **Consent** | required | stricter/explicit |
| **Breach notice** | — | within **72 hours** |
| **Penalty** | — | up to 4% global turnover / €20M |
| **Scope** | national (e.g. Malaysia/SG) | EU-wide, extraterritorial |

> [!NOTE] **When It Flips:** compliance is where the **legal objective collides with the business objective** — regulations (PDPA/GDPR) constrain how freely a business can collect/use/transfer data to extract value, which [[Data Management and Data Governance|governance]] must balance.

## 🧠 Active Recall
> [!FAQ]- What is compliance, and how does GDPR go beyond PDPA?
> > [!SUCCESS]- Answer
> > - **Short answer:** Compliance is the process of ensuring you meet data regulations; GDPR is stricter than PDPA — explicit consent, **72-hour** breach notification, and penalties up to **4% of global turnover or €20M**.
> > - **Why:** **Teeth** ➔ GDPR's short breach window and turnover-based fines make non-compliance far costlier than under the PDPA.

> [!FAQ]- Name four of the PDPA's nine obligations.
> > [!SUCCESS]- Answer
> > - **Short answer:** Any four of: Consent, Purpose limitation, Notification, Access & correction, Accuracy, Protection, Retention limitation, Transfer limitation, Do Not Call Registry.
> > - **Why:** **Collect–use–keep–move** ➔ the obligations govern each stage: consent to collect, limits on use, protection while held, and rules on retention/transfer.
