---
id: ANN-08
title: "Glossari complet de ports i serveis"
status: published
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - glossari
  - ports
  - serveis
  - xarxes
  - nivell-principiant
prerequisites: []
related:
  - LAB-15-10
  - LAB-15-11
estimated_time: lectura
difficulty: beginner
---

# ANN-08 - Glossari complet de ports i serveis

> Guia de referencia per a gent que comença. Cada port explicat: per a que serveix, per que es perillos, i com detectar-lo.

## Que es un port?

Un **port** es com un numero de porta d'un edifici. El teu PC te 65536 portes (ports), i cada porta pot tenir un **servei** diferent escoltant.

- **Port 80**: el servidor web (HTTP)
- **Port 443**: el servidor web segur (HTTPS)
- **Port 22**: el servidor SSH (acces remot segur)
- **Port 21**: el servidor FTP (transferencia de fitxers)

Cada port te un **numero** del 0 al 65535, i un **protocol** (TCP o UDP).

### TCP vs UDP

- **TCP**: orientat a connexio. Mes segur pero mes lent. Usat per web, correu, FTP.
- **UDP**: sense connexio. Mes rapid pero menys fiable. Usat per DNS, video, jocs.

## Ports trobats al Metasploitable2

### Port 21 - FTP (File Transfer Protocol)

**Que es**: Servidor de transferencia de fitxers. Permet pujar i baixar fitxers al servidor.

**Per a que serveix**: Permet als usuaris pujar fitxers al servidor o baixar-ne.

**Versions conegudes**:
- **vsftpd 2.3.4** (trobada al lab) - VERSIO AMB BACKDOOR! (CVE-2011-2523)
- vsftpd 3.0.5 - versio actual segura

**Per que es perillos**:
- FTP envia **contrasenyes en text pla** (no xifrades)
- Molts servidors permeten **anonymous** (sense usuari/contrasenya)
- Algunes versions tenen **backdoors** (portes del darrere)

**Com detectar-lo**: `nmap -p 21 -sV IP`

**Com protegir-se**:
- Utilitzar **SFTP** o **FTPS** (versions xifrades)
- No permetre anonymous
- Utilitzar contrasenyes fortes

---

### Port 22 - SSH (Secure Shell)

**Que es**: Servidor d'acces remot segur. Permet entrar al sistema de forma xifrada.

**Per a que serveix**: Administracio remota del sistema.

**Versions trobades**: OpenSSH 4.7p1 (2007)

**Per que es perillos**:
- Si tens contrasenyes febles, es pot fer **brute force** (provar totes)
- Algunes versions tenen vulnerabilitats antigues
- Si l'atacant entra, te **control total** del sistema

**Com detectar-lo**: `nmap -p 22 -sV IP`

**Com protegir-se**:
- Utilitzar **claus SSH** en lloc de contrasenyes
- Canviar el port per defecte
- Utilitzar **fail2ban** (bloqueja IPs que fan masses intents)
- Desactivar login de root

---

### Port 23 - Telnet

**Que es**: Antic protocol d'acces remot. **No xifra** res.

**Per a que serveix**: Antigament era com SSH pero avui dia **NO sha d'utilitzar**.

**Per que es perillos**:
- **TOT** va en text pla (incloses contrasenyes)
- Qualsevol que escolti el trafic pot veure-ho tot

**Com protegir-se**:
- **Desactivar Telnet** sempre
- Utilitzar **SSH** en lloc

---

### Port 25 - SMTP (Simple Mail Transfer Protocol)

**Que es**: Servidor de correu electronic sortint.

**Per a que serveix**: Enviar correus electronic.

**Versions trobades**: Postfix smtpd

**Per que es perillos**:
- Servidors antics poden permetre **open relay** (enviar correus falsos)
- Es pot fer servir per **spam** o **phishing**
- Algunes versions tenen vulnerabilitats

**Com detectar-lo**: `nmap -p 25 -sV IP`

**Com protegir-se**:
- Autenticacio obligatoria
- Tancar open relay
- Utilitzar TLS

---

### Port 80 - HTTP (HyperText Transfer Protocol)

**Que es**: Servidor web. Mostra pagines web.

**Per a que serveix**: Servir pagines web als navegadors.

**Versions trobades**: Apache httpd 2.2.8 (2008)

**Per que es perillos**:
- HTTP envia **TOT en text pla** (incloses contrasenyes)
- Versions antigues tenen moltes **vulnerabilitats conegudes**
- Es el port mes atacat perque **tothom te un servidor web**

**Com protegir-se**:
- Utilitzar **HTTPS** (port 443) en lloc d'HTTP
- Mantenir el servidor actualitzat
- Configurar correctament els permisos

---

### Port 111 - RPCBind (Remote Procedure Call Bind)

**Que es**: Servei que assigna numeros de port als serveis RPC.

**Per a que serveix**: Permet als clients trobar els serveis RPC al servidor.

