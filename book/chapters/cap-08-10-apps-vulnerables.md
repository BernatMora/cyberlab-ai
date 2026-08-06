---
id: CAP-08-10
title: "Aplicacions vulnerables"
status: draft
version: 0.2
created: 2026-07-28
updated: 2026-08-06
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - apps-vulnerables
  - laboratori
prerequisites:
  - CAP-05-10
  - CAP-08-20
related:
  - CAP-08-20
  - CAP-05-10
---

# CAP-08-10 — Aplicacions vulnerables

> Com desplegem aplicacions vulnerables al CyberLab per practicar tècniques d'atac en un entorn aïllat i segur.

## 1. Què és?

Una aplicació vulnerable és una aplicació dissenyada **intencionadament** amb falles de seguretat per permetre practicar tècniques de pentesting de forma ètica i legal. Són eines educatives — cada vulnerabilitat està documentada i es pot practicar a diferents nivells de dificultat.

## 2. Per què existeix?

Perquè per aprendre ciberseguretat ofensiva cal practicar contra objectius reals, però no es pot atacar sistemes de producció ni de tercers. Les aplicacions vulnerables proporcionen un objectiu legal i controlat.

## 3. Quan s'utilitza?

- Per aprendre SQL injection, XSS, command injection, etc.
- Per practicar amb nmap, nikto, sqlmap i altres eines de Kali.
- Per fer labs completets: reconeixement → explotació → post-explotació.
- Per provar configuracions defensives (WAF, IDS) contra atacs coneguts.

## 4. Alternatives

| Alternativa | Avantatges | Inconvenients | Quan triar-la |
|---|---|---|---|
| TryHackMe / HackTheBox | Online, sense muntar res | Cal subscripció, no tens control | Per a aprenentatge inicial |
| Metasploitable (VM) | Aïllament total de VM | Pesada (GB de RAM) | Quan tinguis 16+ GB RAM |
| Aplicacions vulnerables en Docker | Lleugeres, ràpides, reproduïbles | Menys aïllament que VM | ✅ Escollida per al CyberLab actual |

## 5. Avantatges

- Molt lleugeres — corren en contenidors Docker (megabytes).
- Fàcils de desplegar i destruir — `docker compose up/down`.
- Aïllades en xarxa Docker interna — sense accés a la LAN.
- Diverses aplicacions disponibles (DVWA, Juice Shop, Webgoat, etc.).

## 6. Inconvenients

- No repliquen un sistema operatiu complet — algunes tècniques de post-explotació no apliquen.
- Cal Docker funcionant al host.
- Les imatges públiques poden estar desactualitzades.

## 7. Arquitectura al CyberLab

```
┌──────────────────────────────────────────────┐
│  Kali (hort) — 10.10.30.0/24 (lab-net)       │
│                                               │
│  ┌─────────────────────────────────────────┐ │
│  │ DVWA (contenidor Docker)                │ │
│  │ imatge: vulnerables/web-dvwa            │ │
│  │ IP interna: 10.10.30.x                 │ │
│  │ port: 127.0.0.1:8080 → 80               │ │
│  │ xarxa: lab-net (bridge, aïllada)        │ │
│  └─────────────────────────────────────────┘ │
│                                               │
│  Kali natiu = màquina atacant                 │
│  nmap, nikto, sqlmap, gobuster               │
└──────────────────────────────────────────────┘
```

La víctima i l'atacant estan al mateix host (Kali), però la víctima està aïllada en una xarxa Docker bridge. L'atacant accedeix via `127.0.0.1:8080`.

## 8. Instal·lació

### 8.1 — Crear directori del lab

```bash
mkdir -p ~/cyberlab
```

### 8.2 — Crear docker-compose.yml

```bash
cat > ~/cyberlab/docker-compose.yml << 'EOF'
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
EOF
```

### 8.3 — Arrencar DVWA

```bash
cd ~/cyberlab
docker compose up -d
```

