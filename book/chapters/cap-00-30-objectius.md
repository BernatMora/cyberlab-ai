---
id: CAP-00-30
title: "Objectius del projecte"
status: published
version: 1
created: 2026-07-28
updated: 2026-07-28
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - introduccio
  - objectius
prerequisites:
  - CAP-00-20
related:
  - CAP-00-40
  - CAP-01-10
---

# CAP-00-30 — Objectius del projecte

> Què volem aconseguir amb el Bernat CyberLab AI.

## Objectiu principal

Construir un **laboratori personal de ciberseguretat, completament legal,
privat i orientat exclusivament a l'aprenentatge**, que funcioni dins la
nostra pròpia infraestructura, modular, escalable, segur i documentat,
cap d'evolucionar durant anys.

## Objectius específics

### 1. Aprenentatge pràctic

Vull practicar, no només llegir:

- Linux (Ubuntu Server, Kali, gestió de serveis, scripting bash).
- Windows (administració, Active Directory, PowerShell).
- Xarxes (segmentació, VLAN, DNS, anàlisi de tràfic amb Wireshark).
- Docker i contenidors.
- Wireshark i anàlisi de paquets.
- Forense digital.
- Programació (Python, bash, scripts d'automatització).
- IA aplicada a la ciberseguretat (anàlisi de logs, generació de regles,
  assistent de laboratori).
- Anàlisi defensiva (SIEM, IDS, monitorització).
- Seguretat web en entorns de laboratori (DVWA, Juice Shop, OWASP).
- Active Directory en laboratoris propis.
- Gestió de vulnerabilitats en entorns de prova (OpenVAS/GVM).

Tot **sobre màquines i serveis propis del laboratori**. Mai contra sistemes
externs.

### 2. Plataforma estable

No vull una col·lecció de scripts que funcioni "de vegades". Vull una
plataforma:

- Que pugui estar engegada 24/7 sense intervenció manual.
- Que es recuperi sola d'un tall elèctric.
- Que documenti ella mateixa el seu estat.
- Que es pugui refer ràpidament des d'una còpia de seguretat.

### 3. Arquitectura escalable

Afegir una nova eina o VM ha de ser:

- **Documentat**: una ADR que justifiqui la decisió.
- **Reproduïble**: un script o un conjunt de comandes que ho faci sempre igual.
- **Aïllat**: la nova peça no afecta les existents.
- **Reversible**: es pot treure sense deixar rastre.

### 4. Documentació viva

No una documentació que s'escriu al final i queda obsoleta. Vull:

- Un llibre (aquest) que creix amb el projecte.
- ADR per a cada decisió important.
- TRB (resolucions de problemes) per a cada bug no trivial.
- Exercicis i laboratoris documentats pas a pas.

### 5. Automatització progressiva

No automatitzar-ho tot des del primer dia. Anar afegint automatització
quan una tasca es repeteix prou vegades per justificar l'script.

Hermes participarà progressivament:
- Inicialment: **consultar i recomanar**.
- Més endavant: **executar tasques reversibles** (arrancar contenidors,
  generar esquemes).
- Més endavant: **executar tasques amb confirmació humana** (modificar
  configuracions, crear VMs).
- MAI: **accés administratiu il·limitat**.

Veure [CAP-06-20](cap-06-20-hermes.md).

### 6. Aplicació de la IA

La IA no és el centre del projecte, és una eina més. Vull usar-la per:

- Accelerar l'anàlisi de logs.
- Generar esquemes de xarxa i documentació.
- Suggerir exercicis personalitzats segons el meu progrés.
- Ajudar a entendre alertes de seguretat.

Però **mai** per substituir el coneixement fonamental. Si no entenc per què
una cosa funciona, no la poso en producció.

### 7. Compartició selectiva

Aquest projecte és personal però **el llibre és públic**. La raó és doble:

- Documentar en públic em força a escriure millor.
- Pot ajudar algú en una situació semblant.

Compromís: cap dada sensible real al repo. Tots els exemples amb
placeholders.

## Anti-objectius

Tan important com saber què volem és saber **què NO volem**:

- ❌ No és un CTF competitiu.
- ❌ No és un entorn per practicar contra tercers.
- ❌ No és un servei comercial ni multi-usuari.
- ❌ No és una rèplica exacta d'una empresa; és un laboratori d'aprenentatge.
- ❌ No és una cursa per tenir més eines; tenir-ne menys i ben enteses és millor.

## Com es mesura l'èxit

El projecte serà un èxit si, d'aquí a 5 anys:

1. Puc tornar a aquest llibre i entendre tot el que hi ha explicat.
2. Puc reconstruir el laboratori en 1-2 dies des de zero seguint les
   instruccions.
3. He après els fonaments que volia aprendre.
4. Tinc una base sòlida per continuar creixent.

Si només una d'aquestes quatre coses es compleix, encara serà un èxit.

## Resum

- Aprenentatge pràctic sobre infraestructura pròpia.
- Plataforma estable, escalable, documentada.
- Automatització progressiva amb Hermes com a assistent.
- IA com a eina, no com a substitut del coneixement.
- Compartició selectiva (repo públic, dades privades).

## Referències

- [CAP-00-20](cap-00-20-filosofia.md) — Filosofia del CyberLab
- [CAP-00-40](cap-00-40-com-llegir.md) — Com llegir aquest llibre
- [CAP-01-10](cap-01-10-arquitectura-general.md) — Arquitectura general