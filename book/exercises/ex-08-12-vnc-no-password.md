---
id: EX-08-12
title: "VNC sense contrasenya al Metasploitable"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - vnc
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

# EX-08-12 - VNC sense contrasenya al Metasploitable

> Entrar al VNC del Metasploitable2 sense contrasenya i capturar pantalla.

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova el servei: `nmap -sV -p 5900 10.10.30.30`
3. Instal·la un client VNC: `sudo apt install vncviewer`
4. Prova connectar: `vncviewer 10.10.30.30:5900`
5. Si et demana contrasenya, prem Enter (buida)
6. Si funciona, ja tens l'escriptori remot
7. Fes una captura de pantalla amb `scrot` (si tens entorn grafic)
8. Tanca la sessio VNC quan acabis

## Que has de buscar

- Pots entrar sense contrasenya?
- Que hi ha a l'escriptori del Metasploitable?
- Que pot fer un atacant amb acces VNC?
- Com podem protegir el VNC?

## Preguntes per respondre

1. Has pogut entrar al VNC?
2. Que hi ha a l'escriptori?
3. Es una vulnerabilitat critica?

## Glossari

- **VNC**: Virtual Network Computing. Permet controlar un escriptori remotament.
- **port 5900**: Port per defecte del VNC. VNC 5901 = display :1, etc.
- **sense contrasenya**: Quan el VNC no demana autenticacio. Molt perillos!
- **control remot**: Permet a un atacant veure i controlar l'escriptori de la victima.

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
