---
id: CAP-00-15
title: "Què és un laboratori de ciberseguretat (i per què serveix)"
status: published
version: 1
created: 2026-08-06
updated: 2026-08-06
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - introduccio
  - laboratori
  - novatos
prerequisites: []
related:
  - CAP-00-10
  - CAP-00-20
  - CAP-08-10
---

# CAP-00-15 — Què és un laboratori de ciberseguretat (i per què serveix)

> Si el llibre et sona a xinès, comença per aquí. T'ho explico amb
> analogies que entens des del primer dia.

## 1. La pregunta incòmoda

Per què algú munten un **laboratori de ciberseguretat** a casa seva?
La resposta curta és:

> Per aprendre a defensar (i entendre) ordinadors **sense posar en
> risc** els ordinadors de veritat.

Però aquesta frase sona abstracta. Anem amb analogies.

## 2. L'analogia del cotxe d'autoescola

Quan tens 18 anys i vols el carnet de conduir:

- ❌ **NO** aprens entrant al pàrquing del supermercat i fent marxa
  enrere amb el cotxe del teu pare.
- ✅ El que fas és: lloges un **cotxe d'autoescola** (amb doble
  pedal de professor) i **practiques en una pista buida**.

Un **laboratori de ciberseguretat és exactament el mateix**:

- ❌ **NO** aprens entrant a la web del banc del teu veí.
- ✅ El que fas és: prepares **ordinadors de joguina** amb
  vulnerabilitats a propòsit i **practiques contra ells**.

| Autoescola | Laboratori cyber |
|---|---|
| Pista buida | Xarxa aïllada (`10.10.30.0/24`) |
| Cotxe amb doble pedal | Kali (sempre pots "desfer" el que facis) |
| Senyals de tràfic | Regles de tallafoc (`iptables`) |
| Examen oficial | Exercicis (`EX-XX-YY`) |
| Examen suspès = repetir | Contenidor trencat = `docker rm` i tornes a començar |

## 3. L'analogia del galliner

Un altre cop per entendre l'**aïllament**:

Imagina que vols entrenar el teu gos a caçar conills, però no tens
conills. Què fas?

- ❌ Deixes el gos sol al bosc i reses.
- ✅ Muntes un **galliner petit** amb conills de joguina (o conills
  vius en un tancat tancat amb clau).

L'aïllament del laboratori cyber és el **galliner**:

- El gos (Kali) pot entrar al galliner (xarxa `10.10.30.0/24`).
- **NO** pot sortir-ne per anar a mossegar la mainadera del veí.
- Si el gos es descontrola, els conills de joguina **NO pateixen**
  (són contenidors — els pots tornar a aixecar en 5 segons).

## 4. L'analogia del mecànic i el cotxe avariat

I per entendre les **3 "víctimes"** que tenim:

Un mecànic no aprèn amb un Ferrari modern. Aprèn amb **3 cotxes
diferents**, cadascun pensat per ensenyar una cosa:

| Víctima | Cotxe avariat equivalent | Què n'aprens |
|---|---|---|
| **DVWA** | Una Seat Panda dels 80 | Fonaments: com entrar i sortir bàsic |
| **Juice Shop** | Un Toyota modern amb ordinador de bord | Vulnerabilitats modernes web |
| **Metasploitable** | Un camió dels 90 amb el candau fluix | Servidors antics, FTP, carpetes compartides |

Les tres estan **aïllades dins el galliner** per si una l'aprèn a
utilitzar malament, la resta de casa teva (Mac, RPi, impressora) no
se n'assabenta.

## 5. Per què Docker i no màquines virtuals "de veritat"

Aquí ve la pregunta tècnica que tothom es fa:

> Per què no tenim un Windows de veritat amb un Linux de veritat
> corrent?

Perquè ocuparíem **40 GB de disc i 4 GB de RAM per cada màquina**.
Avui en dia els contenidors Docker fan **el mateix amb 200 MB i 50
MB de RAM** cadascun. Per a practicar és perfecte. El dia que vulguem
fer coses **molt serioses** (Active Directory de Windows, anàlisi de
malware, etc.), muntarem màquines virtuals de veritat a l'HP Z1 G9.

## 6. Qui hi ha dins el laboratori

En aquest moment tenim **tres personatges**:

1. **Bernat (humà)** — l'estudiant que aprèn.
2. **Kali Linux** — l'eina d'atac. Té centenars d'utilitats
   instal·lades (nmap, wireshark, sqlmap...). És com la **caixa
   d'eines** del mecànic.
3. **Les 3 víctimes** (DVWA, Juice Shop, Metasploitable) — els
   objectius de les pràctiques.

I una quarta peça invisible:

4. **El tallafoc** (`isolate-lab.sh` + `isolate-lab.service`) — el
   vigilant que impedeix que les pràctiques surtin del galliner.

## 7. Què NO és un laboratori

- **NO és una eina d'atac contra gent innocent.** Aprens contra
  joguines, no contra veïns.
- **NO és una garantia de feina.** Ningú et contractarà només per
  tenir un Kali muntat, però sí que et contractaran si saps **explicar
  què has après**.
- **NO és car.** Tots els programes que fem servir són gratuïts
  (Kali, DVWA, Juice Shop, Metasploitable). El que costa és el
  temps.
- **NO és il·legal.** Tot el que fem és contra ordinadors que són
  **nostres** i estan **aïllats**.

## 8. Què SÍ és

- **És una aula.** Cada víctima és una lliçó.
- **És un joc.** Juice Shop té un score board — encertar
  vulnerabilitats et dóna estrelles.
- **És una inversió.** El temps que hi dediques ara et servirà
  d'aquí 5 anys quan vulguis entendre un article de ciberseguretat,
  o auditar una xarxa, o simplement no caure en trucs bàsics.
- **És un hobby.** I per a mi això és el més important.

## 9. Resum

| Què | Per a què |
|---|---|
| **Kali** | La caixa d'eines de l'atacant (l'estudiant) |
| **DVWA** | Una botiga web de joguina per practicar coses bàsiques |
| **Juice Shop** | Una botiga web moderna de joguina per practicar coses noves |
| **Metasploitable** | Un servidor Linux de joguina per practicar coses velles |
| **`isolate-lab.sh`** | El vigilant que no deixa sortir res del galliner |
| **`isolate-lab.service`** | L'encenedor automàtic del vigilant |

Si has entès aquesta taula, **ja saps més del 80% del que fa el
laboratori**. La resta és practicar i aprofundir.

## 10. Per on continuar

- Vols veure les joguines amb més detall? → [EX-00-01]
  (../exercises/ex-00-01-que-son-aquestes-3-victimes.md)
- Vols entendre la filosofia del projecte? → [CAP-00-20]
  (cap-00-20-filosofia.md)
- Vols saber què és cada eina de Kali? → [CAP-08-20]
  (cap-08-20-kali-linux.md)
- Vols veure què hem muntat al hort avui (6 agost 2026)? → [ANN-07]
  (../appendices/ann-07-historia-del-projecte.md), secció
  `2026-08-06`.
