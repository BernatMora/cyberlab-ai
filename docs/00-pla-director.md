# Pla Director del Bernat CyberLab AI

> Document mestre. Defineix l'arquitectura, la governança, les fases i la metodologia.
> Si tens dubtes, mira primer aquí.

## 0. Objectiu i abast

Construir un **laboratori personal de ciberseguretat**, completament legal, privat i orientat exclusivament a l'aprenentatge. Totes les pràctiques ofensives es limiten a **dispositius, màquines virtuals, contenidors i serveis propis del laboratori**. No es dissenyen ni s'automatitzen activitats dirigides contra sistemes de tercers.

L'objectiu no és només instal·lar eines, sinó construir una **plataforma estable, escalable i ben documentada** que evolucioni durant anys.

## 1. Filosofia

- **Modular** — cada component té una responsabilitat clara.
- **Escalable** — afegir VMs, contenidors o eines ha de ser trivial i documentat.
- **Documentat** — cada decisió tècnica té una justificació escrita (ADR) i un procediment pas a pas.
- **Automatitzat** — les tasques repetibles són scripts, no clics manuals.
- **Segur** — principi de mínim privilegi, xifratge, aïllament de xarxa, autenticació multifactor.
- **Fàcil de mantenir** — un altre tu (o un col·laborador) ha de poder reprendre el projecte en 6 mesos només llegint la documentació.

## 2. Maquinari i assignació de rols

| Dispositiu | Nom al tailnet | Rol | Serveis principals |
|---|---|---|---|
| PC Windows 11 (HP Z1 G9, 32 GB) | `cyber-host` | Host de virtualització + storage | Hyper-V, WSL2, Docker, VMs, captures |
| MacBook Pro 13" (macOS 12.7.6) | `cyber-brain` | Cervell de serveis | Hermes, Ollama, MCP, API, scripts |
| Raspberry Pi 4 | `cyber-pi` | Infraestructura lleugera | AdGuard Home, Uptime Kuma, Tailscale SR, ntfy, Node-RED, WoL |
| MacBook Air 13" (macOS 26.5.2) | `cyber-control` | Consola humana | Cap servei permanent |
| iPhone 17 | `cyber-mobile` | Consola mòbil | Tailscale, Termius, notificacions |

Justificació detallada: [`../ADR/0001-arquitectura-general.md`](../ADR/0001-arquitectura-general.md) i [`../ADR/0002-rolls-per-equip.md`](../ADR/0002-rolls-per-equip.md).

## 3. Arquitectura proposada

### Cervell del laboratori — `cyber-brain` (MacBook Pro)
- Hermes Agent
- Ollama
- MCP servers
- API interna
- Base de coneixement
- Automatitzacions
- Tailscale
- Docker (lleuger)
- Repositori de configuració

### Potència del laboratori — `cyber-host` (PC Windows)
- Hyper-V (hipervisor natiu)
- Màquines virtuals (Kali, Ubuntu, Windows, AD lab)
- WSL2 + Docker Desktop
- Aplicacions vulnerables (DVWA, Juice Shop, ...)
- Captures de xarxa
- Snapshots
- Laboratoris d'Active Directory (aïllats)

### Infraestructura lleugera — `cyber-pi` (Raspberry Pi)
- Tailscale Subnet Router (opcional, controlat)
- AdGuard Home (DNS)
- Uptime Kuma (monitorització)
- Node-RED (automatitzacions)
- ntfy (notificacions)
- Watchdog
- Wake-on-LAN

### Consola humana — `cyber-control` (MacBook Air)
- VS Code
- SSH
- Navegador
- Escriptori remot
- Panell d'administració
- Documentació

### Consola mòbil — `cyber-mobile` (iPhone)
- Tailscale
- Termius / Blink (SSH)
- Notificacions
- Consulta ràpida

## 4. Xarxa

Xarxes previstes (veure [`../network/schema-adreces.md`](../network/schema-adreces.md) per a placeholders):

| Xarxa | Rang | Propòsit |
|---|---|---|
| Xarxa domèstica | (la que ja tinguis) | Els teus equips personals |
| Tailscale | `100.64.0.0/10` | Pla de gestió entre equips |
| Gestió de VMs | `10.10.10.0/24` | Host ↔ VMs |
| Xarxa ofensiva | `10.10.20.0/24` | Kali i eines d'atac |
| Xarxa de víctimes | `10.10.30.0/24` | Màquines i apps vulnerables (sense Gateway) |
| Xarxa defensiva | `10.10.40.0/24` | SIEM, sensors, IDS |

