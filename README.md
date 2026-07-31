# Bernat CyberLab AI

> Laboratori personal de ciberseguretat, modular, documentat, accessible remotament via Tailscale.
> Totes les pràctiques ofensives es limiten exclusivament a dispositius, VMs, contenidors i serveis propis.

[![Repo](https://img.shields.io/badge/repo-BernatMora%2Fcyberlab--ai-181717?logo=github)](https://github.com/BernatMora/cyberlab-ai)
[![Status](https://img.shields.io/badge/status-bootstrap-blue)](#estat-del-projecte)
[![License Docs](https://img.shields.io/badge/docs-CC%20BY--SA%204.0-lightgrey)](LICENSE-DOCS)
[![License Code](https://img.shields.io/badge/code-MIT-green)](LICENSE-CODE)

## Visió

Convertir un conjunt heterogeni de màquines personals (PC Windows, dos MacBook, Raspberry Pi 4, iPhone) en un **laboratori de ciberseguretat privat, segur, documentat i evolutiu**, gestionat per [Hermes Agent](https://hermes-agent.nousresearch.com/docs) com a arquitecte, administrador i mentor.

L'objectiu no és només instal·lar eines, sinó construir una **plataforma estable, escalable i ben documentada** que pugui créixer durant anys.

## Filosofia

- **Modular** — cada component té una responsabilitat clara i pot substituir-se.
- **Escalable** — afegir una nova VM, contenidor o eina ha de ser trivial i documentat.
- **Documentat** — cada decisió tècnica té una justificació escrita (ADR) i un procediment pas a pas (runbook).
- **Automatitzat** — les tasques repetibles són scripts, no clics manuals.
- **Segur** — el laboratori no és un joc; s'aplica el principi de mínim privilegi, xifratge, aïllament de xarxa i autenticació multifactor.
- **Fàcil de mantenir** — un altre tu (o un col·laborador) ha de poder reprendre el projecte en 6 mesos només llegint la documentació.

## Arquitectura en una mirada

| Dispositiu | Ubicació | Nom al tailnet | Rol |
|---|---|---|---|
| PC HP Z1 G9 Tower (32 GB) | **Hort** | `cyber-host` | Host principal: Kali Linux natiu + hipervisor per a màquines virtuals |
| MacBook Pro 13" vell | **Hort** | `cyber-helper` | Serveis complementaris a l'hort: Tailscale, scripts, monitoratge |
| Mac potent | **Casa** | `cyber-brain` | Centre de control: VS Code, scripts, eines, futura Ollama |
| MacBook Air 13" | **Casa** | `cyber-control` | Consola diària lleugera (sense serveis permanents) |
| iPhone 17 | **Casa / mòbil** | `cyber-mobile` | Consola mòbil d'emergència i consulta |
| (futura) RPi `cyber-pi` | Per decidir | `cyber-pi` | Infraestructura lleugera (AdGuard Home, Uptime Kuma, ntfy) |

**Nota**: la RPi del projecte hort-osona queda **fora** d'aquest projecte.

Tots els equips units per **Tailscale** (xarxa mesh WireGuard sobre Parlem 5G/CGNAT).
Detalls complets a [`docs/00-pla-director.md`](docs/00-pla-director.md),
[`book/chapters/cap-01-60-ubicacions-i-desplegaments.md`](book/chapters/cap-01-60-ubicacions-i-desplegaments.md)
i els ADR [`ADR/0001-arquitectura-general.md`](ADR/0001-arquitectura-general.md).

## Llicència

Llevat que s'indiqui el contrari:

- El **codi, scripts, Docker Compose i automatitzacions** es publiquen sota [MIT](LICENSE-CODE).
- La **documentació, esquemes, tutorials i exercicis** es publiquen sota [CC BY-SA 4.0](LICENSE-DOCS).

Els fitxers de tercers conserven la seva llicència original.

## Política de secrets

Aquest repositori és **públic**. Per tant:

- Mai no s'hi inclouen contrasenyes, tokens, claus API, claus SSH privades, cookies, credencials, números de sèrie, IPs públiques reals ni configuracions que permetin accés directe.
- Tots els fitxers de configuració al repo són **plantilles `.example`** amb placeholders (`<CYBER_HOST_IP>`, `<TAILNET_API_KEY>`, etc.).
- Els valors reals viuen a `BernatCyberLab/_local/` (al PC, fora de Git) o dins un **KeePassXC** / magatzem xifrat amb [`age`](https://github.com/FiloSottile/age).
- `.gitignore` estricte, `git-secrets` recomanat, i **secret scanning** activat a GitHub.

Més detalls a [`CONTRIBUTING.md`](CONTRIBUTING.md).

## Estat del projecte

Fase actual: **Fase 0 — Auditoria de maquinari** (pendent).

```
[ ] Fase 0  Auditoria de maquinari
[ ] Fase 1  Tailscale i accés remot
[ ] Fase 2  Servidor Hermes (cyber-brain)
[ ] Fase 3  Virtualització al PC (Hyper-V)
[ ] Fase 4  Primer laboratori web (DVWA / Juice Shop)
[ ] Fase 5  Automatització amb Hermes
[ ] Fase 6  Monitorització
[ ] Fase 7  Laboratoris Windows
[ ] Fase 8  Active Directory (aïllat)
[ ] Fase 9  SIEM i defensa
```

Roadmap complet: [`docs/00-pla-director.md`](docs/00-pla-director.md) § 18.

## Estrutura del repositori

```
BernatCyberLab/
├── README.md                        ← aquest fitxer
├── LICENSE-CODE / LICENSE-DOCS      ← llicència doble
├── CONTRIBUTING.md                  ← política de secrets + flux Git
├── .gitignore  /  .gitattributes    ← normals + binaris protegits
│
├── ADR/                             ← Architecture Decision Records
├── architecture/                    ← diagrames i convencions
├── inventory/                       ← plantilles d'inventari
│
├── docs/                            ← documentació per fase
│   ├── 00-pla-director.md
│   ├── 10-fase-0-auditoria/
│   ├── 11-fase-1-tailscale/
│   └── ...
│
├── book/                            ← Llibre Viu del CyberLab
│   ├── README.md                    ← guia editorial
│   ├── SUMMARY.md                   ← índex mestre
│   ├── chapters/                    ← capítols (CAP-XX-YY)
│   ├── exercises/  labs/            ← exercicis i laboratoris
│   ├── assets/                      ← imatges, diagrames
│   ├── appendices/                  ← ANN-XX (glossari, comandes, ...)
│   └── templates/                   ← plantilles per a nous continguts
│
├── network/                         ← esquemes, ACL, firewall (.example)
├── docker/                          ← Compose per a apps vulnerables
├── virtual-machines/                ← fitxes de cada VM
├── hermes/                          ← govern del laboratori per Hermes
│   ├── automations/
│   └── missions/
│
├── knowledge-base/                  ← writeups, errors, snippets
├── scripts/                         ← audit, backup, monitoring
├── exercises/                       ← plantilles d'exercicis
├── reports/                         ← informes per fase
│
├── secrets-templates/               ← plantilles .example de secrets
├── captures/                        ← .gitkeep — captures de xarxa
├── backups/                         ← .gitkeep — backups fora del Git
│
└── _local/                          ← MAI al Git — valors reals del teu entorn
```

## El Llibre Viu

A més de la documentació del laboratori (`docs/`), el projecte inclou un
**llibre tècnic viu** a [`book/`](book/) — la memòria completa del
projecte, amb filosofia, decisions, instal·lacions, configuracions,
exercicis i conclusions. Veure [`book/README.md`](book/README.md) per a la
guia editorial i [`book/SUMMARY.md`](book/SUMMARY.md) per a l'índex.

## Com començar

1. Llegeix el [`docs/00-pla-director.md`](docs/00-pla-director.md) sencer.
2. Fes una còpia local: `git clone https://github.com/BernatMora/cyberlab-ai.git` (a qualsevol dels teus equips).
2. Executa les ordres d'auditoria de la Fase 0 — totes organitzades i llestes per copiar-enganxar a [`docs/10-fase-0-auditoria/ordinances.md`](docs/10-fase-0-auditoria/ordinances.md).
3. Comparteix-me el resum anonimitzat amb la plantilla que trobaràs al final d'aquell fitxer.
4. Confirmo la fase 0 → comencem la fase 1 (Tailscale).

## Crèdits

- Arquitectura, planificació i documentació: **Bernat Mora** + **Hermes Agent**.
- Eines de tercers: veure [`docs/03-reconeixements.md`](docs/03-reconeixements.md) (en construcció).
