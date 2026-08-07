---
id: EX-08-03
title: "XSS reflectit al DVWA - Explicat per a gent inexperta"
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

# EX-08-03 - XSS reflectit al DVWA - Explicat per a gent inexperta

> Aprendre que es XSS i com funciona en una web vulnerable.

## Que necessites saber

### Que es XSS?

**XSS** (Cross-Site Scripting) es una **vulnerabilitat web** on pots **injectar codi JavaScript** a una pagina web.

Permet a l'atacant:
- Executar codi al navegador d'altres usuaris
- Robar galetes (cookies)
- Redirigir a altres webs
- Modificar el contingut de la pagina

### Que es JavaScript?

**JavaScript** es el **llenguatge de programacio** que fan servir les webs per fer coses interactives. Es el que fa que els botons funcionin, que els formularis validin dades, etc.

Quan una web es vulnerable a XSS, un atacant pot executar JavaScript **al navegador d'altres usuaris** sense que ho sàpiguen.

### Que es XSS reflectit?

**XSS reflectit** vol dir que el codi malicios ve d'una **peticio HTTP** (URL o formulari) i nomes afecta a la persona que fa la peticio.

Hi ha dos tipus:
- **XSS reflectit**: nomes tu reps el codi (per exemple, en un enllaç)
- **XSS persistent**: queda guardat al servidor i afecta tothom

### Que es `<script>`?

Es una **etiqueta HTML** que serveix per incloure JavaScript. Si una web permet ficar `<script>` sense filtrar, es vulnerable.

Exemple:
```html
<script>alert('Hola!')</script>
```

Aixo mostra un popup amb "Hola!".

### Que es una URL?

**URL** es l'adreça d'una pagina web. Com:
- `http://10.10.30.10/`
- `https://google.com`

Quan hi ha XSS reflectit, l'atacant pot posar el codi malicios a la URL i enviar-lo a la victimes.

### Glossari

- **XSS**: Cross-Site Scripting, vulnerabilitat web
- **JavaScript**: llenguatge de programacio de les webs
- **`<script>`**: etiqueta HTML per incloure JavaScript
- **HTML**: llenguatge de marques per crear webs
- **HTTP**: protocol per fer peticions a una web
- **URL**: adreça d'una pagina web
- **reflectit**: que ve d'una peticio i no es guarda

## Que has de fer

1. Entra al DVWA: http://10.10.30.10/
2. Entra amb admin/password
3. Canvia el nivell de seguretat a Low
4. Ves a XSS Reflected al menu
5. Al camp Name, escriu el teu nom i prem Submit
6. Ara escriu: `<script>alert('XSS funciona!')</script>`
7. Prem Submit
8. Hauries de veure un popup amb 'XSS funciona!'
9. Si funciona, prova tambe: `<script>document.title='Hackejat!'</script>`
10. Ara el titol de la pestanya canviaria
11. Prova tambe redirigir: `<script>document.location='http://example.com'</script>`
12. Per veure si funciona, obre la consola JavaScript (F12)

## Que has de buscar

- Has vist el popup?
- Quantes formes de XSS has provat?
- Pots redirigir a una altra web?
- Com canviaries el contingut de la pagina?
- Com podem protegir contra XSS?

## Preguntes que has de respondre

1. Que es XSS i per que es perillos?
2. Quina diferencia hi ha entre XSS reflectit i persistent?
3. Com podem protegir una web contra XSS?
4. Quines tecniques has usat per explotar el XSS?

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
