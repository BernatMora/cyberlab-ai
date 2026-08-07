---
id: EX-08-06
title: "SMB enumeration amb enum4linux - Explicat per a gent inexperta"
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

# EX-08-06 - SMB enumeration amb enum4linux - Explicat per a gent inexperta

> Aprendre a enumerar recursos compartits SMB al Metasploitable2.

## Que necessites saber

### Que es SMB?

**SMB** (Server Message Block) es un **protocol** que serveix per **compartir fitxers i impressores** entre ordinadors. Es el que fa Windows per compartir carpetes.

Tambe es pot utilitzar des de Linux amb **Samba**.

### Que es Samba?

**Samba** es la **implementacio de SMB per a Linux**. Permet que un PC Linux comparteixi fitxers amb un PC Windows, i viceversa.

### Que es una carpeta compartida?

Una **carpeta compartida** es una carpeta a un PC que altres PCs poden veure i accedir-hi per la xarxa.

Per exemple, a la feina pots tenir una carpeta compartida anomenada "Comptabilitat" on tothom pot accedir.

### Que es enumeracio?

**Enumeracio** es el procés de **descobrir** tots els recursos disponibles en un sistema. Es la fase despres del reconeixement.

En aquest cas, volem veure:
- Quines carpetes hi ha compartides
-quins usuaris hi ha al sistema
-quins grups existeixen

### Que es enum4linux?

**enum4linux** es una **eina automatica** que fa enumeracio SMB. Prova moltes coses i et dona un resum.

### Que es NULL session?

Una **NULL session** es una connexio SMB **sense autenticacio**. Si el servidor ho permet, pots veure informacio sense entrar amb usuari/contrasenya.

Es una **vulnerabilitat** classica que sha de corregir.

### Glossari

- **SMB**: protocol per compartir fitxers
- **Samba**: implementacio de SMB per Linux
- **carpeta compartida**: carpeta accessible per xarxa
- **enumeracio**: descobrir recursos d'un sistema
- **enum4linux**: eina automatica per enumerar SMB
- **NULL session**: connexio SMB sense autenticacio

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova que el servei esta actiu: `nmap -sV -p 139,445 10.10.30.30`
3. Executa: `enum4linux -a 10.10.30.30`
4. Espera que acabi (pot trigar 1-2 minuts)
5. Llegeix els resultats amb atencio
6. Busca la seccio 'Users' - quins usuaris hi ha?
7. Busca la seccio 'Shares' - quines carpetes hi ha compartides?
8. Busca la seccio 'Groups' - quins grups hi ha?
9. Prova tambe: `smbclient -L //10.10.30.30 -N`
10. Si hi ha una carpeta 'tmp' o 'homes', intenta connectar-t'hi
11. Per connectar: `smbclient //10.10.30.30/tmp -N`

## Que has de buscar

- Quants usuaris hi ha al sistema?
- Quines carpetes hi ha compartides?
- Pots accedir a alguna carpeta sense contrasenya?
- Hi ha informacio sensible?
- Quin tipus de SMB es (Samba, Windows)?

## Preguntes que has de respondre

1. Quants usuaris has trobat?
2. Quantes carpetes compartides?
3. Com podem protegir el SMB?
4. Per que la NULL session es perillosa?

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
