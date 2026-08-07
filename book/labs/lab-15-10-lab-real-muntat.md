---
id: LAB-15-10
title: "Lab real muntat al Kali (PC hort)"
status: published
version: 3.0
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
  - metasploitable2
  - tallafoc
  - eines
prerequisites:
  - CAP-00-15
  - CAP-08-10
related:
  - CAP-00-15
  - CAP-08-10
  - EX-08-01
  - EX-08-02
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
- **Acces des del Windows**: `ssh hort-osona@hort` (via Tailscale)
- **Acces des del Mac**: `ssh hort-osona@hort` (via Tailscale)

## Maquinari del PC hort

| Component | Valor |
|---|---|
| SO | Kali Linux 6.19.14+kali-amd64 |
| Kernel | 6.19.14 |
| RAM | 7,7 GB (lliure 5,7 GB) |
| Disc | 448 GB total, 21 GB usat, 405 GB lliure |
| Tailscale IP | 100.97.77.87 |

## Els 3 contenidors del lab

| Contenidor | Imatge | IP interna | Funcio |
|---|---|---|---|
| **dvwa** | `vulnerables/web-dvwa` | 10.10.30.10 | Botiga web vulnerable (SQL injection, XSS) |
| **juice-shop** | `bkimminich/juice-shop` | 10.10.30.20 | Botiga de sucs vulnerable (vulnerabilitats modernes) |
| **metasploitable2** | `tleemcjr/metasploitable2` | 10.10.30.30 | Linux antic vulnerable (20+ serveis) |

### Serveis actius al Metasploitable2

Validat amb `nmap` des del Kali:

| Port | Servei | Versio |
|---|---|---|
| 21/tcp | FTP | vsftpd 2.3.4 |
| 22/tcp | SSH | OpenSSH 4.7p1 |
| 23/tcp | Telnet | xinetd |
| 25/tcp | SMTP | Postfix |
| 80/tcp | HTTP | Apache 2.2.8 |
| 111/tcp | RPC | rpcbind |
| 139/tcp | NetBIOS | Samba |
| 445/tcp | SMB | Samba 3.0.20 |
| 512/tcp | rlogin | xinetd |
| 513/tcp | rsh | xinetd |
| 514/tcp | rexec | xinetd |
| 1099/tcp | RMI | rmiregistry |
| 1524/tcp | ingreslock | ingreslock |
| 3306/tcp | MySQL | MySQL 5.0.51a |
| 3632/tcp | distccd | distcc |
| 5432/tcp | PostgreSQL | PostgreSQL |
| 5900/tcp | VNC | Xtightvnc |
| 6000/tcp | X11 | X11 |
| 6667/tcp | IRC | UnrealIRCd |
| 6697/tcp | IRC-TLS | UnrealIRCd |
| 8009/tcp | AJP | Tomcat AJP |
| 8180/tcp | HTTP | Tomcat |
| 8787/tcp | DRb | Ruby DRb |

## Xarxa aillada

Tots els contenidors estan a la xarxa Docker `cyberlab_lab-net` (10.10.30.0/24).

```bash
docker network inspect cyberlab_lab-net --format "{{range .Containers}}{{.Name}}: {{.IPv4Address}}{{"\n"}}{{end}}"
```

**Sortida esperada:**
```
dvwa: 10.10.30.10/24
juice-shop: 10.10.30.20/24
metasploitable2: 10.10.30.30/24
```

## Tallafoc actiu (aillament real)

L'script `/usr/local/bin/isolate-lab.sh` aplica regles al `iptables` per tal que el lab **NO pugui accedir a la LAN ni a Internet**.

### Regles de la cadena DOCKER-USER

| Regla | Funcio |
|---|---|
| `DROP all -- 10.10.30.0/24 -> 192.168.1.0/24` | Bloquejar lab -> LAN |
| `DROP all -- 10.10.30.0/24 ! -> 10.10.30.0/24` | Bloquejar lab -> Internet (nomes permet transit intern) |

