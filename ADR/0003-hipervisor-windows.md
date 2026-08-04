# ADR-0003 — Hipervisor al PC Windows

- **Estat:** acceptada (pendent validació a Fase 3)
- **Data:** 2026-07-28\n- **Última revisió:** 2026-08-04
- **Decisors:** Bernat Mora + Hermes
- **Tags:** virtualitzacio, hipervisor, windows

## Context i problema

Necessitem un hipervisor al PC Windows 11 per allotjar Kali, Ubuntu Server, Windows de laboratori i, més endavant, un Active Directory aïllat. La decisió afecta rendiment, compatibilitat amb Docker, facilitat de xarxes virtuals i capacitat de continuar usant Windows 11 amb normalitat.

## Opcions considerades

### Hyper-V (Windows 11 Pro)
- Pros: natiu, gratuït, integrat amb WSL2/Docker Desktop, snapshots potents, vSwitch per a xarxes.
- Contres: tipus de switch una mica confús al principi (External / Internal / Private); cal Windows Pro.

### VMware Workstation Pro
- Pros: networking molt flexible, snapshots, compatibilitat àmplia.
- Contres: de pagament des de la versió Pro (gratuït només per a ús personal); coexistència amb Hyper-V complicada.

### VirtualBox
- Pros: gratuït, multiplataforma, networking fàcil.
- Contres: rendiment inferior; alguns problemes amb Windows 11; no integra bé amb WSL2.

### Proxmox com a host directe
- Pros: molt potent, web UI.
- Contres: obliga a esborrar Windows 11 o fer dual boot — trenca la filosofia "no convertir el PC en servidor dedicat immediatament".

### WSL2 sol
- Pros: integrat, ràpid.
- Contres: NO és un hipervisor de VMs completes — no serveix per a Kali ni per a AD.

## Decisió

**Windows 11 Pro** es manté com a sistema host i **Hyper-V** és l'únic hipervisor principal. Kali Linux funciona com a màquina virtual d'atac. VirtualBox només es considerarà després d'una revisió explícita de l'ADR; no s'instal·laran dos hipervisors competidors per defecte.

Justificació:
- És gratuït i ja ve amb Windows 11 Pro.
- Permet conviure amb WSL2 + Docker Desktop (compartint el backend de virtualització).
- Té `vSwitch` natiu per crear les xarxes aïllades 10.10.x.
- No obliga a esborrar res.

## Conseqüències

- Cal Windows 11 **Pro** (la Home no porta Hyper-V complet). Si tens Home, cal actualitzar o usar VirtualBox.
- WSL2, Docker Desktop i Hyper-V comparteixen la plataforma de virtualització; cal validar-ne la convivència i els límits de memòria.\n- Les víctimes s'han de connectar a un vSwitch **Private** sense gateway. Kali pot usar dues interfícies només quan la pràctica ho requereixi: gestió controlada i xarxa privada de laboratori.
- Snapshots de VMs en fitxers `.vhdx` al disc del PC (cal preveure espai).

## Validació (Fase 3)

- Hyper-V activat.
- Kali i Ubuntu Server creats, connectats a un vSwitch intern.
- Prova: Kali pot fer ping a Ubuntu però **no** a la xarxa domèstica.
- Docker Desktop funciona dins WSL2 simultàniament.

## Referències

- `docs/00-pla-director.md` § 6
- `virtual-machines/` — fitxes de cada VM (es crearan a Fase 3)
