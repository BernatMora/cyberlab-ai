---
id: EX-08-07
title: "FTP anonymous login - Explicat per a gent inexperta"
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

# EX-08-07 - FTP anonymous login - Explicat per a gent inexperta

> Aprendre que es FTP i com funciona l'acces anonymous.

## Que necessites saber

### Que es FTP?

**FTP** (File Transfer Protocol) es un **protocol** que serveix per **transferir fitxers** entre un client i un servidor. Es un dels mes antics d'Internet.

Funciona pel **port 21** del servidor.

Exemple: quan vols pujar una pagina web a un servidor, abans es feia per FTP.

### Que es anonymous login?

**Anonymous login** vol dir **entrar al servidor FTP sense usuari ni contrasenya**. 

Es una opció que tenen alguns servidors FTP per permetre a tothom descarregar fitxers publics (com mirrors de Linux).

Quan t'ho demana, simplement escrius:
- **Usuari**: `anonymous`
- **Contrasenya**: qualsevol cosa (o buida, o el teu correu electronic)

### Que es vsFTPd?

**vsFTPd** (Very Secure FTP Daemon) es un programa de servidor FTP. Es molt utilitzat pero la **versio 2.3.4** (del 2011) te una **porta del darrere** que permet executar comandes com a root!

Es una ironia que el programa es digui "Very Secure" i tingui aquesta vulnerabilitat.

### Que es un servidor FTP?

Es un **ordinador** que te un programa escoltant al port 21. Quan et connectes amb un client FTP, pots:
- Veure els fitxers que te
- Descarregar-ne
- Pujar-ne (si tens permis)
- Esborrar-ne (si tens permis)

### Glossari

- **FTP**: protocol per transferir fitxers (port 21)
- **vsFTPd**: un programa de servidor FTP
- **anonymous**: acces sense autenticacio
- **port 21**: port per defecte del FTP
- **client FTP**: programa per connectar-se a un servidor FTP
- **servidor FTP**: ordinador que comparteix fitxers

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova que el servei esta actiu: `nmap -sV -p 21 10.10.30.30`
3. Instal·la el client FTP si no el tens: `sudo apt install ftp`
4. Connecta al servidor: `ftp 10.10.30.30`
5. Quan et demani Name, escriu: `anonymous`
6. Quan et demani Password, prem Enter (deixa buit)
7. Si funciona, ja estas dins!
8. Escriu `ls` per veure els fitxers
9. Escriu `pwd` per veure on ets
10. Escriu `binary` per preparar descarregues binaries
11. Descarrega un fitxer: `get nom_fitxer`
12. Mira el que has descarregat al teu PC
13. Prova tambe: `put nom_fitxer` per pujar un fitxer (pot fallar)
14. Surt del FTP: `bye`

## Que has de buscar

- Has pogut entrar com anonymous?
- Quin servidor FTP hi ha? (vsftpd, ProFTPD, etc.)
- Quina versio es?
- Quins fitxers hi ha disponibles?
- Hi ha informacio sensible?
- Pots pujar fitxers?

## Preguntes que has de respondre

1. Que es FTP i per a que serveix?
2. Com funciona l'anonymous login?
3. Quin servidor FTP hi ha al lab? De quina versio?
4. Es segur tenir anonymous login? Per que?
5. Que es una porta del darrere? (vsFTPd 2.3.4)

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
