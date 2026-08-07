---
id: EX-08-26
title: "Nessus/OpenVAS basics - instal·lacio i us"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - nessus
  - openvas
  - escaneig-vulnerabilitats
  - nivell-avansat
prerequisites:
  - LAB-15-10
related:
  - LAB-15-10
  - LAB-15-11
estimated_time: 30 min
difficulty: beginner
---

# EX-08-26 - Nessus/OpenVAS basics - instal·lacio i us

> Instal·lar i configurar un escanejador de vulnerabilitats profesional.

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova si tens OpenVAS: `openvas-setup` (potser ja esta instal·lat)
3. Si no, instal·la'l: `sudo apt install openvas && sudo openvas-setup`
4. Espera que acabi la configuracio (pot trigar 30-60 min)
5. Inicia el servei: `sudo systemctl start openvas`
6. Obre el navegador: `firefox https://127.0.0.1:9392`
7. Entra amb les credencials que t'ha donat openvas-setup
8. Crea una tasca nova per escanejar 10.10.30.30
9. Executa l'escaneig
10. Mira els resultats i les vulnerabilitats trobades

## Que has de buscar

- Has pogut instal·lar OpenVAS?
- Quantes vulnerabilitats ha trobat?
- Quines son les mes critiques?
- Com es compara amb el nmap --script=vuln?
- Quin es mes complet?

## Preguntes per respondre

1. Quantes vulnerabilitats ha trobat?
2. Quines son les mes critiques?
3. Com es compara amb nmap?
4. OpenVAS es gratuit? Es professional?

## Glossari

- **OpenVAS**: Open Vulnerability Assessment System. Eina gratuita d'escaneig de vulnerabilitats.
- **Nessus**: Escanejador de vulnerabilitats profesional (de pagament).
- **CVE database**: Base de dades de vulnerabilitats conegudes.
- **CVSS**: Common Vulnerability Scoring System. Puntuacio de severitat.

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
