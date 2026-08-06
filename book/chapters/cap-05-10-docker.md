---
id: CAP-05-10
title: "Docker"
status: draft
version: 0.2
created: 2026-07-28
updated: 2026-08-06
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - docker
  - contenidors
prerequisites:
  - CAP-03-10
related:
  - CAP-08-10
  - CAP-08-20
---

# CAP-05-10 — Docker

> Com instal·lem Docker i Docker Compose al Kali del CyberLab per allotjar aplicacions vulnerables en contenidors aïllats.

## 1. Què és?

Docker és una plataforma de virtualització lleugera basada en contenidors. Cada contenidor comparteix el kernel del host però s'aïlla en el seu propi espai d'usuari, xarxa i sistema de fitxers. Ocupa molt menys que una VM completa (megabytes en lloc de gigabytes).

Docker Compose és una eina que permet definir múltiples contenidors en un sol fitxer YAML (`docker-compose.yml`), amb les seves xarxes, volums i dependències.

## 2. Per què existeix?

Perquè abans, per muntar una aplicació vulnerable per fer pràctiques, calia una VM completa (amb el seu sistema operatiu, espai en disc i RAM). Amb Docker, una aplicació com DVWA arrenca en segons i ocupa ~175 MB.

## 3. Quan s'utilitza?

- Per allotjar aplicacions vulnerables (DVWA, Juice Shop, Metasploitable) al CyberLab.
- Per aïllar serveis en xarxes internes (10.10.30.0/24 per a víctimes).
- Per reproduir entorns de laboratori de forma ràpida i repetible.

## 4. Alternatives

| Alternativa | Avantatges | Inconvenients | Quan triar-la |
|---|---|---|---|
| VMs completes (Hyper-V) | Aïllament total | Pesades (GB de RAM/disc) | Quan cal un SO complet com a víctima |
| Podman | Sense dimoni, rootless | Menys imatges disponibles | Si no vols Docker daemon |
| LXC/LXD | Contenidors de sistema complet | Més complexe | Per a labs que necessiten init system |

## 5. Avantatges

- Molt lleuger — cada contenidor ocupa megabytes, no gigabytes.
- Arrencada en segons.
- Xarxes virtuals natives per aïllar víctimes.
- Reproduïble — el mateix `docker-compose.yml` funciona a qualsevol màquina.
- Volums nomenats per persistir dades sense escriure al host.

## 6. Inconvenients

- Cal un dimoni (`dockerd`) executant-se amb privilegis.
- Per defecte, els contenidors comparteixen el kernel del host (menys aïllament que una VM).
- Les imatges públiques poden tenir vulnerabilitats o estar desactualitzades.

## 7. Arquitectura al CyberLab

```
┌─────────────────────────────────────────────┐
│  Kali (host) — hort                         │
│                                              │
│  Docker Engine (28.5.2)                     │
│    │                                         │
│    ├── Contenidor: dvwa                      │
│    │   imatge: vulnerables/web-dvwa         │
│    │   xarxa: lab-net (10.10.30.0/24)       │
│    │   port: 127.0.0.1:8080→80              │
│    │                                         │
│    └── Xarxa Docker: cyberlab_lab-net        │
│        subnet: 10.10.30.0/24                │
│        (aïllada de la LAN domèstica)         │
└─────────────────────────────────────────────┘
```

El port del contenidor es publica a `127.0.0.1:8080` — només accessible des del propi host, no des de la LAN ni des de Tailscale. Per accedir-hi remotament, es fa un túnel SSH.

## 8. Instal·lació

### 8.1 — Instal·lar Docker Engine

Al Kali:

```bash
sudo apt update
sudo apt install docker.io -y
```

> ⚠️ Kali no té el paquet `docker-compose-v2`. Sí que té `docker-compose` (v2 com a plugin).

### 8.2 — Instal·lar Docker Compose

```bash
sudo apt install docker-compose -y
```

### 8.3 — Afegir l'usuari al grup docker

Per no necessitar `sudo` per a cada comanda docker:

```bash
sudo usermod -aG docker hort-osona
```

