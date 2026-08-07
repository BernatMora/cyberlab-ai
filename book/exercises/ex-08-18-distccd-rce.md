---
id: EX-08-18
title: "Distccd command execution al Metasploitable"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - distccd
  - rce
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

# EX-08-18 - Distccd command execution al Metasploitable

> Explotar una vulnerabilitat de distccd per executar comandes al Metasploitable2.

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova el servei: `nmap -sV -p 3632 10.10.30.30`
3. Investiga quines eines hi ha per atacar distccd
4. Prova amb nmap scripting: `nmap -p 3632 --script=distcc-cve2004-2687 10.10.30.30`
5. Si nmap no te el script, busca'l a searchsploit
6. Llegeix la documentacio: `searchsploit distccd`
7. Prova l'exploit manualment amb Python o Metasploit

## Que has de buscar

- Quina versio de distccd te el Metasploitable2?
- Es vulnerable? A quin CVE?
- Pots executar comandes? Quines has provat?
- Com podem protegir distccd?

## Preguntes per respondre

1. Quin CVE afecta aquesta versio?
2. Has pogut executar una comanda? Quina?
3. Com podem protegir el servei?

## Glossari

- **distccd**: Distributed C compiler. Servei per compilar codi en xarxa.
- **CVE-2004-2687**: Vulnerabilitat de distccd que permet execucio remota de comandes.
- **RCE**: Remote Code Execution. Execucio de codi remot. La pitjor vulnerabilitat!
- **searchsploit**: Eina local per buscar exploits a la base de dades Exploit-DB.

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
