# Plantilla: secret d'exemple

> Aquest fitxer és una **plantilla pública** amb placeholders. La versió amb valors reals viu a `BernatCyberLab/_local/secrets/<servei>.env` (no versionat).

## Variables

```bash
# Copia aquest fitxer a .env i omple'l amb valors reals.
# .env ESTÀ EXCLÒS DEL REPO PER .gitignore.

# Tailscale
TAILSCALE_AUTHKEY=<tskey-authkey-PLACEHOLDER>
TAILSCALE_TAILNET=<your-tailnet>.ts.net

# KeePassXC DB
KEEPASS_DB_PATH=/home/<USER>/BernatCyberLab/_local/secrets/cyberlab.kdbx
KEEPASS_PASSWORD=<NOT_STORED_HERE_USE_AGENT_OR_PROMPT>

# age (per desxifrar .env.age)
AGE_KEY_PATH=/home/<USER>/BernatCyberLab/_local/secrets/age.key

# Contrasenya BD DVWA (per si s'usa)
DVWA_DB_PASSWORD=<placeholder-CHANGE-ME>
```

## Bones pràctiques

- Cap secret en text pla al Git, **mai**.
- `.env` afegit a `.gitignore` (ja hi és).
- Rotació periòdica (cada 90 dies com a mínim per a claus d'accés).
- Auditoria: `git log -p --all | grep -iE "password|token|key"` ha de retornar zero resultats.
