---
id: LAB-15-10
title: "Lab real muntat al Kali (PC hort)"
status: published
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - kali
  - lab-real
  - docker
  - dvwa
  - juice-shop
  - metasploitable
prerequisites:
  - CAP-00-15
  - CAP-08-10
related:
  - CAP-00-15
  - CAP-08-10
estimated_time: 30 min
difficulty: beginner
---

# LAB-15-10 - Lab real muntat al Kali (PC hort)

> Estat actual del laboratori de ciberseguretat que funciona de veritat.

## On esta el lab

- **Maquina fisica**: PC hort amb Kali Linux
- **Hostname**: `Hort`
- **Tailscale IP**: `100.97.77.87`
- **Usuari SSH**: `hort-osona`
- **Acces**: `ssh hort-osona@hort` (via Tailscale) o be `ssh -J bernat@hortosona hort-osona@hort` (saltant per la RPi)

## Maquinari

| Component | Valor |
|---|---|
| SO | Kali Linux 6.19.14+kali-amd64 |
| Kernel | 6.19.14 |
| RAM | 7,7 GB (lliure 5,7 GB) |
| Disc | 448 GB total, 21 GB usat, 405 GB lliure |
| Tailscale | 100.97.77.87 |

## Els 3 contenidors del lab

S'han vist tots 3 actius durant 14 hores seguides (des de 2026-08-06):

| Contenidor | Imatge | IP interna | Ports | Funcio |
|---|---|---|---|---|
| **dvwa** | `vulnerables/web-dvwa` | 10.10.30.10 | 127.0.0.1:8080 -> 80 | Botiga web vulnerable (SQL injection, XSS) |
| **juice-shop** | `bkimminich/juice-shop` | 10.10.30.20 | 127.0.0.1:3000 -> 3000 | Botiga de sucs vulnerable (vulnerabilitats modernes) |
| **metasploitable** | `peakkk/metasploitable` | 10.10.30.30 | 21-23, 25, 80, 111, 139, 445, 512-514, 1099, 1524, 3306, 3632, 5432, 5900, 6000, 6667, 6697, 8009, 8180, 32963, 37537, 45458 | Linux antic vulnerable |

## Xarxa aillada

Tots els contenidors estan a la xarxa Docker `cyberlab_lab-net` (10.10.30.0/24).

```
docker network inspect cyberlab_lab-net
```

**Sortida esperada:**
```
juice-shop: 10.10.30.20/24
metasploitable: 10.10.30.30/24
dvwa: 10.10.30.10/24
```

## Tallafoc actiu (aillament real)

Veiem regles actives al `iptables`:

| Cadena | Politica | Observacio |
|---|---|---|
| INPUT | ACCEPT | Permet tot (es un Kali personal) |
| FORWARD | **DROP** | Tallafoc actiu! |
| OUTPUT | ACCEPT | Permet tot |

**Regles Docker especifiques:**

```
Chain DOCKER (2 references)
target     prot opt source               destination
ACCEPT     tcp  --  0.0.0.0/0            10.10.30.10          tcp dpt:80      # DVWA
ACCEPT     tcp  --  0.0.0.0/0            10.10.30.20          tcp dpt:3000    # Juice Shop
DROP       all  --  0.0.0.0/0            0.0.0.0/0
DROP       all  --  0.0.0.0/0            0.0.0.0/0
```

**Interpretacio**: nomes es permet transit als ports 80 (DVWA) i 3000 (Juice Shop). La resta queda **bloquejada**.

## Eines de Kali instal·lades (11+ trobades)

| Eina | Path | Us |
|---|---|---|
| `nmap` | /usr/bin/nmap | Escaneig de xarxa i ports |
| `nikto` | /usr/bin/nikto | Escaneig de vulnerabilitats web |
| `sqlmap` | /usr/bin/sqlmap | SQL injection automatitzat |
| `hydra` | /usr/bin/hydra | Brute force de contrasenyes |
| `john` | /usr/sbin/john | Crackejador de hashes |
| `hashcat` | /usr/bin/hashcat | Crackejador de hashes (GPU) |
| `gobuster` | /usr/bin/gobuster | Bruteforce de directoris/fitxers |
| `dirb` | /usr/bin/dirb | Bruteforce de directoris |
| `wpscan` | /usr/bin/wpscan | Escaneig de WordPress |
| `burpsuite` | /usr/bin/burpsuite | Proxy d'atac web |
| `nuclei` | /usr/bin/nuclei | Escaneig automatitzat de vulnerabilitats |
| `ffuf` | /usr/bin/ffuf | Fuzzing web rapid |

**Nota**: Falta `metasploit-framework` (no instal·lat). Es pot afegir amb `apt install metasploit-framework`.

## Com accedir al lab

### Des del Kali mateix

```bash
# Entrar al contenidor DVWA
docker exec -it dvwa bash

# Escanegar Metasploitable amb nmap
nmap -sV 10.10.30.30

# Accedir a DVWA des del navegador
# Port forwarding automatic per 127.0.0.1:8080
firefox http://127.0.0.1:8080

# Accedir a Juice Shop
firefox http://127.0.0.1:3000
```

### Des del Mac de casa

```bash
# Túnel SSH per accedir a la web del DVWA
ssh -L 8080:127.0.0.1:8080 hort-osona@hort

# Ara al navegador del Mac:
# http://127.0.0.1:8080 -> DVWA
# http://127.0.0.1:3000 -> Juice Shop
```

### Des de la RPi hortosona (via Tailscale)

```bash
# Saltar per la RPi per accedir al Kali
ssh bernat@hortosona
ssh hort-osona@hort  # un cop dins
```

### Des del Windows (via Tailscale)

```powershell
ssh hort-osona@hort
# o amb password:
ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no hort-osona@hort
```

## Validacio real feta (2026-08-07)

Tots els punts d'aquest document han estat validats amb sortida real del sistema:

- ✅ Contenidors actius (14h)
- ✅ Xarxa `cyberlab_lab-net` existent
- ✅ IPs correctes (10.10.30.10, 20, 30)
- ✅ Tallafoc actiu amb DROP a FORWARD
- ✅ Regles ACCEPT nomes per DVWA:80 i Juice Shop:3000
- ✅ 11+ eines de Kali instal·lades

## Estat

- **Validat per:** Hermes Agent (acces SSH al Kali)
- **Data:** 2026-08-07
- **Font:** Validacio directa via SSH al PC hort
- **Propera revisio:** Quan es facin canvis al lab

## Pendents

- [ ] Verificar que el servei `isolate-lab.service` existeix (no sha trobat a `/etc/systemd/system/`)
- [ ] Crear scripts d'arrencada automatica del lab (`docker-compose.yml`)
- [ ] Documentar el tallafoc `isolate-lab.sh`
- [ ] Instal·lar `metasploit-framework` si es vol usar
- [ ] Afegir un IDS (Snort o Suricata) per detectar atacs

## Referencies

- [CAP-00-15](../chapters/cap-00-15-que-es-un-lab.md) - Que es un lab
- [CAP-08-10](../chapters/cap-08-10-apps-vulnerables.md) - Aplicacions vulnerables
- [ANN-07](ann-07-historia-del-projecte.md) - Historia del projecte
- [EX-08-01](../exercises/ex-08-01-nmap-metasploitable.md) - Nmap Metasploitable
- [EX-08-02](../exercises/ex-08-02-sql-injection-dvwa.md) - SQL Injection DVWA
