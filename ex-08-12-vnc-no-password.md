---
id: EX-08-12
title: "VNC sense contrasenya - Explicat per a gent inexperta"
status: draft
version: 2.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - per-a-principiants
  - explicacio-detallada
prerequisites:
  - LAB-15-10
  - ANN-09
related:
  - LAB-15-10
  - ANN-08
  - ANN-09
estimated_time: 30 min
difficulty: beginner
---

# EX-08-12 - VNC sense contrasenya - Explicat per a gent inexperta

> Aprendre a accedir a un VNC sense autenticacio.

## Que necessites saber

### Que es VNC?

**VNC** (Virtual Network Computing) es un sistema per **controlar un ordinador remotament** veient el seu escriptori.

Es com **TeamViewer** pero mes antic i basic.

Funciona pel **port 5900**.

### Que es un escriptori remot?

Un **escriptori remot** et permet veure i controlar la pantalla d'un altre ordinador des del teu. Serveix per:
- Ajuda tecnica
- Treballar desde casa
- Accedir a un servidor

### Que es una contrasenya buida?

Igual que amb MySQL, una **contrasenya buida** vol dir que pots accedir al VNC **sense posar cap contrasenya**.

Es MOLT perillos perque l'atacant pot veure i fer **tot el que tu pots fer**.

### Que es vncviewer?

**vncviewer** es el **client** per connectar a un servidor VNC. Et mostra l'escriptori remot en una finestra.

### Glossari

- **VNC**: sistema d'escriptori remot
- **port 5900**: port per defecte del VNC
- **escriptori remot**: veure i controlar un altre PC
- **contrasenya buida**: acces sense autenticacio
- **vncviewer**: client per connectar al VNC
- **RFB**: protocol que utilitza VNC

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova el servei: `nmap -sV -p 5900 10.10.30.30`
3. Instal·la el client VNC: `sudo apt install tigervnc-viewer` (o vncviewer)
4. Connecta: `vncviewer 10.10.30.30:5900`
5. Si et demana contrasenya, prem Enter (buida)
6. Si funciona, veuras l'escriptori remot
7. Fes una captura de pantalla (scrot si tens entorn grafic)
8. Explora el que pots fer
9. Tanca la sessio quan acabis

## Que has de buscar

- Has pogut entrar al VNC?
- Que hi ha a l'escriptori?
- Quines accions pots fer?
- Es una vulnerabilitat critica?

## Preguntes que has de respondre

1. Que es VNC?
2. Has pogut accedir sense contrasenya?
3. Que podria fer un atacant amb acces VNC?
4. Com podem protegir el VNC?

## Si no entens alguna cosa

1. **Torna a llegir** la seccio "Que necessites saber"
2. **Mira** [ANN-09](ann-09-comencar-de-zero.md) - Guia per a gent inexperta
3. **Mira** [ANN-08](ann-08-glossari-ports.md) - Glossari de ports
4. **Pregunta** si segueixes sense entendre

## Solucio de problemes

Si alguna cosa no funciona:

1. **Comprova** que el lab esta actiu (`docker ps` al Kali)
2. **Comprova** que tens acces a Internet des del Kali
3. **Comprova** que la IP que estas fent servir es correcta
4. **Llegeix** l'error amb atencio - sovint diu que passa

## Validacio

Quan acabis, compara els teus resultats amb els del document [LAB-15-11](../labs/lab-15-11-nmap-complet-metaploitable2.md).

## Seguretat

**Recorda**:
- Aixo es **nomes per practicar** al lab
- Mai en sistemes **reals** sense permis
- Practicar sense permis es **IL·LEGAL**
- Si tens dubtes, pregunta

## Referencies

- [ANN-09](ann-09-comencar-de-zero.md) - Començar de zero
- [ANN-08](ann-08-glossari-ports.md) - Glossari de ports
- [LAB-15-10](../labs/lab-15-10-lab-real-muntat.md) - Lab real muntat al Kali
- [LAB-15-11](../labs/lab-15-11-nmap-complet-metaploitable2.md) - Nmap complet
