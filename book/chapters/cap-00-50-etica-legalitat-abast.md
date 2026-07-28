---
id: CAP-00-50
title: "Ètica, legalitat i abast"
status: published
version: 1
created: 2026-07-28
updated: 2026-07-28
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - introduccio
  - etica
  - legalitat
prerequisites:
  - CAP-00-40
related:
  - CAP-00-20
  - CAP-01-40
---

# CAP-00-50 — Ètica, legalitat i abast

> Aquest capítol existeix per una raó concreta: la ciberseguretat comença
> per la pròpia conducta. Sense reflexió ètica, un laboratori és perillós.

## Principi fonamental

**Totes les pràctiques d'aquest laboratori es limiten exclusivament a
dispositius, màquines virtuals, contenidors i serveis propis.**

No es dissenyen ni s'automatitzen activitats dirigides contra sistemes de
tercers. No es fan probes en xarxes alienes. No s'exploren vulnerabilitats
en serveis que no siguin nostres.

## Per què importa

### 1. És il·legal

Accedir, interrompre o simplement explorar sistemes informàtics aliens
sense autorització és delicte a la majoria de jurisdiccions, inclosa
l'espanyola (Llei Orgànica 10/1995 del Codi Penal, articles 197 bis i
tercers; i normativa europea equivalent).

### 2. És immoral

Independentment de la legalitat, fer proves contra tercers sense el seu
consentiment viola el seu dret a la privacitat i a la integritat dels
seus sistemes.

### 3. És contraproduent

Una persona que practica ofensivament fora del seu laboratori no està
aprendre ciberseguretat: està posant en risc la seva carrera, la seva
llibertat i la reputació de la comunitat.

## L'abast del CyberLab

### Dins de l'abast

Tot el que sigui **nostre** i estigui **aïllat**:

- Les màquines virtuals del nostre PC.
- Els contenidors Docker al nostre entorn.
- Les màquines vulnerables descarregades oficialment (Metasploitable,
  DVWA, Juice Shop, etc.).
- Les xarxes internes del laboratori (10.10.x.x).
- Els serveis que aixequem nosaltres mateixos.

### Fora de l'abast

- Qualsevol dispositiu de la xarxa domèstica **fora** del laboratori.
- Qualsevol servei a Internet sense autorització explícita i per escrit.
- Qualsevol dispositiu d'un veí, d'un amic o d'un desconegut.
- Qualsevol sistema d'una empresa per la qual treballem (encara que hi
  tinguem accés, hi ha polítiques).
- Qualsevol xarxa Wi-Fi pública oberta.

### Àrea grisa (cal extremada precaució)

- **CTFs (Capture The Flag)**: sí, però sempre en entorns controlats.
- **Bug bounties**: sí, però amb compte registrat i respectant l'abast
  definit per l'empresa.
- **HackTheBox / TryHackMe / VulnHub**: sí, són plataformes legals.
- **Pràctiques en empreses amb autorització**: sí, sempre amb carta
  signada i clàusules clares.

## Com es garanteix l'aïllament

### Xarxa

- Les xarxes de laboratori (`10.10.20/30/40.0/24`) **no es publiquen** a
  Tailscale.
- Les màquines vulnerables **no tenen Gateway per defecte** — no poden
  trucar a casa.
- Cap port obert al router domèstic.
- Les xarxes internes del laboratori estan separades de la LAN domèstica
  per Hyper-V vSwitch.

Detalls a [CAP-01-40](cap-01-40-subxarxes-segmentacio.md).

### Identitat

- Cap servei del laboratori usa les nostres credencials personals reals.
- Comptes separats per a administració del laboratori.
- Cap correu personal ni compte bancari en cap servei del laboratori.

### Dades

- Cap dada personal real al repo.
- Cap dada personal real al laboratori (només dades de prova generades
  per a aquest propòsit).

### Eines

- Eines ofensives només a màquines aïllades.
- Cap eina ofensiva a màquines amb accés a la xarxa domèstica.
- Tots els logs es revisen periòdicament per detectar qualsevol tràfic
  de sortida no desitjat.

## Com actuar si trobes una vulnerabilitat "al món real"

Si durant una navegació, una investigació o una pràctica descobreixes una
vulnerabilitat en un sistema d'un altre:

1. **No la provis ni la valides**.
2. **No la comparteixis** en canals públics.
3. **Contacta amb l'organització** mitjançant el seu programa de
   divulgació responsable (si en té) o el seu formulari de contacte.
4. **Documenta el procés** al teu KeePassXC (no al repo).

Si tens dubtes sobre si una acció és legal o ètica, **no la facis** fins
que ho hagis validat amb una font fiable.

## Responsabilitat

La responsabilitat última de cada acció dins del laboratori és meva.
Hermes pot suggerir, recomanar i executar tasques tècniques, però la
decisió d'actuar — i la responsabilitat de les conseqüències — és sempre
humana.

## Resum

- **L'abast és explícit**: només sistemes propis.
- **L'aïllament és tècnic**: xarxa, credencials, dades i eines separades.
- **La responsabilitat és humana**: jo decideixo, jo responc.
- **La regla és simple**: si no és teu o no tens autorització, no hi
  toquis.

## Referències

- [CAP-00-20](cap-00-20-filosofia.md) — Filosofia (principi 7: ètic i legal)
- [CAP-01-40](cap-01-40-subxarxes-segmentacio.md) — Subxarxes i segmentació
- [CAP-04-10](cap-04-10-tailscale.md) — Tailscale (per què no exposar
  serveis directament a Internet)
- [`../../CONTRIBUTING.md`](../../CONTRIBUTING.md) — Política de secrets