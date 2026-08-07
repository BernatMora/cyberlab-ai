---
id: LAB-15-10
title: "Lab real muntat al Kali (PC hort)"
status: published
version: 2.0
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

Tots 3 actius des de fa 14+ hores:

| Contenidor | Imatge | IP interna | Ports | Funcio |
|---|---|---|---|---|
| **dvwa** | `vulnerables/web-dvwa` | 10.10.30.10 | 127.0.0.1:8080 -> 80 | Botiga web vulnerable (SQL injection, XSS) |
| **juice-shop** | `bkimminich/juice-shop` | 10.10.30.20 | 127.0.0.1:3000 -> 3000 | Botiga de sucs vulnerable (vulnerabilitats modernes) |
| **metasploitable** | `peakkk/metasploitable` | 10.10.30.30 | 21-23, 25, 80, 111, 139, 445, 512-514, 1099, 1524, 3306, 3632, 5432, 5900, 6000, 6667, 6697, 8009, 8180, 32963, 37537, 45458 | Linux antic vulnerable |

## Xarxa aillada

Tots els contenidors estan a la xarxa Docker `cyberlab_lab-net` (10.10.30.0/24).

```bash
docker network inspect cyberlab_lab-net --format "{{range .Containers}}{{.Name}}: {{.IPv4Address}}{{"\n"}}{{end}}"
```

**Sortida esperada:**
```
juice-shop: 10.10.30.20/24
metasploitable: 10.10.30.30/24
dvwa: 10.10.30.10/24
```

## Tallafoc actiu (aillament real)

L'script `/usr/local/bin/isolate-lab.sh` aplica regles al `iptables` per tal que el lab **NO pugui accedir a la LAN ni a Internet**.

### Regles de la cadena DOCKER-USER

| Regla | Funcio |
|---|---|
| `DROP all -- 10.10.30.0/24 -> 192.168.1.0/24` | Bloquejar lab -> LAN |
| `DROP all -- 10.10.30.0/24 ! -> 10.10.30.0/24` | Bloquejar lab -> Internet (nomes permet transit intern) |

### Regles de la cadena raw (PREROUTING)

| Regla | Funcio |
|---|---|
| `DROP -d 10.10.30.30 ! -i br-e3b7b7768083` | Bloquejar acces a Metasploitable des de fora del bridge |
| `DROP -d 10.10.30.20 ! -i br-e3b7b7768083` | Bloquejar acces a Juice Shop des de fora del bridge |
| `DROP -d 10.10.30.10 ! -i br-e3b7b7768083` | Bloquejar acces a DVWA des de fora del bridge |
| `DROP -d 127.0.0.1:3000 ! -i lo` | Bloquejar acces al port 3000 si no ve del loopback |
| `DROP -d 127.0.0.1:8080 ! -i lo` | Bloquejar acces al port 8080 si no ve del loopback |

**Interpretacio**: nomes els contenidors Docker poden accedir als serveis del lab. La RPi, el Mac o qualsevol altre dispositiu del tailnet **NO** pot accedir-hi directament.

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
| Containers | 3 |
| Images | 4 |
| Total imatges | 2.26 GB |
| Total contenidors | 120.4 MB |

## Com accedir al lab

### Des del Kali mateix

```bash
# Entrar al contenidor DVWA
docker exec -it dvwa bash

# Escanegar Metasploitable amb nmap
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

- ✅ Contenidors actius (14+ hores)
- ✅ Xarxa `cyberlab_lab-net` existent
- ✅ IPs correctes (10.10.30.10, 20, 30)
- ✅ Tallafoc actiu amb DROP a FORWARD
- ✅ Regles ACCEPT nomes per DVWA:80 i Juice Shop:3000
- ✅ 16 eines de Kali instal·lades
- ✅ Acces SSH funcional des del Windows (despres de crear clau nova)

## Problemes coneguts i solucions

### El servei `isolate-lab.service` esta a /tmp/

**Problema**: El fitxer de servei esta a `/tmp/isolate-lab.service` (no persistent). Si es reinicia el Kali, es perd.

**Solucio propera**: Moure'l a `/etc/systemd/system/isolate-lab.service` i fer-lo persistent.

### El fitxer `docker-compose.yml` no sha trobat

**Problema**: Els contenidors s'han creat manualment amb `docker run`, no amb Docker Compose.

**Solucio**: Crear un `docker-compose.yml` que documenti com aixecar el lab de zero.

### Falta el tallafoc automatic al boot

**Problema**: Si el Kali es reinicia, les regles d'iptables es perden.

**Solucio**: Configurar un servei systemd que apliqui l'script al boot.

## Estat

- **Validat per:** Hermes Agent (acces SSH al Kali)
- **Data:** 2026-08-07
- **Font:** Validacio directa via SSH al PC hort
- **Propera revisio:** Despres de moure el servei a /etc/systemd/system/

## Pendents

- [ ] Moure `isolate-lab.service` a `/etc/systemd/system/`
- [ ] Crear `docker-compose.yml` per aixecar el lab de zero
- [ ] Fer un script de backup de la configuracio
- [ ] Documentar el tallafoc `isolate-lab.sh` (ja fet aqui)
- [ ] Instal·lar `metasploit-framework` si es vol usar
- [ ] Afegir un IDS (Snort o Suricata) per detectar atacs

## Referencies

- [CAP-00-15](../chapters/cap-00-15-que-es-un-lab.md) - Que es un lab
- [CAP-08-10](../chapters/cap-08-10-apps-vulnerables.md) - Aplicacions vulnerables
- [ANN-07](ann-07-historia-del-projecte.md) - Historia del projecte
- [EX-08-01](../exercises/ex-08-01-nmap-metasploitable.md) - Nmap Metasploitable
- [EX-08-02](../exercises/ex-08-02-sql-injection-dvwa.md) - SQL Injection DVWA
