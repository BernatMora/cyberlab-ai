# Inventari de maquinari — plantilla pública

> Les dades reals del teu entorn viuen a `BernatCyberLab/_local/inventory/local.md` (no versionat).
> Aquesta plantilla et serveix per fer l'auditoria de Fase 0.

## PC principal (cyber-host)

| Camp | Valor |
|---|---|
| Model | (placeholder) |
| CPU | |
| RAM | |
| Disc principal (C:) | capacitat / lliure |
| Disc de dades (D:, E:, ...) | capacitat / lliure per cada |
| Discs externs | capacitat / lliure per cada |
| Versió Windows | (Pro / Home / Education) |
| Hyper-V disponible | (sí/no) |
| WSL2 disponible | (sí/no) |
| Docker instal·lat | (sí/no) |
| Versió BIOS | |
| Virtualització (VT-x) activada a BIOS | (sí/no) |
| Wake-on-LAN disponible | (sí/no) |
| Ethernet / Wi-Fi | |
| Any de compra | |

## MacBook Pro 13" (cyber-brain)

| Camp | Valor |
|---|---|
| Any de fabricació | |
| Processador (Intel / Apple Silicon) | |
| RAM | |
| SSD (capacitat / lliure) | |
| Cicles de bateria | |
| Condició de bateria | |
| macOS exacte | |
| Docker present | (sí/no) |
| Ollama present | (sí/no) |
| Consum aproximat (W) | |

## MacBook Air 13" (cyber-control)

| Camp | Valor |
|---|---|
| Any | |
| Processador | |
| RAM | |
| SSD (capacitat / lliure) | |
| Bateria | |
| macOS | |
| VS Code instal·lat | (sí/no) |
| Altres eines de treball | |

## Raspberry Pi 4 (cyber-pi)

| Camp | Valor |
|---|---|
| RAM (1/2/4/8 GB) | |
| Disc de boot (SD / SSD USB) | |
| SO actual | |
| IP actual a la LAN | |
| IP estàtica configurada? | (sí/no) |
| AdGuard Home instal·lat | (sí/no) |
| Uptime Kuma instal·lat | (sí/no) |
| Tailscale instal·lat | (sí/no) |
| Font d'alimentació (oficial?) | |
| Connexió (Ethernet / Wi-Fi) | |

## iPhone 17 (cyber-mobile)

| Camp | Valor |
|---|---|
| iOS | |
| Tailscale instal·lat | (sí/no) |
| Termius / Blink instal·lat | (sí/no) |

## Xarxa domèstica

| Camp | Valor |
|---|---|
| Rang LAN actual | (ex. `192.168.1.0/24`) |
| Router (model) | |
| Suporta VLAN | (sí/no) |
| Ports oberts al router | (hauria de ser cap) |
| DHCP actiu | (sí/no) |

## Com omplir

1. Executa les comandes de [`docs/10-fase-0-auditoria/README.md`](../docs/10-fase-0-auditoria/README.md) a cada màquina.
2. Enganxa la sortida.
3. Omple aquesta plantilla.
4. Mou la versió amb valors reals a `BernatCyberLab/_local/inventory/local.md`.
5. Comparteix-me el resum (sense secrets) aquí al xat per validar.
