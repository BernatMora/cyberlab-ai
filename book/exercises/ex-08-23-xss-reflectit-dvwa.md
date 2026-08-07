---
id: EX-08-23
title: "XSS reflectit a DVWA"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - xss
  - dvwa
  - reflectit
  - nivell-mitja
prerequisites:
  - LAB-15-10
related:
  - LAB-15-10
  - LAB-15-11
estimated_time: 30 min
difficulty: beginner
---

# EX-08-23 - XSS reflectit a DVWA

> Fer un XSS reflectit al DVWA per executar JavaScript al navegador.

## Que has de fer

1. Des del Kali, obre un navegador: `firefox http://10.10.30.10/`
2. Entra amb admin/password
3. Ves a DVWA Security i posa el nivell a Low
4. Ves a XSS Reflected (al menu de l'esquerra)
5. Al camp Name, posa: `<script>alert('XSS')</script>`
6. Prem Submit. Hauries de veure un popup amb 'XSS'
7. Prova tambe: `<script>document.location='http://example.com'</script>`
8. Prova amb `<img src=x onerror=alert(1)>`
9. Prova carregar una imatge externa: `<img src="http://example.com/img.png">`

## Que has de buscar

- Has vist el popup?
- Quines variants de XSS has provat?
- Pots redirigir a una web externa?
- Com podem protegir contra XSS?

## Preguntes per respondre

1. Has aconseguit el XSS?
2. Quines tecniques has usat?
3. Com podem protegir contra XSS?
4. XSS pot ser perillos per a un lloc real?

## Glossari

- **XSS**: Cross-Site Scripting. Injeccio de codi JavaScript a una pagina web.
- **XSS reflectit**: El codi ve d'una peticio HTTP (URL, formulari).
- **XSS persistent**: El codi es guarda al servidor i afecta tothom.
- **alert()**: Funcio JavaScript que mostra un popup. Utilitzada per provar XSS.
- **onerror**: Event JavaScript que s'executa quan falla carregar una imatge.

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
