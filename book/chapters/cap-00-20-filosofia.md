---
id: CAP-00-20
title: "Filosofia del CyberLab"
status: published
version: 1
created: 2026-07-28
updated: 2026-07-28
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - introduccio
  - filosofia
prerequisites:
  - CAP-00-10
related:
  - CAP-00-30
  - CAP-00-50
---

# CAP-00-20 — Filosofia del CyberLab

> Els principis que guien totes les decisions tècniques del projecte.

Aquest capítol estableix els **7 principis rectors** del CyberLab. Totes
les decisions posteriors — quina eina instal·lar, quina arquitectura triar,
quins recursos dedicar — es contrasten amb aquesta llista.

## 1. Modular

> Cada component té una responsabilitat clara i pot substituir-se.

- Un sol servei per fitxer de configuració.
- Les dependències entre mòduls són explícites i documentades.
- Afegir o treure una peça no ha de trencar la resta.

Per què? Perquè els projectes de laboratori tendeixen a créixer orgànicament
i acabar com un bolet de configuracions interdependents on tocar una cosa
pot trencar tres més.

## 2. Escalable

> Afegir una nova VM, contenidor o eina ha de ser trivial i documentat.

- Cada nova peça té la seva pròpia secció al llibre i la seva ADR.
- Els esquemes d'adreces IP tenen espai per créixer.
- Les capacitats del maquinari es mesuren, no es suposen.

Per què? Perquè d'aquí un any voldré afegir un Active Directory, una eina
de forense o un model d'IA local més gran, i hauria de poder fer-ho sense
replantejar tota l'arquitectura.

## 3. Documentat

> Cada decisió tècnica té una justificació escrita i un procediment pas a pas.

- Cap decisió important sense una ADR (Architecture Decision Record).
- Cada instal·lació té el seu capítol amb les 15 seccions estàndard.
- Cap configuració sense un README que l'expliqui.

Per què? Perquè la memòria humana és fràgil i el coneixement no documentat
és coneixement perdut.

## 4. Automatitzat

> Les tasques repetibles són scripts, no clics manuals.

- Scripts al repo per a tot allò que s'hagi de fer més d'una vegada.
- Plantilles per a coses comunes (crear VM, crear contenidor, crear ADR).
- Hooks de pre/post a Git quan calgui.

Per què? Perquè automatitzar allò que es repeteix allibera temps per a
l'aprenentatge, que és l'objectiu últim.

## 5. Segur

> El laboratori no és un joc; s'aplica el principi de mínim privilegi.

- Xifratge de discs al PC i a la Raspberry.
- Autenticació multifactor a tots els serveis externs.
- Xarxes segmentades i aïllament de màquines vulnerables.
- Cap secret en text pla al Git.
- Cap port obert al router domèstic que no sigui estrictament necessari.

Per què? Perquè el fet que sigui un laboratori no vol dir que pugui estar
desprotegit. Aprendre seguretat implica **fer seguretat**.

## 6. Fàcil de mantenir

> Un altre tu (o un col·laborador) ha de poder reprendre el projecte en 6
> mesos només llegint la documentació.

- Convencions clares (noms, estructura, formats).
- Scripts d'auditoria que recullen l'estat actual del sistema.
- Cap dependència de decisions no documentades.

Per què? Perquè el context es perd. Si la documentació no és prou bona per
rellegir-la sense context, no és prou bona.

## 7. Ètic i legal

> Totes les pràctiques es limiten a dispositius, màquines virtuals,
> contenidors i serveis propis. No es dissenyen ni s'automatitzen activitats
> dirigides contra sistemes de tercers.

- Aïllament de xarxa per a totes les màquines vulnerables.
- Monitorització per detectar qualsevol tràfic de sortida no desitjat.
- Cap càrrega d'eines ofensives a màquines amb accés a la xarxa domèstica.
- Una reflexió explícita sobre l'abast a [CAP-00-50](cap-00-50-etica-legalitat-abast.md).

Per què? Perquè la ciberseguretat ètica comença amb la pròpia conducta.

## Com s'apliquen aquests principis

Cada decisió tecnològica del projecte es contrasta amb aquesta llista. Si
una elecció trenca més d'un principi, requereix una justificació
extraordinària i una ADR explícita.

Per exemple:

- "Per què Ollama al MacBook Pro i no al PC Windows?"
  → Modularitat (responsabilitat clara), escala (no competeix amb les VMs),
    seguretat (aïlla la càrrega d'IA del cor del laboratori).

- "Per què Tailscale i no una VPN tradicional?"
  → Modularitat (un sol agent), facilitat (no exposar ports), manteniment
    (configuració mínima), escala (afegir un node és un clic).

- "Per què Hyper-V i no Proxmox?"
  → Modularitat (no esborrar Windows), escala (coexisteix amb WSL2),
    facilitat (natiu). Compromís: rendiment lleugerament inferior a Proxmox.

## Resum

7 principis: **modular, escalable, documentat, automatitzat, segur, fàcil
de mantenir, ètic i legal**. Tots ells al servei d'un únic objectiu:
aprendre.

## Referències

- [CAP-00-10](cap-00-10-proleg.md) — Pròleg
- [CAP-00-30](cap-00-30-objectius.md) — Objectius del projecte
- [CAP-00-50](cap-00-50-etica-legalitat-abast.md) — Ètica, legalitat i abast
- [`docs/00-pla-director.md`](../../docs/00-pla-director.md) — Pla Director del laboratori