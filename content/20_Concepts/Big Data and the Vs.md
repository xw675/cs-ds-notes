---
unit: [FIT2094, FIT1043]
domain: [C, F]
week: [9, 11]
parent: "[[Relational Model]]"
tags: [CS/Databases, DataScience/BigData]
aliases: [Big Data, 3Vs, Four Vs, Volume, Velocity, Variety]
---
# [[Big Data and the Vs]]

**Context:** [[FIT2094_MOC]], [[FIT1043_MOC]] · why a transactional [[Relational Model|RDBMS]] breaks at internet scale (FIT2094) · characterising data for a project (FIT1043) · motivates [[NoSQL Databases]] · growth driven by [[Growth Laws (Moore, Koomey, Bell, Zimmerman)|growth laws]]
**Parent Framework:** [[Relational Model]]

> [!abstract] Quick Revision
> - **🎯 Objective:** characterise data too big/fast/varied for a traditional RDBMS ➔ the 3 Vs Volume, Velocity, Variety.
> - **📦 Core Components:** Volume ➔ scale up vs **out** | Velocity ➔ stream/feedback | Variety ➔ structured/semi/unstructured.
> - **⚡ Key Constraint:** the two core problems — **receive** data fast enough (write/ingest) and **retrieve** it fast enough (query) — both overwhelm an RDBMS at scale.

## 📝 Core
### 1. Volume — how much
- **Scale up (vertical)** ➔ one bigger machine; simple but capped and expensive.
- **Scale out (horizontal)** ➔ add cheap commodity servers to a cluster; no practical limit (Google/Amazon approach).

### 2. Velocity — how fast
- **Stream processing** ➔ analyse/filter/summarise on arrival, before full storage (CERN: 600 TB/s raw ➔ ~1 GB/s stored).
- **Feedback loop** ➔ capture behaviour, analyse immediately, feed results back within the same interaction (Amazon recommendations).

### 3. Variety — what shape
- **Structured** ➔ fixed schema, uniform fields; RDBMS-friendly.
- **Unstructured** ➔ no model (video/audio/social/raw sensor); stored in natural format.
- **Semi-structured** ➔ self-describing but varying fields (JSON/XML); the IoT sensor case.

### 4. The V Taxonomy (Laney)
- **Origin** ➔ Doug **Laney (2001)** named the original **3 Vs** (Volume, Velocity, Variety) — these characterise "**bigness**".
- **Problems** ➔ **Veracity** (correctness/truth — noise, sensor faults) and **Variability** (meaning changes over time, e.g. natural language).
- **Aspirations** ➔ **Visualisation** (a method for analysis) and **Value** (what we want out of the data).
- **Definition** ➔ Big Data = data beyond commonly used tools' ability to capture/curate/manage/process in tolerable time — a **moving target**; a cost-free byproduct of digital interaction, enabled by the **cloud**.

## ⚖️ Core Decision Matrix
| Strategy | Move | Pro | Con |
| :--- | :--- | :--- | :--- |
| **Scale up (vertical)** | bigger single server | simple to manage | hard ceiling; costly |
| **Scale out (horizontal)** | more commodity nodes | near-unlimited growth | needs distribution (sharding/replication) |

> [!NOTE] **When It Flips:** the original "Big Data" is the **intersection** of all three Vs — large volume, high velocity, *and* variable structure at once; any one alone a classic RDBMS can often still handle.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** A Pilbara ore train: 16 sensors/car, 200 ore cars, 25 records/sec each. Ingest rate?
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
16 \text{ sensors} \times 200 \text{ cars} \times 25 \tfrac{\text{rec}}{\text{s}} = 80{,}000 \text{ records/second}
$$
**Final Extracted Output:** a continuous 80,000 semi-structured JSON records/sec — a write **stream**, not a batch; an OLTP RDBMS cannot keep up on ingest *or* real-time query.

## 🧠 Active Recall
> [!FAQ]- Why does Variety, more than Volume, push organisations off the relational model?
> - **Hint:** Rigid schema vs varying records.
> > [!SUCCESS]- Answer
> > - **Short answer:** Relational storage requires a fixed schema; semi/unstructured data (JSON sensor readings, video) has varying or no fields, so forcing it into normalised tables is impractical.
> > - **Why:** **Schema-on-write vs natural capture** ➔ Big Data systems store data in its native shape, deferring structure to read time.

> [!FAQ]- Group the V's by what they characterise, and give the one-line "what is Big Data" summary.
> - **Hint:** Bigness vs problems vs aspirations.
> > [!SUCCESS]- Answer
> > - **Short answer:** Laney's Volume/Velocity/Variety characterise **bigness**; Veracity/Variability characterise **analysis problems**; Visualisation/Value are **aspirations**. Big Data = *any attribute that challenges the constraints of a system's capability or a business need*.
> > - **Why:** **Moving target** ➔ "big" is relative to current tools, so the definition shifts as capability grows ([[Growth Laws (Moore, Koomey, Bell, Zimmerman)|growth laws]]).
