---
id: EX-08-26
title: "Nessus/OpenVAS basics - Explicat per a gent inexperta"
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

# EX-08-26 - Nessus/OpenVAS basics - Explicat per a gent inexperta

> Aprendre a instal·lar i utilitzar un escanejador de vulnerabilitats professional.

## Que necessites saber

### Que es un escanejador de vulnerabilitats?

Es una eina que **busca automaticament** totes les vulnerabilitats conegudes en un sistema. Es com un **nmap pero molt mes potent**.

### Que es OpenVAS?

**OpenVAS** (Open Vulnerability Assessment System) es un escanejador de vulnerabilitats **gratuït i open source**.

Es el mes utilitzat del mon per ser gratis i potent.

### Que es Nessus?

**Nessus** es el **mes popular** pero es **de pagament**. Te una versio gratuita limitada anomenada Nessus Essentials.

### Que es CVE database?

**CVE** (Common Vulnerabilities and Exposures) es una **base de dades** de totes les vulnerabilitats conegudes. Cada vulnerabilitat te un identificador unic.

Exemple: **CVE-2017-0144** es **EternalBlue**, la vulnerabilitat que sha utilitzat per WannaCry.

### Que es CVSS?

**CVSS** (Common Vulnerability Scoring System) es un sistema de **puntuacio** de vulnerabilitats. Va de 0 a 10:
- **0.1-3.9**: baixa
- **4.0-6.9**: mitjana
- **7.0-8.9**: alta
- **9.0-10.0**: critica

### Glossari

- **OpenVAS**: escanejador de vulnerabilitats open source
- **Nessus**: escanejador professional (de pagament)
- **CVE**: base de dades de vulnerabilitats
- **CVSS**: puntuacio de severitat
- **vulnerabilitat**: forat de seguretat

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova si tens OpenVAS: `openvas-setup`
3. Si no, instal·la: `sudo apt install openvas && sudo openvas-setup`
4. Espera que acabi (pot trigar 30-60 min)
5. Inicia el servei: `sudo systemctl start openvas`
6. Obre el navegador: `firefox https://127.0.0.1:9392`
7. Entra amb les credencials
8. Crea una tasca per escanejar 10.10.30.30
9. Executa l'escaneig
10. Mira els resultats

## Que has de buscar

- Has pogut instal·lar OpenVAS?
- Quantes vulnerabilitats ha trobat?
- Quines son les mes critiques?
- Com es compara amb nmap?

## Preguntes que has de respondre

1. Que es OpenVAS?
2. Quantes vulnerabilitats ha trobat?
3. Quin es mes complet: OpenVAS o nmap?
4. OpenVAS es gratuit?

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
