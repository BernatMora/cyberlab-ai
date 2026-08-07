---
id: EX-08-08
title: "HTTP enumeration amb nikto - Explicat per a gent inexperta"
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

# EX-08-08 - HTTP enumeration amb nikto - Explicat per a gent inexperta

> Aprendre a usar nikto per trobar vulnerabilitats en una web.

## Que necessites saber

### Que es nikto?

**nikto** es una **eina d'escaneig** que busca **vulnerabilitats** en servidors web. Es una de les mes antigues i utilitzades.

Escaneja:
- Fitxers perillosos
- Versions antigues
- Configuracions incorrectes
- Capçaleres HTTP que falten
- I molt mes

### Que es whatweb?

**whatweb** es una eina que **identifica les tecnologies** darrere d'una web (WordPress, Apache, PHP, etc.).

Es com un "detective" que mira les petjades digitals d'una web.

### Que es una capçalera HTTP?

Les **capçaleres HTTP** son **infromacio extra** que el servidor envia amb cada resposta. Per exemple:

```
HTTP/1.1 200 OK
Content-Type: text/html
Server: Apache/2.2.8
X-Frame-Options: SAMEORIGIN
```

Aquesta informacio pot revelar:
- Quin servidor web es
- Quines versions
- Si hi ha proteccions

### Que es phpinfo()?

**phpinfo()** es una **funcio PHP** que mostra tota la configuracio del servidor: PHP, sistema operatiu, tot.

Es molt util per als administradors pero **perillos** si es publica a Internet perque dona molta informacio als atacants.

### Que es una URL?

**URL** es l'adreça d'una pagina web. Com `http://10.10.30.30/`.

Per veure les capçaleres d'una web pots fer:
```bash
curl -I http://10.10.30.30/
```

### Glossari

- **nikto**: eina per trobar vulnerabilitats web
- **whatweb**: eina per identificar tecnologies web
- **capçalera HTTP**: informacio extra que envia el servidor
- **phpinfo()**: funcio PHP que mostra la configuracio
- **Apache**: servidor web molt utilitzat
- **PHP**: llenguatge de programacio per a webs

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova que el servei esta actiu: `nmap -sV -p 80 10.10.30.30`
3. Executa: `nikto -h http://10.10.30.30`
4. Espera que acabi (pot trigar 5-10 minuts)
5. Llegeix els resultats amb atencio
6. Cada linia es una vulnerabilitat trobada
7. Despres prova: `whatweb http://10.10.30.30`
8. Mira les tecnologies detectades
9. Prova: `curl -I http://10.10.30.30`
10. Mira les capçaleres HTTP
11. Prova tambe: `curl -I http://10.10.30.30/phpinfo.php`
12. Compara els resultats

## Que has de buscar

- Quantes vulnerabilitats ha trobat nikto?
- Quines son les mes importants?
- Hi ha phpinfo()?
- Quines tecnologies ha detectat whatweb?
- Quines capçaleres falten per seguretat?

## Preguntes que has de respondre

1. Que es nikto i per a que serveix?
2. Quantes vulnerabilitats has trobat?
3. Quines tecnologies te la web?
4. Per que es perillos tenir phpinfo() public?
5. Com podem protegir una web?

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
