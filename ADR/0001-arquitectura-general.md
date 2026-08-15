# ADR-0001 — Arquitectura general del CyberLab

- **Estat:** acceptada (revisada 2026-08-04)
- **Data original:** 2026-07-28
- **Última revisió:** 2026-08-04
- **Decisors:** Bernat Mora + Hermes Agent
- **Tags:** arquitectura, visio-global

## Context i problema

L'objectiu és construir un laboratori personal de ciberseguretat que sigui **modular, escalable, documentat, segur i fàcil de mantenir**, sobre el maquinari ja disponible, amb dues ubicacions principals (hort i casa) unides per Tailscale a través d'Internet. Cap dispositiu ha d'assumir més responsabilitats de les que pot dur de forma sostenible 24/7.

## Consideracions

- El **PC de l'hort** (HP Z1 G9 Tower, 32 GB RAM) és la màquina més potent — bona candidata per allotjar el cor del laboratori (Windows 11 Pro, Hyper-V i màquines virtuals).
- El **Mac vell de l'hort** (macOS 12.7.6) pot estar sempre connectat a l'hort — bona candidata per a serveis complementaris (Tailscale, scripts d'automatització, terminals d'accés).
- El **Mac potent de casa** és el centre de control natural: des d'on es fan les pràctiques, es gestionen les eines, s'analitzen resultats.
- El **MacBook Air** de casa queda com a **consola humana diària** (VS Code, navegador, SSH cap al lab).
- La **Raspberry Pi del projecte hort-osona** queda **fora d'aquest projecte** — pertany al sistema de sensors del hort. Si volem un `cyber-pi`, l'adquirim nova.
- L'**iPhone** és un terminal mòbil.
- L'accés remot a l'hort passa per **Parlem 5G**, amb **CGNAT actiu** — fet que descarta port forwarding directe i fa de **Tailscale** l'única via còmoda.

## Opcions considerades

### Opció A — Tot al PC de l'hort (un sol servidor)
- Pros: simplicitat, una sola màquina potent.
- Contres: punt únic de fallada; difícil accedir-hi des de casa a través de CGNAT; l'iPhone queda exclòs.

### Opció B — Distribució per responsabilitat amb 2 ubicacions (escollida)
- Pros: cada m té un rol clar; failovers aïllats; replicable; Tailscale uneix tot; el Mac potent de casa és un centre de control natural.
- Contres: més complexitat de xarxa; cal gestionar la latència entre ubicacions; cal suportar el cas "el router Parlem cau".

### Opció C — Tot al cloud
- Pros: cap dependència del maquinari local.
- Contres: costos, latència, pràctiques ofensives al cloud són delicades; perd el sentit del projecte.

## Decisió

**Opció B — distribució per responsabilitat en 2 ubicacions:**

**Ubicació HORT** (sota Parlem 5G, CGNAT):

- `cyber-host` (PC HP Z1 G9, 32 GB) → host principal amb **Windows 11 Pro**. Hyper-V allotja Kali, Ubuntu i víctimes aïllades; WSL2/Docker Desktop allotja eines i aplicacions quan sigui adequat.
- `cyber-helper` (MacBook Pro 13" vell, macOS 12.7.6) → serveis complementaris a l'hort: Tailscale, scripts de monitoratge, terminal secundari.

**Ubicació CASA**:

- `cyber-brain` (Mac potent de casa) → centre de control: VS Code, scripts d'anàlisi, eines de documentació, Hermes Agent (en una fase posterior).
- `cyber-control` (MacBook Air) → consola diària lleugera.
- `cyber-mobile` (iPhone) → consola mòbil.

**Ubicació PER DEFINIR**:

- `cyber-pi` → infraestructura lleugera (AdGuard Home, Uptime Kuma, ntfy, watchdog). Decidirem a Fase 1 si és una RPi nova, un contenidor Docker al PC de l'hort o una altra cosa.

**Xarxa comuna**: **Tailscale tailnet** que uneix tot. Cap port obert al router de l'hort ni al de casa. Les xarxes internes del laboratori (10.10.x) no es publiquen al tailnet per defecte.

## Conseqüències

### Positives

- Cada m pot fallar sense arrossegar la resta.
- El PC Windows de l'hort disposa de 32 GB de RAM per repartir entre Hyper-V, Kali i les altres màquines virtuals.
- Des del Mac potent de casa tenim latència acceptable (~50 ms) al lab de l'hort via Tailscale.
- Si Parlem cau, podem continuar treballant localment a casa.

### Negatives

- Tailscale és un punt únic d'accés remot (risc parcial; mitigat amb autenticació multifactor).
- El Mac vell de l'hort degradarà la bateria si està sempre endollat → cal gestionar càrrega.
- El PC de l'hort ha d'estar sempre encès → consum elèctric + configuració de Wake-on-LAN.

### Riscos acceptats

- **CGNAT de Parlem** impedeix port forwarding directe → Tailscale és l'única via. Acceptat perquè és la millor solució real.
- Latència hort ↔ casa via Tailscale (~50 ms) → acceptable per SSH, terminal, eines web; potser no òptim per eines gràfiques intensives.
- Possible desconnexió del router Parlem → cal un script a la RPi (quan existeixi) que enviï alertes via ntfy quan perd connectivitat.

## Validació

- Cadascun dels 5 equips pot fer ping a la resta via Tailscale.
- Cada dispositiu té el seu nom al tailnet i resol per MagicDNS.
- Les xarxes de laboratori (10.10.x) no són visibles des del tailnet.
- Kali i una víctima poden comunicar-se en un vSwitch privat, però la víctima no pot accedir a Internet, a la LAN ni al tailnet.
- El Mac potent de casa pot obrir una sessió SSH al PC de l'hort via Tailscale en <100 ms.
- L'iPhone pot fer SSH al PC de l'hort via Tailscale amb xifrat WireGuard.

## Referències

- `docs/00-pla-director.md` — Pla Director complet
- [`../book/chapters/cap-01-10-arquitectura-general.md`](../book/chapters/cap-01-10-arquitectura-general.md) — capítol equivalent al llibre
- [`../book/chapters/cap-01-60-ubicacions-i-desplegaments.md`](../book/chapters/cap-01-60-ubicacions-i-desplegaments.md) — escenaris de desplegament
- `ADR/0002-rolls-per-equip.md` — decisió de rols
- `ADR/0004-segmentacio-xarxa.md` — segmentació de xarxa