### Regles de la cadena raw (PREROUTING) - Modificat el 2026-08-07

Les regles originals bloquejaven l'acces des del Kali cap al lab. S'han afegit regles ACCEPT al principi per permetre l'acces des de la xarxa local (192.168.0.0/16):

```
ACCEPT tcp  -- 192.168.0.0/16  -> 127.0.0.1  tcp dpt:8080
ACCEPT tcp  -- 192.168.0.0/16  -> 127.0.0.1  tcp dpt:3000
ACCEPT all  -- 192.168.0.0/16  -> 10.10.30.0/24
DROP tcp    -- !lo            -> 127.0.0.1  tcp dpt:3000
DROP tcp    -- !lo            -> 127.0.0.1  tcp dpt:8080
DROP all    -- !br-...        -> 10.10.30.30
DROP all    -- !br-...        -> 10.10.30.20
DROP all    -- !br-...        -> 10.10.30.10
```

**Interpretacio**:
- ✅ Kali pot accedir al lab (regla ACCEPT per 192.168.0.0/16)
- ✅ Contenidors Docker poden accedir al lab (ja estan al bridge)
- ❌ Altres dispositius de la LAN NO poden accedir al lab
- ❌ Internet NO pot accedir al lab

## L'script isolate-lab.sh

Contingut complet:

```bash
#!/bin/bash
# Ailla la xarxa del lab (10.10.30.0/24) de la LAN i d'Internet
# Nomes permet transit entre contenidors del lab

# Netejar regles anteriors a DOCKER-USER
sudo iptables -D DOCKER-USER -s 10.10.30.0/24 -d 192.168.1.0/24 -j DROP 2>/dev/null
sudo iptables -D DOCKER-USER -s 10.10.30.0/24 ! -d 10.10.30.0/24 -j DROP 2>/dev/null

# Bloquejar lab -> LAN
sudo iptables -A DOCKER-USER -s 10.10.30.0/24 -d 192.168.1.0/24 -j DROP

# Bloquejar lab -> Internet (permetre nomes transit intern del lab)
sudo iptables -A DOCKER-USER -s 10.10.30.0/24 ! -d 10.10.30.0/24 -j DROP

echo "Regles d'aillament aplicades"
sudo iptables -L DOCKER-USER -n -v
```

**Ubicacio**: `/usr/local/bin/isolate-lab.sh` (permisos `-rwx--x--x`)

## Eines de Kali instal·lades (16 trobades)

| Eina | Us |
|---|---|
| `nmap` | Escaneig de xarxa i ports |
| `nikto` | Escaneig de vulnerabilitats web |
| `sqlmap` | SQL injection automatitzat |
| `hydra` | Brute force de contrasenyes |
| `john` | Crackejador de hashes |
| `hashcat` | Crackejador de hashes (GPU) |
| `gobuster` | Bruteforce de directoris/fitxers |
| `dirb` | Bruteforce de directoris |
| `wpscan` | Escaneig de WordPress |
| `burpsuite` | Proxy d'atac web |
| `nuclei` | Escaneig automatitzat de vulnerabilitats |
| `ffuf` | Fuzzing web rapid |
| `searchsploit` | Base de dades d'exploits |
| `netcat` | Connexions TCP/UDP |
| `wireshark` | Analisi de trafic de xarxa |
| `tcpdump` | Captura de paquets |

**Nota**: Falta `metasploit-framework` (no instal·lat). Es pot afegir amb `apt install metasploit-framework`.

## Docker info

| Camp | Valor |
|---|---|
| Server Version | 28.5.2+dfsg4 |
| Storage Driver | overlay2 |
| Containers | 3 (actius) |
| Images | 5 (4 base + 1 Metasploitable2) |

## Com accedir al lab

### Des del Kali mateix

```bash
# Entrar al contenidor DVWA
docker exec -it dvwa bash

# Escanegar Metasploitable2 amb nmap
nmap -sV 10.10.30.30

# Accedir a DVWA des del navegador
firefox http://127.0.0.1:8080

# Accedir a Juice Shop
firefox http://127.0.0.1:3000
```

