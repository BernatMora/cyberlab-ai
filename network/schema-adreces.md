# Esquema d'adreces (plantilla pública)

> Les IPs reals del teu entorn viuen a `BernatCyberLab/_local/network/ips.local.md` (no versionat).
> Aquest fitxer usa **placeholders** i rangs de referència.

## Xarxes principals

| Xarxa | Rang | Propòsit |
|---|---|---|
| Xarxa domèstica | `<LAN>/24` (placeholder: `192.168.1.0/24`) | Els teus equips personals |
| Tailscale tailnet | `100.64.0.0/10` | Pla de gestió entre equips |
| Gestió de VMs | `10.10.10.0/24` | Host ↔ VMs (SSH, gestió) |
| Xarxa ofensiva | `10.10.20.0/24` | Kali i eines d'atac |
| Xarxa de víctimes | `10.10.30.0/24` | Màquines i apps vulnerables |
| Xarxa defensiva | `10.10.40.0/24` | SIEM, sensors, IDS |

## Adreces reservades (plantilla)

### cyber-host (PC Windows)
- LAN: `<CYBER_HOST_LAN_IP>` (placeholder: `192.168.1.10`)
- Tailscale: assignat per Tailscale
- Gestió de VMs: `10.10.10.1` (host) — placeholder

### cyber-brain (MacBook Pro)
- LAN: `<CYBER_BRAIN_LAN_IP>` (placeholder: `192.168.1.20`)
- Tailscale: assignat per Tailscale

### cyber-pi (Raspberry Pi)
- LAN: `<CYBER_PI_LAN_IP>` (placeholder: `192.168.1.30`)
- Tailscale: assignat per Tailscale

### cyber-control (MacBook Air)
- LAN: assignat per DHCP (no crític)

### cyber-mobile (iPhone)
- Mòbil, canvia sovint; només importa la IP Tailscale

## VMs (plantilla)

| Màquina | Xarxa | IP estàtica |
|---|---|---|
| `kali-01` | Ofensiva | `10.10.20.10` |
| `ubuntu-01` | Gestió + Ofensiva | `10.10.10.11` |
| `target-linux-01` | Víctimes | `10.10.30.10` (sense Gateway) |
| `target-web-01` | Víctimes | `10.10.30.11` (sense Gateway) |
| `win-dc-01` (Fase 8) | Defensa + AD interna | `10.10.40.10` |

## Bones pràctiques

- **IP estàtica** per a totes les VMs de servei (no dependre del DHCP).
- **Sense Gateway** a la xarxa de víctimes (clau per a l'aïllament).
- **Placeholders** a la doc pública; valors reals només a `_local/`.
