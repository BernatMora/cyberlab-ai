---
id: EX-08-02
title: "SQL injection amb sqlmap - Explicat per a gent inexperta"
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

# EX-08-02 - SQL injection amb sqlmap - Explicat per a gent inexperta

> Aprendre a usar sqlmap per automatitzar una SQL injection al DVWA.

## Que necessites saber

### Que es SQL?

**SQL** (Structured Query Language) es un **llenguatge** que serveix per parlar amb bases de dades. Es com un "idioma" que utilitzen les aplicacions per guardar i buscar dades.

Si no saps que es SQL, llegeix primer [EX-08-22](ex-08-22-sql-injection-manual-dvwa.md) que ho explica en detall.

### Que es SQL injection?

Es **injectar codi SQL malicios** en una web vulnerable. Permet a l'atacant:
- Veure dades que no hauria de veure
- Esborrar dades
- Modificar dades
- Ficar-se al sistema

### Que es sqlmap?

**sqlmap** es una **eina automatica** que fa SQL injection per tu. En lloc d'escriure les comandes a ma, sqlmap les prova totes sol.

Es **mes rapid** pero has d'entendre que fas servir-lo correctament.

### Que es DVWA?

Es una **aplicacio web feta per ser vulnerable**. Si no la coneixes, llegeix [EX-08-22](ex-08-22-sql-injection-manual-dvwa.md).

### Que es una galeta (cookie)?

Les **galetes** (cookies) son petits fitxers que les webs guarden al teu navegador per recordar coses (com que has entrat amb usuari/contrasenya).

En aquest exercici necessitarem una galeta per a que sqlmap s'autentiqui.

### Glossari

- **SQL injection**: vulnerabilitat on pots ficar codi SQL no desitjat
- **sqlmap**: eina per automatitzar SQL injection
- **cookie/galeta**: fitxer petit que les webs guarden al navegador
- **DVWA**: web vulnerable per practicar
- **base de dades**: on es guarden les dades de la web

## Que has de fer

1. Entra al DVWA amb el navegador: http://10.10.30.10/
2. Entra amb admin/password
3. Canvia el nivell de seguretat a Low
4. Ves a SQL Injection al menu
5. Al navegador, prem F12 per obrir les Developer Tools
6. Ves a la pestanya Application (o Storage)
7. Busca la galeta PHPSESSID i copia el seu valor
8. Des del Kali, obre una terminal
9. Executa: `sqlmap -u "http://10.10.30.10/vulnerabilities/sqli/?id=1&Submit=Submit" --cookie="PHPSESSID=EL_TEU_VALOR; security=low" --dbs`
10. Substitueix EL_TEU_VALOR pel valor de la teva galeta
11. Espera que acabi (pot trigar una mica)
12. Mira les bases de dades que ha trobat
13. Despres prova: `sqlmap -u "..." --cookie="..." -D dvwa --tables`
14. I despres: `sqlmap -u "..." --cookie="..." -D dvwa -T users --dump`

## Que has de buscar

- Quantes bases de dades ha trobat sqlmap?
- Quines taules te la base de dades dvwa?
- Quantes files ha trobat a la taula users?
- Quines contrasenyes has vist? (estan en hash)
- Quant ha trigat sqlmap?

## Preguntes que has de respondre

1. Quantes bases de dades hi ha?
2. Com has vist les taules?
3. Quines contrasenyes has trobat?
4. Es mes facil amb sqlmap o manualment?
5. Com podem protegir contra sqlmap?

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
