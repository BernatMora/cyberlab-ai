---
id: EX-08-01
title: "Nmap contra Metasploitable - Explicat per a gent inexperta"
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

# EX-08-01 - Nmap contra Metasploitable - Explicat per a gent inexperta

> Aprendre que es nmap i com trobar quins serveis hi ha oberts al Metasploitable2.

## Que necessites saber

### Que es nmap?

**nmap** es una eina que serveix per **veure quins serveis hi ha oberts** en un ordinador. Es com si passes per un edifici mirant quines finestres tenen gent a dins.

nmap:
- Escaneja **ports** (les finestres)
- Et diu quin **servei** hi ha (web, FTP, base de dades...)
- Et diu quina **versio** del programa es

### Que es un port?

Si no saps que es un port, llegeix primer la guia [ANN-09](../appendices/ann-09-comencar-de-zero.md) i [ANN-08](../appendices/ann-08-glossari-ports.md).

### Que es Metasploitable2?

Es una **maquina antiga** que sha fet expressament per ser vulnerable. Te molts serveis oberts amb versions molt antigues.

### Que veuras?

nmap et mostrara una llista de **ports** amb la **informacio** del servei que hi ha.

Exemple de resultat:
```
PORT   STATE SERVICE
22/tcp open  ssh
80/tcp open  http
```

Aixo vol dir:
- Al port 22 hi ha **SSH** (acces remot)
- Al port 80 hi ha **HTTP** (servidor web)
- Els dos estan **oberts** (tenen servei escoltant)

### Glossari d'aquest exercici

- **nmap**: eina per escanejar ports
- **port**: numero que identifica un servei
- **servei**: programa que escolta en un port
- **versio**: quina versio del programa es
- **STATE open**: servei actiu, pots connectar-t'hi
- **STATE closed**: no hi ha servei en aquest port
- **-sV**: opcio de nmap per detectar versions

## Que has de fer

1. Des del Kali, obre una terminal
2. Escriu: `nmap 10.10.30.30` i prem Enter
3. Espera que acabi (triga uns segons)
4. Llegeix els resultats amb atencio
5. Ara escriu: `nmap -sV 10.10.30.30`
6. Aquesta comanda mostra les versions dels programes
7. Compara els dos resultats

## Que has de buscar

- Quants ports hi ha oberts?
- Quins serveis has trobat?
- Quines versions son? (amb -sV)
- Quin servei es mes antic?
- Quin servei te mes vulnerabilitats conegudes?

## Preguntes que has de respondre

1. Quants ports hi ha oberts al Metasploitable?
2. Quin es el port 21? I el 22? I el 80?
3. Per que nmap -sV triga mes?
4. Es perillos tenir molts serveis oberts?

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
