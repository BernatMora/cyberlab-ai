---
id: CAP-08-20
title: "Kali Linux"
status: draft
version: 0.2
created: 2026-07-28
updated: 2026-08-06
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - kali
  - atac
prerequisites:
  - CAP-04-10
related:
  - CAP-08-10
  - CAP-05-10
---

# CAP-08-20 — Kali Linux

> Com hem instal·lat i configurat Kali Linux natiu al PC de l'hort com a màquina ofensiva del CyberLab.

## 1. Què és?

Kali Linux és una distribució Linux basada en Debian, mantinguda per Offensive Security, dissenyada específicament per a pentesting i auditories de seguretat. Ve amb més de 600 eines preinstal·lades per a reconeixement, explotació, anàlisi forense i enginyeria inversa.

## 2. Per què existeix?

Perquè abans els professionals de seguretat havien d'instal·lar eines una a una sobre distribucions genèriques. Kali agrupa tot el necessari en una sola imatge, amb dependències resoltes i configuració optimitzada per a l'atac.

## 3. Quan s'utilitza?

- Com a màquina atacant en un laboratori aïllat.
- Per fer reconeixement de xarxa (nmap, masscan).
- Per explotar vulnerabilitats conegudes (Metasploit, sqlmap).
- Per a anàlisi web (nikto, gobuster, Burp Suite).
- Per a captura i anàlisi de tràfic (Wireshark, tcpdump).

## 4. Alternatives

| Alternativa | Avantatges | Inconvenients | Quan triar-la |
|---|---|---|---|
| Parrot Security OS | Més lleugera, millor per a ús diari | Menys eines preinstal·lades | Si el PC té pocs recursos |
| BlackArch | Molt extensa (2000+ eines) | Massa pesada, basada en Arch | Per a labs molt avançats |
| Ubuntu + instal·lació manual | Control total | Cal instal·lar cada eina manualment | Si només necessites 1-2 eines |

## 5. Avantatges

- Totes les eines ofensives ja preinstal·lades i configurades.
- Actualitzacions regulars d'eines.
- Documentació extensa i comunitat activa.
- Suport natiu per a Docker, Tailscale i SSH.

## 6. Inconvenients

- És una distribució pesada (no és lleugera com Alpine).
- Pot donar falsos positius en antivirus de la xarxa domèstica.
- No és adequada com a sistema d'ús diari (tot i que es pot).

## 7. Arquitectura al CyberLab

Kali s'instal·la **nativament** al PC de l'hort (hostname `hort`). Aquesta màquina fa de **màquina ofensiva** al laboratori.

```
┌─────────────────────────────────────────────┐
│  PC Hort (Kali natiu)                       │
│  hostname: hort                              │
│  IP Tailscale: 100.97.77.87                  │
│  Usuari: hort-osona                          │
│                                              │
│  ┌─────────┐  ┌─────────┐  ┌──────────────┐ │
│  │ Kali    │  │ Docker  │  │ DVWA         │ │
│  │ natiu   │  │ engine  │  │ (contenidor) │ │
│  │ (atac)  │  │         │  │ víctima      │ │
│  └─────────┘  └─────────┘  └──────────────┘ │
│                                              │
│  Tailscale ──→ 100.97.77.87 ←── Mac control  │
└─────────────────────────────────────────────┘
```

**Hardware actual:**
- Intel Pentium G850 @ 2.90GHz
- 8 GB RAM
- Disc local

> ⚠️ Aquest PC té 8 GB — no pot allotjar màquines virtuals. Les VMs (Metasploitable, AD) queden pendents fins a tenir l'HP Z1 G9 (32 GB).

## 8. Instal·lació

### 8.1 — Instal·lar Kali des de USB

Descarregar la imatge de https://www.kali.org/get-kali/ i gravar-la amb Rufus o balenaEtcher en un USB.

Arrancar el PC des de l'USB i seguir l'instal·lador. Crear l'usuari `hort-osona` amb la contrasenya corresponent.

### 8.2 — Activar SSH

Per poder gestionar Kali remotament des del Mac:

```bash
sudo systemctl enable --now ssh
```

### 8.3 — Configurar accés SSH per clau (des del Mac)

