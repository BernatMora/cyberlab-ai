# Plantilla: màquina virtual

> Aquesta és una **plantilla pública**. La fitxa de cada VM real (adreces, MACs, snapshots) viu a `BernatCyberLab/_local/vms/<nom>.local.md` (no versionat).

## Dades generals

- **Nom:** `<vm-name>` (ex. `kali-01`)
- **Hipèrvisor:** Hyper-V / VirtualBox / Proxmox
- **Sistema operatiu:** Kali Linux 2024.x
- **CPU:** 2 vCPU
- **RAM:** 4096 MB
- **Disc:** 60 GB dinàmic
- **Snapshot inicial:** `clean-install-YYYY-MM-DD`

## Xarxes

| Adapter | vSwitch | Adreça IP | Gateway |
|---|---|---|---|
| NIC 1 | mgmt (`10.10.10.0/24`) | `10.10.10.10/24` | `10.10.10.1` |
| NIC 2 | ofensive (`10.10.20.0/24`) | `10.10.20.10/24` | (NAT a través del host, controlat) |

## Credencials

| Usuari | Contrasenya | Notes |
|---|---|---|
| root | (a KeePassXC) | només per a tasques específiques |
| user | (a KeePassXC) | ús diari |

⚠️ Mai no documentis les contrasenyes reals aquí. Utilitza KeePassXC.

## Procediment d'instal·lació

1. Descarregar la ISO oficial de Kali.
2. Crear la VM al hipervisor amb els paràmetres anteriors.
3. Instal·lar amb les opcions per defecte.
4. Actualitzar: `sudo apt update && sudo apt full-upgrade -y`.
5. Instal·lar eines bàsiques: `sudo apt install -y vim git curl wget net-tools`.
6. Configurar `/etc/network/interfaces` o NetworkManager per a les IPs estàtiques.
7. Instal·lar SSH server: `sudo apt install -y openssh-server && sudo systemctl enable ssh`.
8. **Snapshot inicial** anomenat `clean-install-YYYY-MM-DD`.

## Procediment de restauració

1. Aturar la VM.
2. Aplicar el snapshot `clean-install-YYYY-MM-DD`.
3. Tornar a arrencar.

## Notes

- Cada vegada que es modifica alguna cosa important, fer un nou snapshot.
- Els snapshots ocupen espai: netejar els vells regularment.