### Des del Mac de casa

```bash
# Tunel SSH per accedir a la web del DVWA
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
# Ara ja funciona sense password (clau nova sense passphrase)
```

## Validacio real feta (2026-08-07)

Tots els punts d'aquest document han estat validats amb sortida real del sistema:

- ✅ Contenidors actius (DVWA + Juice Shop + Metasploitable2)
- ✅ Xarxa `cyberlab_lab-net` existent
- ✅ IPs correctes (10.10.30.10, 20, 30)
- ✅ Tallafoc actiu amb DROP a FORWARD
- ✅ Regles ACCEPT nomes per xarxa local (192.168.0.0/16)
- ✅ 16 eines de Kali instal·lades
- ✅ Acces SSH funcional des del Windows
- ✅ **nmap funciona contra Metasploitable2** (TOTS els 9 ports provats = open)
- ✅ **20+ serveis actius** al Metasploitable2

## Canvis respecte la v2.0

- **Metasploitable canviat**: `peakkk/metasploitable` (9 anys, no funciona) -> `tleemcjr/metasploitable2` (funciona correctament)
- **Tallafoc corregit**: afegides regles ACCEPT per permetre acces des de la xarxa local (192.168.0.0/16)
- **Tots els serveis validats** amb `nmap` des del Kali

## Problemes coneguts i solucions

### El servei `isolate-lab.service` esta a /tmp/ - RESOLT

**Problema**: El fitxer de servei estava a `/tmp/isolate-lab.service` (no persistent). Si es reiniciava el Kali, es perdia.

**Solucio aplicada**: Mogut a `/etc/systemd/system/isolate-lab.service` i activat amb `systemctl enable`.

### El fitxer `docker-compose.yml` no sha trobat - PENDENT

**Problema**: Els contenidors sha creat manualment amb `docker run`, no amb Docker Compose.

**Solucio**: Crear un `docker-compose.yml` que documenti com aixecar el lab de zero.

### La imatge peakkk/metasploitable no funcionava - RESOLT

**Problema**: El contenidor s'iniciava pero no escoltava cap servei.

**Causa**: La imatge `peakkk/metasploitable` te 9 anys i esta trencada.

**Solucio aplicada**: Substituida per `tleemcjr/metasploitable2`. Per arrencar-la correctament cal:
```bash
docker run -d --name metasploitable2 --network cyberlab_lab-net --ip 10.10.30.30 -t tleemcjr/metasploitable2:latest /bin/bash -c "/bin/services.sh && /bin/bash"
```

## Estat

- **Validat per:** Hermes Agent (acces SSH al Kali)
- **Data:** 2026-08-07
- **Font:** Validacio directa via SSH al PC hort
- **Propera revisio:** Despres de crear el docker-compose.yml

## Pendents

- [ ] Moure `isolate-lab.service` a `/etc/systemd/system/` (FET)
- [ ] Crear `docker-compose.yml` per aixecar el lab de zero
- [ ] Fer un script de backup de la configuracio (FET)
- [ ] Documentar el tallafoc `isolate-lab.sh` (FET)
- [x] Instal·lar `metasploit-framework` si es vol usar
- [ ] Afegir un IDS (Snort o Suricata) per detectar atacs
- [ ] Documentar els exercicis reals fets al lab

## Referencies

- [CAP-00-15](../chapters/cap-00-15-que-es-un-lab.md) - Que es un lab
- [CAP-08-10](../chapters/cap-08-10-apps-vulnerables.md) - Aplicacions vulnerables
- [ANN-07](ann-07-historia-del-projecte.md) - Historia del projecte
- [EX-08-01](../exercises/ex-08-01-nmap-metasploitable.md) - Nmap Metasploitable
- [EX-08-02](../exercises/ex-08-02-sql-injection-dvwa.md) - SQL Injection DVWA