**Normes clau:**
- Cap port obert al router domèstic.
- Les xarxes 10.10.x no es publiquen a Tailscale.
- Les màquines vulnerables no tenen Gateway per defecte.
- Hyper-V gestiona la segmentació amb vSwitch (Private / Internal / External).

Detalls: [`../ADR/0004-segmentacio-xarxa.md`](../ADR/0004-segmentacio-xarxa.md) i [`../architecture/topologia-xarxa.md`](../architecture/topologia-xarxa.md).

## 5. Accés remot (Tailscale)

- Tots els dispositius amb Tailscale instal·lat.
- Subnet Router opcional a la RPi (només si cal accedir a la LAN des del tailnet, controlat).
- ACL estrictes (veure [`../network/tailscale.example.md`](../network/tailscale.example.md)).
- **MFA** activat al compte de Tailscale.
- Cap port obert al router — Tailscale és l'única porta.

## 6. Virtualització

Recomanació: **Hyper-V** al PC Windows 11 Pro. Veure [`../ADR/0003-hipervisor-windows.md`](../ADR/0003-hipervisor-windows.md).

## 7. Màquines virtuals inicials (mínim viable)

- **Atacant:** Kali Linux (`kali-01`)
- **Servidor base:** Ubuntu Server (`ubuntu-01`)
- **Víctima (una sola, Linux):** Metasploitable 2 o similar (`target-linux-01`)
- **App web vulnerable (Docker):** DVWA o Juice Shop (`target-web-01`)
- Windows de laboratori: **més endavant** (Fase 7)
- Active Directory: **molt més endavant** (Fase 8)

## 8. Docker

- Al PC Windows via **WSL2 + Docker Desktop**.
- Les apps vulnerables viuen a la xarxa Docker `cyberlab_victim_net` (10.10.30.0/24).
- Cap port exposat a la xarxa domèstica.

Veure [`../docker/README.md`](../docker/README.md).

## 9. Hermes com a director del laboratori

Hermes governa el laboratori amb **principi de mínim privilegi**. Veure [`../hermes/README.md`](../hermes/README.md) per a capacitats actuals i previstes.

## 10. Base de coneixement i gestió de secrets

- Base de coneixement: [`../knowledge-base/`](../knowledge-base/) (writeups, errors, snippets).
- **Secrets:** KeePassXC (ús diari) + `.env` xifrats amb `age` (serveis automatitzats).
- MAI cap secret en text pla al Git (ni tan sols `.env`).
- Veure [`../ADR/0005-gestio-secrets.md`](../ADR/0005-gestio-secrets.md) i [`../secrets-templates/README.md`](../secrets-templates/README.md).

## 11. Estructura de carpetes

Veure el `README.md` arrel per al detall complet.

## 12. Repositori Git

- **Repo:** `github.com/BernatMora/cyberlab-ai` (públic).
- **Llicència:** doble — MIT (codi) + CC BY-SA 4.0 (docs).
- **Branques:** `main` (protegida) + `develop` + `feature/*`, `fix/*`, `docs/*`, `experiment/*`.
- **Tags:** versions per fase (`v0.0-bootstrap`, `v0.1-audit`, `v0.2-tailscale`, ...).
- Veure [`../../CONTRIBUTING.md`](../../CONTRIBUTING.md) per a la política de commits i secrets.

## 13. Còpies de seguretat

- **Restic** + **rclone** per a còpies incrementals i deduplicades.
- **Discs externs** (xifrats amb BitLocker) per a còpies locals.
- **Cloud xifrat** (opcional, per a còpies off-site).
- Tipus de dades:
  - Dades que es poden tornar a descarregar (no cal backup).
  - Dades a copiar (documentació, scripts, configs, KeePassXC, captures).
  - Dades a versionar (tot el que va al Git).
  - Dades amb secrets (mai al Git, KeePassXC, `.env` xifrats).
  - Dades temporals (volums Docker efímers — no cal backup).

## 14. Monitorització

- **Uptime Kuma** a la RPi (Fase 6).
- Alertes via **ntfy** (auto-hostat) → iPhone.
- **Glances** opcional al PC per a CPU/RAM/temps.
- SIEM complet (Wazuh) → Fase 9.

## 15. Apagat i engegada remota

- **Wake-on-LAN** del PC: configurat a la BIOS/UEFI + comanda `etherwake` des de la RPi.
- **Apagat segur** abans de qualsevol tall elèctric.
- **Engegada automàtica** després d'un tall: configurar a la BIOS ("Restore on AC Power Loss" = "Power On").
- Com a últim recurs: endoll intel·ligent, **mai** per tallar l'alimentació.

