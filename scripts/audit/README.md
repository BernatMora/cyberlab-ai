# Scripts d'auditoria

Aquesta carpeta conté scripts que **només llegeixen** informació del sistema per
a la fase d'auditoria (Fase 0).

## Ús

```bash
# Windows (Git Bash)
bash scripts/audit/audit-windows.sh > _local/inventory/windows.txt 2>&1

# Mac (terminal)
bash scripts/audit/audit-mac.sh > _local/inventory/mac.txt 2>&1

# Raspberry Pi
bash scripts/audit/audit-rpi.sh > _local/inventory/rpi.txt 2>&1
```

⚠️ Tots els scripts escriuen a `_local/inventory/`, que **NO** està versionat.
