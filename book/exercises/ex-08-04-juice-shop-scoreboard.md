---
id: EX-08-04
title: "Exploració de Juice Shop (score board i OWASP Top 10)"
status: draft
version: 0.1
created: 2026-08-06
updated: 2026-08-06
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - juice-shop
  - owasp
  - web
prerequisites:
  - CAP-08-10
related:
  - CAP-08-10
estimated_time: 30 min
difficulty: intermediate
---

# EX-08-04 — Exploració de Juice Shop (score board i OWASP Top 10)

> Descobreix la meitat dels reptes de OWASP Juice Shop només amb el
> navegador. Aprèn a orientar-te en un lab modern.

## Objectiu

Trobar el **score board** ocult de Juice Shop i resoldre els 5 primers
reptes sense cap eina externa (només DevTools del navegador).

## Requisits

- Juice Shop pujat a `10.10.30.20` (port `127.0.0.1:3000` al Kali).
- Túnel SSH: `ssh -L 3000:127.0.0.1:3000 hort-osona@hort`.
- Navegador modern (Firefox/LibreWolf/Chrome).

## Entorn

- Atacant: Kali.
- Víctima: Juice Shop (`10.10.30.20`).
- Eines: DevTools del navegador (F12).

## Passos

### 1. Preparació

Accedeix a `http://127.0.0.1:3000` des del Mac (via túnel). Hauries de
veure la botiga de sucs "OWASP Juice Shop".

### 2. Trobar el score board

Prem **F12** per obrir DevTools. A la consola, escriu:

```javascript
fetch('/api/Challenges/').then(r => r.json()).then(console.log)
```

Hauries de veure un objecte JSON amb **tots els reptes** disponibles.
El score board visual és a `/score-board` — ves-hi directament
(`http://127.0.0.1:3000/#/score-board`).

### 3. Resoldre 5 reptes trivials

Aquí tens els 5 primers, tots es resolen amb el navegador:

| # | Repte | Com resoldre'l |
|---|---|---|
| 1 | Find the score board | Navega a `/#/score-board` |
| 2 | Access the administration section | Navega a `/#/administration` |
| 3 | Find a hidden page | Mira el `robots.txt`: `/robots.txt` |
| 4 | Find a forgotten backup file | Prova `http://127.0.0.1:3000/backup.zip` |
| 5 | Access a restricted file | Prova `/ftp/` (un directori FTP simulat) |

Cada repte resolt et donarà una estrella al score board.

### 4. Comprovació

Vés al score board. Hauries de veure **5 estrelles** i el teu progrés.

## Comprovacions

- [ ] He trobat el score board
- [ ] He resolt els 5 reptes
- [ ] He entès que Juice Shop és **didàctic** — les vulnerabilitats
  són evidents a propòsit

## Què has après

- Les aplicacions web modernes tenen **reptes deliberadament visibles**
  per aprendre — Juice Shop és la referència de l'OWASP.
- El **DevTools del navegador** és la primera eina d'un pentester web.
  Xarxa (Network), consola (Console), i codi font (Sources/Inspector)
  ho mostren gairebé tot.
- Un cop resolts els reptes bàsics, els següents impliquen SQL injection,
  XSS, IDOR, JWT attacks, etc.

## Pròxims passos

Prova a resoldre manualment aquests reptes (sense mirar tutorials):

- Login com `admin@juice-sh.op` sense conèixer la contrasenya.
- Afegir un producte al carret amb preu negatiu.
- Accedir a la comanda d'un altre usuari canviant la ID a la URL.

Si te'n surts, ja tens el nivell per començar a usar **Burp Suite**.

## Referències

- [CAP-08-10](../chapters/cap-08-10-apps-vulnerables.md) — Aplicacions vulnerables
- [OWASP Juice Shop — Source & Docs](https://github.com/juice-shop/juice-shop)
