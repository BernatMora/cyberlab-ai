---
id: EX-08-05
title: "Aïllar el lab Docker de la LAN amb iptables"
status: draft
version: 1
created: 2026-08-06
updated: 2026-08-06
authors:
  - Bernat Mora
  - Hermes Agent
type: exercici
prerequisites:
  - CAP-05-10
  - CAP-08-10
related:
  - CAP-04-30
dificultat: mitjà
temps: 20 min
tags:
  - docker
  - iptables
  - aïllament
  - xarxa
---

# EX-08-05 — Aïllar el lab Docker de la LAN amb iptables

> Objectiu: que el contenidors de `10.10.30.0/24` NO puguin arribar ni a la
> LAN domèstica ni a Internet, però sí que es vegin entre ells.

## Per què és important

Docker per defecte connecta els contenidors al bridge `docker0` i aquests
poden accedir a la xarxa de l'host. Si un contenidor es compromet (RCE),
l'atacant pot:

1. Escanjar la LAN per veure quins altres equips hi ha.
2. Sortir a Internet per descarregar més eines (C2, miners).
3. Pivotar cap altres serveis exposats al router.

Cal tancar aquesta porta.

## Què aprendràs

- La cadena `DOCKER-USER` i per què és l'única cadena que Docker NO toca.
- La diferència entre `FORWARD` (a on va el trànsit entre xarxes) i
  `DOCKER-USER` (a on apliques regles abans que Docker gestioni el bridge).
- Com fer un script idempotent (`-D` abans de `-A`).
- Com convertir-ho en un servei systemd `oneshot` persistent.

## Requisits

- Kali amb Docker 28.5.2 ja funcionant.
- Lab pujat a `10.10.30.0/24` (veure EX-08-04).
- `sudo` al Kali.

## Procediment pas a pas

### Pas 1 — Comprovar l'estat actual

```bash
docker network inspect cyberlab_lab-net \
  --format '{{range .IPAM.Config}}{{.Subnet}}{{end}}'
# Ha de retornar 10.10.30.0/24

sudo iptables -L DOCKER-USER -n -v
# Si no has afegit cap regla, la cadena estarà buida (policy ACCEPT).
```

### Pas 2 — Escriure l'script d'aïllament

Crea `~/cyberlab/isolate-lab.sh`:

```bash
#!/bin/bash
# Aïlla la xarxa del lab (10.10.30.0/24) de la LAN i d'Internet.
# Només permet trànsit entre contenidors del lab.

# Netejar regles anteriors (idempotent)
sudo iptables -D DOCKER-USER -s 10.10.30.0/24 -d 192.168.1.0/24 -j DROP 2>/dev/null
sudo iptables -D DOCKER-USER -s 10.10.30.0/24 ! -d 10.10.30.0/24 -j DROP 2>/dev/null

# Bloquejar lab -> LAN
sudo iptables -A DOCKER-USER -s 10.10.30.0/24 -d 192.168.1.0/24 -j DROP

# Bloquejar lab -> qualsevol cosa fora del lab (Internet, tailscale0…)
sudo iptables -A DOCKER-USER -s 10.10.30.0/24 ! -d 10.10.30.0/24 -j DROP

echo "Regles d'aïllament aplicades"
sudo iptables -L DOCKER-USER -n -v
```

```bash
chmod +x ~/cyberlab/isolate-lab.sh
```

### Pas 3 — Aplicar i verificar

```bash
sudo ~/cyberlab/isolate-lab.sh
# Ha de mostrar:
#   Chain DOCKER-USER (1 references)
#    pkts bytes target prot opt in out source      destination
#        0     0 DROP   all  --  *  *   10.10.30.0/24 192.168.1.0/24
#        0     0 DROP   all  --  *  *   10.10.30.0/24 !10.10.30.0/24
```

Prova des de dins d'un contenidor:

```bash
docker exec -it dvwa bash
ping -c 1 10.10.30.20        # OK (entre contenidors)
ping -c 1 192.168.1.1        # FAIL (aïllat)
ping -c 1 8.8.8.8            # FAIL (aïllat)
exit
```

### Pas 4 — Fer-ho persistent amb systemd

Crea `~/cyberlab/isolate-lab.service`:

```ini
[Unit]
Description=Isolate CyberLab network from LAN and Internet
After=docker.service
Requires=docker.service

[Service]
Type=oneshot
ExecStart=/usr/local/bin/isolate-lab.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

```bash
sudo cp isolate-lab.sh /usr/local/bin/
sudo cp isolate-lab.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now isolate-lab.service
sudo systemctl status isolate-lab.service
# Ha de dir: active (exited)
```

Ara cada vegada que el Kali arranqui, les regles s'aplicaran soles.

## Verificació final

```bash
# Les regles continuen presents?
sudo iptables -L DOCKER-USER -n -v

# Reinicia el Kali i comprova que tornen a aplicar-se
sudo reboot
sudo iptables -L DOCKER-USER -n -v
```

## Què has après

- `DOCKER-USER` és la cadena que **Docker NO toca automàticament** — pots
  posar-hi regles pròpies que es respectaran quan Docker creï els seus
  bridges.
- L'ordre importa: Docker primer instal·la les seves regles a `FORWARD`,
  i les teves a `DOCKER-USER` es processen **abans**.
- `RemainAfterExit=yes` + `Type=oneshot` és el patró estàndard per a
  serveis que apliquen una configuració i acaben (com `iptables-restore`,
  `sysctl --system`, etc.).

## Errors comuns

| Error | Causa | Solució |
|---|---|---|
| `iptables: Permission denied` | No tens `sudo` | Usa `sudo` o afegeix-te al grup `sudoers` |
| Regles duplicades en re-executar | No has fet `-D` primer | Afigeix `-D` abans de cada `-A` |
| `systemctl status` diu `inactive (dead)` | T'has deixat `RemainAfterExit=yes` | Torna a posar-lo |
| Contenidors no es veuen entre ells | La segona regla és massa ampla | Usa `! -d 10.10.30.0/24` (NOT), no pas `-d 0.0.0.0/0` |

## Referències

- [Docker docs — iptables](https://docs.docker.com/network/iptables/)
- [`man iptables-extensions`](https://man7.org/linux/man-pages/man8/iptables-extensions.8.html)
- [`docker/lab/isolate-lab.sh`](../../docker/lab/isolate-lab.sh) — L'script al repo
- [`docker/lab/isolate-lab.service`](../../docker/lab/isolate-lab.service) — La unitat systemd al repo
