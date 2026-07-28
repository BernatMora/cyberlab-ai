# ADR-0004 — Segmentació de xarxa

- **Estat:** acceptada
- **Data:** 2026-07-28
- **Decisors:** Bernat Mora + Hermes
- **Tags:** xarxa, segmentacio, aillament

## Context i problema

Volem segmentar la xarxa perquè una màquina vulnerable no pugui:
1. Exposar-se a Internet.
2. Trepitjar la xarxa domèstica amb els nostres equips personals.
3. Interferir amb la monitorització.

## Consideracions

- Hyper-V permet `vSwitch` de tipus External, Internal i Private.
- Una xarxa **Private** al Hyper-V no té sortida — útil per a illes totalment aïllades.
- Una xarxa **Internal** permet comunicació entre VMs i amb el host, però no amb la xarxa externa.
- Una xarxa **External** connecta amb la xarxa física — **mai** s'ha de donar a una VM vulnerable.
- Tailscale no és una xarxa de laboratori — és la xarxa de gestió, independent.

## Decisió

Esquema d'adreces:

| Xarxa | Rang | Propòsit | Tipus Hyper-V | Tailscale visible? |
|---|---|---|---|---|
| Xarxa domèstica | (la que ja tinguis) | Els teus equips personals | (existent) | no directament |
| Gestió de VMs | `10.10.10.0/24` | Host ↔ VMs (accés SSH/administració) | Internal | no |
| Xarxa ofensiva | `10.10.20.0/24` | Kali i eines d'atac | Internal | **no** |
| Xarxa de víctimes | `10.10.30.0/24` | Màquines i apps vulnerables | Private (sense sortida) | **no** |
| Xarxa defensiva | `10.10.40.0/24` | SIEM, sensors, IDS | Internal | no (només per a consultes explícites) |
| Tailscale | `100.64.0.0/10` | Pla de gestió entre equips | n/a | sí |

**Norma:** les xarxes 10.10.20/30/40 **no es publiquen** a Tailscale. Si en algun moment cal accedir-hi des del tailnet, es fa via jump-host a `cyber-host` amb regla explícita.

## Conseqüències

- Màquina víctima queda **sense Gateway** → no pot trucar a casa. Cal configurar manualment si volem que reporti a un sensor.
- Màquina ofensiva pot accedir a víctima (són xarxes internes connectades al host).
- Host pot fer NAT per a la xarxa ofensiva si cal que Kali actualitzi eines — controlat i reversible.

## Validació (Fase 3)

- Kali pot fer ping a Ubuntu a `10.10.10.x` (gestió).
- Màquina víctima (`10.10.30.x`) **no** pot fer ping al router de la LAN.
- Des d'un altre equip de la LAN, **no** es pot fer ping a cap IP `10.10.x`.

## Referències

- `architecture/topologia-xarxa.md` (a crear)
- `docs/00-pla-director.md` § 4
