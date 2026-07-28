# Ordres d'auditoria — Fase 0

> Aquest fitxer conté **les ordres llestes per copiar-enganxar** a cada dispositiu per recollir la informació de la Fase 0.
> Totes les ordres són de **només lectura** (no modifiquen res al sistema).
> Aquestes mateixes ordres estan empaquetades als scripts `scripts/audit/audit-*.sh`; pots fer servir el que et sigui més còmode.

## On guardar la sortida

Cada dispositiu escriu la seva sortida a la **carpeta `_local/` del projecte al PC Windows** (que **no es versiona**):

```
C:\Users\iadmin\bernatlab\bernatlab-cyberlab\_local\inventory\
├── windows.txt        ← PC Windows
├── mac-brain.txt      ← MacBook Pro (cyber-brain)
├── mac-air.txt        ← MacBook Air (cyber-control)
└── rpi.txt            ← Raspberry Pi (cyber-pi)
```

⚠️ Si executes des d'un Mac o la RPi, la ruta al PC no existeix. En aquest cas:
- guarda la sortida a un fitxer local (`~/inventory-<device>.txt`),
- copia-la després al PC (correu, Drive, USB, `scp`, etc. — **mai** la publiquis al Git).

---

## A. PC Windows — `cyber-host`

**On executar:** Git Bash al PC Windows 11.

### A.1 — Ordres individuals (mode "copiar-enganxar per blocs")

```bash
# === BLOC 1: Sistema operatiu ===
systeminfo | grep -E "OS Name|OS Version|System Type|Total Physical|Hyper-V"
```

```bash
# === BLOC 2: CPU ===
wmic cpu get name,numberofcores,numberoflogicalprocessors /value
```

```bash
# === BLOC 3: Discs (unitats lògiques) ===
wmic logicaldisk get caption,size,freespace,filesystem /value
```

```bash
# === BLOC 4: Xarxa (adaptadors + IPs) ===
ipconfig /all | grep -E "Adaptador|IPv4|Subnet|MAC|Gateway"
```

```bash
# === BLOC 5: Adaptadors de xarxa (PowerShell) ===
powershell -Command "Get-NetAdapter | Select-Object Name,Status,LinkSpeed,MacAddress | Format-Table -AutoSize"
```

```bash
# === BLOC 6: Hyper-V disponible? ===
powershell -Command "Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V"
```

```bash
# === BLOC 7: WSL2 disponible? ===
wsl --status
```

```bash
# === BLOC 8: Docker present? ===
docker --version 2>/dev/null || echo "Docker NO instal·lat"

# === BLOC 9: Tailscale present? ===
tailscale --version 2>/dev/null || echo "Tailscale NO instal·lat"

# === BLOC 10: KeePassXC present? ===
where keepassxc 2>/dev/null || echo "KeePassXC NO instal·lat"
```

### A.2 — Tot en un sol bloc (recomanat)

Si vols recollir-ho tot de cop i desar-ho a `_local/inventory/windows.txt`:

```bash
OUT="/c/Users/iadmin/bernatlab/bernatlab-cyberlab/_local/inventory/windows.txt"
mkdir -p "$(dirname "$OUT")"

{
  echo "=== Bernat CyberLab AI — Auditoria Windows ==="
  echo "Data: $(date -Iseconds)"
  echo ""

  echo "## Sistema"
  systeminfo | grep -E "OS Name|OS Version|System Type|Total Physical|Hyper-V"
  echo ""

  echo "## CPU"
  wmic cpu get name,numberofcores,numberoflogicalprocessors /value
  echo ""

  echo "## Discs"
  wmic logicaldisk get caption,size,freespace,filesystem /value
  echo ""

  echo "## Xarxa (ipconfig)"
  ipconfig /all | grep -E "Adaptador|IPv4|Subnet|MAC|Gateway"
  echo ""

  echo "## Adaptadors de xarxa"
  powershell -Command "Get-NetAdapter | Select-Object Name,Status,LinkSpeed,MacAddress | Format-Table -AutoSize"
  echo ""

  echo "## Hyper-V"
  powershell -Command "Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V"
  echo ""

  echo "## WSL"
  wsl --status 2>&1 || echo "WSL no disponible"
  echo ""

  echo "## Docker"
  docker --version 2>/dev/null || echo "Docker NO instal·lat"
  echo ""

  echo "## Tailscale"
  tailscale --version 2>/dev/null || echo "Tailscale NO instal·lat"
  echo ""

  echo "## KeePassXC"
  where keepassxc 2>/dev/null || echo "KeePassXC NO instal·lat"
} > "$OUT" 2>&1

echo "Sortida desada a: $OUT"
```

