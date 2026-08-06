---
id: EX-08-01
title: "Escaneig bàsic amb nmap contra Metasploitable"
status: draft
version: 0.1
created: 2026-08-06
updated: 2026-08-06
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - nmap
  - reconeixement
  - metasploitable
prerequisites:
  - CAP-08-10
  - CAP-08-20
related:
  - CAP-08-10
estimated_time: 20 min
difficulty: beginner
---

# EX-08-01 — Escaneig bàsic amb nmap contra Metasploitable

> Aprèn les 4 opcions essencials de nmap en 20 minuts.

## Objectiu

Descobrir ports oberts, serveis i versions a Metasploitable amb nmap.

## Requisits

- Metasploitable pujat (`10.10.30.30`).
- Kali amb nmap (`nmap --version` ha de funcionar).

## Entorn

- Atacant: Kali.
- Víctima: Metasploitable (`10.10.30.30`).
- Xarxa: `10.10.30.0/24`.

## Passos

### 1. Preparació — Descobreix la IP

```bash
docker network inspect cyberlab_lab-net \
  --format '{{range .Containers}}{{.Name}} {{.IPv4Address}}{{"\n"}}{{end}}'
```

Confirma que `metasploitable` té la IP `10.10.30.30`.

### 2. Execució — 4 tipus d'escaneig

**a) Host discovery (saber si està viu):**

```bash
nmap -sn 10.10.30.30
# Nmap scan report for 10.10.30.30
# Host is up (0.00045s latency).
```

**b) Escaneig de ports TCP bàsic:**

```bash
nmap -sT -p- 10.10.30.30 --min-rate=5000
# Escanegen TOTS els ports TCP (1-65535) ràpid.
```

`--min-rate=5000` envia almenys 5000 paquets/s — escurça el temps.

**c) Detecció de serveis i versions:**

```bash
nmap -sV 10.10.30.30
# 21/tcp   open  ftp       vsftpd 2.3.4
# 22/tcp   open  ssh       OpenSSH 4.7p1 Debian
# 23/tcp   open  telnet    Linux telnetd
# ...
```

**d) Detecció de vulnerabilitats (scripts NSE):**

```bash
nmap -sV --script=vuln 10.10.30.30
# Ens pot trobar: backdoors, CVEs coneguts, configuracions febles.
```

### 3. Comprovació — Què hem trobat?

Metasploitable hauria de tenir **~20 serveis exposats**:

| Port | Servei | Perillositat |
|---|---|---|
| 21 | FTP (vsftpd 2.3.4) | Backdoor coneguda |
| 22 | SSH (OpenSSH 4.7) | Antic, però usable |
| 23 | Telnet | En clar |
| 25 | SMTP | Possible relay |
| 80 | HTTP | Apache 2.2.8 |
| 139, 445 | SMB | Samba 3.0.20 (CVE-2007-2447) |
| 1099 | Java RMI | Exploit conegut |
| 3306 | MySQL | Sense password |
| 5432 | PostgreSQL | Sense password |
| 6667 | IRC | Backdoor Unreal |
| 8180 | Tomcat | Credencials per defecte |

Aquesta és la **superfície d'atac** que explorarem en exercicis posteriors.

## Comprovacions

- [ ] He vist la llista de ports oberts
- [ ] He identificat almenys 3 serveis amb versions vulnerables
- [ ] He provat `nmap --script=vuln`

## Què has après

- `-sT` (TCP connect) és el més bàsic — no necessita permisos especials.
- `-sV` (versió) és imprescindible per prioritzar: no és el mateix un
  Apache 2.4 que un Apache 2.2 amb 50 CVEs.
- `--script=vuln` activa tots els scripts de detecció de vulnerabilitats.
  Pot trigar minuts però val or.
- **nmap NMAPÉs la primera eina** — abans de fer res, sempre escanejar.

## Errors habituals

| Error | Causa | Solució |
|---|---|---|
| `Host seems down` | El contenidor està parat | `docker start metasploitable` |
| Escaneig massa lent | No has posat `--min-rate` | Afegeix `--min-rate=1000` |
| `Operation not permitted` per `-sS` | No tens `CAP_NET_RAW` | Usa `-sT` en lloc de `-sS` |
| Massa warnings de `nmap --script` | Scripts falsos positius | Filtra amb `--script-args` |

## Referències

- [CAP-08-10](../chapters/cap-08-10-apps-vulnerables.md)
- [nmap docs](https://nmap.org/book/man.html)
- [nmap NSE scripts](https://nmap.org/nsedoc/)
