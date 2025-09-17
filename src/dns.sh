#!/usr/bin/env bash
set -euo pipefail

DNS_SERVER=${DNS_SERVER:-"8.8.8.8"}
TARGET_URL=${TARGET_URL:-"example.com"}

# Archivos de salida
LOG_PATH="out/dns.log"
IPS_PATH="out/dns_ips.log"
UNIQUE_PATH="out/dns_unique.log"
CNAME_PATH="out/dns_cname.log"

# Asegurar carpeta de salida
mkdir -p out

# Consulta DNS
echo "Consultando DNS de $TARGET_URL con $DNS_SERVER" | tee "$LOG_PATH"
dig @"$DNS_SERVER" "$TARGET_URL" A +noall +answer | tee -a "$LOG_PATH"
dig @"$DNS_SERVER" "$TARGET_URL" CNAME +noall +answer | tee -a "$LOG_PATH"

# Procesamiento
# Extraer IPs (columna 5 de los registros tipo A)
awk '{ if ($4 == "A") print $5 }' "$LOG_PATH" > "$IPS_PATH"

# IPs únicas
sort "$IPS_PATH" | uniq > "$UNIQUE_PATH"

# Extraer CNAME (columna 5 de los registros tipo CNAME)
awk '{ if ($4 == "CNAME") print $5 }' "$LOG_PATH" > "$CNAME_PATH"

echo "Archivos generados:"
echo " - $LOG_PATH"
echo " - $IPS_PATH"
echo " - $UNIQUE_PATH"
echo " - $CNAME_PATH"
