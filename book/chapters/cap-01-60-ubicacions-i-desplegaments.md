---
id: CAP-01-60
title: "Ubicacions i desplegaments"
status: published
version: 1
created: 2026-07-28
updated: 2026-07-28
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - arquitectura
  - ubicacio
  - desplegament
prerequisites:
  - CAP-01-10
related:
  - CAP-01-40
  - CAP-04-10
  - ANN-05
---

# CAP-01-60 — Ubicacions i desplegaments

> Per què el CyberLab té dues ubicacions i com s'uneixen.

## 1. Què és?

Aquest capítol documenta els **dos escenaris físics** on viu el CyberLab,
la diferència entre ells, com es comuniquen i quines implicacions té per
al dia a dia.

## 2. Per què existeix?

Aquest projecte neix d'una necessitat concreta: hi ha un PC potent a
l'**hort** que estava infrautilitzat, i un **Mac potent a casa** que és el
centre de treball diari. L'objectiu és aprofitar-los tots dos per a
finalitats diferents:

- **L'hort** allotja les màquines virtuals, les eines ofensives i la Kali.
- **Casa** allotja la consola de control, l'anàlisi, la documentació.

Però cal resoldre el problema clàssic: com connectar dues xarxes separades
geogràficament sense exposar serveis a Internet?

## 3. Quan s'utilitza?

Sempre. Aquesta és l'arquitectura per defecte del projecte. Tots els
dies laborals i caps de setmana hi ha equips engegats en ambdues ubicacions.

## 4. Alternatives

### Opció A — Tot a casa (un sol lloc)
- Avantatges: simplicitat de xarxa, un sol router, una sola política.
- Inconvenients: el PC de l'hort queda infrautilitzat; el·lipsis del sentit
  original del projecte.

### Opció B — Tot al núvol
- Avantatges: cap dependència de maquinari local.
- Inconvenients: costos mensuals; pràctiques ofensives al núvol generen
  problemes amb els proveïdors; perd l'aprenentatge de xarxes reals.

### Opció C — Dues ubicacions unides per Tailscale (escollida)
- Avantatges: cada màquina al seu lloc natural; xifrat de punta a punta
  (WireGuard); resistència al CGNAT; cost zero; replicable.
- Inconvenients: latència hort ↔ casa (~50 ms); cal gestionar dues
  polítiques de xarxa; cal un tallafocs a cada costat.

## 5. Avantatges

- **Realisme**: el CyberLab reflecteix una situació real amb múltiples
  seus i equips heterogenis.
- **Resiliència**: si Parlem cau, podem continuar treballant a casa.
- **Aprenentatge de xarxes reals**: IPv4, NAT, CGNAT, WireGuard, DNS
  privat — tot això passa de veritat.
- **Escalabilitat**: afegir una nova ubicació és trivial (un altre node
  Tailscale).

## 6. Inconvenients

- Latència hort ↔ casa (~50 ms).
- Cal Wake-on-LAN al PC de l'hort per si s'apaga.
- El Mac vell de l'hort degradarà la bateria (sempre endollat) — cal
  controlar la càrrega amb `Al Dente` o similar.
- El PC de l'hort ha d'estar sempre encès → consum elèctric (~50-100 W).

## 7. Arquitectura al CyberLab

### Ubicació HORT

- **Router Parlem 4G/5G** (CGNAT actiu, IP pública compartida).
  - Model pendent d'auditar a Fase 0.
  - Connecta a Internet per 4G/5G amb 150 GB/mes.
- **Xarxa LAN de l'hort**: rang habitual `192.168.1.0/24` (o el que
  tingui el router Parlem).
- **Equip 1: `cyber-host`** — PC HP Z1 G9 Tower, 32 GB RAM.
  - **SO**: Kali Linux 2026.2 instal·lat nadiu al disc.
  - Connexió: Ethernet al router Parlem.
  - Rol: host principal del laboratori (Kali + hipervisor per a màquines
    virtuals vulnerables).
- **Equip 2: `cyber-helper`** — MacBook Pro 13" vell (macOS 12.7.6).
  - Connexió: Ethernet o Wi-Fi al router Parlem.
  - Rol: serveis complementaris (Tailscale, scripts, monitoratge, terminal
    alternatiu).
- **`cyber-pi` (futura)**: infraestructura lleugera. Decidim a Fase 1
  (veure més avall).

### Ubicació CASA

