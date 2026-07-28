# Tailscale — configuració d'exemple (plantilla pública)

> ⚠️ Aquest fitxer és una **plantilla pública** amb placeholders.
> La teva configuració real viu a `BernatCyberLab/_local/tailscale/local.md` (no versionat).

## Dispositius al tailnet

| Nom | Tipus | FQDN | Rol |
|---|---|---|---|
| `cyber-host` | Windows 11 | `cyber-host.tailnet` | Host VMs |
| `cyber-brain` | macOS 12 | `cyber-brain.tailnet` | Cervell serveis |
| `cyber-pi` | Linux ARM | `cyber-pi.tailnet` | DNS / monitor |
| `cyber-control` | macOS 26 | `cyber-control.tailnet` | Consola |
| `cyber-mobile` | iOS | `cyber-mobile.tailnet` | Mòbil |

## Subnet Router

Si vols accedir a la xarxa domèstica des del tailnet **sense exposar cap port**, configura la Raspberry Pi com a Subnet Router.

```bash
# A la RPi (placeholder, no executar tal qual):
sudo tailscale up \
  --advertise-routes=<LAN_SUBNET>/24 \
  --accept-routes \
  --hostname=cyber-pi
```

Aleshores, a la consola de Tailscale, aprova la ruta anunciada.

**⚠️ Avís:** activar-ho vol dir que qualsevol node del tailnet podrà accedir a la xarxa domèstica. Activa-ho només si ho necessites i combina'l amb ACL estrictes.

## ACL (exemple)

```jsonc
// tailscale-acl.example.hujson
{
  "acls": [
    // cyber-mobile pot accedir a consoles
    {
      "action": "accept",
      "src": ["tag:mobile"],
      "dst": ["tag:console:22", "tag:console:443", "tag:console:3389"]
    },
    // cyber-control (admin) pot accedir a tot arrede gestio
    {
      "action": "accept",
      "src": ["tag:admin"],
      "dst": ["tag:gestio:*"]
    },
    // Xarxes de laboratori 10.10.x no son accessibles des del tailnet
    {
      "action": "deny",
      "src": ["*"],
      "dst": ["10.10.20.0/24:*", "10.10.30.0/24:*", "10.10.40.0/24:*"]
    }
  ],
  "tagOwners": {
    "tag:admin":    ["autogroup:admin"],
    "tag:mobile":   ["autogroup:admin"],
    "tag:console":  ["autogroup:admin"],
    "tag:gestio":   ["autogroup:admin"]
  }
}
```

## Bones pràctiques

- **MFA activat** al compte de Tailscale (obligatori).
- **Auth keys** per afegir nous dispositius amb caducitat curta.
- **Re-auth** periòdic (cada 90 dies).
- **Tagging** dels dispositius per fer ACL netes.
- **MagicDNS** activat (per defecte).
- **HTTPS** activat a Tailscale.
- **No exposar** la xarxa de laboratori al tailnet.

## On va la configuració real

| Què | On |
|---|---|
| Auth key de Tailscale | KeePassXC + `secrets-templates/tailscale.authkey.example` |
| ACL JSON real | `BernatCyberLab/_local/tailscale/acl.local.hujson` |
| Subnet routes aprovades | Consola web de Tailscale (un sol lloc) |
| Llista de dispositius | Consola web de Tailscale (font única de veritat) |
