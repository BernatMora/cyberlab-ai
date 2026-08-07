---
id: EX-08-16
title: "Deteccio de tecnologies amb whatweb"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - whatweb
  - reconeixement
  - dvwa
  - juice-shop
  - nivell-principiant
prerequisites:
  - LAB-15-10
related:
  - LAB-15-10
  - LAB-15-11
estimated_time: 30 min
difficulty: beginner
---

# EX-08-16 - Deteccio de tecnologies amb whatweb

> Identificar les tecnologies que hi ha darrere dels servidors web.

## Que has de fer

1. Des del Kali, obre una terminal
2. Prova contra DVWA: `whatweb http://10.10.30.10/`
3. Prova contra Juice Shop: `whatweb http://10.10.30.20:3000/`
4. Prova contra Metasploitable: `whatweb http://10.10.30.30/`
5. Prova amb agressivitat maxima: `whatweb -a 4 http://10.10.30.30/`
6. Prova amb el plugin de versio: `whatweb --plugins=versions http://10.10.30.10/`

## Que has de buscar

- Quines tecnologies ha detectat per cada web?
- Quines versions? Son actuals?
- Hi ha cap CMS? (WordPress, Joomla, etc.)
- Quines llibreries JavaScript utilitza Juice Shop?
- Agressivitat 4 es mes complet pero mes lent - quant triga?

## Preguntes per respondre

1. Quines son les tecnologies principals de cada web?
2. Quines versions son mes vulnerables?
3. Per que la agressivitat 4 triga mes?
4. Com podem amagar aquestes tecnologies?

## Glossari

- **whatweb**: Eina de reconeixement web. Identifica tecnologies, CMS, versions, etc.
- **CMS**: Content Management System. WordPress, Joomla, Drupal, etc.
- **agressivitat**: Nivell de detall de l'escaneig. De 1 (basic) a 4 (tot).
- **reconeixement**: Primera fase d'un atac. Recollir informacio sobre l'objectiu.

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