- **Router de casa** (DHCP actiu, sense VLAN).
- **Xarxa LAN de casa**: rang habitual `192.168.1.0/24` (pot coincidir
  amb l'hort; Tailscale ho gestiona).
- **Equip 3: `cyber-brain`** — Mac potent de casa.
  - Connexió: Wi-Fi al router de casa.
  - Rol: centre de control. Des d'aquí es fan les pràctiques, s'analitzen
    resultats, s'escriu documentació. Més endavant allotjarà Hermes
    Agent i Ollama (si el hardware ho permet).
- **Equip 4: `cyber-control`** — MacBook Air 13" (macOS 26.5.2).
  - Connexió: Wi-Fi al router de casa.
  - Rol: consola diària. Cap servei permanent.
- **Equip 5: `cyber-mobile`** — iPhone 17.
  - Connexió: Wi-Fi casa + dades mòbils.
  - Rol: SSH mòbil, notificacions, consulta ràpida.

### Xarxa comuna (Tailscale)

Tots els equips anteriors formen part del **mateix tailnet** (xarxa
privada Tailscale):

```
Internet ──┬─── Parlem 5G (CGNAT) ─────── Hort
           │       │
           │       ├─── cyber-host      (Kali Linux, 32 GB)
           │       └─── cyber-helper    (macOS 12, scripts)
           │
           └─── Router de casa ──────── Casa
                       │
                       ├─── cyber-brain       (Mac potent)
                       ├─── cyber-control     (MacBook Air)
                       └─── cyber-mobile      (iPhone)
                       (i Cisco, RPi, etc.)

Tots units per Tailscale (WireGuard, xifrat punta a punta).
```

## 8. Instal·lació

La instal·lació dels equips es documenta als capítols respectius:

- [CAP-08-20](cap-08-20-kali-linux.md) — Kali Linux al PC de l'hort.
- [CAP-03-30](cap-03-30-macos-essencial.md) — macOS (Mac potent, MBP vell).
- [CAP-04-10](cap-04-10-tailscale.md) — Tailscale als 5 equips.
- [CAP-04-30](cap-04-30-firewall.md) — tallafocs al PC de l'hort.

## 9. Configuració

### Configuració recomanada al PC de l'hort

- **IP estàtica** a la LAN de l'hort (ex. `192.168.1.20/24`).
- **Gateway**: IP del router Parlem (normalment `192.168.1.1`).
- **DNS primari**: `1.1.1.1` (Cloudflare) o AdGuard (si `cyber-pi` existeix).
- **Tailscale** instal·lat i actiu.
- **Wake-on-LAN** activat a la BIOS/UEFI (per si s'apaga).

### Configuració recomanada al Mac potent de casa

- Tailscale instal·lat.
- Sense serveis permanents addicionals (aquesta és la màquina de treball,
  no de serveis).
- Compte de Tailscale amb **MFA activat**.

### Configuració de Tailscale

- Tots els dispositius al tailnet amb noms `cyber-*`.
- **ACL** que permeti:
  - `cyber-brain` → SSH a `cyber-host`, `cyber-helper`.
  - `cyber-mobile` → SSH a tots els cyber-* (per emergència).
  - Cap accés directe a les xarxes `10.10.x` des del tailnet.

## 10. Verificació

- [ ] Tots els 5 equips apareixen a `tailscale status` amb noms correctes.
- [ ] Ping entre equips via Tailscale: `ping cyber-host` des de
      `cyber-brain` ha de respondre en <100 ms.
- [ ] SSH des del Mac potent de casa al PC de l'hort:
      `ssh user@cyber-host`.
- [ ] SSH des de l'iPhone al PC de l'hort: funcional.
- [ ] El router Parlem es pot reiniciar sense perdre l'accés (gràcies a
      Tailscale).
- [ ] Si apaguem el PC de l'hort, l'iPhone envia una alerta ntfy (quan
      `cyber-pi` existeixi).

## 11. Problemes habituals

| Símptoma | Causa probable | Solució |
|---|---|---|
| Latència >200 ms entre casa i hort | Tailscale no ha pogut fer NAT traversal directe | Tailscale ho resol·lé sol; si no, verificar DERP relays |
| SSH rebutja la contrasenya | El compte Tailscale no s'ha sincronitzat correctament | `tailscale up` amb `--ssh` al destí |
| CGNAT impedeix ping directe | Normal — és per això que usem Tailscale | No fer ping per IP pública; usar el nom del tailnet |
| El PC de l'hort s'apaga sol | Apagada automàtica per inactivitat o temperatura | Desactivar sleep a la configuració d'energia |

## 12. Bones pràctiques

- **Sempre** accedir al PC de l'hort via Tailscale, mai per IP pública.
- Mantenir el router Parlem actualitzat (per seguretat i estabilitat).
- Configurar alertes via ntfy (quan `cyber-pi` existeixi) per si el PC
  de l'hort perd connectivitat.
- Fer còpies de seguretat del PC de l'hort periòdicament (veure
  [CAP-07-30](cap-07-30-copies-seguretat.md)).
- Rotar les claus SSH cada 90 dies.
- Documentar qualsevol canvi de xarxa (canvis d'IP al router Parlem) al
  fitxer privat `BernatCyberLab/_local/network/`.

## 13. Aspectes de seguretat

- Cap port obert al router Parlem (CGNAT ja ho impossibilita; reforç).
- Cap port obert al router de casa (Tailscale evita aquesta necessitat).
- Tots els equips tenen tallafocs actiu.
- SSH al PC de l'hort amb claus (no contrasenyes), i prohibit root login.
- Tailscale amb MFA activat al compte.
- Sesions llargues amb timeout (evitar terminals oblidats oberts).

## 14. Automatització amb Hermes

Quan `cyber-brain` tingui Hermes (Fase 2+):

- Pot preguntar l'estat del lab hort-casa amb una sola consulta.
- Pot ajudar a generar ordres per reproduir una sessió des de casa.
- Pot documentar automàticament canvis de xarxa (canvis d'IP, etc.).

Més detalls a [CAP-06-20](cap-06-20-hermes.md).

## 15. Resum

- **Dues ubicacions**: hort (Parlem 5G/CGNAT) + casa.
- **5 equips**: 2 a l'hort + 3 a casa + 1 pendent (futura `cyber-pi`).
- **Units per Tailscale** sobre WireGuard.
- **Cap port obert** a cap router.
- **El PC de l'hort és el cor del lab** (Kali natiu + hipervisor).
- **El Mac potent de casa és el centre de control** (des d'on es fan les
  pràctiques).

## Referències

- [ADR/0001-arquitectura-general.md](../../ADR/0001-arquitectura-general.md)
- [ADR/0002-rolls-per-equip.md](../../ADR/0002-rolls-per-equip.md)
- [CAP-04-10](cap-04-10-tailscale.md) — Tailscale
- [CAP-08-20](cap-08-20-kali-linux.md) — Kali Linux
- [ANN-05](ann-05-xuleta-comandes.md) — Xuleta de comandes
- [ANN-07](ann-07-historia-del-projecte.md) — Història del projecte