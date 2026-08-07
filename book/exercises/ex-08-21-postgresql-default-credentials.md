---
id: EX-08-21
title: "PostgreSQL default credentials"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - postgresql
  - credencials
  - metasploitable2
  - nivell-mitja
prerequisites:
  - LAB-15-10
related:
  - LAB-15-10
  - LAB-15-11
estimated_time: 30 min
difficulty: beginner
---

# EX-08-21 - PostgreSQL default credentials

> Entrar al PostgreSQL amb credencials per defecte.

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova el servei: `nmap -sV -p 5432 10.10.30.30`
3. Prova credencials per defecte: `psql -h 10.10.30.30 -U postgres -W`
4. Quan et demani contrasenya, prova: `postgres`, `password`, `admin`, `123456`
5. Si funciona, veuras un prompt `postgres=#`
6. Llista les bases de dades: `\l`
7. Canvia a una BD: `\c template1`
8. Llista les taules: `\dt`
9. Mira el contingut: `SELECT * FROM pg_user;`

## Que has de buscar

- Quines credencials funcionen?
- Quantes bases de dades hi ha?
- Pots accedir a informacio sensible?
- Com podem protegir PostgreSQL?

## Preguntes per respondre

1. Has pogut entrar? Amb quines credencials?
2. Quantes bases de dades hi ha?
3. Com podem protegir PostgreSQL?

## Glossari

- **PostgreSQL**: Sistema de gestio de bases de dades. Alternativa a MySQL.
- **credencials per defecte**: Usuari/contrasenya que venen per defecte. MOLT perillos!
- **psql**: Client de linia de comandes per PostgreSQL.
- **\l**: Llista totes les bases de dades.
- **\dt**: Llista totes les taules de la base de dades actual.

## Validacio

Quan acabis, compara els teus resultats amb els del document [LAB-15-11](../labs/lab-15-11-nmap-complet-metaploitable2.md).

## Seguretat

**Recorda**: 
- Aquestes tecniques nomes sha d'utilitzar en entorns controlats (com aquest lab)
- Mai en sistemes reals sense permis
- Practicar sense permis es IL·LEGAL

## Referencies

- [LAB-15-10](../labs/lab-15-10-lab-real-muntat.md) - Lab real muntat al Kali
- [LAB-15-11](../labs/lab-15-11-nmap-complet-metaploitable2.md) - Nmap complet
- [EX-08-01](ex-08-01-nmap-metasploitable.md) - Nmap Metasploitable
- [EX-08-02](ex-08-02-sql-injection-dvwa.md) - SQL Injection DVWA
