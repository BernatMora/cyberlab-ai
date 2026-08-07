---
id: EX-08-02
title: "SQL injection a DVWA (nivell Low)"
status: published
version: 1.0
created: 2026-08-06
updated: 2026-08-07
completed: 2026-08-06
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

# EX-08-02 - SQL injection a DVWA (nivell Low)

> Apren la injeccio SQL mes classica: bypass de login amb `' OR '1'='1`.

## Objectiu

Accedir a DVWA sense coneixer cap credencial, explotant una SQL injection
triv al formulari de login.

## Glossari rapid (per si no saps que volen dir les ordres)

| Ordre / cosa | Que vol dir en planer |
|---|---|
| **SQL** | Llenguatge per parlar amb bases de dades. Es com fer una pregunta a un Excel. |
| **SQL Injection** | "Injectar" SQL dins una pregunta per enganyar la base de dades. |
| `SELECT * FROM users WHERE user_id = '$id'` | "**Selecciona** tots els usuaris on el ID es igual a $id". |
| `' OR '1'='1` | La **trampa classica**: diu "l'ID es buit **O** 1=1" - i 1 sempre es igual a 1, aixi que **sempre es veritat**. |
| `--` o `#` | **Comentaris** SQL. Tot el que ve despres no s'executa. Serveix per "tallar" la resta de la query. |
| `$_REQUEST['id']` | **Variable PHP** que conte el que l'usuari ha posat al formulari web. |

## Per que funciona? (analogia)

Imagina que la base de dades es un **bibliotecari** i tu li preguntes:

- Pregunta normal: "Dona'm el llibre amb ID 5"
- Pregunta amb SQL injection: "Dona'm el llibre amb ID **buit o be el primer llibre**"

El bibliotecari (mal programat) enten: "vale, dono el primer llibre". I aixo es nomes el principi.

## Requisits

- DVWA pujat a `10.10.30.10` (port `127.0.0.1:8080` al Kali).
- Tunel SSH obert: `ssh -L 8080:127.0.0.1:8080 hort-osona@hort`.
- DVWA en nivell de seguretat **Low** (per defecte).

## Entorn

- Atacant: Kali (`hort`).
- Victima: DVWA (`dvwa`, `10.10.30.10`).
- Xarxa: `cyberlab_lab-net` (`10.10.30.0/24`).

## Passos

### 1. Preparacio

Accedeix a `http://127.0.0.1:8080` des del navegador del Mac (via tunel).
Fes login amb `admin / password` (credencials per defecte de DVWA).
A la seccio "DVWA Security", posa el nivell a **Low** i guarda.

### 2. Execucio

Ves a "SQL Injection" al menu esquerre. Al camp `User ID`, escriu:

```
' OR '1'='1
```

Prem **Submit**.

**Que esta passant?** La teva entrada literal `' OR '1'='1` sha ficat **dins** la query SQL que el servidor prepara. La query queda axi:

```sql
SELECT first_name, last_name FROM users WHERE user_id = '' OR '1'='1';
```

Lordinador avalua `'1'='1'` i sempre es veritat, per tant retorna **totes** les files.

### 3. Comprovacio

Hauries de veure una llista amb multiples IDs (`1, 2, 3, 4, 5`) i noms
dusuari. Axi vol dir que la consulta SQL ha retornat totes les files
de la taula `users`.

## Comprovacions

- [x] He vist mes dun usuari a la resposta
- [x] He entes per que `' OR '1'='1` trenca la consulta
- [x] He provat amb `' OR 1=1 -- -` (amb comentari)

## Que passa per sota

DVWA construeix la query axi (codi PHP):

```php
$id = $_REQUEST['id'];
$query = "SELECT first_name, last_name FROM users WHERE user_id = '$id';";
```

**Que es cada cosa?**
- `$_REQUEST['id']`: el que lusuari ha posat al formulari.
- `$query`: la pregunta SQL completa que senvia a la base de dades.

Si poses `' OR '1'='1`, la query esdev:

```sql
SELECT first_name, last_name FROM users WHERE user_id = '' OR '1'='1';
```

La condicio `'1'='1'` es sempre certa -> retorna totes les files.

## Variants classiques

| Variant | Que fa |
|---|---|
| `' OR '1'='1` | La mes classica. Retorna tot. |
| `' OR 1=1 -- -` | Igual pero amb comentari per tallar la resta. |
| `' UNION SELECT ... --` | **UNION** combina dues consultes. Permet veure altres taules. |
| `'; DROP TABLE users; --` | La **molt perillosa**: esborra la taula! |

## Errors habituals

| Error | Causa | Solucio |
|---|---|---|
| "You have an error in your SQL syntax" | Cometa mal tancada | Comprova que tens una `'` dobertura i una de tancament |
| No retorna cap fila | Nivell de seguretat massa alt | Posal a **Low** |
| El tunel no respon | No has executat `ssh -L` | Re-executa el tunel SSH |

## Conclusio

Has apres la base de SQL injection: trencar la logica duna query amb
una cometa i una condicio sempre certa. En nivells **Medium** i **High**
DVWA aplica defenses (prepared statements, filtres). Els exploraras als
exercicis seguents.

## Referencies

- [CAP-08-10](../chapters/cap-08-10-apps-vulnerables.md) - Aplicacions vulnerables
- [PortSwigger - SQL injection](https://portswigger.net/web-security/sql-injection)

## Estat

- **Completat per:** Bernat Mora
- **Data:** 2026-08-06
- **Validacio:** La injeccio `' OR '1'='1` va retornar multiples usuaris correctament.
