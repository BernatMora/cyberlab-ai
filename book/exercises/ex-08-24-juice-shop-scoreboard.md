---
id: EX-08-24
title: "Juice Shop - trobar el scoreboard"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - juice-shop
  - owasp
  - nivell-mitja
prerequisites:
  - LAB-15-10
related:
  - LAB-15-10
  - LAB-15-11
estimated_time: 30 min
difficulty: beginner
---

# EX-08-24 - Juice Shop - trobar el scoreboard

> Trobar el scoreboard amagat del Juice Shop.

## Que has de fer

1. Des del Kali, obre un navegador: `firefox http://10.10.30.20:3000/`
2. Mira el menu lateral, les opcions, els enllacos
3. Mira el codi font de la pagina (Ctrl+U)
4. Busca comentaris HTML: `<!--`
5. Prova URLs comuns: /score-board, /scoreboard, /admin, /api
6. Mira la consola JavaScript (F12)
7. Busca fitxers ocults amb gobuster: `gobuster dir -u http://10.10.30.20:3000/ -w /usr/share/wordlists/dirb/common.txt -x html,js,json`
8. Quan trobis el scoreboard, mira quins reptes hi ha
9. Intenta resoldre'n algun (per exemple, trobar la pagina oculta)

## Que has de buscar

- Has trobat el scoreboard? On?
- Quants reptes hi ha?
- Has pogut resoldre'n algun?
- Com podem protegir contra aquestes tecniques?

## Preguntes per respondre

1. Has trobat el scoreboard?
2. Quants reptes hi ha?
3. Quin es el mes facil? Per que?
4. Com podem protegir contra aquestes tecniques?

## Glossari

- **OWASP**: Open Web Application Security Project. Organitzacio que publica llista de vulnerabilitats.
- **scoreboard**: Panell que mostra els reptes completats. En Juice Shop esta amagat.
- **recon**: Reconaixement. Primera fase d'un atac. Recollir informacio.
- **F12**: Tecla per obrir les DevTools del navegador. Util per inspeccionar.

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
