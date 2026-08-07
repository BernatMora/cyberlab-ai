---
id: EX-08-04
title: "Juice Shop - Trobar el scoreboard - Explicat per a gent inexperta"
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

# EX-08-04 - Juice Shop - Trobar el scoreboard - Explicat per a gent inexperta

> Aprendre a explorar una web per trobar funcionalitats ocultes.

## Que necessites saber

### Que es OWASP Juice Shop?

**OWASP Juice Shop** es una **aplicacio web feta per ser vulnerable**. Es mantinguda per l'organitzacio OWASP (Open Web Application Security Project).

Es una **botiga de sucs** (ficticia) que te moltes vulnerabilitats amagades que has de trobar.

### Que es un scoreboard?

Un **scoreboard** (panell de puntuacio) es on es mostren els reptes que has superat. Al Juice Shop esta **amagat** - has de trobar-lo tu!

### Que es DevTools?

**DevTools** (Developer Tools) son eines del navegador per veure el **codi intern** de la web. S'obren prement **F12**.

Serveixen per:
- Veure el codi HTML
- Veure les peticions de xarxa
- Executar JavaScript
- Veure les galetes
- I molt mes

### Que es un comentari HTML?

En HTML, els comentaris son text que sha posat pero **no es mostra** a la pagina. Serveixen per notes dels programadors.

Exemple:
```html
<!-- Aixo es un comentari, no es veu a la web -->
<p>Aixo es un paragraf visible</p>
```

Pero si tu mires el codi font, **si que els veuras**. A vegades, els comentaris contenen **pistes** o **informacio sensible**.

### Que es gobuster?

**gobuster** es una eina per **brute force** de directoris web. Prova molts noms de carpetes/fitxers per veure quins existeixen.

Si vols saber-ne mes, llegeix [EX-08-10](ex-08-10-gobuster-dvwa.md).

### Glossari

- **OWASP**: organitzacio que publica guies de seguretat web
- **Juice Shop**: aplicacio web vulnerable per practicar
- **scoreboard**: panell de puntuacio
- **DevTools**: eines del navegador (F12)
- **comentari HTML**: text invisible dins el codi
- **recon**: reconeixement, primera fase d'un atac

## Que has de fer

1. Entra a Juice Shop: http://10.10.30.20:3000/
2. Explora el menu i les opcions
3. Prem F12 per obrir les DevTools
4. Mira el codi font de la pagina (Ctrl+U)
5. Busca comentaris HTML (`<!-- ... -->`)
6. Busca cadenes com 'score', 'admin', 'debug' al codi
7. Prova accedir a URLs comuns: /score-board, /admin, /api
8. Des del Kali: `gobuster dir -u http://10.10.30.20:3000/ -w /usr/share/wordlists/dirb/common.txt -x html,js,json`
9. Mira els resultats de gobuster
10. Quan trobis el scoreboard, mira quins reptes hi ha
11. Intenta resoldre algun repte (per exemple, trobar la pagina oculta)

## Que has de buscar

- Has trobat el scoreboard? Com?
- Quants reptes hi ha al Juice Shop?
- Has pogut resoldre algun repte?
- Quines eines sha utilitzat per trobar el scoreboard?

## Preguntes que has de respondre

1. On has trobat el scoreboard?
2. Com es fa el reconeixement d'una web?
3. Per que es important trobar fitxers ocults?
4. Com podem protegir una web contra aquestes tecniques?

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
