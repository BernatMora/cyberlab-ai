---
id: EX-08-10
title: "Directori bruteforce amb gobuster - Explicat per a gent inexperta"
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

# EX-08-10 - Directori bruteforce amb gobuster - Explicat per a gent inexperta

> Aprendre a descobrir directoris ocults amb gobuster.

## Que necessites saber

### Que es gobuster?

**gobuster** es una **eina** que prova **molts noms de directoris** i fitxers en una web per veure quins existeixen.

Es com si provis totes les combinacions de adreces possibles dins un edifici per veure quines portes existeixen.

### Que es un directori web?

Un **directori web** es una **carpeta** dins d'un servidor web. Per exemple:
- `http://web.com/admin/` podria ser una carpeta d'administracio
- `http://web.com/backup/` podria contenir copies de seguretat

### Que es bruteforce de directoris?

Es **provar molts noms** (admin, backup, test, privat...) per veure quins existeixen. Si trobem un directori privat, podriem accedir a informacio confidencial.

### Que es una wordlist?

Una **wordlist** es una **llista de paraules** que es fan servir per provar noms de directoris.

Algunes inclouen:
- noms comuns (admin, backup, test...)
- noms de fitxers comuns (index.html, robots.txt...)
- extensions (php, html, txt...)

Al Kali ja tens wordlists a `/usr/share/wordlists/`.

### Que es un codi HTTP?

Quan visites una web, el servidor retorna un **codi numeric** que indica si tot ha anat be:

- **200 OK**: tot correcte, el recurs existeix
- **301 Moved**: el recurs sha mogut
- **403 Forbidden**: tens prohibit accedir-hi
- **404 Not Found**: el recurs no existeix

gobuster utilitza aquests codis per saber quins directoris existeixen.

### Glossari

- **gobuster**: eina per bruteforce de directoris
- **directori web**: carpeta dins d'un servidor web
- **bruteforce**: provar moltes combinacions
- **wordlist**: llista de paraules
- **codi HTTP**: numero que indica l'estat d'una peticio
- **200 OK**: el recurs existeix
- **403 Forbidden**: prohibit accedir

## Que has de fer

1. Des del Kali, obre una terminal
2. Necessites una wordlist: `ls /usr/share/wordlists/dirb/`
3. Si no hi ha, instal·la: `sudo apt install wordlists`
4. Comprova que DVWA esta actiu: `curl -I http://10.10.30.10/`
5. Executa: `gobuster dir -u http://10.10.30.10/ -w /usr/share/wordlists/dirb/common.txt -x php,txt,html -t 30`
6. Espera els resultats (pot trigar 1-5 minuts)
7. Mira quins directoris/fitxers ha trobat
8. Visita algun dels trobats
9. Fixa't en els codis HTTP

## Que has de buscar

- Quants directoris ha trobat?
- Quins son interessants?
- Hi ha 403 Forbidden? Quines implicacions te?
- Hi ha phpinfo o admin?
- Quant ha trigat?

## Preguntes que has de respondre

1. Que es gobuster i per a que serveix?
2. Quants directoris has trobat?
3. Quin es el mes perillos?
4. Com podem protegir una web contra aixo?

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
