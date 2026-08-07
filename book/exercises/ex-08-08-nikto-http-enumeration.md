---
id: EX-08-08
title: "HTTP enumeration amb nikto al Metasploitable"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - nikto
  - http
  - metasploitable2
  - nivell-principiant
prerequisites:
  - LAB-15-10
related:
  - LAB-15-10
  - LAB-15-11
estimated_time: 30 min
difficulty: beginner
---

# EX-08-08 - HTTP enumeration amb nikto al Metasploitable

> Escanejar el servidor web del Metasploitable2 amb nikto per trobar vulnerabilitats.

## Que has de fer

1. Des del Kali, obre una terminal
2. Fes `nikto -h http://10.10.30.30`
3. Espera que acabi (pot trigar 5-10 minuts)
4. Llegeix els resultats amb atencio
5. Fes tambe `whatweb http://10.10.30.30` per veure tecnologies detectades
6. Prova `curl -I http://10.10.30.30` per veure les capçaleres HTTP

## Que has de buscar

- Quantes vulnerabilitats ha trobat nikto?
- Quines son les mes importants? (critical, high)
- Hi ha cap fitxer interessant? (phpinfo, robots.txt, etc.)
- Quines capçaleres HTTP veus?
- Quines tecnologies ha detectat whatweb?

## Preguntes per respondre

1. Quantes vulnerabilitats ha trobat nikto en total?
2. Quines 3 son les mes importants? Per que?
3. Que es phpinfo() i per que es perillos?
4. Quines capçaleres de seguretat falten? (X-Frame-Options, etc.)

## Glossari

- **nikto**: Escanejador de vulnerabilitats web. Serveix per trobar problemes comuns en servidors HTTP.
- **whatweb**: Eina que identifica les tecnologies darrere d'una web (CMS, llenguatge, servidor, etc.)
- **HTTP headers**: Informacio que el servidor envia amb cada resposta (Content-Type, Server, etc.)
- **phpinfo()**: Funcio PHP que mostra tota la configuracio del servidor. Si es publica, es un forat de seguretat.

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
