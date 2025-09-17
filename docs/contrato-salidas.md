# Contrato de Salidas – Alumno2 (DNS)

## Archivos generados en `out/`

| Archivo          | Descripción |
|------------------|-------------|
| `dns.log`        | Log completo de la consulta DNS (registros A y CNAME). |
| `dns_ips.log`    | Lista de todas las direcciones IPv4 encontradas en el log. |
| `dns_unique.log` | Lista de direcciones IPv4 únicas (sin duplicados). |
| `dns_cname.log`  | Registros CNAME asociados al dominio consultado. |

## Observaciones
- Los archivos se sobrescriben en cada ejecución de `src/dns.sh`.
- El contenido depende del dominio (`$TARGET_URL`) y del servidor DNS (`$DNS_SERVER`) configurados.