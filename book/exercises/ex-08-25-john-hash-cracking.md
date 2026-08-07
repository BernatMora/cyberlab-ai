---
id: EX-08-25
title: "Hash cracking amb john the ripper"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - john
  - hash
  - cracking
  - nivell-mitja
prerequisites:
  - LAB-15-10
related:
  - LAB-15-10
  - LAB-15-11
estimated_time: 30 min
difficulty: beginner
---

# EX-08-25 - Hash cracking amb john the ripper

> Utilitzar john per trencar hashes de contrasenyes obtingudes amb SQL injection.

## Que has de fer

1. Si no les tens, primer fes l'exercici EX-08-22 (SQL injection)
2. Copia els hashes MD5 que has trobat
3. Crea un fitxer `hashes.txt` amb els hashes (un per linia)
4. Des del Kali: `john --format=raw-md5 --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt`
5. Si no tens rockyou, instal·la'l: `sudo apt install wordlists`
6. Espera que acabi (pot trigar una estona)
7. Mira els resultats: `john --show hashes.txt`

## Que has de buscar

- Quants hashes has aconseguit?
- Quantes contrasenyes has trencat?
- Quant ha trigat?
- Quin tipus de hash es? (MD5, SHA1)
- Com podem protegir les contrasenyes?

## Preguntes per respondre

1. Quantes contrasenyes has trencat?
2. Quant ha trigat?
3. Quin tipus de hash es?
4. Com podem protegir les contrasenyes? (bcrypt, argon2)

## Glossari

- **john**: John the Ripper. Eina per trencar hashes de contrasenyes.
- **MD5**: Algoritme de hash feble. Es pot trencar rapid.
- **rockyou.txt**: Llista de contrasenyes famosa. Te milions de contrasenyes reals.
- **bcrypt**: Algoritme de hash fort. Dificulta el cracking.
- **salting**: Afegir text aleatori al hash per fer-lo unic.

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
