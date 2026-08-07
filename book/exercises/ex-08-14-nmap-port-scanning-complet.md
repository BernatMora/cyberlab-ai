---
id: EX-08-14
title: "Port scanning complet amb nmap"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - nmap
  - escaneig-de-ports
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

# EX-08-14 - Port scanning complet amb nmap

> Fer un escaneig complet de tots els 65535 ports del Metasploitable2.

## Que has de fer

1. Des del Kali, obre una terminal
2. Prova nomes els 100 ports mes comuns: `nmap -F 10.10.30.30`
3. Prova un rang concret: `nmap -p 1-1000 10.10.30.30`
4. Prova TOTS els ports (pot trigar): `nmap -p- --min-rate=5000 10.10.30.30`
5. Compara resultats entre les tres comandes
6. Compta quants ports hi ha oberts en total

## Que has de buscar

- Quants ports hi ha oberts segons l'escaneig -F?
- Quants mes n'ha trobat l'escaneig complet?
- Quins serveis corresponen a cada port?
- Per que --min-rate=5000 es mes rapid?

## Preguntes per respondre

1. Quants ports hi ha oberts en total?
2. Quina diferencia hi ha entre -F i -p-?
3. Per que --min-rate=5000 es mes rapid?
4. Quin risc te fer un escaneig complet d'un sistema real?

## Glossari

- **nmap -F**: Escaneig rapid. Nomes els 100 ports mes comuns.
- **nmap -p-**: Escaneig de TOTS els 65535 ports. Triga molt mes.
- **--min-rate**: Numero minim de paquets per segon. Mes alt = mes rapid pero mes detectable.
- **ports oberts**: Servei escoltant. Pot ser vulnerable si esta mal configurat.

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
