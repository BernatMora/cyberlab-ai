# Convencions de noms dels equips

Adoptem noms curts, en minúscules, amb guions, sense espais ni caràcters especials.
Tots els noms s'usen simultàniament a **Tailscale**, **SSH**, **DNS**, **Docker** i
**documentació**.

## Convensió

- `cyber-<rol>` per als equips físics de gestió del laboratori.
- `<servei>-<nn>` per a les màquines virtuals i contenidors.
- Sufix numèric de 2 dígits si n'hi ha més d'un (p. ex. `kali-01`, `kali-02`).

## Dispositius físics

| Nom curt | Dispositiu | FQDN Tailscale |
|---|---|---|
| `cyber-host` | PC Windows 11 (HP Z1 G9) | `cyber-host.tailnet` |
| `cyber-brain` | MacBook Pro 13" (macOS 12.7.6) | `cyber-brain.tailnet` |
| `cyber-pi` | Raspberry Pi 4 | `cyber-pi.tailnet` |
| `cyber-control` | MacBook Air 13" (macOS 26.5.2) | `cyber-control.tailnet` |
| `cyber-mobile` | iPhone 17 | `cyber-mobile.tailnet` |

## Màquines virtuals

| Nom | Funció | FQDN Tailscale |
|---|---|---|
| `kali-01` | Kali Linux (atacant) | `kali-01.tailnet` |
| `ubuntu-01` | Ubuntu Server (base) | `ubuntu-01.tailnet` |
| `win-lab-01` | Windows 10/11 vulnerable | `win-lab-01.tailnet` |
| `target-linux-01` | Màquina Linux vulnerable (Metasploitable, etc.) | `target-linux-01.tailnet` |
| `target-web-01` | App web vulnerable (DVWA / Juice Shop) | `target-web-01.tailnet` |
| `win-dc-01` | Windows Server com a Domain Controller | `win-dc-01.tailnet` (Fase 8) |
| `defense-01` | SIEM / sensor | `defense-01.tailnet` (Fase 9) |

## Serveis a la Raspberry Pi (mateixa màquina, noms lògics diferents)

| Nom | Funció | Port intern |
|---|---|---|
| `cyber-dns` | AdGuard Home | 53 (DNS), 3000 (UI) |
| `cyber-mon` | Uptime Kuma | 3001 (UI) |
| `cyber-nodered` | Node-RED | 1880 (UI) |
| `cyber-ntfy` | ntfy (notificacions) | 2586 |

Tots viuen al `cyber-pi`. Els noms lògics permeten regles específiques a les
ACL de Tailscale sense dependre de la IP.

## Contenidors Docker al PC

| Nom | Funció | Port host |
|---|---|---|
| `dvwa-01` | DVWA (web vulnerable) | 8080 |
| `juice-shop-01` | OWASP Juice Shop | 8081 |
| `portainer-01` | Portainer (gestió Docker) | 9443 |
| `watchtower-01` | Watchtower (auto-update) | n/a |

## Bones pràctiques

- **Mai** posar el nom real d'una persona a un nom d'equip.
- **Mai** posar la ubicació geogràfica.
- Si una màquina canvia de rol, es rebateja (no s'afegeix un sufix `_v2`).
- Els noms es decideixen a [`ADR/0001-arquitectura-general.md`](../ADR/0001-arquitectura-general.md).
