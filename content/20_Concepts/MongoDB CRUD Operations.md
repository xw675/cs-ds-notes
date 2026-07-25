---
unit: FIT2094
week: 11
parent: "[[MongoDB Document Model]]"
tags: [CS/Databases, DataScience/BigData]
type: pattern
aliases: [CRUD, insertOne, find, updateOne, deleteMany, $set, $elemMatch]
---
# [[MongoDB CRUD Operations]]

**Context:** [[FIT2094_MOC]] · query/modify a [[MongoDB Document Model|MongoDB]] collection · the NoSQL counterpart of [[SQL SELECT and WHERE|SQL DML/SELECT]]
**Problem it solves:** create, read, update, or delete documents by a filter, using `$`-prefixed operators.

> [!abstract] Quick Revision
> - **🎯 Trigger:** operate on documents ➔ db.collection.command( {filter}, {action} ); an omitted or {} filter = **all** documents.
> - **⚡ Key Constraint:** update needs `$set` (else it **replaces the whole document**); there is **no ROLLBACK** — a bad `updateMany`/`deleteMany({})` is permanent.

## 🔧 Minimal Working Example
```javascript
db.dronerent.insertOne({ "drone_id": 100, "type": { "code": "DMA2" }, "cost_per_hour": 15 });

db.dronerent.find(                         // READ: filter + projection
  { "drone_id": { "$eq": 103 } },
  { "type.model": 1, "pur_date": 1, "_id": 0 }  // 1=include, 0=suppress
);

db.dronerent.updateOne(                     // UPDATE
  { "drone_id": { "$eq": 103 } },
  { "$set": { "total_flighttime": 230 } }
);

db.dronerent.deleteOne({ "drone_id": { "$eq": 103 } });   // DELETE
```
**Expected output:** insert returns the `_id`; find returns matching docs (projection controls fields); update returns `matchedCount`/`modifiedCount`; delete returns `deletedCount`.

- **Collections auto-create** ➔ first insert makes the collection; no `CREATE TABLE`, schema-less.
- **Comparison operators** ➔ `$eq $ne $gt $gte $lt $lte $in $nin` (quoted, `{field:{"$gt":0}}`).
- **Logical operators** ➔ `$and $or $not $nor` over an array of conditions.
- **Update operators** ➔ `$set` (replace field), `$inc` (add to number); `insertMany([...])` / `updateMany` / `deleteMany` for bulk.
- **Projection** ➔ `1` include / `0` suppress; `_id` returned unless suppressed; `$slice: -1` = last array element.

## 🔀 Variations
- **Array element update (`$` positional)** ➔ update the matched `RentalInfo` element: filter `"RentalInfo.rent_out": "…"`, then `{ "$set": { "RentalInfo.$.rent_in": "…" } }`.
- **`$elemMatch`** ➔ force **multiple conditions onto the same array element**: `"RentalInfo": { "$elemMatch": { "rent_in": null } }`.

| SQL | MongoDB |
| :--- | :--- |
| `SELECT * FROM t` | `db.t.find({})` |
| `SELECT c WHERE …` | `db.t.find({filter},{c:1})` |
| `UPDATE … SET …` | `db.t.updateMany({filter},{$set:{…}})` |
| `DELETE … WHERE …` | `db.t.deleteMany({filter})` |
| `DROP TABLE t` | `db.t.drop()` |

## ✍️ Practice 
> [!QUESTION]- Practice 1: Raise `cost_per_hour` to 55 for **all** PAPR-type drones.
> > [!SUCCESS]- Reference solution
> > ```javascript
> > db.dronerent.updateMany(
> >   { "type.code": { "$eq": "PAPR" } },
> >   { "$set": { "cost_per_hour": 55 } }
> > );
> > ```
> > - **Key move:** `updateMany` + `$set`; dot-notation `type.code` reaches into the sub-document.

## ⚠️ Common Mistakes
- 💡 **No `$set` = full replacement** ➔ `{ "cost_per_hour": 55 }` alone as the action replaces the entire document; always wrap in `$set`/`$inc`.
- 💡 **Empty filter hits everything, no ROLLBACK** ➔ `deleteMany({})` empties the collection; there is no undo — verify the filter first.
- 💡 **`modifiedCount = 0` with `matchedCount > 0`** ➔ the document exists but already held that value (nothing changed) — not an error.
