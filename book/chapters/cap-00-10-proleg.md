---
id: CAP-00-10
title: "Pròleg"
status: published
version: 1
created: 2026-07-28
updated: 2026-07-28
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - introduccio
  - proleg
prerequisites: []
related:
  - CAP-00-20
  - CAP-00-30
---

# CAP-00-10 — Pròleg

> Benvingut al Llibre Viu del Bernat CyberLab.

## Per què aquest llibre existeix

Aquest llibre no és un manual d'instal·lació. Tampoc és una col·lecció de
configuracions copiades d'Internet. És la **memòria viva d'un projecte** que
vol construir un laboratori personal de ciberseguretat, modular, segur,
documentat i evolucionable.

La idea és senzilla: cada vegada que afegim una eina, canviem una
configuració, aprenem un error o prenem una decisió, ho deixem per escrit.
No només el "què" i el "com", sinó també el **"per què"**. Perquè d'aquí a
dos, cinc o deu anys, puguem rellegir-lo i entendre exactament què vam fer,
per què ho vam fer, què hauria de continuar igual i què hauria de canviar.

## A qui va dirigit

- A **mi mateix**, quan hagi oblidat detalls.
- A qualsevol persona amb coneixements tècnics que vulgui **reconstruir el
  laboratori** des de zero.
- A estudiants o professionals que vulguin veure un exemple real de
  projecte de ciberseguretat amb totes les seves virtuts i imperfeccions.

## Què trobaràs

- **22 capítols** organitzats en 9 blocs temàtics.
- **Exercicis i laboratoris pràctics** associats a cada tema.
- **Decisions documentades** (ADR) que expliquen per què hem triat cada
  tecnologia.
- **Resolucions de problemes** reals (TRB).
- **Plantilles** per crear nous capítols, exercicis i laboratoris amb el
  mateix format.

## Què NO trobaràs

- Informació sensible real: cap IP privada, MAC, contrasenya, token ni clau.
- Promeses de cobertura completa: aquest llibre serà eternament incomplet.
- Perfecció: cometrem errors i els documentarem tal com són.

## Com navegar-lo

Si ets la primera vegada, comença pel [CAP-00-20](cap-00-20-filosofia.md),
després el [CAP-00-30](cap-00-30-objectius.md), el
[CAP-00-40](cap-00-40-com-llegir.md) i el
[CAP-00-50](cap-00-50-etica-legalitat-abast.md). A partir del CAP-01 tens
el llibre tècnic pròpiament dit.

### Si ets **jo** del futur i no recordes res

Aquest llibre està escrit per a gent que ja en sap una mica. Però si
ets tu mateix d'aquí 3 anys i has oblidat tot, **comença aquí**:

1. [CAP-00-15](cap-00-15-que-es-un-lab.md) — què és un laboratori de
   ciberseguretat, explicat amb analogies de cotxes i galliners
   (15 min).
2. [EX-00-01](../exercises/ex-00-01-que-son-aquestes-3-victimes.md) —
   què són les 3 "víctimes" del lab i què n'aprens amb cada una
   (10 min, sense tocar res).
3. Després ja pots tornar a la resta del llibre.

Això et donarà el **mínim viable** per entendre tota la resta.

Si ja tens experiència, salta a la [`SUMMARY.md`](../SUMMARY.md) i tria el
bloc que t'interessi.

## Una nota sobre Hermes

Hermes és el meu assistent tècnic i coautor d'aquest llibre. La seva
participació es nota sobretot en:

- L'estructura i la claredat del llenguatge.
- La identificació de patrons i bones pràctiques.
- L'automatització d'algunes tasques repetitives.

Les **decisions finals, l'ètica i la responsabilitat** són meves.

---

*Comencem.*