# ADR-0002 — Assignació de rols per equip

- **Estat:** acceptada (revisada 2026-07-28)
- **Data original:** 2026-07-28
- **Última revisió:** 2026-07-28
- **Decisors:** Bernat Mora + Hermes Agent
- **Tags:** rols, equip

## Context i problema

Volem decidir quin equip fa què. No tots els dispositius serveixen per a tot, i ara tenim **dues ubicacions** (hort amb Parlem 5G/CGNAT i casa) que hem de cobrir correctament.

## Consideracions

| Equip | Ubicació | Capacitat | Limitacions |
|---|---|---|---|
| PC HP Z1 G9 (32 GB) | **Hort** | CPU potent, RAM abundant | Distància, accés remot depèn de Parlem |
| MacBook Pro 13" vell (macOS 12.7.6) | **Hort** | Sempre endollat | Bateria, any (pendent validar) |
| Mac potent de casa | **Casa** | Alta capacitat | Compartit amb ús diari |
| MacBook Air | **Casa** | Màquina de treball | Bateria, rendiment, portabilitat |
| iPhone | **Casa o mòbil** | Mòbil | Pantalla, bateria |
| RPi del projecte hort-osona | **Hort** | — | **NO entra al lab.** Reservada per al projecte hort-osona. |
| `cyber-pi` (futura) | Per decidir | — | Decidim a Fase 1 |

## Decisió

### Ubicació HORT

| Rol | Equip | Motiu |
|---|---|---|
| Host principal (Kali + hipervisor) | `cyber-host` (PC HP Z1 G9) | 32 GB RAM per a VMs; Kali natiu; el cor del lab és aquí |
| Servei complementari a l'hort | `cyber-helper` (MBP vell) | Tailscale, scripts, monitoratge local |

### Ubicació CASA

| Rol | Equip | Motiu |
|---|---|---|
| Centre de control (des d'on es fan les pràctiques) | `cyber-brain` (Mac potent) | Màquina principal de treball; capacitat alta |
| Consola diària | `cyber-control` (MacBook Air) | Ús diari, sense serveis permanents |
| Consola mòbil | `cyber-mobile` (iPhone) | SSH mòbil, Tailscale, notificacions |

### Pendent de decidir

| Rol | Equip | Estat |
|---|---|---|
| Infraestructura lleugera (AdGuard, Uptime Kuma, ntfy, watchdog) | `cyber-pi` | Decidim a Fase 1: RPi nova, contenidor Docker, o altre |

## Conseqüències

- El cervell del lab és el PC de l'hort, no el Mac potent de casa. Això és **voluntari**: volem que el laboratori estigui "a prop de les màquines que estudia", i les VMs al PC de l'hort hi estan.
- El Mac potent de casa és el centre de **control**, no de càlcul. Una futura eina d'anàlisi pot dividir tasques entre ambdós.
- La RPi del hort-osona queda **independent** d'aquest projecte.
- Si volem `cyber-pi`, hem de comprar-la nova (no podem tocar la del hort-osona).

## Validació (a Fase 1)

- El PC de l'hort pot fer SSH al Mac potent de casa via Tailscale.
- El Mac potent de casa pot fer SSH al PC de l'hort via Tailscale.
- Tots els equips es veuen al `tailscale status` amb el seu nom correcte.
- El PC de l'hort continua accessible quan Parlem rota la IP (perquè Tailscale no depèn d'IP pública).

## Referències

- `ADR/0001-arquitectura-general.md` — arquitectura general
- [`../book/chapters/cap-01-60-ubicacions-i-desplegaments.md`](../book/chapters/cap-01-60-ubicacions-i-desplegaments.md) — escenaris de desplegament
- `docs/00-pla-director.md` § 1