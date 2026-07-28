#!/usr/bin/env bash
# ============================================================================
# audit-rpi.sh — Només lectura, cap canvi al sistema.
# Recull informació per a la Fase 0 del Bernat CyberLab AI.
# ============================================================================
set -euo pipefail

OUT="${1:-./rpi-audit.txt}"
echo "=== Bernat CyberLab AI — Auditoria Raspberry Pi ===" | tee "$OUT"
echo "Data: $(date -Iseconds)" | tee -a "$OUT"
echo "" | tee -a "$OUT"

echo "## Hardware" | tee -a "$OUT"
cat /proc/cpuinfo 2>/dev/null | grep -E "Model|Hardware|Revision" | head -5 | tee -a "$OUT" || true
echo "" | tee -a "$OUT"

echo "## RAM" | tee -a "$OUT"
free -h 2>/dev/null | tee -a "$OUT" || true
echo "" | tee -a "$OUT"

echo "## Disc" | tee -a "$OUT"
df -h / 2>/dev/null | tee -a "$OUT" || true
echo "" | tee -a "$OUT"

echo "## Xarxa" | tee -a "$OUT"
ip -4 addr show 2>/dev/null | grep -E "inet " | tee -a "$OUT" || true
echo "" | tee -a "$OUT"

echo "## SO" | tee -a "$OUT"
cat /etc/os-release 2>/dev/null | head -10 | tee -a "$OUT" || true
echo "" | tee -a "$OUT"

echo "## Serveis actius" | tee -a "$OUT"
systemctl list-units --type=service --state=running 2>/dev/null | head -30 | tee -a "$OUT" || true
echo "" | tee -a "$OUT"

echo "## Apps presents" | tee -a "$OUT"
for app in docker ollama node python3 git gh tailscale adguardhome uptime-kuma node-red ntfy etherwake; do
  v=$(command -v $app 2>/dev/null || echo "no trobat")
  echo "$app: $v" | tee -a "$OUT"
done
echo "" | tee -a "$OUT"

echo "## Tailscale" | tee -a "$OUT"
tailscale status 2>/dev/null | tee -a "$OUT" || echo "Tailscale no instal·lat" | tee -a "$OUT"
echo "" | tee -a "$OUT"

echo "=== Auditoria completada. Sortida a: $OUT ==="
