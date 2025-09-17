#!/usr/bin/env bash
set -euo pipefail

DNS_SERVER=${DNS_SERVER:-"8.8.8.8"}
TARGET_URL=${TARGET_URL:-"example.com"}

# Archivos de salida
LOG_PATH="out/dns.log"
IPS_PATH="out/dns_ips.log"
UNIQUE_PATH="out/dns_unique.log"
CNAME_PATH="out/dns_cname.log"

# Consulta DNS
echo "Consultando DNS de $TARGET_URL con $DNS_SERVER" | tee "$LOG_PATH"
dig @"$DNS_SERVER" "$TARGET_URL" A +noall +answer | tee -a "$LOG_PATH"
dig @"$DNS_SERVER" "$TARGET_URL" CNAME +noall +answer | tee -a "$LOG_PATH"

# Procesamiento
awk '/^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/ {print $1}' "$LOG_PATH" > "$IPS_PATH"
sort "$IPS_PATH" | uniq > "$UNIQUE_PATH"
grep "CNAME" "$LOG_PATH" > "$CNAME_PATH" || true


echo "Archivos generados:"
echo " - $LOG_PATH"
echo " - $IPS_PATH"
echo " - $UNIQUE_PATH"
echo " - $CNAME_PATH"