## 16. Seguretat del laboratori

- Comptes d'administració separats (no usar el compte personal per a serveis).
- Contrasenyes úniques, emmagatzemades a KeePassXC.
- **MFA** activat a Tots els serveis que ho permetin (Tailscale, GitHub, etc.).
- Actualitzacions automàtiques al PC i a la RPi.
- Firewall activat per defecte.
- Xifratge de disc al PC (BitLocker) i a la RPi (LUKS).
- Claus SSH amb passphrase, generada amb `ed25519`.
- Tokens guardats a KeePassXC.
- Registre d'activitat (logs centralitzats a la RPi a partir de Fase 6).
- **Snapshot de recuperació** abans de cada exercici important.

## 17. Sistema de noms

Veure [`../architecture/convencions-noms.md`](../architecture/convencions-noms.md). Resum:

- Físics: `cyber-host`, `cyber-brain`, `cyber-pi`, `cyber-control`, `cyber-mobile`.
- VMs: `<servei>-NN` (`kali-01`, `ubuntu-01`, `target-linux-01`, ...).
- Serveis RPi: `cyber-dns`, `cyber-mon`, `cyber-nodered`, `cyber-ntfy`.
- Contenidors Docker: `<servei>-NN` (`dvwa-01`, `juice-shop-01`, ...).

## 18. Fases d'implantació

| # | Fase | Sortida esperada |
|---|---|---|
| 0 | Auditoria de maquinari | Inventari complet validat |
| 1 | Xarxa i accés remot (Tailscale) | Tailnet operatiu, ACL bàsiques, SSH validat |
| 2 | Servidor Hermes (cyber-brain) | Hermes + Ollama operatius, MCP bàsic, vault de secrets |
| 3 | Virtualització al PC | Hyper-V actiu, Kali + Ubuntu creats, xarxa aïllada |
| 4 | Primer laboratori web (DVWA o Juice Shop) | App vulnerable aïllada, primer exercici complet |
| 5 | Automatització amb Hermes | Hermes pot consultar estat, arrancar/aturar contenidors, generar missions |
| 6 | Monitoratge | Uptime Kuma + AdGuard Home + alertes, watchdog actiu |
| 7 | Laboratoris Windows | Windows vulnerable, pràctiques d'administració |
| 8 | Active Directory | Domini de laboratori aïllat, controlador + clients, pràctiques inicials |
| 9 | SIEM i defensa | Wazuh/Security Onion, detecció, investigació |

Total estimat: 28-40 dies treballats (no seguits). Cada fase amb pausa per validar.

## 19. Metodologia obligatòria per fase

Cada fase ha de contenir:

1. **Objectiu** — què volem aconseguir.
2. **Arquitectura afectada** — quins components toquem.
3. **Requisits previs** — què ha de ser veritat abans de començar.
4. **Programari necessari** — eines concretes.
5. **Passos exactes** — numerats, reproduïbles.
6. **Comandes** — text exacte a executar.
7. **Comprovacions** — què verificar un cop executat cada pas.
8. **Resultat esperat** — l'estat final de la fase si tot va bé.
9. **Errors habituals** — amb solució.
10. **Procediment de recuperació** — com tirar enrere si alguna cosa falla.
11. **Documentació que s'ha d'actualitzar** — quins fitxers del repo canvien.
12. **Criteri per considerar la fase completada** — llista de comprovació final.

**No s'avança a la següent fase fins que l'anterior estigui validada.**

## 20. Glossari

- **Tailnet** — la xarxa privada de Tailscale.
- **MagicDNS** — DNS intern que resol noms de Tailscale sense configurar res.
- **vSwitch** — switch virtual de Hyper-V (Private / Internal / External).
- **Hyper-V** — hipervisor natiu de Windows 11 Pro.
- **WSL2** — Windows Subsystem for Linux v2.
- **Ollama** — motor de LLM local.
- **MCP** — Model Context Protocol (per connectar eines a Hermes).
- **ADR** — Architecture Decision Record.
- **SIEM** — Security Information and Event Management.
- **IDS** — Intrusion Detection System.
- **NIDS** — Network IDS.
- **ACL** — Access Control List.
- **SR** — Subnet Router.
- **WoL** — Wake-on-LAN.

---

## proper pas

Quan hagis validat aquest document, comencem la **Fase 0 — Auditoria de maquinari**.
Ves a [`10-fase-0-auditoria/README.md`](10-fase-0-auditoria/README.md).
