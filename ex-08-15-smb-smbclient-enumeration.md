---
id: EX-08-15
title: "SMB enumeration amb smbclient - Explicat per a gent inexperta"
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

# EX-08-15 - SMB enumeration amb smbclient - Explicat per a gent inexperta

> Aprendre a usar smbclient per enumerar recursos compartits.

## Que necessites saber

### Que es SMB i Samba?

Si no saps que es SMB o Samba, llegeix primer [EX-08-06](ex-08-06-smb-enum4linux.md).

### Que es smbclient?

**smbclient** es un **client** per connectar-se a servidors SMB des de la linia de comandes. Permet:
- Llistar els recursos compartits
- Entrar a una carpeta compartida
- Descarregar fitxers
- Pujar fitxers (si tens permis)

### Que es -L i -N?

Opcions de smbclient:
- **-L**: llistar (list) els recursos compartits
- **-N**: sense autenticacio (null session)

### Que es un recurs compartit?

Un **recurs compartit** es una carpeta accessible per la xarxa. Per exemple, `\servidor\compartit` es un recurs.

### Glossari

- **smbclient**: client de linia de comandes per SMB
- **-L**: llistar recursos
- **-N**: sense autenticacio
- **recurs compartit**: carpeta accessible per xarxa

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova el servei: `nmap -sV -p 139,445 10.10.30.30`
3. Llista els recursos: `smbclient -L //10.10.30.30 -N`
4. Mira tots els recursos que hi ha
5. Connecta a un recurs: `smbclient //10.10.30.30/tmp -N`
6. Dins, fes `ls`
7. Descarrega un fitxer: `get nom_fitxer`
8. Prova altres recursos si n'hi ha

## Que has de buscar

- Quants recursos hi ha?
- Pots accedir a tots sense contrasenya?
- Quins noms tenen? Son reveladors?
- Hi ha informacio sensible?

## Preguntes que has de respondre

1. Que es smbclient?
2. Quants recursos has trobat?
3. Pots accedir-hi tots?
4. Com podem protegir el SMB?

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
