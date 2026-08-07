---
id: EX-08-11
title: "MySQL enumeration - Explicat per a gent inexperta"
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

# EX-08-11 - MySQL enumeration - Explicat per a gent inexperta

> Aprendre a connectar al MySQL i enumerar les dades.

## Que necessites saber

### Que es MySQL?

**MySQL** es un **sistema de gestio de bases de dades**. Es el mes utilitzat del mon. Guarda dades de forma estructurada en **taules**.

Exemple: una web guarda usuaris, productes, comandes en una base de dades MySQL.

### Que es una base de dades?

Una **base de dades** es com un **Excel gegant** amb moltes taules. Cada taula te files (les dades) i columnes (els camps).

Exemple de taula `usuaris`:
| id | nom | correu |
|---|---|---|
| 1 | Bernat | bernat@example.com |
| 2 | Maria | maria@example.com |

### Que es credencials buides?

**Credencials buides** vol dir que pots entrar al MySQL **sense posar usuari ni contrasenya**.

Es una **vulnerabilitat critica** que sha de corregir sempre. Si un atacant troba això, pot veure TOTES les dades.

### Que es un hash?

Un **hash** es una **contrasenya xifrada**. 

Exemple:
- Contrasenya: `password`
- Hash MD5: `5f4dcc3b5aa765d61d8327deb882cf99`

Si veus un hash, **no pots** saber quina es la contrasenya original (en teoria).

### Que es mysql?

**mysql** es el **client** de linia de comandes per connectar al MySQL. Permet fer consultes directament.

### Glossari

- **MySQL**: sistema de bases de dades
- **base de dades**: lloc on es guarden les dades
- **taula**: estructura amb files i columnes
- **credencials buides**: acces sense autenticacio
- **hash**: contrasenya xifrada
- **mysql**: client per connectar al MySQL
- **port 3306**: port per defecte del MySQL

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova el servei: `nmap -sV -p 3306 10.10.30.30`
3. Prova credencials buides: `mysql -h 10.10.30.30 -u root`
4. Si funciona, veuras un prompt `mysql>`
5. Llista les bases de dades: `SHOW DATABASES;`
6. Canvia a una BD: `USE mysql;`
7. Llista les taules: `SHOW TABLES;`
8. Mira els usuaris: `SELECT User, Password FROM user;`
9. Si no va, prova amb altres usuaris: `mysql -h 10.10.30.30 -u admin`
10. Prova tambe amb hydra per trobar mes credencials

## Que has de buscar

- Has pogut entrar? Amb quines credencials?
- Quantes bases de dades hi ha?
- Quins usuaris hi ha?
- Les contrasenyes son hash? De quin tipus?
- Pots veure informacio sensible?

## Preguntes que has de respondre

1. Que es MySQL?
2. Has pogut entrar?
3. Quines bases de dades hi ha?
4. Com podem protegir el MySQL?

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
