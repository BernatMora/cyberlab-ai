# Inventari de maquinari — CyberLab

> Dades reals del laboratori. Aquest fitxer és una plantilla pública.
> Les dades sensibles (IPs, contrasenyes) viuen a `_local/inventory/` (no versionat).

## PC de l'hort (cyber-host provisional)

| Camp | Valor |
|---|---|
| Hostname | hort |
| Model | (PC antic — HP?) |
| CPU | Intel Pentium G850 @ 2.90GHz |
| RAM | 8 GB |
| Disc local | (per verificar) |
| SO | Kali Linux (natiu) |
| Kernel | (per verificar) |
| Docker | 28.5.2 |
| Docker Compose | 2.40.3 |
| Tailscale IP | 100.97.77.87 |
| SSH | actiu, clau ed25519 des del Mac |
| Eines ofensives | nmap, nikto, sqlmap, gobuster, whatweb, dirb (preinstal·lades) |
| Contenidors | DVWA (vulnerables/web-dvwa) |
| Notes | PC antic, no viable per a VMs. Pendents HP Z1 G9 (32GB) per a cyber-host definitiu. |

## MacBook Air 13" (cyber-control)

| Camp | Valor |
|---|---|
| Hostname | MacBook-Air-de-Bernat |
| macOS | 26.5.2 |
| Tailscale | actiu (compte Apple `bernatmora@mac.com`) |
| SSH | clau ed25519 cap a hort |
| Rol | Consola diària + Hermes Agent |

## Raspberry Pi 4B (hort-osona)

| Camp | Valor |
|---|---|
| Hostname | hortosona |
| SO | Raspberry Pi OS Trixie 13.5 |
| IP local | 192.168.100.77 |
| Tailscale IP | 100.115.134.76 |
| Rol | Fora del CyberLab — pertany al projecte hort-osona |

## PCs pendents

| Equip | Estat |
|---|---|
| HP Z1 G9 Tower (32 GB) | No disponible encara — cyber-host definitiu |
| Mac potent de casa | No disponible — cyber-brain |
| MacBook Pro 13" vell | No disponible — cyber-helper |
