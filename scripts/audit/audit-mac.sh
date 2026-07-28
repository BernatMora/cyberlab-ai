#!/usr/bin/env bash
# ============================================================================
# audit-mac.sh — Només lectura, cap canvi al sistema.
# Recull informació per a la Fase 0 del Bernat CyberLab AI.
# ============================================================================
set -euo pipefail

OUT="${1:-./mac-audit.txt}"
echo "=== Bernat CyberLab AI — Auditoria macOS ===" | tee "$OUT"
echo "Data: $(date -Iseconds)" | tee -a "$OUT"
echo "" | tee -a "$OUT"

echo "## Hardware" | tee -a "$OUT"
system_profiler SPHardwareDataType 2>/dev/null | grep -E "Model Name|Model Identifier|Chip|Processor|Memory|Total Number of Cores" | tee -a "$OUT" || true
echo "" | tee -a "$OUT"

echo "## macOS" | tee -a "$OUT"
sw_vers 2>/dev/null | tee -a "$OUT" || true
echo "" | tee -a "$OUT"

echo "## Emmagatzematge" | tee -a "$OUT"
df -h / 2>/dev/null | tee -a "$OUT" || true
echo "" | tee -a "$OUT"

echo "## Bateria" | tee -a "$OUT"
system_profiler SPPowerDataType 2>/dev/null | grep -E "Cycle Count|Condition|Maximum Capacity|Charge Remaining" | tee -a "$OUT" || true
echo "" | tee -a "$OUT"

echo "## Apps presents" | tee -a "$OUT"
for app in docker ollama node python3 git gh tailscale; do
  v=$(command -v $app 2>/dev/null || echo "no trobat")
  echo "$app: $v" | tee -a "$OUT"
done
echo "" | tee -a "$OUT"

echo "## Xarxa" | tee -a "$OUT"
ifconfig 2>/dev/null | grep -E "inet |status:" | tee -a "$OUT" || true
echo "" | tee -a "$OUT"

echo "=== Auditoria completada. Sortida a: $OUT ==="
