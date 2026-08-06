---
id: EX-08-02
title: "SQL injection a DVWA (nivell Low)"
status: draft
version: 0.1
created: 2026-08-06
updated: 2026-08-06
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - sql-injection
  - dvwa
  - web
prerequisites:
  - CAP-08-10
related:
  - CAP-08-10
estimated_time: 15 min
difficulty: beginner
---

# EX-08-02 — SQL injection a DVWA (nivell Low)

> Aprèn la injecció SQL més clàssica: bypass de login amb `' OR '1'='1`.

## Objectiu

Accedir a DVWA sense conèixer cap credencial, explotant una SQL injection
triv al formulari de login.

## Requisits

- DVWA pujat a `10.10.30.10` (port `127.0.0.1:8080` al Kali).
- Túnel SSH obert: `ssh -L 8080:127.0.0.1:8080 hort-osona@hort`.
- DVWA en nivell de seguretat **Low** (per defecte).

## Entorn

- Atacant: Kali (`hort`).
- Víctima: DVWA (`dvwa`, `10.10.30.10`).
- Xarxa: `cyberlab_lab-net` (`10.10.30.0/24`).

## Passos

### 1. Preparació

Accedeix a `http://127.0.0.1:8080` des del navegador del Mac (via túnel).
Fes login amb `admin / password` (credencials per defecte de DVWA).
A la secció "DVWA Security", posa el nivell a **Low** i guarda.

### 2. Execució

Ves a "SQL Injection" al menú esquerre. Al camp `User ID`, escriu:

```
' OR '1'='1
```

Prem **Submit**.

### 3. Comprovació

Hauries de veure una llista amb múltiples IDs (`1, 2, 3, 4, 5`) i noms
d'usuari. Això vol dir que la consulta SQL ha retornat totes les files
de la taula `users`.

## Comprovacions

- [ ] He vist més d'un usuari a la resposta
- [ ] He entès per què `' OR '1'='1` trenca la consulta
- [ ] He provat amb `' OR 1=1 -- -` (amb comentari)

## Què passa per sota

DVWA construeix la query així (codi PHP):

```php
$id = $_REQUEST['id'];
$query = "SELECT first_name, last_name FROM users WHERE user_id = '$id';";
```

Si poses `' OR '1'='1`, la query esdevé:

```sql
SELECT first_name, last_name FROM users WHERE user_id = '' OR '1'='1';
```

La condició `'1'='1'` és sempre certa → retorna totes les files.

## Errors habituals

| Error | Causa | Solució |
|---|---|---|
| "You have an error in your SQL syntax" | Cometa mal tancada | Comprova que tens una `'` d'obertura i una de tancament |
| No retorna cap fila | Nivell de seguretat massa alt | Posa'l a **Low** |
| El túnel no respon | No has executat `ssh -L` | Re-executa el túnel SSH |

## Conclusió

Has après la base de SQL injection: trencar la lògica d'una query amb
una cometa i una condició sempre certa. En nivells **Medium** i **High**
DVWA aplica defenses (prepared statements, filtres). Els exploraràs als
exercicis següents.

## Referències

- [CAP-08-10](../chapters/cap-08-10-apps-vulnerables.md) — Aplicacions vulnerables
- [PortSwigger — SQL injection](https://portswigger.net/web-security/sql-injection)
