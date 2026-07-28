# ADR-0001 — Arquitectura general del CyberLab

- **Estat:** acceptada
- **Data:** 2026-07-28
- **Decisors:** Bernat Mora + Hermes
- **Tags:** arquitectura, visió-global

## Context i problema

L'objectiu és construir un laboratori personal de ciberseguretat que sigui **modular, escalable, documentat, segur i fàcil de mantenir**, sobre el maquinari ja disponible (PC Windows, 2 MacBook, Raspberry Pi 4, iPhone). Cap dispositiu ha d'assumir més responsabilitats de les que pot dur de forma sostenible 24/7.

## Consideracions

- El PC Windows (HP Z1 G9, 32 GB RAM) és la màquina més potent — bona candidata per a virtualització.
- El MacBook Pro 13" (macOS 12.7.6) pot estar sempre connectat — bona candidata per a serveis IA.
- El MacBook Air ha de quedar lliure per a ús diari (bateria + rendiment).
- La Raspberry Pi 4 té 4 GB de RAM — insuficient per a models d'IA útils, però adequada per a serveis lleugers.
- L'iPhone és un terminal mòbil, no un servidor.
- Tots els dispositius poden participar en una xarxa Tailscale, formant un tailnet privat sense exposar ports al router.

## Opcions considerades

### Opció A — Tot al PC Windows (un sol servidor)
- Pros: simplicitat, una sola màquina potent.
- Contres: punt únic de fallada per a tot; el PC ha de fer VMs + IA + monitorització; l'iPhone queda exclòs.

### Opció B — Distribució per responsabilitat (escollida)
- Pros: cada m té un rol clar; fallides aïllades; replicable.
- Contres: més complexitat de xarxa i configuració inicial; cal coordinació entre equips.

### Opció C — Tot al cloud
- Pros: cap dependència del maquinari local.
- Contres: costos, latència, pràctiques ofensives al cloud són delicades; no és l'objectiu.

## Decisió

**Opció B — distribució per responsabilitat:**

- `cyber-host` (PC Windows) → host de virtualització i storage.
- `cyber-brain` (MacBook Pro) → Hermes, Ollama, MCP, automatitzacions.
- `cyber-pi` (Raspberry Pi) → DNS, monitorització, watchdog.
- `cyber-control` (MacBook Air) → consola humana sense serveis.
- `cyber-mobile` (iPhone) → consola mòbil sense serveis.

Tots units per Tailscale (xarxa de gestió). Les xarxes de laboratori (10.10.20/30/40/24) **no es publiquen al tailnet** per defecte.

## Conseqüències

### Positives
- Cada m pot fallar sense arrossegar la resta.
- Les VMs poden consumir RAM del PC sense competir amb Ollama.
- El MacBook Air queda 100% per a ús diari.

### Negatives
- Més passos d'instal·lació distribuïts.
- Tailscale és un punt únic d'accés remot (risc parcial; mitigat amb autenticació multifactor i monitorització).

### Riscos acceptats
- El MacBook Pro degradarà la bateria si està sempre endollat → mitigat amb `Al Dente` i comprovacions periòdiques.
- L'SD de la RPi pot fallar → mitigat amb còpies de seguretat de la imatge i/o SSD USB boot.

## Validació

- Cadascun dels 5 dispositius pot fer ping a la resta via Tailscle.
- Cada dispositiu té el seu nom al tailnet i resol per MagicDNS.
- Les xarxes de laboratori (10.10.x) **no** són visibles des del tailnet.
- Una VM de prova no pot accedir a la xarxa domèstica sense regla explícita.

## Referències

- `docs/00-pla-director.md` — Pla Director complet
- `architecture/diagram-general.md` — diagrama Mermaid
- `architecture/convencions-noms.md` — noms dels equips
