#!/usr/bin/env bash
set -euo pipefail

DNS_SERVER=${DNS_SERVER:-"8.8.8.8"}
TARGET_URL=${TARGET_URL:-"example.com"}
LOG_PATH="out/dns.log"

echo "[DNS] Resolviendo $TARGET_URL con $DNS_SERVER" | tee "$LOG_PATH"
dig @"$DNS_SERVER" "$TARGET_URL" +short | tee -a "$LOG_PATH"

awk '/^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/ {print $0}' out/dns.log | sort | uniq > out/dns_clean.log

@test "DNS devuelve al menos una IP" 
{
  run bash src/dns.sh
  [[ "$output" =~ [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ ]]
}
