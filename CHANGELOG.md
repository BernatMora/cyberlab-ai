# Changelog del Bernat CyberLab AI

Tots els canvis notables al projecte es documenten aquí.
Adoptem el format de [Keep a Changelog](https://keepachangelog.com/) i
[Semantic Versioning](https://semver.org/).

## [Unreleased]

### Canviat
- Arquitectura consolidada: Windows 11 Pro és el host de `cyber-host`, Hyper-V és l'hipervisor i Kali funciona com a VM d'atac.
- Separació explícita entre documentació preparada i fases validades sobre maquinari real.
- Validació automàtica de qualitat, scripts i patrons de secrets.

### Corregit
- Eliminada la contradicció entre Kali natiu i Hyper-V.
- Eliminada la secció duplicada de `v0.0-bootstrap`.

### Afegit
- **Integració del material antic de lab-seguretat** al llibre:
  - ADR-0001 i ADR-0002 revisats amb el context hort/casa real.
  - Nou `CAP-01-60-ubicacions-i-desplegaments.md` (published) — explica els 2 escenaris (hort amb Parlem 5G/CGNAT i casa) i el rol de cada equip.
  - `ANN-05-xuleta-comandes.md` (published) — annex de comandes basat en el `xuleta-comandes.md` antic, adaptat al CyberLab.
  - `ANN-07-historia-del-projecte.md` (published) — cronologia, decisions, lliçons apreses.
  - `scripts/cheatsheet/build-pdf.sh` — script que genera el PDF de la xuleta des del .md.
  - `book/appendices/ann-05-xuleta-comandes.pdf` — PDF generat (3 pàgines).
- **Decisió important**: la RPi del projecte hort-osona queda **fora** del CyberLab. Si volem `cyber-pi`, l'adquirim nova.
- **Validació YAML**: 57 fitxers amb frontmatter vàlid, 0 errors.

## [v0.1-book-skeleton] - 2026-07-28

### Afegit
- **Llibre Viu del Bernat CyberLab**: nova carpeta `book/` amb estructura completa.
  - `book/README.md` (guia editorial), `book/SUMMARY.md` (índex mestre), `book/LICENSE` (CC BY-SA 4.0).
  - 7 plantilles: `cap-XX-YY.md`, `ex-XX-YY.md`, `lab-XX-YY.md`, `adr-XXX.md`, `trb-XX-YY.md`, `chk-XX-YY.md`, `ann-XX.md`.
  - Bloc introductori complet (CAP-00-10 a CAP-00-50): Pròleg, Filosofia, Objectius, Com llegir, Ètica.
  - 38 capítols d'esquelet (CAP-01 a CAP-09) amb metadades YAML vàlides.
  - 4 annexos (glossari, comandes, referències, changelog del llibre).
  - Sistema de codis permanents (CAP-XX-YY, EX-XX-YY, LAB-XX-YY, ADR-XXX, TRB-XX-YY, CHK-XX-YY, ANN-XX) amb salts de 10.
  - Tots els fitxers amb metadades YAML validades (54 fitxers OK, 0 errors).

## [v0.0.1] - 2026-07-28

### Afegit
- CODEOWNERS i plantilles d'issues/PR al `.github/`.
- Branca `main` protegida (PR required, no force-push).

## [v0.0-bootstrap] - 2026-07-28

### Afegit
- Estructura inicial del projecte (bootstrap).
- README, dues llicències, CONTRIBUTING, .gitignore estricte.
- ADR inicials (0001-0005).
- Plantilles `.example` per a xarxa, docker, VMs, hermes, secrets.
- Scripts d'auditoria (Windows, macOS, RPi).
- Documentació de la Fase 0 (auditoria).

[Unreleased]: https://github.com/BernatMora/cyberlab-ai/compare/v0.0-bootstrap...HEAD
[v0.0-bootstrap]: https://github.com/BernatMora/cyberlab-ai/releases/tag/v0.0-bootstrap
