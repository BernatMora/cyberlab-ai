---
id: EX-08-07
title: "FTP anonymous login al Metasploitable"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - ftp
  - anonymous
  - metasploitable2
  - nivell-principiant
prerequisites:
  - LAB-15-10
related:
  - LAB-15-10
  - LAB-15-11
estimated_time: 30 min
difficulty: beginner
---

# EX-08-07 - FTP anonymous login al Metasploitable

> Entrar al servidor FTP del Metasploitable2 amb anonymous i trobar fitxers interessants.

## Que has de fer

1. Des del Kali, obre una terminal
2. Fes `nmap -p 21 -sV 10.10.30.30` per veure quin servei FTP hi ha
3. Prova `ftp 10.10.30.30` des del Kali (instal·la'l si cal: `sudo apt install ftp`)
4. Quan et demani usuari, escriu `anonymous`
5. Quan et demani contrasenya, prem Enter (buida)
6. Un cop dins, fes `ls -la` per veure tots els fitxers
7. Baixa el fitxer que trobis amb `get nom_fitxer`
8. Mira el contingut amb `cat` o `less`

## Que has de buscar

- Quin servidor FTP hi ha? (vsftpd, ProFTPD, etc.)
- Quina versio?
- Quins fitxers hi ha disponibles per anonymous?
- Hi ha informacio sensible? (passwords, notes, config)
- Pots pujar fitxers? (prova `put` amb un fitxer de prova)

## Preguntes per respondre

1. Quin servidor FTP hi ha? De quina versio es?
2. Quin fitxer/s has trobat? De que parlen?
3. Anonymous te permisos d'escriptura? Com ho has vist?
4. Es una vulnerabilitat critica? Per que?

## Glossari

- **FTP**: Protocol de transferencia de fitxers. Porta 21 per defecte. Servei molt antic.
- **anonymous**: Accedir al servidor FTP sense usuari/contrasenya. Molts servidors antics ho permeten.
- **vsftpd**: Very Secure FTP Daemon. Ironia: la versio 2.3.4 te una porta del darrere!
- **nmap -sV**: Deteccio de versions. Mostra quin programari i quina versio hi ha darrere un port.

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
