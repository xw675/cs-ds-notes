---
unit: FIT1043
domain: F
week: 10
parent: "[[Big Data and the Vs]]"
tags: [DataScience/BigData, DataScience/DistributedProcessing]
aliases: [Distributed Processing, Map-Reduce, MapReduce, Batch, Streaming]
---
# [[Distributed Processing and Map-Reduce]]

**Context:** [[FIT1043_MOC]] · break computation up to scale past one machine · the paradigm behind [[Hadoop and Spark|Hadoop/Spark]] · processes [[Big Data and the Vs|Big Data]]

> [!abstract] Quick Revision
> - **🎯 Objective:** scale computation by splitting it across machines ➔ Map-Reduce = data-parallel **map** then a **reduce** (merge).
> - **📦 Core Components:** processing modes (interactive / streaming / batch) | data-parallel map | key-based reduce.
> - **⚡ Key Constraint:** it only works when the work is **data-parallel** — independent chunks that can be processed separately, then merged.

## 📝 How It Works
### 1. Processing Modes
- **Interactive** ➔ humans in the loop.
- **Streaming** ➔ massive data flows **through** the system with little storage (real-time).
- **Batch** ➔ data stored, analysed in large blocks ("batches") — easier to develop/analyse (offline).

### 2. Background Concepts
- **In-memory** ➔ in RAM, not going to disk (fast, volatile); vs **HDD/SSD** (permanent).
- **Parallel processing** ➔ tasks run at the same time; **distributed computing** ➔ across multiple machines.
- **Scalability** ➔ handle growing work by enlarging capacity (not just "big").
- **Data-parallel** ➔ processing done **independently** on separate chunks of data — the prerequisite for Map-Reduce.
- **Legacy limit** ➔ desktop tools (SAS/R/Matlab) often lack distributed support; distributing needs algorithm redesign.

### 3. Map-Reduce
- **Origin** ➔ a simple distributed framework from **Google** (Dean & Ghemawat, **2004**); runs on **commodity hardware** with **fault tolerance**.
- **Pattern** ➔ (1) **divide** data across machines → (2) **map()** each record to **key-value** pairs → (3) **sort/merge** identical keys → (4) **reduce** (merge) per key.
- **History** ➔ Google moved on (~2005) to "Cloud Dataflow"; the idea lives on in Hadoop/Spark.

## 📊 Exam Execution Trace

### Manual Execution Trace — word count
| Step / State | Action | Result |
| :--- | :--- | :--- |
| **0 (Init)** | split text across nodes | shards on machines |
| 1 (map) | each word → `(word, 1)` | `("the",1) ("cat",1) ("the",1)` |
| 2 (sort/shuffle) | group by key | `("the",[1,1]) ("cat",[1])` |
| 3 (reduce) | sum values per key | `("the",2) ("cat",1)` |

**Final Extracted Output:** per-word counts, computed data-parallel then merged — scales to huge corpora on commodity machines.

> [!NOTE] **When It Flips:** streaming vs batch is the axis behind [[Hadoop and Spark]] — Netflix's pipeline handles **~500 billion events / 1.3 PB per day** (≈8M events/sec at peak) by **streaming** (Kafka + Spark), not overnight batch.

## 🧠 Active Recall
> [!FAQ]- Walk through Map-Reduce on a word-count task, and state its precondition.
> > [!SUCCESS]- Answer
> > - **Short answer:** Divide the text across machines; `map` emits `(word, 1)` pairs; sort/shuffle groups identical keys; `reduce` sums the counts per word. Precondition: the work must be **data-parallel** (independent chunks).
> > - **Why:** **Map (parallel) + reduce (merge)** ➔ independent mapping scales horizontally, then a keyed merge combines partial results.

> [!FAQ]- Distinguish batch, streaming, and interactive processing.
> > [!SUCCESS]- Answer
> > - **Short answer:** Batch stores data and analyses it in large blocks (offline); streaming processes a massive flow in real time with little storage; interactive brings a human into the loop.
> > - **Why:** **Storage vs latency** ➔ batch trades latency for simplicity; streaming trades storage for real-time results.