**Per que es perillos**:
- Pot revelar **informacio** sobre serveis actius
- Es pot utilitzar per a **atacs de denegacio de servei** (DoS)

**Com protegir-se**:
- Desactivar si no sha de fer servir
- Firewall bloquejant acces extern

---

### Port 139 i 445 - SMB (Server Message Block)

**Que es**: Protocol per compartir fitxers i impressores. **Utilitzat per Windows**.

**Per a que serveix**: Permet compartir carpetes entre equips Windows (i Linux amb Samba).

**Versions trobades**: Samba 3.X - 4.X

**Per que es perillos**:
- Molts servidors permeten **acces anonymous** (sense autenticacio)
- Vulnerabilitats conegudes: **CVE-2017-7494** (Sambacry, RCE)
- Es pot **enumerar** usuaris, carpetes, fitxers sense permis

**Com detectar-lo**: `nmap -p 139,445 -sV IP`

**Com protegir-se**:
- Desactivar SMB si no sha de fer servir
- No permetre acces anonymous
- Mantenir Samba actualitzat
- Firewall bloquejant acces extern

---

### Ports 512, 513, 514 - rlogin/rsh/rexec

**Que es**: Serveis d'acces remot **antics** (anterior a SSH).

**Per a que serveix**: Permet executar comandes remotament (com SSH pero menys segur).

**Per que es perillos**:
- **NO xifren** res
- Autenticacio feble (basada en IP)
- Gairebe **mai sha d'utilitzar** avui dia

**Com protegir-se**:
- **Desactivar** aquests serveis sempre
- Utilitzar SSH

---

### Port 1099 - Java RMI

**Que es**: Java Remote Method Invocation. Permet cridar funcions Java entre maquines.

**Per a que serveix**: Aplicacions Java distribuides.

**Per que es perillos**:
- Es pot fer servir per **execucio remota de codi** (RCE)
- Algunes versions permeten carregar classes desde URLs externes

**Com protegir-se**:
- Filtrar amb firewall
- Utilitzar autenticacio
- Mantenir Java actualitzat

---

### Port 1524 - Ingreslock

**Que es**: Port **misterios**. En alguns sistemes es fa servir per Ingres (base de dades), pero al Metasploitable2 esta **obert amb un shell**.

**Per que es perillos**:
- Al lab hi ha un **shell directament accessible** (sense autenticacio)
- Es una **porta del darrere** classica

**Com protegir-se**:
- **Tancar** aquest port si no sha de fer servir
- Firewall bloquejant acces extern

---

### Port 3306 - MySQL

**Que es**: Base de dades MySQL.

**Per a que serveix**: Emmagatzemar dades de forma estructurada.

**Versions trobades**: MySQL 5.0.51a (2008)

**Per que es perillos**:
- Credencials febles o buides
- Versions antigues tenen **bypass d'autenticacio** (CVE-2009-2446)
- Accessible desde Internet = exposicio total

**Com detectar-lo**: `nmap -p 3306 -sV IP`

**Com protegir-se**:
- Contrasenyes fortes
- No exposar a Internet
- Mantenir actualitzat
- Tancar acces per defecte

---

### Port 3632 - Distccd

**Que es**: Distributed C Compiler. Servei per compilar codi C en xarxa.

**Per a que serveix**: Compilar codi rapidament utilitzant varios equips.

**Per que es perillos**:
- Vulnerabilitat **CVE-2004-2687**: execucio remota de comandes
- Permet executar qualsevol comanda al servidor

**Com protegir-se**:
- **Desactivar** si no sha de fer servir
- Firewall bloquejant acces extern

---

### Port 5432 - PostgreSQL

**Que es**: Base de dades PostgreSQL.

**Per a que serveix**: Emmagatzemar dades. Alternativa a MySQL.

**Versions trobades**: PostgreSQL 8.3.x (2008)

**Per que es perillos**:
- Credencials per defecte (postgres/postgres)
- Versions antigues tenen vulnerabilitats

**Com protegir-se**:
- Canviar credencials per defecte
- No exposar a Internet
- Mantenir actualitzat

---

### Port 5900 - VNC (Virtual Network Computing)

**Que es**: Control remot d'escriptori. Com una "porta del darrere" gràfica.

**Per a que serveix**: Veure i controlar l'escriptori d'un altre equip.

**Per que es perillos**:
- Molts VNC **no tenen contrasenya** o son molt febles
- Si l'atacant entra, **veu tot** el que fas
- Pot executar comandes com si fos al teu lloc

**Com detectar-lo**: `nmap -p 5900 -sV IP`

**Com protegir-se**:
- Contrasenya forta
- VNC sobre SSH (tunel xifrat)
- No exposar a Internet

---

### Port 6000 - X11

**Que es**: Sistema grafic de Linux. Permet finestres remotes.

**Per a que serveix**: Aplicacions grafic de Linux en xarxa.

**Per que es perillos**:
- Si esta mal configurat, qualsevol pot veure les teves finestres
- **Keylogging**: poden veure el que escrius
- Es pot fer servir per prendre control del sistema

