---
id: EX-08-21
title: "PostgreSQL default credentials - Explicat per a gent inexperta"
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

# EX-08-21 - PostgreSQL default credentials - Explicat per a gent inexperta

> Aprendre a entrar al PostgreSQL amb credencials per defecte.

## Que necessites saber

### Que es PostgreSQL?

**PostgreSQL** (o "Postgres") es un **sistema de bases de dades** molt potent. Es una **alternativa a MySQL**.

Utilitza el **port 5432**.

### Que son credencials per defecte?

**Credencials per defecte** son **usuari/contrasenya** que venen configurats de fabrica. Son coneguts per tothom.

Exemple: 
- **usuari**: postgres
- **contrasenya**: postgres

Si no es canvien, qualsevol pot entrar.

### Que es psql?

**psql** es el **client** de linia de comandes per connectar al PostgreSQL.

### Que son les comandes `\l` i `\dt`?

Són **meta-comandes** de psql:
- **`\l`**: llista totes les bases de dades
- **`\dt`**: llista les taules de la BD actual
- **`\c NOM`**: canvia a la BD NOM

### Glossari

- **PostgreSQL**: sistema de bases de dades
- **credencials per defecte**: usuari/contrasenya inicials
- **psql**: client per PostgreSQL
- **port 5432**: port per defecte de PostgreSQL

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova el servei: `nmap -sV -p 5432 10.10.30.30`
3. Prova: `psql -h 10.10.30.30 -U postgres -W`
4. Prova contrasenyes: postgres, password, admin, 123456
5. Si funciona, veuras un prompt `postgres=#`
6. Llista les BD: `\l`
7. Canvia a template1: `\c template1`
8. Llista les taules: `\dt`
9. Mira els usuaris: `SELECT * FROM pg_user;`

## Que has de buscar

- Has pogut entrar?
- Quines BD hi ha?
- Pots accedir a informacio sensible?
- Com podem protegir?

## Preguntes que has de respondre

1. Que es PostgreSQL?
2. Has pogut entrar?
3. Quantes BD hi ha?
4. Com podem protegir?

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