Al Mac, generar clau si no existeix:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
```

Copiar la clau pública al Kali (al Kali):

```bash
mkdir -p ~/.ssh && echo "ssh-ed25519 AAAA... bernatmorasanglas@MacBook-Air" >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys
```

Verificar connexió (al Mac):

```bash
ssh hort-osona@hort
```

### 8.4 — Permetre sudo sense contrasenya (per gestió remota)

Al Kali:

```bash
echo "hort-osona ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/hort-osona
```

### 8.5 — Instal·lar Tailscale

Veure [CAP-04-10](cap-04-10-tailscale.md).

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```

Verificar:

```bash
tailscale status
```

Sortida esperada: `hort` amb IP `100.97.77.87`.

### 8.6 — Eines ofensives preinstal·lades

Kali ja porta les eines bàsiques. Verificar:

```bash
which nmap nikto sqlmap gobuster whatweb dirb
```

## 9. Configuració

### 9.1 — Hostname

El hostname és `hort`. Per canviar-lo si cal:

```bash
sudo hostnamectl set-hostname hort
```

### 9.2 — Layout de teclat

Si el teclat no té `&` o altres símbols, el layout pot estar mal configurat:

```bash
sudo dpkg-reconfigure keyboard-configuration
```

### 9.3 — Actualització del sistema

```bash
sudo apt update && sudo apt full-upgrade -y
```

## 10. Verificació

Comandes de test:

```bash
# SSH accessible des del Mac
ssh hort-osona@hort "echo OK"

# Tailscale actiu
ssh hort-osona@hort "tailscale status"

# Eines disponibles
ssh hort-osona@hort "nmap --version | head -1"
```

## 11. Problemes habituals

| Símptoma | Causa probable | Solució |
|---|---|---|
| `&` no funciona al teclat | Layout incorrecte | `sudo dpkg-reconfigure keyboard-configuration` |
| SSH `connection refused` | Servei SSH no activat | `sudo systemctl enable --now ssh` |
| SSH `permission denied` | Clau no copiada o usuari incorrecte | Verificar `authorized_keys` i nom d'usuari |
| `sudo: terminal required` | sudo per SSH sense contrasenya | Configurar `NOPASSWD` a `/etc/sudoers.d/` |
| Docker `permission denied` | Usuari no al grup docker | `sudo usermod -aG docker hort-osona` |

## 12. Bones pràctiques

- Mantenir Kali actualitzat: `sudo apt update && sudo apt full-upgrade -y`.
- No exposar el servei SSH a Internet — només via Tailscale.
- Usar claus SSH, no contrasenyes, per a accés remot.
- Verificar regularment que Tailscale està connectat.

## 13. Aspectes de seguretat

- Kali porta eines ofensives — **mai** executar-les contra xarxes que no són del laboratori.
- Les xarxes de laboratori (10.10.x) han d'estar aïllades de la LAN domèstica.
- El PC de l'hort està sota CGNAT (Parlem 5G) — cap port obert, només Tailscale.
- La màquina víctima (DVWA) no té accés a Internet.

## 14. Automatització amb Hermes

Hermes pot connectar-se per SSH al Kali via Tailscale i:

- Executar comandes de reconeixement (nmap, nikto).
- Gestionar contenidors Docker (arrencar/aturar víctimes).
- Actualitzar el sistema.
- Documentar resultats automàticament al repo cyberlab-ai.

Configuració SSH a Hermes: `ssh hort-osona@hort` (resolt per Tailscale MagicDNS).

## 15. Resum

- Kali natiu instal·lat al PC de l'hort (`hort`, 100.97.77.87).
- SSH per clau pública configurat des del Mac.
- Tailscale connecta el Kali amb la resta del lab.
- Eines ofensives preinstal·lades (nmap, nikto, sqlmap, gobuster).
- Limitació actual: 8 GB RAM — sense VMs fins a tenir l'HP Z1 G9.

---

## Referències

- [Kali Linux — Lloc oficial](https://www.kali.org/)
- [CAP-04-10](cap-04-10-tailscale.md) — Tailscale
- [CAP-05-10](cap-05-10-docker.md) — Docker
- [CAP-08-10](cap-08-10-apps-vulnerables.md) — Aplicacions vulnerables
- [ADR-0001](../../ADR/0001-arquitectura-general.md) — Arquitectura general
