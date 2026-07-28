# ADR-0002 — Assignació de rols per equip

- **Estat:** acceptada
- **Data:** 2026-07-28
- **Decisors:** Bernat Mora + Hermes
- **Tags:** rols, equip

## Context i problema

Volem decidir quin equip fa què. No tots els dispositius serveixen per a tot.

## Consideracions

| Equip | Capacitat | Limitacions |
|---|---|---|
| PC Windows (HP Z1 G9, 32 GB) | CPU potent, RAM abundant, sempre encès | Cal deixar-ne RAM per a ús diari de Windows |
| MacBook Pro 13" (macOS 12.7.6) | Sempre endollat, dedicat | Bateria, any (pendent validar) |
| MacBook Air 13" (macOS 26.5.2) | Màquina de treball | Bateria, rendiment, portabilitat |
| Raspberry Pi 4 | Sempre en marxa, baix consum | 4 GB RAM, SD frágil |
| iPhone 17 | Mòbil | Pantalla, bateria, no servidor |

## Opcions considerades

### Opció A — Ollama al PC
- Contres: competeix amb les VMs per RAM; el PC no pot fer dues coses bé alhora.

### Opció B — Ollama al MacBook Pro (escollida)
- Pros: dedicat; no competeix amb VMs; sempre encès.
- Contres: any del hardware (pendent validar Fase 0).

### Opció C — Ollama a la Raspberry Pi
- Contres: 4 GB RAM insuficient per a models útils; CPU ARM lenta.

## Decisió

| Rol | Equip | Motiu |
|---|---|---|
| Host VMs | `cyber-host` (PC) | 32 GB RAM, Hyper-V natiu |
| Cervell IA | `cyber-brain` (MBP) | Sempre encès, dedicat |
| DNS / monitor / watchdog | `cyber-pi` (RPi) | Baix consum, sempre en marxa |
| Consola humana | `cyber-control` (MBA) | Ús diari sense serveis |
| Consola mòbil | `cyber-mobile` (iPhone) | Tailscale + SSH app |

**Regla:** la RPi no executa Ollama; el MBA no allotja serveis permanents; el PC no allotja Ollama.

## Conseqüències

- El cervell IA depèn del MacBook Pro. Si mor, cal substituir o redistribuir.
- La RPi queda com a única peça "sempre en marxa" de baix consum — bona candidata per a Wake-on-LAN del PC.

## Validació

- Comprovació a Fase 0 que el MacBook Pro té prou RAM i és recent.
- Prova de foc: una inferència de 7B amb Ollama retorna en <10 s en una frase curta.

## Referències

- `ADR/0001-arquitectura-general.md`
- `docs/00-pla-director.md` § 1