### A.3 — Equivalent en script

```bash
# mateix resultat, una sola ordre:
bash /c/Users/iadmin/bernatlab/bernatlab-cyberlab/scripts/audit/audit-windows.sh \
  /c/Users/iadmin/bernatlab/bernatlab-cyberlab/_local/inventory/windows.txt
```

---

## B. MacBook Pro — `cyber-brain`

**On executar:** Terminal.app o iTerm2 al MacBook Pro (macOS 12.7.6).

⚠️ Aquest equip **no és el PC**; la ruta `C:\Users\iadmin\...` no existeix. Guarda a `~/inventory-mac-brain.txt` i després copia al PC.

### B.1 — Tot en un sol bloc

```bash
OUT="$HOME/inventory-mac-brain.txt"

{
  echo "=== Bernat CyberLab AI — Auditoria macOS (cyber-brain) ==="
  echo "Data: $(date -Iseconds)"
  echo ""

  echo "## Hardware"
  system_profiler SPHardwareDataType | grep -E "Model Name|Model Identifier|Chip|Processor|Memory|Total Number of Cores|Year"
  echo ""

  echo "## macOS"
  sw_vers
  echo ""

  echo "## Emmagatzematge"
  df -h /
  echo ""

  echo "## Bateria"
  system_profiler SPPowerDataType | grep -E "Cycle Count|Condition|Maximum Capacity|Charge Remaining|Charge Cycles"
  echo ""

  echo "## Apps presents"
  for app in docker ollama node python3 git gh tailscale keepassxc; do
    v=$(command -v "$app" 2>/dev/null || echo "no trobat")
    echo "$app: $v"
  done
  echo ""

  echo "## Xarxa (ifconfig)"
  ifconfig | grep -E "inet |status:|ether " | head -30
  echo ""

  echo "## Tailscale"
  tailscale status 2>&1 | head -20 || echo "Tailscale no instal·lat"
} > "$OUT" 2>&1

echo "Sortida desada a: $OUT"
```

### B.2 — Equivalent en script (si tens el repo clonat al Mac)

```bash
cd ~/Projects/bernatlab-cyberlab   # ajusta la ruta si escau
bash scripts/audit/audit-mac.sh ~/inventory-mac-brain.txt
```

---

## C. MacBook Air — `cyber-control`

**On executar:** Terminal.app al MacBook Air (macOS 26.5.2).

Mateix procediment que B, però la sortida canvia de nom:

```bash
OUT="$HOME/inventory-mac-air.txt"

{
  echo "=== Bernat CyberLab AI — Auditoria macOS (cyber-control) ==="
  echo "Data: $(date -Iseconds)"
  echo ""

  echo "## Hardware"
  system_profiler SPHardwareDataType | grep -E "Model Name|Model Identifier|Chip|Processor|Memory|Total Number of Cores"
  echo ""

  echo "## macOS"
  sw_vers
  echo ""

  echo "## Emmagatzematge"
  df -h /
  echo ""

  echo "## Bateria"
  system_profiler SPPowerDataType | grep -E "Cycle Count|Condition|Maximum Capacity"
  echo ""

  echo "## Apps presents"
  for app in code docker ollama node python3 git gh tailscale; do
    v=$(command -v "$app" 2>/dev/null || echo "no trobat")
    echo "$app: $v"
  done
  echo ""

  echo "## Xarxa"
  ifconfig | grep -E "inet |status:|ether " | head -30
} > "$OUT" 2>&1

echo "Sortida desada a: $OUT"
```

---

## D. Raspberry Pi 4 — `cyber-pi`

**On executar:** SSH al RPi (o terminal directe).

```bash
OUT="$HOME/inventory-rpi.txt"

{
  echo "=== Bernat CyberLab AI — Auditoria Raspberry Pi (cyber-pi) ==="
  echo "Data: $(date -Iseconds)"
  echo ""

  echo "## Hardware"
  grep -E "Model|Hardware|Revision" /proc/cpuinfo | head -5
  echo ""

  echo "## RAM"
  free -h
  echo ""

  echo "## Disc"
  df -h /
  echo ""

  echo "## Xarxa"
  ip -4 addr show | grep -E "inet "
  echo ""

  echo "## SO"
  cat /etc/os-release | head -10
  echo ""

  echo "## Serveis actius (top 30)"
  systemctl list-units --type=service --state=running | head -30
  echo ""

  echo "## Apps presents"
  for app in docker ollama node python3 git gh tailscale adguardhome uptime-kuma node-red ntfy etherwake; do
    v=$(command -v "$app" 2>/dev/null || echo "no trobat")
    echo "$app: $v"
  done
  echo ""

  echo "## Tailscale"
  tailscale status 2>&1 | head -20 || echo "Tailscale no instal·lat"
} > "$OUT" 2>&1

echo "Sortida desada a: $OUT"
```

