---
id: EX-08-22
title: "SQL injection manual a DVWA nivell baix - Explicat per a gent inexperta"
status: draft
version: 2.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - sql-injection
  - dvwa
  - manual
  - nivell-mitja
  - per-a-principiants
prerequisites:
  - LAB-15-10
  - ANN-09
related:
  - LAB-15-10
  - LAB-15-11
  - ANN-08
  - ANN-09
estimated_time: 1 hora
difficulty: beginner
---

# EX-08-22 - SQL injection manual a DVWA

> Aquest exercici t'ensenya una de les vulnerabilitats mes comunes del mon: la injeccio SQL. **Si no saps que es SQL, llegeix primer la seccio "Que necessites saber"**.

## Que necessites saber abans

### Que es SQL?

**SQL** (Structured Query Language) es un **llenguatge** que s'utilitza per parlar amb **bases de dades**.

Pensa-ho aixi:
- Una **base de dades** es com un Excel gegant amb moltes taules
- **SQL** es l'idioma que utilitzes per preguntar coses a aquestes taules

Exemple d'una taula anomenada `usuaris`:

| id | nom | contrasenya |
|---|---|---|
| 1 | admin | hash1 |
| 2 | bernat | hash2 |

Per demanar "dona'm tots els usuaris", escriuries en SQL:
```sql
SELECT * FROM usuaris;
```

Aixo es tradueix a: "Selecciona TOT (`*`) de la taula `usuaris`".

### Que es una SQL injection?

Una **SQL injection** es quan un atacant **injecta codi SQL** malicios en un lloc on l'aplicacio no ho esperava.

Per exemple, si una web et demana el teu ID d'usuari i tu poses `1`, l'aplicacio fa aixo:
```sql
SELECT * FROM usuaris WHERE id = 1;
```

Pero si tu poses `' OR '1'='1`, l'aplicacio fa:
```sql
SELECT * FROM usuaris WHERE id = '' OR '1'='1';
```

La part `' OR '1'='1` es **nova condicio** que sempre es compleix, per tant la consulta retorna **TOTS** els usuaris.

Es com si el formulari et demanes "digues el teu nom" i tu respons "el meu nom es qualsevol cosa i tambe m'agrada la pizza". L'aplicacio no sap que fer amb la part de la pizza, pero la processa igual.

### Que es DVWA?

**DVWA** (Damn Vulnerable Web Application) es una **aplicacio web feta per ser vulnerable**. Es la mes utilitzada per practicar seguretat web.

Esta feta perque puguis practicar atacs **sense fer mal** a ningun.

### Que es una contrasenya hash?

Una **contrasenya hash** es una contrasenya que ha estat **transformada** per que no es pugui llegir directament.

Exemple:
- Contrasenya original: `password`
- Hash MD5: `5f4dcc3b5aa765d61d8327deb882cf99`

Si veus un hash, **no pots saber** quina es la contrasenya original (en teoria). Pero alguns hashes son febles i es poden trencar.

### Que es MD5?

**MD5** es un **algoritme** que serveix per crear hashes. Es un dels mes antics.

Avui dia MD5 es considera **insegur** perque:
- Es pot trencar rapidament amb eines modernes
- Dos contrasenyes diferents poden tenir el mateix hash (col·lisions)

## Que faras en aquest exercici

Aquest exercici te 4 parts:

1. **Entrar al DVWA** amb usuari i contrasenya
2. **Canviar el nivell de seguretat** a "Low" (el mes facil)
3. **Fer SQL injection** per obtenir tots els usuaris
4. **Documentar el que has trobat**

## Que necessites

- Un navegador (Firefox, Chrome, etc.)
- Acces al lab (DVWA ha destar actiu)
- Coneixements basics de SQL (els tens a la seccio anterior)

## Pas a pas detallat

### Part 1: Entrar al DVWA

**1.1.** Des del teu PC (Windows, Mac o Linux), obre un navegador.

Si vols accedir desde el Kali:
```bash
firefox http://10.10.30.10/
```

