# El Llibre Viu del Bernat CyberLab

> Manual tècnic, memòria viva i llibre d'estudi del laboratori personal de
> ciberseguretat de Bernat Mora.

Aquest llibre no és una documentació tècnica convencional. És el registre
complet, viu i en evolució del projecte Bernat CyberLab AI: explica què és,
per què existeix, com es construeix i què s'ha après durant el procés.

Està pensat perquè **d'aquí a uns anys** qualsevol persona amb coneixements
tècnics pugui reconstruir completament el laboratori només llegint-lo.

## Llicència

Aquest llibre està publicat sota la llicència **CC BY-SA 4.0**. Es permet
copiar-lo, compartir-lo i adaptar-lo, fins i tot comercialment, sempre que
es reconegui l'autoria i les obres derivades es publiquin sota la mateixa
llicència.

El **codi i els scripts** del repositori continuen sota llicència MIT
(véure `LICENSE-CODE` a l'arrel del repo).

## Filosofia editorial

Cada capítol segueix una estructura comuna de 15 seccions (introdueix,
justifica, instal·la, configura, verifica, resol, etc.) i **referencia els
altres capítols** per formar una xarxa de coneixement. Veure
[`templates/cap-XX-YY.md`](templates/cap-XX-YY.md).

Mai no assumim coneixements previs: expliquem primer el **què** i el **per
què** d'una tecnologia, i només després el **com** l'apliquem al CyberLab.

## Sistema de codis permanents

Tot el contingut del llibre té un **codi únic i permanent** que no es
reutilitza ni es modifica encara que el títol canviï. Format:

| Tipus | Format | Exemple |
|---|---|---|
| Capítol | `CAP-XX-YY` | `CAP-03-20` (Subxarxes i segmentació) |
| Exercici | `EX-XX-YY` | `EX-08-10` (Primera inspecció de DVWA) |
| Laboratori pràctic | `LAB-XX-YY` | `LAB-15-10` (Laboratori web bàsic) |
| Decisió d'arquitectura | `ADR-XXX` | `ADR-007` (Adoptem Hyper-V) |
| Resolució de problemes | `TRB-XX-YY` | `TRB-18-10` (Docker no arrenca a Windows) |
| Checklist | `CHK-XX-YY` | `CHK-02-10` (Auditoria de maquinari) |
| Annex | `ANN-XX` | `ANN-01` (Glossari) |

S'utilitzen **salts de 10** entre capítols per poder intercalar-ne de nous
sense renumerar tot el llibre.

Cada fitxer comença amb **metadades YAML** (id, title, status, version,
created, updated, authors, tags, prerequisites, related). El codi (`id`)
és la identitat permanent; el títol pot canviar.

### Estats possibles

- `idea` — només una idea, sense estructura.
- `outline` — esquema bàsic, falten seccions.
- `draft` — esborrany en curs.
- `review` — pendent de revisió final.
- `published` — publicat i validat.
- `deprecated` — substituït per un altre capítol (mantenir amb redirect).

## Estructura

```
book/
├── README.md                   ← guia editorial (aquest fitxer)
├── SUMMARY.md                  ← índex mestre del llibre
├── LICENSE                     ← CC BY-SA 4.0
│
├── chapters/                   ← capítols principals
│   ├── cap-00-10-proleg.md
│   ├── cap-00-20-filosofia.md
│   └── ...
│
├── exercises/                  ← exercicis curts associats als capítols
├── labs/                       ← laboratoris pràctics complets
├── assets/                     ← imatges, diagrames, taules
│   ├── diagrams/
│   ├── screenshots/
│   └── tables/
│
├── appendices/                 ← glossari, comandes, checklists, referències
│
└── templates/                  ← plantilles per a nous capítols
    ├── cap-XX-YY.md
    ├── ex-XX-YY.md
    ├── lab-XX-YY.md
    ├── adr-XXX.md
    ├── trb-XX-YY.md
    ├── chk-XX-YY.md
    └── ann-XX.md
```

## Com contribuir

Per afegir un capítol nou:

1. Tria un `id` lliure respectant els salts de 10.
2. Copia la plantilla corresponent (`templates/cap-XX-YY.md`).
3. Omple les **metadades YAML** (sobretot `id`, `title`, `status: draft`).
4. Escriu el contingut seguint les 15 seccions.
5. Afegeix el capítol al `SUMMARY.md`.
6. Referència els capítols relacionats a `related:` (i vice-versa).
7. Obre un PR amb el patró `book/cap-XX-YY: descripció curta`.

## Política de secrets

Igual que la resta del repo:

- ❌ Mai cap IP real, MAC, contrasenya, token ni clau al llibre.
- ✅ Sempre placeholders (`<CYBER_HOST_IP>`, `<TAILSCALE_AUTHKEY>`).
- ✅ Exemples amb valors ficticis (10.10.x.x, `cyber-host.tailnet`).
- ✅ Configuracions reals a `BernatCyberLab/_local/` (no versionat).

Veure [`../CONTRIBUTING.md`](../CONTRIBUTING.md) per a la política completa.

## Evolució

Aquest llibre **mai es considerarà acabat**. Quan canviem una configuració,
afegim una màquina, instal·lem una eina o millorem una automatització,
també cal actualitzar el capítol corresponent.

La documentació i el laboratori han d'estar **sempre sincronitzats**.

---

[Comença pel Pròleg →](chapters/cap-00-10-proleg.md)