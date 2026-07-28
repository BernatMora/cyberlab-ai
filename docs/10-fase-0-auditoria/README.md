# Fase 0 — Auditoria de maquinari

> Objectiu: validar que el maquinari disponible és adequat per al pla.
> Durada estimada: 1-2 dies.
> Pre-requisit: res (aquesta és la primera fase).

## 0. Resultat esperat

Un document d'inventari (privat, a `BernatCyberLab/_local/inventory/local.md`) amb les dades reals de cada dispositiu, i una versió pública anonimitzada penjada al repo.

## 1. Comandes segures per obtenir la informació

Aquestes comandes **només llegeixen** informació, no modifiquen res.

### A. PC Windows (executar a Git Bash)

```bash
# Sistema
systeminfo | grep -E "OS Name|OS Version|System Type|Total Physical|Hyper-V"

# CPU
wmic cpu get name,numberofcores,numberoflogicalprocessors /value 2>/dev/null

# Discs
wmic logicaldisk get caption,size,freespace,filesystem /value 2>/dev/null

# Xarxa
ipconfig /all | grep -E "Adaptador|IPv4|Subnet|MAC|Gateway"
powershell -Command "Get-NetAdapter | Select-Object Name,Status,LinkSpeed,MacAddress" 2>/dev/null

# Hyper-V disponible?
powershell -Command "Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All" 2>/dev/null | head -20

# WSL disponible?
wsl --status 2>/dev/null

# Docker ja instal·lat?
docker --version 2>/dev/null || echo "Docker no instal·lat"
```

### B. MacBook Pro (`cyber-brain`)

```bash
# Model i any
system_profiler SPHardwareDataType | grep -E "Model Name|Model Identifier|Year|Chip|Processor|Memory|Total Number of Cores"

# Versió macOS
sw_vers

# Emmagatzematge
df -h /

# Estat bateria
system_profiler SPPowerDataType | grep -E "Cycle Count|Condition|Maximum Capacity"

# Apps presents (no instal·lar res)
for app in docker ollama node python3; do
  command -v $app 2>/dev/null && $app --version 2>/dev/null || echo "$app no trobat"
done
```

### C. MacBook Air (`cyber-control`)

Mateixes comandes B, més:

```bash
ls /Applications/ | grep -iE "code|termius|ssh|tailscale"
```

### D. Raspberry Pi (`cyber-pi`)

```bash
cat /proc/cpuinfo | grep -E "Model|Hardware" | head -3
free -h
df -h /
ip -4 addr show | grep -E "inet "
systemctl list-units --type=service --state=running | head -20
docker --version 2>/dev/null || echo "Docker no present"
```

### E. Xarxa domèstica (des de qualsevol equip)

```bash
ip route | grep default
nslookup google.com
```

## 1.bis Ordres per copiar-enganxar

Totes les **ordres individuals, organitzades per dispositiu** i llestes per copiar-enganxar estan a:
[`ordinances.md`](ordinances.md).

Si vols el mode "tot d'una", pots fer servir els scripts:
```bash
bash scripts/audit/audit-windows.sh /tmp/out.txt   # PC
bash scripts/audit/audit-mac.sh /tmp/out.txt       # Mac
bash scripts/audit/audit-rpi.sh /tmp/out.txt       # RPi
```

## 2. Llista de comprovació

Marca cada casella quan estigui validada:

- [ ] PC Windows: CPU, RAM, BIOS (VT-x/SLAT), discs, versió Windows, Hyper-V disponible
- [ ] PC Windows: discs externs detectats i amb espai
- [ ] MacBook Pro: any, CPU (Intel/Apple Silicon), RAM, SSD lliure, salut bateria
- [ ] MacBook Pro: Docker, Ollama, Hermes ja presents? (no instal·lar res)
- [ ] MacBook Air: any, CPU, RAM, VS Code present
- [ ] Raspberry Pi: RAM, boot (SD/SSD), SO, IP actual, serveis en execució
- [ ] Xarxa domèstica: rang IP, router (model, VLAN), IPs estàtiques reservades
- [ ] iPhone: iOS, apps de terminal/Tailscale ja presents
- [ ] Cap port obert al router domèstic (verificar)
- [ ] Disposar d'un compte Tailscale (o estar disposat a crear-lo)

## 3. Com reportar els resultats

1. Executa les comandes a cada dispositiu.
2. Omple la plantilla [`../../inventory/hardware.template.md`](../../inventory/hardware.template.md) amb valors reals.
3. Mou la versió amb valors reals a `BernatCyberLab/_local/inventory/local.md` (fora del Git).
4. Enganxa al xat un **resum anonimitzat** (sense IPs reals ni MACs).
5. Confirmo o ajusto el pla segons els resultats.

## 4. Errors habituals

- **"Get-WindowsOptionalFeature falla"** — obrir PowerShell **com a administrador**.
- **"system_profiler no trobat"** — provar amb `sudo system_profiler SPHardwareDataType`.
- **"docker --version no trobat"** — simplement Docker no està instal·lat, és normal.
- **"no tinc accés a la RPi"** — apunt temporal: pots ajornar la RPi a Fase 1 (no és bloquejant per a Fase 0).

## 5. Com es considera la fase completada

- [ ] Tots els equips auditats amb les comandes anteriors.
- [ ] Document d'inventari privat creat.
- [ ] Confirmació de l'adequació del maquinari al pla.
- [ ] Possibles ajustos al pla anotats als ADR corresponents.

Quan tot això estigui validat, **comencem la Fase 1 (Tailscale)**.