Si vols accedir desde un altre equip, fes un tunel SSH primer:
```bash
ssh -L 8080:127.0.0.1:8080 hort-osona@hort
# Ara obre: http://127.0.0.1:8080
```

**Que veuras?**: Una pagina de login del DVWA.

**1.2.** Entra amb aquestes credencials:
- **Usuari**: `admin`
- **Contrasenya**: `password`

**Que ha de passar?**: Hauries de veure el menu principal del DVWA.

**Si no funciona**: comprova que DVWA esta actiu. Desde el Kali:
```bash
docker ps
# Hauries de veure "dvwa" a la llista
```

### Part 2: Canviar el nivell de seguretat

**2.1.** Al menu de l'esquerra, busca **"DVWA Security"**.

**Que es?**: El nivell de seguretat del DVWA. Hi ha 4 nivells:
- **Low**: MOLT vulnerable (ideal per aprendre)
- **Medium**: una mica protegit
- **High**: mes protegit
- **Impossible**: totalment protegit

**2.2.** Al desplegable, selecciona **"Low"**.

**2.3.** Prem el boto **"Submit"**.

**Que ha de passar?**: Hauries de veure un missatge de confirmacio.

**Important**: El nivell ha de ser **Low** per a aquest exercici. Si es mes alt, algunes coses no funcionaran.

### Part 3: Fer SQL injection

**3.1.** Al menu de l'esquerra, busca **"SQL Injection"** (a la seccio "Vulnerabilities").

**Que veuras?**: Un formulari amb un camp que posa "User ID".

**3.2.** Al camp, escriu `1` i prem **"Submit"**.

**Que ha de passar?**: Hauries de veure informacio d'un usuari:
```
ID: 1
First name: admin
Surname: admin
```

**Que significa?**: L'aplicacio ha fet una consulta SQL com:
```sql
SELECT first_name, last_name FROM users WHERE user_id = '1';
```

**3.3.** Ara, al camp, escriu: `' OR '1'='1`

**IMPORTANT**: Atencio a les **cometes simples** (`'`). Son importants!

Prem **Submit**.

**Que hauria de passar?**: Hauries de veure **TOTS** els usuaris de la taula.

**Que ha passat?**: L'aplicacio ha fet:
```sql
SELECT first_name, last_name FROM users WHERE user_id = '' OR '1'='1';
```

Com que `'1'='1'` sempre es cert, retorna totes les files.

**3.4.** Prova tambe: `' OR 1=1 -- `

**Que es `--`?**: Es un **comentari** en SQL. Tot el que ve despres s'ignora.

**3.5.** Prova tambe: `' UNION SELECT user, password FROM users -- `

**Que es UNION SELECT?**: Es una tecnica que permet **combinar** resultats de dues consultes.

Aixo et donara els noms d'usuari **i les contrasenyes** (en hash).

**3.6.** Anota totes les contrasenyes que vegis. Estan en format MD5 (32 caracters hexadecimals).

### Part 4: Documentar el que has trobat

**4.1.** Crea un fitxer al teu PC amb el que has trobat:

```bash
nano resultats-ex-08-22.txt
```

**4.2.** Escriu-hi:
- Quants usuaris has trobat?
- Quin es el hash de la contrasenya de l'admin?
- Quin es el hash de la contrasenya de l'usuari bernat?
- Quines comandes has usat?

**4.3.** Si vols trencar els hashes, segueix l'exercici [EX-08-25](ex-08-25-john-hash-cracking.md) (John the Ripper).

## Que has de buscar

Durant l'exercici, busca:

