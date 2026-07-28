# Hermes — cervell del laboratori

> Hermes Agent no executa ordres administratives directament des del primer dia.
> Comença amb **consulta** i **recomanació**; la capacitat d'**actuar** s'afegeix gradualment.

## Què pot fer Hermes avui

- ✅ Consultar l'estat del laboratori (quins serveis estan engegats).
- ✅ Llegir la documentació i respondre preguntes sobre l'arquitectura.
- ✅ Recomanar la següent fase o el següent exercici.
- ✅ Generar esquemes, ADR i documentació.

## Què podrà fer (per fases)

- 🔜 **Fase 5** — Iniciar/aturar contenidors Docker (amb confirmació).
- 🔜 **Fase 5** — Generar missions i registrar-ne el progrés.
- 🔜 **Fase 6** — Consultar Uptime Kuma i resumir l'estat.
- 🔜 **Fase 9** — Analitzar alertes del SIEM i proposar investigació.

## Què NO hauria de fer mai

- ❌ Esborrar dades sense confirmació humana.
- ❌ Modificar regles de firewall sense confirmació.
- ❌ Exposar serveis a Internet.
- ❌ Executar comandes a les VMs com a root.
- ❌ Accedir a KeePassXC o desxifrar secrets automàticament.
- ❌ Fer proves ofensives contra cap sistema extern.

## Principi de mínim privilegi

Cada eina / script que Hermes governa té un àmbit acotat:

| Component | Permisos | Justificació |
|---|---|---|
| `docker compose up/down` | Només els seus propis contenidors | Evita que un script aturi tot el lab |
| `tailscale status` | Lectura | No canvia res |
| `uptime-kuma API` | Lectura + alertes ack | Pot silenciar alertes confirmades |
| Scripts de backup | Només escriure al seu volum | Res més |

## Fitxers relacionats

- `automations/` — scripts que Hermes pot invocar
- `missions/` — definicions d'exercicis i reptes
- `ADR/0001-arquitectura-general.md` — decisió global

## Configuració MCP (plantilla)

```jsonc
// hermes/mcp.example.json
{
  "mcpServers": {
    "docker-lab": {
      "command": "docker",
      "args": ["mcp", "--config", "/home/<USER>/BernatCyberLab/_local/docker/mcp-config.json"],
      "env": {}
    },
    "tailscale": {
      "command": "tailscale-mcp",
      "args": ["--read-only"],
      "env": {
        "TS_API_KEY": "<TAILSCALE_API_KEY_PLACEHOLDER>"
      }
    }
  }
}
```

⚠️ La versió amb valors reals viu a `BernatCyberLab/_local/hermes/mcp.local.json`.
