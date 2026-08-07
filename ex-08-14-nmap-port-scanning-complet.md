---
id: EX-08-14
title: "Port scanning complet amb nmap - Explicat per a gent inexperta"
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

# EX-08-14 - Port scanning complet amb nmap - Explicat per a gent inexperta

> Aprendre els diferents tipus d'escaneig de ports amb nmap.

## Que necessites saber

### Que es nmap?

**nmap** es una eina per veure **quins serveis hi ha oberts** en un equip.

Si no saps que es nmap, llegeix primer [EX-08-01](ex-08-01-nmap-metasploitable.md).

### Que es un port?

Si no saps que es un port, llegeix primer [ANN-08](ann-08-glossari-ports.md).

### Tipus d'escaneig

nmap te **moltes opcions** per fer escanejos:

- **-F**: nomes els 100 ports mes comuns (rapid)
- **-p 1-1000**: un rang de ports concret
- **-p-**: TOTS els 65535 ports (lent pero complet)
- **--min-rate=5000**: com a minim 5000 paquets per segon (mes rapid)

### Que son els paquets?

Quan nmap escaneja, envia **paquets** (missatges petits) a cada port i mira si hi ha resposta.

Mes paquets per segon = mes rapid pero mes **detectable** (el servidor pot veure que l'estan escanejant).

### Glossari

- **nmap**: eina d'escaneig de ports
- **port**: numero que identifica un servei
- **-F**: escaneig rapid (100 ports)
- **-p-**: tots els ports
- **--min-rate**: paquets per segon
- **paquet**: missatge de xarxa

## Que has de fer

1. Des del Kali, obre una terminal
2. Prova nomes els 100 mes comuns: `nmap -F 10.10.30.30`
3. Compta quants n'ha trobat
4. Prova un rang: `nmap -p 1-1000 10.10.30.30`
5. Compara resultats
6. Prova tots els ports: `nmap -p- --min-rate=5000 10.10.30.30`
7. Compara els 3 resultats
8. Compta quants ports hi ha en total

## Que has de buscar

- Quants ports ha trobat l'escaneig -F?
- Quants mes n'ha trobat l'escaneig complet?
- Quins serveis hi ha?
- Per que --min-rate=5000 es mes rapid?

## Preguntes que has de respondre

1. Quants ports hi ha oberts en total?
2. Quina diferencia hi ha entre -F i -p-?
3. Per que --min-rate=5000 es mes rapid?
4. Quin risc te fer un escaneig complet?

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
