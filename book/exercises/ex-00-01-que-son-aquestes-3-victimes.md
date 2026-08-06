---
id: EX-00-01
title: "Què són aquestes 3 'víctimes' i per què serveixen"
status: published
version: 1
created: 2026-08-06
updated: 2026-08-06
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - novatos
  - introduccio
  - aplicacions-vulnerables
prerequisites:
  - CAP-00-15
related:
  - CAP-08-10
estimated_time: 10 min
difficulty: beginner
---

# EX-00-01 — Què són aquestes 3 "víctimes" i per què serveixen

> Un exercici de **10 minuts** per entendre què tenim realment al lab.
> No cal Kali, ni Docker, ni obrir cap terminal. Només **llegir i
> pair**.

## Objectiu

Que quan algú et pregunti "què esteu fent al lab?", sàpigues
explicar **en 30 segons** què són DVWA, Juice Shop i Metasploitable,
per què les tenim i què pots aprendre amb cadascuna.

## Requisits

Cap. Només la teva atenció.

## Les 3 joguines, explicades com si fos un conte

### 1. DVWA — La botiga de cartró del poble

**DVWA** són les sigles de **D**amn **V**ulnerable **W**eb
**A**pplication. És una aplicació web feta amb PHP que **exageradament
té totes les vulnerabilitats clàssiques** posades a propòsit.

#### Què hi trobaràs

Una pàgina web molt lletja, plena de botons i camps, on pots:

- Entrar un nom d'usuari i veure si la contrasenya és bona
  (aquesta és la part que té la vulnerabilitat de **SQL injection**).
- Escriure text que surt a la pàgina i veure si el navegador l'executa
  (aquesta és la part de **XSS**, o cross-site scripting).
- Pujar fitxers i veure si el servidor els desa tal qual
  (aquesta és la part d'**upload malicious**).
- Moltes més coses, totes amb falles a propòsit.

#### Per què serveix

DVWA és **com un curs de natació a la piscina de 2 metres**.
Suficient per aprendre els fonaments sense riscos.

Si vols entendre per què la contrasenya del banc del teu veí pot ser
"123456", **DVWA t'ho ensenya**.

#### Què NO serveix

No és realista. Les botigues de veritat el 2026 tenen defenses que
DVWA no simula. Per a vulnerabilitats modernes, tens la joguina
següent.

#### Com s'hi accedeix

```
http://127.0.0.1:8080
```

(Però abans cal fer el túnel SSH des del Mac — això t'ho explico al
[CAP-08-10](../chapters/cap-08-10-apps-vulnerables.md)).

---

### 2. Juice Shop — La botiga moderna amb score

**OWASP Juice Shop** és una aplicació web moderna feta amb Node.js i
Angular. Té **totes les vulnerabilitats del llistat OWASP Top 10**
(posades a propòsit), totes les d'una botiga moderna de veritat.

#### Què hi trobaràs

Una botiga de sucs amb:

- Login (usuari + contrasenya)
- Cistella de compra
- Pas de caixa amb targeta
- Perfil d'usuari
- Un **score board ocult** que et posa estrelles cada vegada que
  trobes una vulnerabilitat

#### Per què serveix

Juice Shop és **com una piscina olímpica** amb carrils i cronòmetre.
Aprens a nedar de veritat, amb regles de competició.

Si vols entendre com t'ataca la gent quan tinc una botiga real,
**Juice Shop t'ho ensenya**.

#### Què té d'especial

El **score board** (`/#/score-board`). És la part més gamificada:

- Cada vegada que trobes una vulnerabilitat, el sistema et dóna
  una estrella.
- Hi ha desenes de reptes: alguns trivials (trobar el score
  board!), altres complexos (explotar JWT, fer XSS DOM-based...).
- Pots veure el teu progrés i comparar-te amb altres hackers del
  món que han fet els mateixos reptes.

#### Com s'hi accedeix

```
http://127.0.0.1:3000
```

---

### 3. Metasploitable — El camió dels 90 al taller

**Metasploitable** és una màquina virtual Linux (un Ubuntu vell)
expressament configurat amb **30 serveis** plens de forats:

- FTP amb contrasenya fluixa
- SMB (carpetes compartides de Windows) sense autenticació
- SSH amb versions antigues plenes de CVEs
- HTTP amb PHP sense actualitzar
- MySQL sense password
- IRC amb backdoor
- I molts més...

#### Què hi trobaràs

**No té interfície web bonica.** És un Linux antic amb moltes
"portes" obertes. S'assembla més a un servidor d'una empresa dels
anys 2005 que no pas a una botiga.

#### Per què serveix

Metasploitable és **com un camió dels 90 al taller**. No té
direcció assistida, no té ABS, no té cinturó. És ideal per
aprendre a:

- Escanear ports (veure quines portes té obertes)
- Entrar per FTP amb usuari/password
- Explotar un SMB obert
- Pivotar d'un servei a un altre

#### Què NO serveix

No és realista per a aplicacions web modernes. Per a això tens
Juice Shop.

#### Com s'hi accedeix

```
ssh msfadmin@10.10.30.30       # dins la xarxa del lab
```

(si tens el Kali engegat i connectat a la xarxa del lab).

---

## Com es complementen les 3

Pensa en elles com una **escola de 3 cursos**:

| Curs | Víctima | Què hi aprens |
|---|---|---|
| 1r | DVWA | Els fonaments de seguretat web |
| 2n | Juice Shop | Les vulnerabilitats modernes + gamificació |
| 3r | Metasploitable | Atacs a xarxa, serveis i servidors antics |

Quan les hagis treballat totes tres, tens una base sòlida per
passar a plataformes externes com **TryHackMe** i **HackTheBox**, on
hi ha reptes del món real.

## Què has après

- Les 3 joguines NO són el mateix: cada una etenya una cosa
  diferent.
- Totes 3 són **gratuïtes** i **deliberadament vulnerables**.
- Cap d'elles **no és perillosa** si l'aïllament del galliner
  funciona (i funciona — veure [EX-08-05]
  (ex-08-05-aillar-xarxa-iptables.md)).

## Comprovacions

- [ ] Sabries explicar en veu alta què fa cada víctima
- [ ] Sabries dir per quina començar (DVWA — és la més fàcil)
- [ ] Saps on accedir-hi (les URLs)

## I ara què?

Si vols començar **avui mateix**:

1. Assegura't que el Kali està engegat i tens el túnel SSH obert.
2. Obre DVWA (`127.0.0.1:8080`) — entra amb `admin / password`.
3. Segueix l'[EX-08-02](ex-08-02-sql-injection-dvwa.md) — el primer
   atac de veritat (5 minuts, et sorprendràs).

## Referències

- [CAP-00-15](../chapters/cap-00-15-que-es-un-lab.md) — Què és un lab
- [CAP-08-10](../chapters/cap-08-10-apps-vulnerables.md) — Aplicacions
  vulnerables (versió tècnica)
- Pàgines oficials:
  - [DVWA](http://www.dvwa.co.uk/)
  - [OWASP Juice Shop](https://owasp.org/www-project-juice-shop/)
  - [Metasploitable](https://docs.rapid7.com/metasploit/metasploitable-2/)
