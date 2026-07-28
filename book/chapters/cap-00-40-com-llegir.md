---
id: CAP-00-40
title: "Com llegir aquest llibre"
status: published
version: 1
created: 2026-07-28
updated: 2026-07-28
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - introduccio
  - lectura
prerequisites:
  - CAP-00-30
related:
  - CAP-00-50
  - CAP-01-10
---

# CAP-00-40 — Com llegir aquest llibre

> Una guia per treure el màxim profit d'aquest material.

## A qui va dirigit cada nivell

Aquest llibre assumeix **coneixements tècnics generals** (saber què és una
IP, un sistema operatiu, una xarxa) però **no assumeix coneixements previs
de cap eina concreta**. Cada capítol comença pel "què és" i acaba al "com
l'ho apliquem al CyberLab".

Si ets:

### Principiant amb ganes

1. Llegeix els capítols del **Bloc 0** (introdueix el projecte).
2. Llegeix el [CAP-01-10](cap-01-10-arquitectura-general.md) i el
   [CAP-01-30](cap-01-30-xarxes-fonaments.md).
3. Fes els exercicis guiats (Bloc 9).
4. Salta als capítols concrets quan et calguin.

### Professional amb experiència

1. Llegeix els **Bloc 0** ràpidament (5 minuts).
2. Mira el [`SUMMARY.md`](../SUMMARY.md) per veure l'abast.
3. Salta als capítols que t'interessen.
4. Compara les nostres eleccions amb les teves (les ADR estan ben
   justificades i pots dirimir ràpidament).

### Estudiant de ciberseguretat

1. Llegeix tot seguint l'ordre del SUMMARY.
2. Fes tots els exercicis del Bloc 9.
3. Reescriu les ADR amb les teves decisions; compara-les amb les nostres.

## Convencions del llibre

### Codis permanents

Cada fitxer té un **codi únic** al frontmatter YAML:

| Prefix | Tipus |
|---|---|
| `CAP-XX-YY` | Capítol |
| `EX-XX-YY` | Exercici |
| `LAB-XX-YY` | Laboratori pràctic |
| `ADR-XXX` | Decisió d'arquitectura |
| `TRB-XX-YY` | Resolució de problema |
| `CHK-XX-YY` | Checklist |
| `ANN-XX` | Annex |

El codi és **permanent**: si un capítol canvia de títol, el codi no canvia.
Si un capítol queda obsolet, es marca com a `deprecated` però el codi es
conserva.

### Estructura comuna dels capítols

Tots els capítols segueixen **15 seccions estàndard** (veure la
[plantilla](../templates/cap-XX-YY.md)):

1. Què és?
2. Per què existeix?
3. Quan s'utilitza?
4. Alternatives
5. Avantatges
6. Inconvenients
7. Arquitectura al CyberLab
8. Instal·lació
9. Configuració
10. Verificació
11. Problemes habituals
12. Bones pràctiques
13. Aspectes de seguretat
14. Automatització amb Hermes
15. Resum

### Estats dels capítols

- `idea` — encara no hi ha estructura.
- `outline` — esquema bàsic amb les 15 seccions.
- `draft` — esborrany en curs.
- `review` — pendent de revisió.
- `published` — publicat i validat.
- `deprecated` — substituït.

Pots veure l'estat global al [`SUMMARY.md`](../SUMMARY.md).

### Notació

- `codi` — text exacte a teclejar (comandes, fitxers).
- `[CAP-XX-YY](cap-XX-YY.md)` — enllaç a un altre capítol.
- **[ADR-XXX](../chapters/...)** — decisió documentada.
- ⚠️ — avís important (risc, error comú).
- 💡 — consell pràctic.
- 🔒 — aspecte de seguretat.

### Exemples i placeholders

Tots els exemples del llibre usen:

- **IPs fictícies**: `10.10.20.0/24`, `192.168.x.x`.
- **Noms genèrics**: `cyber-host`, `kali-01`.
- **Placeholders**: `<CYBER_HOST_IP>`, `<TAILSCALE_AUTHKEY>`.

Cap valor real. Si necessites els teus valors reals, mira
`BernatCyberLab/_local/` al PC (no versionat).

## Com navegar entre capítols

Cada capítol enllaça amb:

- Els seus **prerequisites**: capítols que cal llegir abans.
- Els seus **related**: capítols que hi estan connectats.
- Les **ADR** que el justifiquen.
- Els **exercicis i laboratoris** associats.

Si comences pel [CAP-01-10](cap-01-10-arquitectura-general.md) i segueixes
l'ordre, tens una lectura lineal completa. Si vols saltar, mira els
prerequisites de cada capítol.

## Ritme de lectura recomanat

| Tipus de capítol | Temps estimat |
|---|---|
| Bloc 0 (introdueix) | 15-20 min |
| Capítol tècnic publicat | 20-40 min |
| Exercici | 15-60 min |
| Laboratori pràctic | 1-4 h |

Per al **Bloc 0** sencer, calcula ~1 hora.

## Com contribuir

Si vols afegir un capítol, un exercici o una ADR:

1. Tria un `id` lliure respectant els salts de 10.
2. Copia la plantilla corresponent.
3. Omple el frontmatter YAML.
4. Segueix l'estructura estàndard.
5. Afegeix-lo al [`SUMMARY.md`](../SUMMARY.md).
6. Obre un PR.

Veure [`README.md`](../README.md) per detalls.

## Resum

- Tres audiències definides.
- Codis permanents, 15 seccions estàndard, 6 estats possibles.
- Notació clara i exemples sempre amb placeholders.
- Ritme flexible, navegació per prerequisites i related.

## Referències

- [CAP-00-30](cap-00-30-objectius.md) — Objectius
- [CAP-00-50](cap-00-50-etica-legalitat-abast.md) — Ètica
- [`README.md`](../README.md) — Guia editorial del llibre
- [`SUMMARY.md`](../SUMMARY.md) — Índex mestre