Cal tancar i reobrir la sessió SSH perquè tingui efecte.

### 8.4 — Verificar

```bash
docker --version
docker-compose --version
docker run --rm hello-world
```

## 9. Configuració

### 9.1 — Fitxer docker-compose.yml

La configuració del lab viu a `~/cyberlab/docker-compose.yml`:

```yaml
services:
  dvwa:
    image: vulnerables/web-dvwa
    container_name: dvwa
    ports:
      - "127.0.0.1:8080:80"
    restart: unless-stopped
    networks:
      - lab-net

networks:
  lab-net:
    driver: bridge
    ipam:
      config:
        - subnet: 10.10.30.0/24
```

**Decisions:**
- `127.0.0.1:8080:80` — el port només escolta al localhost, no a la LAN.
- `restart: unless-stopped` — el contenidor es reinicia automàticament llevat que l'aturis manualment.
- `lab-net` amb subnet `10.10.30.0/24` — coincideix amb l'ADR-0004 (xarxa de víctimes).

### 9.2 — Plantilles públiques vs configuració real

El repo cyberlab-ai és públic. Les plantilles Docker viuen a `docker/` (valors genèrics). La configuració amb valors reals (IPs, ports, secrets) viu a `BernatCyberLab/_local/docker/` (no versionat, exclòs per `.gitignore`).

## 10. Verificació

```bash
# Veure contenidors actius
docker ps

# Veure xarxes Docker
docker network ls

# Test de connectivitat al contenidor
curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:8080/
# Esperat: 302 (DVWA redirigeix al login)
```

## 11. Problemes habituals

| Símptoma | Causa probable | Solució |
|---|---|---|
| `permission denied` al docker.sock | Usuari no al grup docker | `sudo usermod -aG docker $USER` + reobrir sessió |
| `No s'ha trobat el paquet docker-compose-v2` | Kali no té aquest paquet | Instal·lar `docker-compose` en lloc seu |
| Contenidor no arrenca | Port 8080 ja en ús | Canviar el port al compose o aturar el procés |
| `curl` retorna `000` | Contenidor encara arrencant | Esperar 5 segons i reintentar |

## 12. Bones pràctiques

- Publicar ports a `127.0.0.1` mai a `0.0.0.0` — les víctimes no s'exposen a la LAN.
- Usar xarxes Docker amb subnets del rang `10.10.x` per mantenir coherència amb l'ADR-0004.
- Usar `restart: unless-stopped` per a serveis del lab.
- Netejar imatges i contenidors antics: `docker system prune -f`.

## 13. Aspectes de seguretat

- Els contenidors vulnerables (DVWA) **mai** han de tenir accés a Internet o a la LAN domèstica.
- La xarxa `lab-net` és `bridge` interna — sense gateway cap a la LAN.
- No guardar secrets ni credencials als fitxers `docker-compose.yml` del repo públic.
- Les imatges públiques poden contenir malware — només usar imatges de fonts fiables.

## 14. Automatització amb Hermes

Hermes pot gestionar Docker per SSH al Kali:

- Arrencar/aturar víctimes: `docker compose up -d` / `docker compose down`.
- Monitoritzar estat: `docker ps`.
- Verificar serveis: `curl` als ports dels contenidors.
- Actualitzar imatges: `docker compose pull`.

## 15. Resum

- Docker 28.5.2 + Docker Compose instal·lats al Kali.
- DVWA corre com a primer contenidor víctima a `127.0.0.1:8080`.
- Xarxa Docker `lab-net` aïllada a `10.10.30.0/24` (segons ADR-0004).
- Els ports es publiquen a `127.0.0.1` — cap exposició a la LAN ni a Tailscale.

---

## Referències

- [Docker — Documentació oficial](https://docs.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [CAP-08-10](cap-08-10-apps-vulnerables.md) — Aplicacions vulnerables
- [CAP-08-20](cap-08-20-kali-linux.md) — Kali Linux
- [ADR-0004](../../ADR/0004-segmentacio-xarxa.md) — Segmentació de xarxa
