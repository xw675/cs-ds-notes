---
unit: FIT1043
week: 10
parent: "[[Distributed Processing and Map-Reduce]]"
tags: [DataScience/BigData, DataScience/DistributedProcessing, Monash/CS_DS]
aliases: [Hadoop, Spark, Apache Spark]
---
# [[Hadoop and Spark]]

**Context:** [[FIT1043_MOC]] · the two big open-source [[Distributed Processing and Map-Reduce|distributed-processing]] platforms · Hadoop = batch, Spark = in-memory/real-time

> [!abstract] Quick Revision
> - **🎯 Objective:** choose a big-data engine ➔ Hadoop for cheap **batch/offline** Map-Reduce; Spark for fast **in-memory/real-time**.
> - **⚡ Key Constraint:** Hadoop writes to disk between steps (not suited to streaming); Spark keeps data **in memory**, so it's much faster and handles real-time.

## 📝 How It Works
### 1. Hadoop
- **What** ➔ open-source **Java** implementation of **Map-Reduce** (Doug Cutting @ Yahoo!).
- **Architecture** ➔ **Common** (Java libraries/utilities) + **MapReduce** (the core paradigm); a huge tool ecosystem.
- **Fit** ➔ inexpensive platform for parallelising processing; **batch/offline** only — **not suited to streaming**; past its hype peak.

### 2. Spark
- **What** ➔ an Apache top-level project (AMPLab, **UC Berkeley**); builds on Hadoop infrastructure.
- **Interfaces** ➔ Java, Scala, Python, R.
- **Edge** ➔ **in-memory** analytics ➔ **real-time** processing, **much faster** than Hadoop; works with parts of the Hadoop ecosystem; includes Map-Reduce capabilities.

## ⚖️ Core Decision Matrix
| Aspect | Hadoop | Spark |
| :--- | :--- | :--- |
| **Core** | Map-Reduce (Java) | in-memory engine on Hadoop infra |
| **Speed** | disk-based, slower | in-memory, much faster |
| **Processing** | batch / offline | real-time / streaming + batch |
| **Interfaces** | Java (MapReduce) | Java, Scala, Python, R |

> [!NOTE] **When It Flips:** the difference is **where data lives between steps** — Hadoop spills to disk (cheap, batch), Spark keeps it in RAM (fast, real-time). For **real-time** processing, choose **Spark**.

## ⚠️ Common Mistakes
- 💡 **Hadoop can't stream** ➔ its disk-based Map-Reduce suits offline batch; use Spark (or a streaming platform like Kafka) for real-time.
- 💡 **Spark ⊃ Map-Reduce** ➔ Spark isn't a rejection of Map-Reduce; it includes those capabilities and adds in-memory speed.

## 🧠 Active Recall
> [!FAQ]- Differentiate Hadoop and Spark, and say which suits real-time processing.
> > [!SUCCESS]- Answer
> > - **Short answer:** Hadoop is a disk-based Java Map-Reduce platform for cheap batch/offline processing; Spark is an in-memory engine built on Hadoop infra that is much faster and supports real-time — so **Spark** for real-time.
> > - **Why:** **In-memory vs disk** ➔ Spark avoids Hadoop's between-step disk writes, enabling streaming/interactive speed.
