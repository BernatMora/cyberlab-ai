# ADR-0005 — Gestió de secrets

- **Estat:** acceptada
- **Data:** 2026-07-28
- **Decisors:** Bernat Mora + Hermes
- **Tags:** secrets, seguretat, bones-practiques

## Context i problema

El repo és públic. Hem d'evitar que pugi cap secret (contrasenya, token, clau API, clau SSH privada) i, alhora, hem de poder usar aquests secrets des dels serveis automatitzats del laboratori.

## Consideracions

- KeePassXC: base de dades local xifrada (AES-256 + Argon2), portable, gratuït, fàcil de usar.
- `age`: eina moderna de xifratge de fitxers (sucessora de GPG per a molts casos).
- Variables d'entorn: clàssic, però cal un mecanisme segur per injectar-les.
- GitHub Secret Scanning: ja activat en crear el repo.
- Tailscle tailnet: les API keys de Tailscale tenen la seva pròpia gestió (`tailscale up --authkey`).

## Opcions considerades

### A — Tot a KeePassXC + plantilles `.example` al Git
- Pros: simple, audit fàcil, res al repo.
- Contres: alguns serveis necessiten el secret en text pla en arrencar.

### B — KeePassXC + `.env` xifrats amb `age` (escollida)
- Pros: els serveis poden arrencar sols desxifrant al vol; res al repo.
- Contres: caldrà un petit orquestrador per desxifrar (script).

### C — Bitwarden / Vault / etc. (cloud)
- Pros: sincronitzat, accesible des de qualsevol lloc.
- Contres: depèn d'un tercer; en cas de caiguda, el laboratori no arrenca.

## Decisió

**Opció B — KeePassXC + `.env` xifrats amb `age`.**

- KeePassXC: BD única amb totes les contrasenyes. S'obre al PC quan es treballa.
- `.env` xifrats amb `age`: cada servei té un `service.env.age` al costat del seu `docker-compose.yml`; un script `decrypt-env.sh` el desxifra a `service.env` en memòria.
- Tots els `docker-compose.yml` i scripts tenen el seu company `*.example` al Git.

## Conseqüències

- Cal recordar la passphrase del KeePassXC (o guardar-la a un lloc segur fora del PC — paper, per exemple).
- Cal recordar la clau `age` (també fora del PC).
- Si obrim el repo a una màquina nova, cal instal·lar KeePassXC i rebre la BD per canal segur.

## Validació (Fase 1-2)

- KeePassXC instal·lat al PC.
- Script `decrypt-env.sh` provat amb un secret fals.
- Cap fitxer `.env` real és rastrejable amb `git log --all --full-history -- .env` o similar.

## Referències

- `CONTRIBUTING.md` — política de secrets
- `secrets-templates/README.md` — ús dels `.env.example`
- `docs/00-pla-director.md` § 10