---

## E. Xarxa domèstica (des de qualsevol equip)

```bash
# Rang i gateway
ip route | grep default

# DNS que s'està fent servir
nslookup google.com

# (Windows PowerShell, equivalent)
# Get-NetRoute | Where-Object {$_.DestinationPrefix -eq "0.0.0.0/0"} | Select-Object NextHop
# Get-DnsClientServerAddress -InterfaceAlias "Ethernet*" | Select-Object -ExpandProperty ServerAddresses
```

---

## F. Compartir les sortides amb Hermes

Un cop tinguis els 4 fitxers (o els que puguis), comparteix-me'n **només un resum anonimitzat** aquí al xat:

### Plantilla de resum (copia i omple)

```text
=== RESUM AUDITORIA (anonimitzat) ===

[PC Windows - cyber-host]
- CPU: <model> <n nuclis>
- RAM: <GB>
- Versió Windows: <10/11 Pro/Home>
- Hyper-V disponible: <sí/no>
- WSL2 disponible: <sí/no>
- Docker: <instal·lat/no>
- Tailscale: <instal·lat/no>
- Discs: <C: N GB / D: N GB / ...>
- Discs externs: <N discs, capacitats>

[MacBook Pro - cyber-brain]
- Processador: <Intel/Apple Silicon, model>
- RAM: <GB>
- SSD: <N GB lliure de M total>
- macOS: <12.7.6>
- Cicles bateria: <N>
- Docker: <instal·lat/no>
- Ollama: <instal·lat/no>

[MacBook Air - cyber-control]
- Processador: <...>
- RAM: <GB>
- macOS: <26.x.y>
- VS Code: <instal·lat/no>

[Raspberry Pi - cyber-pi]
- RAM: <1/2/4/8 GB>
- Boot: <SD/SSD USB>
- SO: <Raspberry Pi OS / Ubuntu / ...>
- IP actual a la LAN: <x.x.x.x>
- Tailscale: <instal·lat/no>
- AdGuard Home: <instal·lat/no>
- Uptime Kuma: <instal·lat/no>

[Xarxa domèstica]
- Rang LAN: <x.x.x.0/24>
- Router (model): <...>
- Suporta VLAN: <sí/no>
- Ports oberts al router: <cap / quins?>

[iPhone 17 - cyber-mobile]
- iOS: <...>
- Tailscale: <instal·lat/no>
- Termius o Blink: <instal·lat/no>

NOTES:
- <qualsevol cosa rara o destacada>
```

Quan m'ho passis, tancarem la Fase 0 i et presente el **Pla Detallat de la Fase 1 (Tailscale)** amb els 12 punts de la metodologia.

---

## Errors habituals

| Error | Causa probable | Solució |
|---|---|---|
| `wmic no es reconeix` | Windows 11 modern sense alias | Fes servir el bloc de PowerShell equivalent |
| `Get-WindowsOptionalFeature: accès denegat` | PowerShell sense admin | Obre Git Bash amb un usuari normal — no cal admin per a cap d'aquestes ordres |
| `system_profiler: command not found` | PATH incomplet al shell del Mac | Prova amb `sudo system_profiler SPHardwareDataType` o `/usr/sbin/system_profiler` |
| `docker --version` retorna "no trobat" | Docker no està instal·lat | Normal — és un dels punts que volem confirmar |
| `tailscale: command not found` | Tailscale no instal·lat | Normal — s'instal·larà a Fase 1 |
| `permission denied` a `/etc/os-release` | Usuari sense permisos | Prova amb `cat /etc/os-release 2>/dev/null` (ignora l'error) |

## Procediment de recuperació

Si executes alguna ordre per error i trenca alguna cosa (no hauria de passar, totes són de lectura):

1. **No facis res més.**
2. Apunta l'ordre exacta que has executat i la sortida.
3. Comparteix-me el missatge d'error aquí al xat.
4. Comprova amb `git status` al repo que no hi hagi canvis no desitjats.