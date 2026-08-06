---
id: ANN-07
title: "Història del projecte"
status: published
version: 1.1
created: 2026-07-28
updated: 2026-08-06
authors:
  - Bernat Mora
type: changelog
related:
  - CAP-01-60
  - ANN-05
---

# ANN-07 — Història del projecte

> L'evolució del CyberLab des dels seus orígens. Per què s'ha fet cada cosa
> en cada moment. Un diari de decisions.

## Cronologia

### 2026-07-27 — Orígens (sessió inicial al projecte)

Esbossos inicials. Definició del PC potent de l'hort + Mac potent de casa
com a nucli del projecte. Primeres idees sobre Kali, Metasploitable, DVWA.

### 2026-07-28 — Decisió de Kali

Triada la distro: **Kali Linux** (vs Parrot/WiFiSlax). Motius: comunitat
gran, molts tutorials, eines preinstal·lades.

Decisions operatives preses:
- Distro: **Kali Linux 2026.2** (Live amd64 amb persistència o Installer).
- USB: **Kingston 256 GB** amb Ventoy.
- Eines: **nmap, hydra, john, aircrack-ng, wireshark**.
- Accés remot: **Tailscale** (per CGNAT + IP dinàmica).

### 2026-07-28 — Decàrrega i validació de la ISO

Descarregada i validada `kali-linux-2026.2-installer-amd64.iso` (SHA256
verificat).

### 2026-07-28 — Rufus vs Ventoy

Inicialment triat **Rufus**, però descobert que:
- ISO **installer** no porta persistència.
- Les Live ISO només via torrent.
- Rufus forçava mode DD amb ISOs ISOHybrid (perdia persistència).

Decisió canviada a **Ventoy al USB Kingston 256 GB** (instal·lat Ventoy).

### 2026-07-30 — Xuleta de comandes

Creat `xuleta-comandes.md` i `xuleta-comandes.pdf` (5 pàgines) amb totes
les ordres apreses fins al moment.

### 2026-07-30 — Decisió final sobre maquinari

Triat definitivament:
- **PC de l'hort** (HP Z1 G9, 32 GB RAM) com a `cyber-host` potent.
- **Mac vell de l'hort** com a màquina complementària.
- **RPi hort-osona** queda **fora** (pertany al projecte hort-osona).
- **Mac potent de casa** com a centre de control.

### 2026-07-30 — Política legal consolidada

- ❌ Mai des de l'equip de la feina (risc laboral).
- ✅ Tot des dels Macs personals.
- ✅ Sobre dispositius propis o amb autorització.
- ✅ Plataformes legals: TryHackMe, HackTheBox, OverTheWire, PortSwigger.

### 2026-07-30 — Decisió Parlem 5G

Operador mòbil de l'hort: **Parlem 5G**, 150 GB/mes. CGNAT actiu → Tailscale
és l'única via còmoda.

### 2026-07-31 — Primer PROJECT_STATE

Creat `PROJECT_STATE.md` a `C:\Users\iadmin\Documents\lab-seguretat\` per
garantir continuïtat entre sessions.

### 2026-07-31 — Idees descartades

- Integrar CyberLab al projecte **BernatLab** del curs (idea abortada).
  Motiu: barrejar conceptes diferents. Es reprendrà més endavant quan hi
  hagi URL pròpia.
- Usar la **RPi del hort-osona** com a `cyber-pi`. Motiu: pertany a un altre
  projecte actiu.

### 2026-07-28 (reprise) — Creació del projecte `cyberlab-ai` al GitHub

- Repo `BernatMora/cyberlab-ai` creat.
- Estructura completa + llicència doble (MIT + CC BY-SA 4.0).
- Llibre Viu iniciat amb Bloc 0 publicat.
- 38 capítols d'esquelet preparats.

### 2026-08-06 — Primer lab real muntat al Kali

**Era el primer dia amb un lab de veritat corrent.** Fins ara tot era teoria
+ esquelet del llibre. Avui hem fet el pas a la pràctica.

**Què s'ha fet al Kali (host hort-osona):**

1. **Tailscale instal·lat** amb `curl -fsSL https://tailscale.com/install.sh | sh`
   i `tailscale up` (autenticat amb el compte de Bernat). Això connecta el
   Kali al tailnet com `hort` — accessible via `100.x.y.z` des de qualsevol
   equip del tailnet (RPi, Mac casa, PC feina).
2. **Docker 28.5.2** ja estava instal·lat. Creat `~/cyberlab/docker-compose.yml`
   amb **3 víctimes** a la xarxa `lab-net` (`10.10.30.0/24`):
   - `dvwa` (`vulnerables/web-dvwa`) — `10.10.30.10`, port `127.0.0.1:8080`
   - `juice-shop` (`bkimminich/juice-shop`) — `10.10.30.20`, port `127.0.0.1:3000`
   - `metasploitable` (`peakkk/metasploitable`) — `10.10.30.30`, sense ports
3. **Aïllament de la xarxa**: creats `isolate-lab.sh` (regles
   `iptables -A DOCKER-USER -s 10.10.30.0/24 -d 192.168.1.0/24 -j DROP` +
   `! -d 10.10.30.0/24 -j DROP`) i `isolate-lab.service` (oneshot
   `After=docker.service`) per fer l'aïllament persistent en cada boot.
4. **Verificació**: `docker ps` → 3 contenidors `Up`. DVWA respon 302,
   Juice Shop 200, Metasploitable accessible a la xarxa interna.

**Què s'ha fet al repo `cyberlab-ai`:**

