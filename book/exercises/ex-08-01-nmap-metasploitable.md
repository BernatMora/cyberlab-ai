---
id: EX-08-01
title: "Escaneig basic amb nmap contra Metasploitable"
status: published
version: 1.0
created: 2026-08-06
updated: 2026-08-07
completed: 2026-08-06
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

# EX-08-01 - Escaneig basic amb nmap contra Metasploitable

> Apren les 4 opcions essentials de nmap en 20 minuts.

## Objectiu

Descobrir ports oberts, serveis i versions a Metasploitable amb nmap.

## Glossari rapid (per si no saps que volen dir les ordres)

| Ordre | Que vol dir en planer |
|---|---|
| `nmap` | Eina que **escaneja** quins ports te oberts un ordinador. Es com trucar a totes les portes d'una casa per veure quines s'obren. |
| `-sn` | "**S**can **n**etwork" - nomes comprova si l'ordinador existeix (esta viu), no mira quins ports te. |
| `-sT` | "**S**can **T**CP" - fa una connexio completa a cada port (metode mes basic). |
| `-p-` | Escaneja **tots els ports** (1 al 65535). Si no poses res, nomes escaneja els 1000 mes comuns. |
| `--min-rate=5000` | Envia **5000 paquets per segon** com a minim. Mes rapid pero mes "agressiu". |
| `-sV` | "**s**ervice **V**ersion" - detecta **quina versio** del programa hi ha a cada port. |
| `--script=vuln` | Activa els **scripts de deteccio de vulnerabilitats**. Son petits programes que proven coses. |

## Requisits

- Metasploitable pujat (`10.10.30.30`).
- Kali amb nmap (`nmap --version` ha de funcionar).

## Entorn

- Atacant: Kali.
- Victima: Metasploitable (`10.10.30.30`).
- Xarxa: `10.10.30.0/24`.

## Passos

### 1. Preparacio - Descobreix la IP

```bash
docker network inspect cyberlab_lab-net \
  --format '{{range .Containers}}{{.Name}} {{.IPv4Address}}{{"\n"}}{{end}}'
```

**Que vol dir?** Docker et dona la llista de contenidors amb les seves IPs. Es com preguntar "qui te la IP X?".

Confirma que `metasploitable` te la IP `10.10.30.30`.

### 2. Execucio - 4 tipus d'escaneig

**a) Host discovery (saber si esta viu):**

```bash
nmap -sn 10.10.30.30
```

**Que vol dir?** nomes comprova que l'ordinador existeix. Rapid i discret.

**b) Escaneig de ports TCP basic:**

```bash
nmap -sT -p- 10.10.30.30 --min-rate=5000
```

**Que vol dir?** Connecta a tots els ports (1-65535) rapidament per veure quins estan oberts.

**c) Deteccio de serveis i versions:**

```bash
nmap -sV 10.10.30.30
```

**Que vol dir?** Per cada port obert, intenta esbrinar quin programa hi corre i quina versio.

**d) Deteccio de vulnerabilitats (scripts NSE):**

```bash
nmap -sV --script=vuln 10.10.30.30
```

**Que vol dir?** Activa scripts automatic que proven milers d'atacs coneguts.

### 3. Comprovacio - Que hem trobat?

Metasploitable hauria de tenir **~20 serveis exposats**:

| Port | Servei | Perillositat |
|---|---|---|
| 21 | FTP (vsftpd 2.3.4) | Backdoor coneguda |
| 22 | SSH (OpenSSH 4.7) | Antic, pero usable |
| 23 | Telnet | En clar |
| 25 | SMTP | Possible relay |
| 80 | HTTP | Apache 2.2.8 |
| 139, 445 | SMB | Samba 3.0.20 (CVE-2007-2447) |
| 1099 | Java RMI | Exploit conegut |
| 3306 | MySQL | Sense password |
| 5432 | PostgreSQL | Sense password |
| 6667 | IRC | Backdoor Unreal |
| 8180 | Tomcat | Credencials per defecte |

Aquesta es la **superficie d'atac** que explorarem en exercicis posteriors.

## Comprovacions

- [x] He vist la llista de ports oberts
- [x] He identificat almenys 3 serveis amb versions vulnerables
- [x] He provat `nmap --script=vuln`

## Que has apres

- `nmap` es la **primera eina** que fa servir qualsevol atacant - abans de res, sempre escanejar.
- `-sT` (TCP connect) es el mes basic - no necessita permisos especials.
- `-sV` (versio) es imprescindible per prioritzar: no es el mateix un Apache 2.4 que un Apache 2.2 amb 50 CVEs.
- `--script=vuln` activa tots els scripts de deteccio de vulnerabilitats. Pot trigar minuts pero val or.

## Errors habituals

| Error | Causa | Solucio |
|---|---|---|
| `Host seems down` | El contenidor esta parat | `docker start metasploitable` |
| Escaneig massa lent | No has posat `--min-rate` | Afegeix `--min-rate=1000` |
| `Operation not permitted` per `-sS` | No tens `CAP_NET_RAW` | Usa `-sT` en lloc de `-sS` |
| Massa warnings de `nmap --script` | Scripts falsos positius | Filtra amb `--script-args` |

## Referencies

- [CAP-08-10](../chapters/cap-08-10-apps-vulnerables.md)
- [nmap docs](https://nmap.org/book/man.html)
- [nmap NSE scripts](https://nmap.org/nsedoc/)

## Estat

- **Completat per:** Bernat Mora
- **Data:** 2026-08-06
- **Validacio:** Tots els 4 tipus d'escaneig van funcionar correctament. Es van identificar multiples serveis vulnerables.