La primera vegada descarrega la imatge (~175 MB).

## 9. Configuració

### 9.1 — Accés a DVWA

DVWA està disponible a `http://127.0.0.1:8080` des del propi Kali.

Per accedir-hi des del Mac remotament, crear un túnel SSH:

```bash
ssh -L 8080:127.0.0.1:8080 <USUARI_KALI>@hort
```

Després obrir al navegador del Mac: `http://localhost:8080`

### 9.2 — Configurar DVWA

A la primera arrencada, cal anar a `http://localhost:8080/setup.php` i fer clic a **Create / Reset Database**. Després, iniciar sessió amb:

- Usuari: `admin`
- Contrasenya: `password`

### 9.3 — Nivells de seguretat

DVWA té 3 nivells: **Low**, **Medium**, **High**, **Impossible**.

- **Low**: sense cap protecció — per aprendre la vulnerabilitat.
- **Medium**: protecció bàsica — cal adaptar l'atac.
- **High**: protecció avançada — cal tècniques més sofisticades.
- **Impossible**: mostra com seria el codi segur.

## 10. Verificació

```bash
# Contenidor actiu
docker ps | grep dvwa

# Respon HTTP
curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:8080/
# Esperat: 302 (redirecció a login)

# Des del Mac via túnel SSH
curl -s -o /dev/null -w '%{http_code}' http://localhost:8080/
# Esperat: 302
```

## 11. Problemes habituals

| Símptoma | Causa probable | Solució |
|---|---|---|
| `curl` retorna `000` | Contenidor encara arrencant | Esperar 5-10 segons |
| Pàgina en blanc | Cal fer setup primer | Anar a `/setup.php` i crear la BD |
| `connection refused` al port 8080 | Contenidor aturat | `docker compose up -d` |
| No accessible des del Mac | No hi ha túnel SSH | `ssh -L 8080:127.0.0.1:8080 <USUARI_KALI>@hort` |

## 12. Bones pràctiques

- Destrueix el contenidor quan no el facis servir: `docker compose down`.
- Torna a crear la BD de DVWA entre sessions per començar de net.
- Comença per **Low** i puja de nivell quan domines la tècnica.
- Mira el codi font de **Impossible** per entendre com mitigar la vulnerabilitat.

## 13. Aspectes de seguretat

- DVWA és **intencionadament vulnerable** — mai exposar-la a Internet o a la LAN.
- El port `8080` només escolta a `127.0.0.1` — cap dispositiu extern hi pot accedir.
- La xarxa `lab-net` és Docker bridge sense sortida — la víctima no pot accedir a Internet.
- Si cal accés remot, usar túnel SSH per Tailscale — mai obrir ports al router.

## 14. Automatització amb Hermes

Hermes pot:

- Arrencar/aturar DVWA per SSH.
- Crear el túnel SSH per accedir des del Mac.
- Executar eines ofensives (nmap, nikto) contra DVWA.
- Documentar resultats al repo cyberlab-ai.

## 15. Resum

- DVWA és la primera aplicació vulnerable del CyberLab.
- Corre en contenidor Docker a `127.0.0.1:8080`, aïllada a `10.10.30.0/24`.
- S'accedeix des del Mac via túnel SSH per Tailscale.
- Nivells Low → Medium → High → Impossible per apendre progressivament.

---

## Exercicis associats

- [EX-08-01] — Escaneig bàsic amb nmap contra DVWA
- [EX-08-02] — SQL injection a DVWA (nivell Low)
- [EX-08-03] — XSS reflectit a DVWA (nivell Low)

## Referències

- [DVWA — GitHub](https://github.com/digininja/DVWA)
- [CAP-05-10](cap-05-10-docker.md) — Docker
- [CAP-08-20](cap-08-20-kali-linux.md) — Kali Linux
- [ADR-0004](../../ADR/0004-segmentacio-xarxa.md) — Segmentació de xarxa
