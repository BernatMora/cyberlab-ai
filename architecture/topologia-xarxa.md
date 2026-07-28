# Topologia de xarxa (versió pública, placeholders)

> ⚠️ Aquest esquema usa **adreces IP fictícies o anonimitzades** (10.10.x.x).
> Les IPs reals del teu entorn viuen a `BernatCyberLab/_local/network/local.md` (no versionat).

## Visió general

```
                    Internet
                        │
              [Router domèstic — cap port obert]
                        │
        ┌───────────────┴───────────────┐
        │                               │
   Xarxa domèstica                Tailscale tailnet
   <LAN>/24 (existent)           100.64.0.0/10 (gestió)
        │                               │
        │  ┌────────────────┐           │
        ├─►│ cyber-host     │◄──────────┤
        │  │ (PC Win11)     │           │
        │  │  Hyper-V       │           │
        │  │  WSL2 + Docker │           │
        │  │  vSwitch:      │           │
        │  │   ├─ mgmt      │           │
        │  │   ├─ ofensive  │           │
        │  │   ├─ victim    │           │
        │  │   └─ defense   │           │
        │  └────────────────┘           │
        │                               │
        │  ┌────────────────┐           │
        ├─►│ cyber-pi       │◄──────────┤
        │  │ (RPi 4)        │           │
        │  │  AdGuard Home  │           │
        │  │  Uptime Kuma   │           │
        │  │  Node-RED      │           │
        │  │  ntfy          │           │
        │  │  Tailscale SR  │           │
        │  └────────────────┘           │
        │                               │
        │  ┌────────────────┐           │
        ├─►│ cyber-brain    │◄──────────┤
        │  │ (MBP 13")      │           │
        │  │  Hermes        │           │
        │  │  Ollama        │           │
        │  │  MCP / API     │           │
        │  └────────────────┘           │
        │                               │
   [cyber-control]              [cyber-mobile]
   MBA — sense serveis          iPhone — només client
```

## Esquema d'adreces (públic)

| Xarxa | Rang | Propòsit | Tailscale visible? |
|---|---|---|---|
| Xarxa domèstica | `<LAN>/24` (la que tinguis) | Els teus equips personals | no |
| Gestió de VMs | `10.10.10.0/24` | Host ↔ VMs (accés SSH/administració) | **no** |
| Xarxa ofensiva | `10.10.20.0/24` | Kali i eines d'atac | **no** |
| Xarxa de víctimes | `10.10.30.0/24` | Màquines i apps vulnerables | **no** |
| Xarxa defensiva | `10.10.40.0/24` | SIEM, sensors, IDS | **no** |
| Tailscale | `100.64.0.0/10` | Pla de gestió entre equips | sí |

## Xarxes Hyper-V (concepte)

Hyper-V distingeix tres tipus de vSwitch. Per a cada xarxa anterior:

| Xarxa | Tipus vSwitch | Per què |
|---|---|---|
| Gestió de VMs | Internal | Permet Host ↔ VMs, no exposa la xarxa domèstica |
| Ofensiva | Internal | Aïllada del tràfic personal |
| Víctimes | Private | Sense Gateway — totalment aïllada |
| Defensa | Internal | Rep logs i alertes, aïllada de la resta |

## Mermaid (diagrama visual)

```mermaid
flowchart TB
    Internet([Internet])
    Router[Router domèstic<br/>cap port obert]
    LAN[Xarxa domèstica<br/>&lt;LAN&gt;/24]
    Tailscale[Tailscale tailnet<br/>100.64.0.0/10]

    subgraph "Xarxa de gestió (cyber-host)"
        Host[cyber-host<br/>PC Win11 + Hyper-V]
    end

    subgraph "Xarxa domèstica (clients)"
        Brain[cyber-brain<br/>MBP 13"]
        Pi[cyber-pi<br/>RPi 4]
        Ctrl[cyber-control<br/>MBA 13"]
        Mob[cyber-mobile<br/>iPhone]
    end

    Internet --> Router --> LAN
    LAN --- Tailscale

    LAN --> Host
    LAN --> Brain
    LAN --> Pi
    LAN --> Ctrl
    LAN --> Mob

    Host -. Tailscale .- Brain
    Host -. Tailscale .- Pi
    Brain -. Tailscale .- Pi
    Mob -. Tailscale .- Host
    Mob -. Tailscale .- Brain
    Mob -. Tailscale .- Pi

    style Host fill:#1f3a5f,stroke:#5fa8d3,color:#fff
    style Brain fill:#5a3d1f,stroke:#d3a85f,color:#fff
    style Pi fill:#1f5a3d,stroke:#5fd3a8,color:#fff
    style Ctrl fill:#3a3a3a,stroke:#999,color:#fff
    style Mob fill:#5a1f3d,stroke:#d35f99,color:#fff
```

## Regles d'accés (resum)

- **cap port obert** al router domèstic.
- Tailscale és l'única porta d'entrada des de fora de casa.
- Les xarxes 10.10.x **no es publiquen** al tailnet.
- Una màquina vulnerable no pot accedir a la xarxa domèstica.
- Una màquina vulnerable no té sortida a Internet per defecte (només si el host li dona NAT, controlat).

## Fitxers relacionats

- [`network/tailscale.example.md`](../network/tailscale.example.md) — ACL i Subnet Router
- [`network/firewall-rules.example.md`](../network/firewall-rules.example.md) — regles
- [`ADR/0004-segmentacio-xarxa.md`](../ADR/0004-segmentacio-xarxa.md) — decisió
- `_local/network/local.md` — valors reals (no al Git)
