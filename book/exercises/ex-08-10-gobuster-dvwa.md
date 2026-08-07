---
id: EX-08-10
title: "Directori bruteforce amb gobuster al DVWA"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - gobuster
  - dvwa
  - bruteforce
  - nivell-mitja
prerequisites:
  - LAB-15-10
related:
  - LAB-15-10
  - LAB-15-11
estimated_time: 30 min
difficulty: beginner
---

# EX-08-10 - Directori bruteforce amb gobuster al DVWA

> Utilitzar gobuster per descobrir directoris i fitxers amagats al DVWA.

## Que has de fer

1. Des del Kali, obre una terminal
2. Necessites una wordlist: `ls /usr/share/wordlists/dirb/common.txt` o `/usr/share/seclists/Discovery/Web-Content/common.txt`
3. Si no hi ha, instal·la: `sudo apt install wordlists` o baixa de SecLists
4. Comprova que DVWA esta actiu: `curl -I http://10.10.30.10/`
5. Executa: `gobuster dir -u http://10.10.30.10/ -w /path/to/wordlist.txt -x php,txt,html -t 30`
6. Observa els resultats
7. Visita alguns dels directoris trobats

## Que has de buscar

- Quants directoris/fitxers ha trobat?
- Quins son interesants? (admin, backup, config, phpinfo)
- Hi ha algun 403 Forbidden? Quines implicacions te?
- Quin es el mes perillos?

## Preguntes per respondre

1. Quants camins ha trobat gobuster?
2. Quin es el mes perillos? Per que?
3. Per que `-x php,txt,html` es important?
4. Com podem protegir-nos contra aixo? (robots.txt, autenticacio, etc.)

## Glossari

- **gobuster**: Eina de bruteforce de directoris web. Prova molts noms de fitxer/dir.
- **dirb**: Alternativa a gobuster. Fa el mateix pero mes lent.
- **403 Forbidden**: Resposta HTTP que indica que tens prohibit accedir al recurs.
- **200 OK**: Resposta HTTP que indica que el recurs existeix i es accessible.
- **401 Unauthorized**: Resposta HTTP que indica que necessites autenticacio.

## Validacio

Quan acabis, compara els teus resultats amb els del document [LAB-15-11](../labs/lab-15-11-nmap-complet-metaploitable2.md).

## Seguretat

**Recorda**: 
- Aquestes tecniques nomes sha d'utilitzar en entorns controlats (com aquest lab)
- Mai en sistemes reals sense permis
- Practicar sense permis es IL·LEGAL

## Referencies

- [LAB-15-10](../labs/lab-15-10-lab-real-muntat.md) - Lab real muntat al Kali
- [LAB-15-11](../labs/lab-15-11-nmap-complet-metaploitable2.md) - Nmap complet
- [EX-08-01](ex-08-01-nmap-metasploitable.md) - Nmap Metasploitable
- [EX-08-02](ex-08-02-sql-injection-dvwa.md) - SQL Injection DVWA
