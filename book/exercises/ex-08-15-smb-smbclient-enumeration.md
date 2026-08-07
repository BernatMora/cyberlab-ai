---
id: EX-08-15
title: "SMB enumeration amb smbclient"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - smb
  - samba
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

# EX-08-15 - SMB enumeration amb smbclient

> Enumerar els recursos compartits SMB del Metasploitable2 amb smbclient.

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova el servei: `nmap -sV -p 139,445 10.10.30.30`
3. Llista els recursos compartits: `smbclient -L //10.10.30.30 -N`
4. El -N vol dir sense contrasenya
5. Busca un recurs interessant (tmp, homes, admin, etc.)
6. Connecta al recurs: `smbclient //10.10.30.30/tmp -N`
7. Un cop dins, fes `ls` per veure els fitxers
8. Baixa un fitxer: `get nom_fitxer`
9. Prova altres recursos si en trobes

## Que has de buscar

- Quants recursos compartits hi ha?
- Quins noms tenen? Son reveladors? (tmp, homes, admin)
- Pots accedir a tots sense contrasenya?
- Hi ha informacio sensible a aquests recursos?
- Com podem protegir el SMB?

## Preguntes per respondre

1. Quants recursos has trobat?
2. Quin es el mes perillos?
3. Com podem protegir el SMB?
4. Per que es tant critic el SMB sense autenticacio?

## Glossari

- **SMB**: Server Message Block. Protocol per compartir fitxers i impressores a xarxes Windows.
- **Samba**: Implementacio de SMB per a Linux. Permet compartir fitxers entre Windows i Linux.
- **smbclient**: Client de linia de comandes per accedir a recursos SMB.
- **recursos compartits**: Carpetes o impressores compartides per SMB.
- **NULL session**: Connexio SMB sense autenticacio. Vulnerabilitat critica!

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
