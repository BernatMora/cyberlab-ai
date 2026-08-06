---
id: EX-08-06
title: "Explotació SMB a Metasploitable amb enum4linux"
status: draft
version: 0.1
created: 2026-08-06
updated: 2026-08-06
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - smb
  - enum4linux
  - metasploitable
prerequisites:
  - CAP-08-10
related:
  - CAP-08-10
estimated_time: 20 min
difficulty: intermediate
---

# EX-08-06 — Explotació SMB a Metasploitable amb enum4linux

> Enumera usuaris, grups i recursos compartits del SMB de Metasploitable.

## Objectiu

Descobrir usuaris vàlids i carpetes compartides al servei SMB
(port 445) de Metasploitable sense necessitat d'explotar cap
vulnerabilitat — només amb **enum4linux**.

## Requisits

- Metasploitable pujat (`10.10.30.30`, a la xarxa `lab-net`).
- Kali amb `enum4linux` instal·lat (`sudo apt install enum4linux`).
- Connexió des del Kali cap a `10.10.30.30:445` (verifica amb
  `nc -zv 10.10.30.30 445`).

## Entorn

- Atacant: Kali (`hort`).
- Víctima: Metasploitable (`10.10.30.30`).
- Xarxa: `cyberlab_lab-net` (`10.10.30.0/24`).

## Passos

### 1. Preparació

Comprova que el servei SMB és accessible:

```bash
nc -zv 10.10.30.30 445
# Connection to 10.10.30.30 445 port [tcp/smb] succeeded!
```

Si no, comprova que el contenidor és `Up`: `docker ps | grep metasploitable`.

### 2. Execució — Enumeració completa

```bash
enum4linux -a 10.10.30.30 2>/dev/null | tee /tmp/enum4linux-output.txt
```

L'opció `-a` fa tot: usuaris, grups, shares, password policy, OS info.

### 3. Comprovació — Què hem trobat?

Al fitxer `/tmp/enum4linux-output.txt` hauries de veure:

- **Llista d'usuaris**: `root`, `user`, `msfadmin`, `service`, etc.
- **Shares**: `tmp` (escriu per tothom), `opt` (potser amb accés interessant).
- **OS info**: `Samba 3.0.20-Debian` (versió antiga amb múltiples CVEs).
- **Password policy**: longitud mínima, etc.

### 4. Accés directe (opcional)

Amb els usuaris descoberts, prova de connectar-te a la share `tmp`:

```bash
smbclient //10.10.30.30/tmp -U msfadmin
# Password: (buit o "msfadmin")
smb: \> ls
smb: \> put /tmp/el_meu_fitxer.txt
```

## Comprovacions

- [ ] He vist la llista d'usuaris
- [ ] He vist les shares
- [ ] He pogut connectar-me amb `smbclient` (almenys en modo anònim)

## Què has après

- **SMB** (Server Message Block) és un protocol de compartició de
  fitxers molt exposat. Qualsevol màquina Windows o Linux amb Samba
  el sol tenir port 445 obert.
- **enum4linux** és l'eina bàsica d'enumeració SMB. Fa el que
  manualment seria 10 ordres de `rpcclient`, `smbclient`, `nmap scripts`.
- **Versió 3.0.20-Debian de Samba** té CVE-2007-2447 (command injection
  via username) — es pot explotar amb Metasploit `usermap_script`.

## Pròxims passos

- Prova l'exploit Metasploit: `use exploit/multi/samba/usermap_script`
- Llegeix els logs a Metasploitable: `docker exec -it metasploitable
  cat /var/log/samba/log.smbd`

## Referències

- [CAP-08-10](../chapters/cap-08-10-apps-vulnerables.md)
- [enum4linux docs](https://labs.portcullis.co.uk/tools/enum4linux/)
- [CVE-2007-2447](https://www.cvedetails.com/cve/CVE-2007-2447/)
