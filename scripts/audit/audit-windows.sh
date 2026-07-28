#!/usr/bin/env bash
# ============================================================================
# audit-windows.sh — Només lectura, cap canvi al sistema.
# Recull informació per a la Fase 0 del Bernat CyberLab AI.
# ============================================================================
set -euo pipefail

OUT="${1:-./windows-audit.txt}"
echo "=== Bernat CyberLab AI — Auditoria Windows ===" | tee "$OUT"
echo "Data: $(date -Iseconds)" | tee -a "$OUT"
echo "" | tee -a "$OUT"

echo "## Sistema" | tee -a "$OUT"
systeminfo 2>/dev/null | grep -E "OS Name|OS Version|System Type|Total Physical|Hyper-V" | tee -a "$OUT" || true
echo "" | tee -a "$OUT"

echo "## CPU" | tee -a "$OUT"
wmic cpu get name,numberofcores,numberoflogicalprocessors 2>/dev/null | tee -a "$OUT" || true
echo "" | tee -a "$OUT"

echo "## Discs" | tee -a "$OUT"
wmic logicaldisk get caption,size,freespace,filesystem 2>/dev/null | tee -a "$OUT" || true
echo "" | tee -a "$OUT"

echo "## Xarxa" | tee -a "$OUT"
ipconfig /all 2>/dev/null | grep -E "Adaptador|IPv4|Subnet|MAC|Gateway" | tee -a "$OUT" || true
echo "" | tee -a "$OUT"

echo "## Hyper-V disponible?" | tee -a "$OUT"
powershell -Command "Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All" 2>/dev/null | head -20 | tee -a "$OUT" || echo "no PowerShell" | tee -a "$OUT"
echo "" | tee -a "$OUT"

echo "## WSL" | tee -a "$OUT"
wsl --status 2>/dev/null | tee -a "$OUT" || echo "WSL no disponible" | tee -a "$OUT"
echo "" | tee -a "$OUT"

echo "## Docker" | tee -a "$OUT"
docker --version 2>/dev/null | tee -a "$OUT" || echo "Docker no instal·lat" | tee -a "$OUT"
echo "" | tee -a "$OUT"

echo "## Tailscale" | tee -a "$OUT"
tailscale --version 2>/dev/null | tee -a "$OUT" || echo "Tailscale no instal·lat" | tee -a "$OUT"
echo "" | tee -a "$OUT"

echo "=== Auditoria completada. Sortida a: $OUT ==="
