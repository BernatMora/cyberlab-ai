---
id: EX-08-18
title: "Distccd command execution - Explicat per a gent inexperta"
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

# EX-08-18 - Distccd command execution - Explicat per a gent inexperta

> Aprendre com funciona una execucio remota de comandes a distccd.

## Que necessites saber

### Que es distccd?

**distccd** es un servei per **compilar codi C** en xarxa. En lloc d'un sol PC fent tota la compilacio, distribueix la feina entre varios equips.

Es util per accelerar la compilacio de programes grans.

### Que es RCE?

**RCE** (Remote Code Execution) es **executar codi** en un altre equip **de forma remota**. Es una de les **vulnerabilitats mes critiques** que existeixen.

Si trobem un RCE, podem fer **el que vulguem** al sistema afectat.

### Que es CVE-2004-2687?

Es el **CVE** que afecta distccd. Va ser descobert al 2004 i encara hi ha sistemes vulnerables.

### Que es searchsploit?

**searchsploit** es una eina per **buscar exploits** a la base de dades Exploit-DB. Es com un "Google" d'exploits pero local.

Permet buscar exploits per nom, CVE, plataforma, etc.

### Que es Metasploit?

**Metasploit** es un **framework** amb milers d'exploits llestos per utilitzar. Es la eina mes utilitzada per pentesting al mon.

Permet automatitzar molts atacs.

### Glossari

- **distccd**: servei per compilar en xarxa
- **RCE**: Remote Code Execution, execucio remota de codi
- **CVE-2004-2687**: vulnerabilitat de distccd
- **searchsploit**: eina per buscar exploits
- **Metasploit**: framework d'exploits
- **exploit**: codi que aprofita una vulnerabilitat

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova el servei: `nmap -sV -p 3632 10.10.30.30`
3. Prova amb nmap scripting: `nmap -p 3632 --script=distcc-cve2004-2687 10.10.30.30`
4. Si nmap no te el script, busca'l a searchsploit: `searchsploit distccd`
5. Llegeix la documentacio
6. Prova l'exploit manualment amb Python
7. Si tens Metasploit, busca: `search distccd`
8. Utilitza l'exploit per executar una comanda

## Que has de buscar

- Quina versio de distccd te el Metasploitable2?
- Es vulnerable? A quin CVE?
- Pots executar comandes? Quines?
- Com podem protegir distccd?

## Preguntes que has de respondre

1. Que es RCE?
2. Quin CVE afecta aquesta versio?
3. Has pogut executar una comanda?
4. Com podem protegir el servei?

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
