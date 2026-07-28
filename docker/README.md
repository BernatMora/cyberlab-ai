# Plantilla: docker-compose per a una app vulnerable

> Aquesta és una **plantilla pública**. La versió amb valors reals (ports, paths, secrets) viu a `BernatCyberLab/_local/docker/<servei>.local.yml` (no versionat).

## Per què plantilles

Aquest repo és públic. Qualsevol fitxer amb valors reals ha de ser `.local` i
**NO** versionat. Aquí hi ha les plantilles genèriques que documenten
**com** es munta el servei.

## Convencions

- El nom de l'stack és `<servei>-01` (ex. `dvwa-01`, `juice-shop-01`).
- Les xarxes Docker són `<rol>-net` (ex. `victim-net`, `mgmt-net`).
- Les dades es guarden en volums Docker, mai en bind mounts dins del repo.
- Els ports publicats al host són >= 1024 i estan reservats a la `infra.example.yml`.

## Exemple: DVWA

```yaml
# docker/compose/dvwa.example.yml
# Copia aquest fitxer a dvwa.local.yml i personalitza'l.
# dvwa.local.yml ESTÀ EXCLÒS DEL REPO PER .gitignore.

services:
  dvwa-01:
    image: vulnerables/web-dvwa:latest
    container_name: dvwa-01
    hostname: target-web-01
    networks:
      victim-net:
        ipv4_address: 10.10.30.11
    environment:
      - RECAPTCHA_PRIV_KEY=<RECAPTCHA_PLACEHOLDER>
      - RECAPTCHA_PUB_KEY=<RECAPTCHA_PLACEHOLDER>
      - SECURITY_LEVEL=low
    # Cap port publicat al host: s'accedeix des de la xarxa interna
    restart: unless-stopped

networks:
  victim-net:
    external: true
    name: cyberlab_victim_net
```

## Exemple: Juice Shop

```yaml
# docker/compose/juice-shop.example.yml
services:
  juice-shop-01:
    image: bkimminich/juice-shop:latest
    container_name: juice-shop-01
    hostname: target-web-01
    networks:
      victim-net:
        ipv4_address: 10.10.30.12
    restart: unless-stopped
```

## Xarxes Docker

Cal crear les xarxes **un sol cop** abans d'aixecar els stacks:

```bash
docker network create --driver bridge \
  --subnet=10.10.30.0/24 \
  --gateway=10.10.30.1 \
  cyberlab_victim_net
```

⚠️ Aquesta xarxa és **només de laboratori**. No la connectis a la xarxa domèstica.

## On va la configuració real

| Què | On |
|---|---|
| `docker-compose.yml` real | `BernatCyberLab/_local/docker/<servei>.local.yml` (no al Git) |
| Volums de dades | Volums Docker nomenats (`cyberlab_<servei>_data`) |
| Captures de tràfic del laboratori | Disc extern, no al Git |
| Ports publicats al host | `_local/docker/ports.md` (no al Git) |