- Commit `a28950c` — `cap-05-10-docker.md`, `cap-08-10-apps-vulnerables.md`
  i `cap-08-20-kali-linux.md` redactats amb dades reals del lab (placeholders
  en comptes de valors sensibles).
- Commit `076ec5b` — neteja de dades reals abans de fer-lo públic.
- Commit `291e5c1` — afegit Juice Shop i Metasploitable (3 contenidors);
  nous exercicis EX-08-01 a 06.
- **Recuperat al repo** (avui, sessió actual): `docker/lab/{docker-compose.yml,
  isolate-lab.sh, isolate-lab.service, README.md}` que vivien sols al Kali.
- **Annex ANN-07** actualitzat amb aquesta entrada.

**Lliçons apreses:**

- **Mai executar res com a root sense validar-ho abans** al Kali (la
  sessió GLM va intentar escriure a `/etc/systemd/` des del Mac — cal
  fer-ho des del Kali mateix).
- **`-L` SSH tunnel és l'única forma neta d'accedir a serveis publicats
  a `127.0.0.1`** des d'una altra màquina del tailnet.
- **Cal `iptables -D` abans de `iptables -A`** per fer l'script idempotent
  (per si l'arrenques dues vegades).
- **`RemainAfterExit=yes`** al servei systemd manté l'estat "actiu" tot i
  ser `oneshot` — si no, `systemctl status` diria `inactive (dead)`.
- **El repo ha d'estar al dia amb el que passa al Kali**: aquesta sessió
  n'és la prova — hi havia 3 fitxers al Kali que no estaven versionats.

**Pendents per a la pròxima sessió:**

- HP Z1 G9 (32 GB RAM) — muntar VMs natives (Metasploitable 2 ISO, Windows
  vulnerable, Active Directory lab).
- Afegir un IDS al lab (Snort o Suricata) per practicar detecció.
- Més exercicis: SQL injection a Juice Shop, JWT attacks, XXE.
- Plantilla d'informe de pentest (executive summary + findings).

### 2026-07-28 — Integració del material antic

Aquest annex s'ha creat per integrar i actualitzar la informació del
PROJECT_STATE antic al context actual del projecte al GitHub.

## Lliçons apreses (per no repetir-les)

### Tècniques

- **ISO installer ≠ ISO live**: la ISO installer no porta persistència.
  Per a persistència de veritat cal ISO **live**.
- **Live ISO només via torrent** (o kali-weekly HTTP).
- **Rufus + ISOHybrid = mode DD forçat**: perd opció de persistència. Per
  a Kali, millor **Ventoy**.
- **Ventoy crea dues particions**: una petita (boot) + una gran (ISOs).
  L'Explorador de Windows pot amagar la partició gran → usar `Get-Volume`
  per veure-les totes.
- **CGNAT** impossibilita port forwarding directe. Tailscale és l'única
  solució còmoda amb Parlem 5G.
- **Tailscale + WireGuard** = NAT traversal automàtic + xifrat punta a
  punta.
- **Wake-on-LAN** cal activar-lo a la BIOS/UEFI; sense això, no podem
  despertar el PC de l'hort des de casa.

### De gestió

- **Mai practicar des de l'equip de la feina** — risc laboral encara que
  l'objectiu sigui casa teva.
- **Documentar cada decisió** en una ADR per no repetir-la d'aquí 2 anys.
- **Xuleta de comandes** = millor que dependre d'una IA per a les ordres
  bàsiques.
- **PROJECT_STATE.md** és or: permet reprendre una sessió amb context.
- **Separar projectes**: el CyberLab NO és el mateix que el projecte
  hort-osona ni que el curs BernatLab.

### De metodologia

- **Decidir abans de comprar**: abans de comprar cap peça nova, validar
  que l'arquitectura actual pot assumir les noves necessitats.
- **Confirmar l'arquitectura amb proves reals**, no amb suposicions.
- **Una sessió = una decisió important**: no voler fer tot en una sola
  sessió porta a errors.
- **Backup primer**: abans de qualsevol canvi important, còpia de seguretat.

## Estadístiques de les sessions anteriors

- Durada: ~4 dies (sessions esparses entre 27-30 juliol).
- ISO validada: `kali-linux-2026.2-installer-amd64.iso` (SHA256 valid).
- USB preparat: Kingston 256 GB amb Ventoy.
- Eines apreses: Get-FileHash, Get-Disk, Get-Volume, Copy-Item,
  qBittorrent, Rufus, Ventoy.
- Documents creats: xuleta-comandes.md, xuleta-comandes.pdf,
  PROJECT_STATE.md.
- Coneixements consolidats: CGNAT, Tailscale, Rufus vs Ventoy, ISO
  live vs installer.

## Fonts

- [`docs/00-pla-director.md`](../../docs/00-pla-director.md) — Pla Director actual
- [`ADR/0001-arquitectura-general.md`](../../ADR/0001-arquitectura-general.md) — Arquitectura revisada
- [`ADR/0002-rolls-per-equip.md`](../../ADR/0002-rolls-per-equip.md) — Rols revisats
- [CAP-01-60](cap-01-60-ubicacions-i-desplegaments.md) — Ubicacions i desplegaments
- [ANN-05](ann-05-xuleta-comandes.md) — Xuleta de comandes
- Material antic a `C:\Users\iadmin\Documents\lab-seguretat\` (no versionat;
  conservat localment).

---

_Última actualització: 2026-07-28 — sincronitzada amb l'estat actual del projecte._