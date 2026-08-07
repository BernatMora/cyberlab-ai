---
id: EX-08-25
title: "Hash cracking amb john - Explicat per a gent inexperta"
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

# EX-08-25 - Hash cracking amb john - Explicat per a gent inexperta

> Aprendre a trencar hashes de contrasenyes amb john.

## Que necessites saber

### Que es un hash?

Un **hash** es una **contrasenya xifrada**. 

Exemple:
- Contrasenya: `password`
- Hash MD5: `5f4dcc3b5aa765d61d8327deb882cf99`

Si veus un hash, **no pots** saber quina es la contrasenya original (en teoria).

### Que es john the ripper?

**john** (John the Ripper) es una eina per **trencar hashes**. Prova milions de combinacions rapidament.

### Que es rockyou.txt?

**rockyou.txt** es la **wordlist mes famosa** del mon. Te 14 milions de contrasenyes reals que sha filtrat d'un atac del 2009.

Es el primer lloc on mirar per trencar hashes.

### Que es bcrypt?

**bcrypt** es un **algoritme de hash fort**. Es molt mes dificil de trencar que MD5 o SHA1.

Si una web utilitza bcrypt, els atacs de cracking son molt mes lents.

### Que es salting?

**Salting** es **afegir text aleatori** al hash per fer-lo unic. Aixi dos usuaris amb la mateixa contrasenya tenen hashes diferents.

Exemple: 
- Sense salt: hash("password") = "5f4dcc3b..."
- Amb salt: hash("password" + "abc123") = "e99a18c2..."

### Glossari

- **hash**: contrasenya xifrada
- **john the ripper**: eina de cracking
- **MD5**: algoritme de hash feble
- **rockyou.txt**: wordlist famosa
- **bcrypt**: algoritme de hash fort
- **salting**: afegir text aleatori al hash
- **cracking**: trencar hashes per obtenir contrasenyes

## Que has de fer

1. Si no tens els hashes, primer fes [EX-08-22](ex-08-22-sql-injection-manual-dvwa.md) o [EX-08-02](ex-08-02-sql-injection-dvwa.md)
2. Copia els hashes MD5 que has trobat
3. Crea un fitxer `hashes.txt` amb els hashes (un per linia)
4. Des del Kali: `john --format=raw-md5 --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt`
5. Si no tens rockyou: `sudo apt install wordlists`
6. Espera que acabi
7. Mira els resultats: `john --show hashes.txt`

## Que has de buscar

- Quants hashes has aconseguit?
- Quantes contrasenyes has trencat?
- Quant ha trigat?
- Quin tipus de hash es?

## Preguntes que has de respondre

1. Quantes contrasenyes has trencat?
2. Quant ha trigat?
3. Com podem protegir les contrasenyes?
4. Per que bcrypt es mes segur que MD5?

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
