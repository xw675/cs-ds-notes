---
unit: FIT2094
week: 11
parent: "[[NoSQL Data Models]]"
tags: [CS/Databases, DataScience/BigData, Tool/SQL]
aliases: [MongoDB, BSON, ObjectId, Embedded Document]
---
# [[MongoDB Document Model]]

**Context:** [[FIT2094_MOC]] · a [[NoSQL Data Models|document store]] · JSON-style documents in schema-less collections · contrasts the normalised [[Relational Model|relational]] schema
**Parent Framework:** [[NoSQL Data Models]]

> [!abstract] Quick Revision
> - **🎯 Objective:** store related data together as one flexible JSON/BSON document ➔ no JOIN to read a whole entity.
> - **📦 Core Components:** database → collection → document → field | `_id`/ObjectId | embedded vs referenced.
> - **⚡ Key Constraint:** the embed-vs-reference choice — embed when read together and stable; reference when large, shared, or independently updated.

## 📝 Core
### 1. Hierarchy & Terminology
| MongoDB | Relational | Key difference |
| :--- | :--- | :--- |
| **Database** | database/schema | same |
| **Collection** | table | **no fixed schema** |
| **Document** | row | nested objects + arrays; fields vary |
| **Field** | column | optional; may hold complex values |

### 2. BSON & Identity
- **BSON** ➔ binary JSON with extra types (dates, binary, ObjectId); you read/write JSON, Mongo stores BSON.
- **`_id`** ➔ auto-added globally unique **ObjectId** (like a PK) if not supplied; a given `_id` you provide is used as-is.
- **Quote fields** ➔ always double-quote field names to avoid parser ambiguity.
- **Unit convention** ➔ store dates/times as **strings** (avoids timezone conversion, stays readable).

### 3. Embedded vs Reference
- **Embedded (denormalised)** ➔ nest sub-documents inside the parent ➔ one read, no join.
- **Reference (normalised)** ➔ store another document's ObjectId ➔ app-layer "join" (not engine-enforced).

## ⚙️ Core Implementation
### 🔹 Embedded document (drone with rental array)
> [!code]- one document = DRONE + DRONE_TYPE + RENTAL rows
> ```json
> {
>   "drone_id": 111,
>   "type": { "code": "PAPR", "model": "Parrot Pro", "manufacturer": "Parrot" },
>   "carrying_capacity": 5,
>   "RentalInfo": [
>     { "rent_no": 11, "bond": 150, "rent_out": "26-Apr-2021 10:21:00",
>       "rent_in": "28-Apr-2021 14:13:00", "custtrain_id": 10 }
>   ]
> }
> ```
> 💡 **Common Mistake:** **Embedding collapses three Oracle tables into one document** ➔ great for "read the whole drone" but duplicates shared data (type/manufacturer) across drones.

### 🔹 Generate the JSON from Oracle
> [!code]- JSON_OBJECT / JSON_ARRAYAGG
> ```sql
> SELECT JSON_OBJECT(
>   'drone_id' VALUE drone_id,
>   'type' VALUE JSON_OBJECT('code' VALUE dt_code, 'model' VALUE dt_model,
>                            'manufacturer' VALUE manuf_name),
>   'RentalInfo' VALUE JSON_ARRAYAGG(
>       JSON_OBJECT('rent_no' VALUE rent_no, 'bond' VALUE rent_bond) ORDER BY rent_no
>   ) FORMAT JSON
> )
> FROM drone.rental NATURAL JOIN drone.drone
>      NATURAL JOIN drone.drone_type NATURAL JOIN drone.manufacturer
> GROUP BY drone_id, dt_code, dt_model, manuf_name;
> ```
> 💡 **Common Mistake:** **`JSON_ARRAYAGG` needs GROUP BY** ➔ it aggregates child rows (rentals) into one array per parent (drone); non-aggregated columns must be grouped.

## ⚖️ Core Decision Matrix
| Approach | Store | Best when | Cost |
| :--- | :--- | :--- | :--- |
| **Embedded (denormalised)** | nested sub-docs | always read together; rarely changes alone | duplication across parents |
| **Reference (normalised)** | ObjectId pointer | large / shared / independently updated | app must do the "join" |

> [!NOTE] **When It Flips:** references mimic a [[Foreign Key and Referential Integrity|foreign key]] but are **not enforced** by the engine — integrity is the application's responsibility, unlike Oracle's referential integrity.

## 🧠 Active Recall
> [!FAQ]- When would you embed rental history in the drone document vs reference it in a separate collection?
> - **Hint:** Read-together + change-independently.
> > [!SUCCESS]- Answer
> > - **Short answer:** Embed when the rentals are always read with the drone and rarely change alone; reference when rentals are large, shared, or updated independently of the drone.
> > - **Why:** **No enforced FK** ➔ a reference is just a stored ObjectId; the application performs and protects the join.
