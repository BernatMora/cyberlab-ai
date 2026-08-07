---
id: EX-08-09
title: "SSH brute force amb hydra al Metasploitable"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - ssh
  - hydra
  - metasploitable2
  - nivell-mitja
prerequisites:
  - LAB-15-10
related:
  - LAB-15-10
  - LAB-15-11
estimated_time: 30 min
difficulty: beginner
---

# EX-08-09 - SSH brute force amb hydra al Metasploitable

> Utilitzar hydra per trobar contrasenyes febles al servei SSH del Metasploitable2.

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova que tens una llista d'usuaris: `ls /usr/share/wordlists/`
3. Si no hi ha cap, baixa una: `sudo apt install wordlists` o descarrega de https://github.com/danielmiessler/SecLists
4. Crea un fitxer petit `users.txt` amb: root, admin, user, msfadmin, postgres, service
5. Crea un fitxer petit `passwords.txt` amb: admin, password, 123456, msfadmin, root, pass
6. Executa: `hydra -L users.txt -P passwords.txt ssh://10.10.30.30 -t 4 -f`
7. Espera els resultats
8. Quan trobis credencials, entra: `ssh usuari@10.10.30.30`

## Que has de buscar

- Quantes combinacions ha provat hydra?
- Quines credencials has trobat?
- Quin usuari te mes riscos? (root es el mes perillos)
- Quant ha trigat? (temps total)
- Pots entrar al sistema un cop tens les credencials?

## Preguntes per respondre

1. Quines credencials has trobat?
2. Per que serveix `-t 4`? I `-f`?
3. Com podem evitar atacs com aquest?
4. Quines son les millors practiques per a contrasenyes SSH?

## Glossari

- **hydra**: Eina de brute force per protocols de xarxa. Prova moltes combinacions rapid.
- **brute force**: Provar totes les combinacions possibles fins trobar la correcta.
- **wordlist**: Llista de paraules que s'utilitzen per provar contrasenyes.
- **rate limiting**: Limitacio de intents. Protegeix contra brute force.
- **fail2ban**: Eina que bloqueja IPs que fan masses intents fallits.

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