1. **Quants usuaris hi ha al sistema?** (normalment 5)
2. **Quin hash te cada contrasenya?** (son MD5 de 32 caracters)
3. **El hash es trencable?** (prova-ho amb john o un web)
4. **Quines comandes SQL has usat?** (anota-les totes)
5. **Per que el nivell Low es vulnerable?** (no filtra l'entrada)

## Preguntes que has de respondre

Despres de fer l'exercici, has de poder respondre:

1. **Que es SQL injection?**
2. **Com funciona la injeccio amb `' OR '1'='1`?**
3. **Que fa `--` en SQL?**
4. **Que es UNION SELECT i per que es perillos?**
5. **Com podem protegir una web contra SQL injection?**
6. **Per que el nivell Low es vulnerable?**
7. **Quants usuaris has trobat? Quins son els seus hashes?**

## Glossari complet

- **SQL**: Llenguatge per parlar amb bases de dades.
- **Base de dades**: On es guarden les dades de l'aplicacio (usuaris, productes, etc.).
- **Taula**: Com un "full de calcul" amb files i columnes.
- **SELECT**: Comanda SQL per obtenir dades.
- **FROM**: Indica de quina taula obtenir les dades.
- **WHERE**: Condicio de filtre.
- **OR**: Operador logic "o". Si una condicio es certa, retorna el resultat.
- **Cometa simple (`'`)**: Caracter que delimita text en SQL.
- **Comentari (`--`)**: Text que SQL ignora.
- **UNION**: Combina resultats de dues consultes.
- **Hash**: Contrasenya xifrada.
- **MD5**: Algoritme de hash feble.
- **Prepared Statement**: Tecnica per evitar SQL injection.

## Com protegir contra SQL injection?

**La forma correcta es utilitzar Prepared Statements (consultes parametritzades)**.

Exemple **dolent** (vulnerable):
```php
$sql = "SELECT * FROM users WHERE id = '" . $_GET['id'] . "'";
```

Exemple **bo** (protegit):
```php
$stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
$stmt->execute([$_GET['id']]);
```

Amb Prepared Statements, l'entrada de l'usuari **mai s'interpreta com a SQL**, nomes com a **dades**.

## Nivells de seguretat del DVWA

Per veure com es veu una web **protegida**, pots canviar el nivell a "Impossible" i provar les mateixes injeccions. **No funcionaran!**.

Aixo demostra que les webs professionals **poden** estar protegides si ho fan be.

## Seguretat

**Recorda**:
- Aixo es **nomes per practicar** al DVWA
- No facis servir aquestes tecniques en webs **reals** sense permis
- Es **IL·LEGAL** atacar webs sense autoritzacio
- Si trobes una web vulnerable "per casualitat", avisa el propietari

## Validacio

Quan acabis, compara els teus resultats amb els del document [LAB-15-11](../labs/lab-15-11-nmap-complet-metaploitable2.md).

## Propers passos

Despres d'aquest exercici, pots fer:

1. **[EX-08-25](ex-08-25-john-hash-cracking.md)**: Trencar els hashes que has trobat
2. **[EX-08-23](ex-08-23-xss-reflectit-dvwa.md)**: XSS al DVWA
3. **[EX-08-09](ex-08-09-ssh-brute-force-hydra.md)**: SSH brute force amb hydra

## Solucio de problemes

**Si no veus res a DVWA**:
- Comprova que estas connectat a la xarxa correcta
- Comprova que el port 80 esta obert: `nmap -p 80 10.10.30.10`
- Comprova que el nivell es "Low"

**Si la injeccio no funciona**:
- Assegura't que el nivell es "Low"
- Comprova que has posat les **cometes simples** correctament
- Prova altres variants: `' OR 1=1 -- `

**Si vols tornar a començar**:
- Canvia el nivell a "Impossible" i tornar a "Low"
- O be, tanca el navegador i torna a entrar

## Referencies

- [ANN-09](ann-09-comencar-de-zero.md) - Començar de zero
- [ANN-08](ann-08-glossari-ports.md) - Glossari de ports
- [LAB-15-10](../labs/lab-15-10-lab-real-muntat.md) - Lab real muntat al Kali
- [LAB-15-11](../labs/lab-15-11-nmap-complet-metaploitable2.md) - Nmap complet
- [EX-08-02](ex-08-02-sql-injection-dvwa.md) - SQL Injection amb sqlmap (automatitzat)
- [CAP-08-10](../chapters/cap-08-10-apps-vulnerables.md) - Aplicacions vulnerables
