---
unit: FIT1047
week: 6
parent: "[[Internet Model (Layers, Protocols, Encapsulation)]]"
tags: [CS/Networks]
aliases: [HTTP, WWW, Request-Response, GET, POST]
---
# [[World Wide Web (HTTP and HTML)]]

**Context:** [[FIT1047_MOC]] · the Application-layer flagship: browser ↔ server via **HTTP**, pages described in **HTML** · Berners-Lee 1989, built on hypertext + URLs

> [!abstract] Quick Revision
> - **🎯 Objective:** read/write a raw HTTP exchange ➔ request line + headers ⟶ status line + headers + body; one page = MANY request-response cycles (each `<img>` is a new GET).
> - **⚡ Key Constraint:** the anatomy labels — request line / request header / response status / response header / response body — exams mark by part-name.

## 📝 Core
- **Two technologies** ➔ HTTP = the browser↔server conversation protocol; HTML = the page description format.
- **Two founding ideas** ➔ *hypertext* (documents linking documents) + *URL* (a standard way to name them).
- **Request–response cycle** ➔ browser sends request through the [[Internet Model (Layers, Protocols, Encapsulation)|stack]], server answers with the document; embedded resources trigger further GETs.

## 📊 Exam Execution Trace — lecture session, verbatim
```text
client:  GET /~guidot/test.html HTTP/1.1        ← request line (method, path, version)
         Host: www.csse.monash.edu              ← request header

server:  HTTP/1.1 200 OK                        ← response status
         Date: Thu, 05 Mar 2015 08:30:48 GMT    ← response headers
         Server: Apache/1.3.26 (Unix)
         Content-Type: text/html
                                                 ← blank line separates
         <html><body><h1>Guido Tack</h1>        ← response body (HTML)
         <img src="images/guido3.jpg">…
```
Then the `<img>` tag causes a **second** cycle: `GET /~guidot/images/guido3.jpg` → `200 OK`, `Content-Type: image/jpeg`, binary body.

## 🎛 HTTP Methods
| Method | Does |
| :-- | :-- |
| `GET` | retrieve the URL |
| `HEAD` | retrieve headers only |
| `POST` | send body data to the URL (forum post, cart item) — also returns a document |
| others | `PUT`, `DELETE`, `OPTIONS`… less common |

## ⚠️ Common Mistakes
- 💡 **One page ≠ one request** ➔ every embedded image/script/stylesheet is its own request-response cycle.
- 💡 **POST also retrieves** ➔ it sends data AND gets a response document back — "POST only uploads" is wrong.
- 💡 **HTTP is plain text** ➔ human-readable on the wire (until TLS wraps it) — which is why exams can show raw sessions.

## 🧠 Active Recall
> [!FAQ]- Label the five anatomical parts of an HTTP exchange and write a minimal valid request.
> > [!SUCCESS]- Answer
> > - **Short answer:** Request line + request headers ‖ response status + response headers + response body; minimal: `GET /page.html HTTP/1.1` + `Host: example.com`.
> > - **Why:** **Host header matters** ➔ one server IP hosts many sites; `Host:` selects which — mandatory since HTTP/1.1.

> [!FAQ]- Loading a page with 3 images: how many request-response cycles, and which method fits adding a forum comment?
> > [!SUCCESS]- Answer
> > - **Short answer:** Four cycles (page + 3 images); the comment is a `POST` (data travels in the request body).
> > - **Why:** **Method semantics** ➔ GET is retrieval-only by convention; state-changing submissions belong in POST.
