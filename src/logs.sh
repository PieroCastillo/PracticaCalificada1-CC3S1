#!/usr/bin/env bash

# Script para recolectar y procesar logs de red (HTTP, DNS, TLS) usando journalctl y utilidades estándar

set -euo pipefail

# Manejo de señales
trap 'echo "Script interrumpido"; exit 1' SIGINT SIGTERM

# Recolectar logs HTTP (simulado con journald de servicios que usen curl o wget)
echo "=== HTTP REQUESTS ==="
journalctl --since "1 hour ago" | grep -Ei "curl|wget|http" | awk '{print $0}' | sort | uniq

# Recolectar logs DNS (systemd-resolved)
echo "=== DNS QUERIES ==="
journalctl -u systemd-resolved --since "1 hour ago" 2>/dev/null | grep -i "query" | awk '{print $0}' | sort | uniq

# Recolectar logs TLS (simulado: errores de openssl o conexiones TLS)
echo "=== TLS ERRORS ==="
journalctl --since "1 hour ago" | grep -Ei "tls|ssl|certificate|handshake" | awk '{print $0}' | sort | uniq

echo "Procesamiento de logs finalizado."