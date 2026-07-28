# Regles de firewall (plantilla pública)

> Les IPs reals del teu entorn viuen a `BernatCyberLab/_local/firewall/local.md` (no versionat).

## Windows Firewall (cyber-host)

```powershell
# EXEMPLE — no executar tal qual
# Regla per permetre SSH des de xarxes internes de laboratori
New-NetFirewallRule -DisplayName "SSH - Lab mgmt" `
  -Direction Inbound -Protocol TCP -LocalPort 22 `
  -RemoteAddress 10.10.10.0/24 -Action Allow -Profile Private

# Regla per permetre RDP des de cyber-control
New-NetFirewallRule -DisplayName "RDP - cyber-control" `
  -Direction Inbound -Protocol TCP -LocalPort 3389 `
  -RemoteAddress <CYBER_CONTROL_IP> -Action Allow -Profile Private

# Regla per permetre gestió Hyper-V des de cyber-control
New-NetFirewallRule -DisplayName "Hyper-V WMI - cyber-control" `
  -Direction Inbound -Protocol TCP -LocalPort 5985,5986 `
  -RemoteAddress <CYBER_CONTROL_IP> -Action Allow -Profile Private
```

## macOS pf (cyber-brain)

```bash
# EXEMPLE — no executar tal qual
# Permetre SSH des del tailnet
echo "pass in proto tcp from 100.64.0.0/10 to any port 22" | sudo pfctl -ef -

# Permetre API Hermes des del tailnet
echo "pass in proto tcp from 100.64.0.0/10 to any port 8000" | sudo pfctl -ef -
```

## Raspberry Pi (cyber-pi)

```bash
# EXEMPLE — no executar tal qual
# AdGuard Home (DNS) i Uptime Kuma només accessibles des de tailnet
sudo ufw allow from 100.64.0.0/10 to any port 53
sudo ufw allow from 100.64.0.0/10 to any port 3000,3001
sudo ufw default deny incoming
sudo ufw enable
```

## Hyper-V vSwitch

La segmentació de xarxa es fa principalment via vSwitch, **no** via firewall.
Els 3 tipus de vSwitch i la seva capacitat d'aïllament:

| Tipus | Host ↔ VMs | VMs ↔ VMs | VMs ↔ LAN externa |
|---|---|---|---|
| **Private** | ❌ | ✅ | ❌ |
| **Internal** | ✅ | ✅ | ❌ |
| **External** | ✅ | ✅ | ✅ |

Assignació prevista:

| Xarxa | Tipus vSwitch | Per què |
|---|---|---|
| Gestió de VMs | Internal | Permet Host ↔ VMs per SSH, no exposa la LAN |
| Ofensiva | Internal | Kali aïllat però amb sortida per actualitzar eines |
| Víctimes | **Private** | Totalment aïllada, sense Gateway |
| Defensa | Internal | SIEM amb accés limitat a xarxa de gestió |
