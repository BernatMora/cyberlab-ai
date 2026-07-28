# Contribuint al Bernat CyberLab AI

Aquest repositori és un laboratori personal d'aprenentatge de ciberseguretat.
Tot i que és un projecte individual, les bones pràctiques hi apliquen igual.

---

## Política d'informació sensible (NO NEGOCIABLE)

Aquest repositori és **públic** i ha de continuar sent-ho. Per tant, **mai** no hi
pugen:

- ❌ Contrasenyes (ni tan sols les de VMs de pràctiques)
- ❌ Tokens (GitHub, Tailscale, Docker Hub, OpenAI, Anthropic, etc.)
- ❌ Claus API
- ❌ Claus SSH privades
- ❌ Cookies / sessions
- ❌ Credencials en general
- ❌ Secrets de Tailscale (`tskey-*`, `tailscale up` amb `--authkey`)
- ❌ Números de sèrie dels equips
- ❌ IPs públiques
- ❌ Dominis personals
- ❌ Dades personals
- ❌ Configuracions reals que permetin accés directe
- ❌ Captures de pantalla amb informació sensible
- ❌ Discos de màquines virtuals (`.vhd`, `.vhdx`, `.qcow2`, `.vdi`, `.vmdk`, `.ova`)
- ❌ PCAPs amb tràfic real
- ❌ Models d'IA grans (`.gguf`, `.bin`, `.safetensors`)

### El que SÍ s'hi posa

- ✅ Plantilles `*.example` amb **placeholders** tipus `<CYBER_HOST_IP>`, `<TAILNET_API_KEY>`, `<USERNAME>`.
- ✅ Adreces IP **fictícies o anonimitzades** a la documentació (p. ex. `10.10.20.0/24` en lloc de la teva xarxa real).
- ✅ Noms **funcionals** de màquines (`kali-01`, `target-web-01`), no noms personals.
- ✅ Documentació, esquemes, ADR, scripts genèrics, writeups, exercicis.
- ✅ Captures de pantalla anonimitzades (si cal posar-ne alguna).

### On van els valors reals

| Tipus | On guardar-ho |
|---|---|
| Contrasenyes, tokens, claus API | **KeePassXC** (BD local xifrada) |
| Configuracions amb valors reals | `BernatCyberLab/_local/` (PC, fora de Git) |
| Secrets de serveis automatitzats | Fitxers `.env` xifrats amb [`age`](https://github.com/FiloSottile/age) o `gpg` |
| Discos de VMs | Discs externs (xifrats amb BitLocker) |
| PCAPs reals | Disc extern, carpeta `captures/` local, no al Git |
| Models d'IA | Carpeta local `~/.ollama/models/` o similar |

---

## Flux de treball amb Git

Adoptem **Git Flow simplificat**:

```
main        ← estable, protegida, només merges des de develop
  │
  └── develop   ← branca d'integració
        │
        ├── feature/*   ← noves funcionalitats
        ├── fix/*       ← correccions
        ├── docs/*      ← canvis documentals significatius
        └── experiment/*← proves (no passen a develop fins que funcionen)
```

### Comandes habituals

```bash
# Començar una funcionalitat nova
git checkout develop
git pull origin develop
git checkout -b feature/nom-curt

# Acabar-la i integrar-la
git add -A
git commit -m "feat: descripció curta"
git push origin feature/nom-curt
# Obre PR des de feature/* cap a develop
# Quan la fase és madura: PR de develop cap a main + tag
```

### Convensió de missatges de commit

Adoptem [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` — funcionalitat nova
- `fix:` — correcció d'error
- `docs:` — canvis només de documentació
- `refactor:` — reescriptura sense canvi funcional
- `test:` — afegir o millorar tests
- `chore:` — manteniment (deps, build, .gitignore)
- `style:` — format, espais, etc.

Exemples:
```
feat(fase-1): afegir configuració Tailscale a la RPi
fix(docker): corregir xarxa de DVWA aïllada
docs(adr): documentar decisió d'hipervisor
```

### Etiquetes (tags) per fase

Cada fase validada porta un tag:

- `v0.0-bootstrap` — estructura inicial creada
- `v0.1-audit` — fase 0 completa
- `v0.2-tailscale` — fase 1 completa
- `v0.3-hermes` — fase 2 completa
- ...

---

## Procés per afegir canvis

1. **Abans de pujar res**, revisa amb:
   ```bash
   git diff --staged
   git status
   ```
2. Comprova que no hi ha cap secret amb:
   ```bash
   # Recomana activar git-secrets o truffleHog al repo (veure més avall)
   ```
3. Escriu el commit amb un missatge clar.
4. Fes push i obre PR si toca.

### Eines recomanades

- [`git-secrets`](https://github.com/awslabs/git-secrets) — bloqueja commits amb patrons de secrets.
- [`trufflehog`](https://github.com/trufflesecurity/trufflehog) — escaneja el repo històricament.
- [`pre-commit`](https://pre-commit.com/) — hooks locals (lint, format, secrets).

---

## Estil de documentació

- Markdown en català (aquest repo és personal i en català; si col·labores, adapta't).
- Títols amb `##` (no `#` dins de subcarpetes per evitar conflictes amb el `README.md`).
- ADR numerats: `0001-titol-curt.md`.
- Adreces IP a la doc pública: placeholders o xarxes fictícies.
- Capçalera recomanada per a fitxers nous:
  ```markdown
  <!--
  Fitxer: ruta/al/fitxer.md
  Última revisió: YYYY-MM-DD
  Estat: esborrany | validat | superat
  -->
  ```

---

## Seguretat

Si trobes informació sensible que NO hauria de ser al repo, **obre un issue
privat** o contacta'm directament. Les comunicacions sobre secrets mai es fan
per canals no xifrats.