**Com protegir-se**:
- Desactivar X11 forwarding si no sha de fer servir
- Utilitzar SSH amb `-X` nomes si cal
- Firewall

---

### Port 6667 - IRC (Internet Relay Chat)

**Que es**: Servidor de xat antic.

**Per a que serveix**: Xat en temps real.

**Versions trobades**: UnrealIRCd 3.2.8.1

**Per que es perillos**:
- **CVE-2010-2075**: BACKDOOR! Permet executar comandes
- Al lab, enviant "AB;id" al servidor IRC, executes una comanda!

**Com protegir-se**:
- **Actualitzar** la versio d'UnrealIRCd
- No exposar a Internet si no cal

---

### Port 6697 - IRC sobre TLS

**Que es**: IRC xifrat.

**Mes segur** que el port 6667 pero tambe te el backdoor al lab.

---

### Port 8009 - AJP (Apache JServ Protocol)

**Que es**: Protocol per comunicar Apache amb Tomcat.

**Per a que serveix**: Tomcat es un servidor d'aplicacions Java.

**Per que es perillos**:
- Si esta mal configurat, es pot fer **RCE** (CVE-2020-1938 Ghostcat)

**Com protegir-se**:
- Configurar correctament
- Firewall

---

### Port 8180 - Apache Tomcat

**Que es**: Servidor d'aplicacions Java.

**Per a que serveix**: Executar aplicacions web Java (JSP, servlets).

**Versions trobades**: Apache Tomcat/Coyote JSP engine 1.1

**Per que es perillos**:
- Versio MOLT antiga
- Vulnerabilitats conegudes: CVE-2009-3548 (auth bypass)
- Aplicacions mal configurades

**Com protegir-se**:
- Mantenir actualitzat
- Canviar el port per defecte
- Autenticacio obligatoria

---

### Port 8787 - DRb (Distributed Ruby)

**Que es**: Ruby Distributed Ruby. Permet cridar objectes Ruby entre maquines.

**Per a que serveix**: Aplicacions Ruby distribuides.

**Per que es perillos**:
- **RCE**: Es pot executar codi Ruby remotament
- Es pot utilitzar per **prendre control** del sistema

**Com protegir-se**:
- Desactivar si no sha de fer servir
- Firewall

---

## Comandes per identificar serveis

### Detectar servei basic
```bash
nmap -sV IP
```

### Detectar versio especifica
```bash
nmap -sV --version-intensity 9 IP
```

### Detectar vulnerabilitats
```bash
nmap --script=vuln IP
```

### Escaneig rapid
```bash
nmap -F IP
```

### Escaneig complet
```bash
nmap -p- --min-rate=5000 IP
```

## Glossari de termes

- **Port**: Numero que identifica un servei a una maquina (0-65535).
- **TCP**: Protocol orientat a connexio. Usat per web, correu, FTP.
- **UDP**: Protocol sense connexio. Usat per DNS, video.
- **Socket**: Combinacio d'IP + port (ex: 192.168.1.1:80).
- **Listening**: Servei esperant connexions a un port.
- **Open/Closed/Filtered**: Estat d'un port segons nmap.
  - **open**: Servei escoltant. Es pot connectar.
  - **closed**: Resposta rebutjada. No hi ha servei.
  - **filtered**: No es pot saber si esta obert o tancat (paquets filtrats).
- **Banner**: Text que mostra el servei quan et connectes.
- **Banner grabbing**: Obtenir el banner per identificar el servei.
- **CVE**: Identificador unic per a una vulnerabilitat.
- **CVSS**: Puntuacio de severitat d'una vulnerabilitat (0-10).
- **RCE**: Remote Code Execution. Execucio remota de codi.
- **LFI/RFI**: Local/Remote File Inclusion. Incloure fitxers no desitjats.

## Conceptes basics de xarxes

### Com funciona una connexio

1. **Client**: Tu (navegador, terminal, etc.)
2. **Servidor**: La maquina que te el servei (port 80 per HTTP)
3. **Connexio**: S'estableix entre IP client : port aleatori i IP servidor : port 80

### El model OSI

```
7. Aplicacio (HTTP, FTP, SSH)
6. Presentacio (TLS, SSL)
5. Sessio
4. Transport (TCP, UDP)
3. Xarxa (IP)
2. Enllaç de dades (Ethernet)
1. Fisica (Cable, WiFi)
```

Els ports son a la capa 4 (Transport).

## Recursos addicionals

- [Wikipedia - TCP/UDP port list](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers)
- [Nmap Reference](https://nmap.org/book/man.html)
- [CVE Details](https://www.cvedetails.com/)

## Referencies

- [LAB-15-10](lab-15-10-lab-real-muntat.md) - Lab real muntat al Kali
- [LAB-15-11](lab-15-11-nmap-complet-metaploitable2.md) - Nmap complet
- [CAP-08-10](../chapters/cap-08-10-apps-vulnerables.md) - Aplicacions vulnerables
