---
id: EX-08-16
title: "Deteccio de tecnologies amb whatweb - Explicat per a gent inexperta"
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

# EX-08-16 - Deteccio de tecnologies amb whatweb - Explicat per a gent inexperta

> Aprendre a identificar tecnologies darrere d'una web.

## Que necessites saber

### Que es whatweb?

**whatweb** es una eina que **identifica les tecnologies** que fan servir les webs. Et pot dir:
- Quin servidor web (Apache, Nginx, etc.)
- Quin llenguatge (PHP, Python, etc.)
- Quin CMS (WordPress, Joomla, etc.)
- Quines versions

### Que es una tecnologia web?

Es qualsevol **programa o llenguatge** que fa funcionar una web:
- **Apache, Nginx**: servidors web
- **PHP, Python, Ruby**: llenguatges
- **WordPress, Drupal**: CMS
- **jQuery, React**: llibreries JavaScript

### Que es un CMS?

**CMS** (Content Management System) es un sistema per gestionar contingut. WordPress es el mes popular i alimenta el 40% de les webs del mon.

Si trobem un WordPress, podem buscar exploits per a la versio.

### Que es l'agressivitat a whatweb?

whatweb te 4 nivells d'agressivitat:
- **1 (passive)**: nomes mira el que veu (rapid)
- **2 (aggressive)**: fa mes peticions
- **3 (heavy)**: fa moltes peticions
- **4 (extreme)**: TOT

Mes agressiu = mes info pero mes lent i detectable.

### Glossari

- **whatweb**: eina d'identificacio de tecnologies
- **Apache, Nginx**: servidors web
- **PHP, Python**: llenguatges de programacio
- **CMS**: sistema de gestio de contingut
- **WordPress**: el CMS mes popular
- **agressivitat**: nivell de detall de l'escaneig

## Que has de fer

1. Des del Kali, obre una terminal
2. Prova contra DVWA: `whatweb http://10.10.30.10/`
3. Prova contra Juice Shop: `whatweb http://10.10.30.20:3000/`
4. Prova contra Metasploitable: `whatweb http://10.10.30.30/`
5. Prova amb agressivitat maxima: `whatweb -a 4 http://10.10.30.30/`

## Que has de buscar

- Quines tecnologies ha detectat per cada web?
- Quines versions? Son actuals?
- Hi ha cap CMS?
- Quines llibreries utilitza Juice Shop?
- Quant triga l'agressivitat 4?

## Preguntes que has de respondre

1. Quines son les tecnologies principals?
2. Quines versions son mes vulnerables?
3. Per que la agressivitat 4 triga mes?
4. Com podem amagar aquestes tecnologies?

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
