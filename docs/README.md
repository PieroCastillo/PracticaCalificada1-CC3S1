# Proyecto 4: Sistema de logs seguro con enfoque DevSecOps

## Descripción
Este proyecto implementa un sistema de recolección y procesamiento de logs de red (HTTP, DNS, TLS, systemd) usando Bash y herramientas Unix, siguiendo principios de 12-Factor, CALMS y You Build It You Run It.

## Variables de entorno
Estas variables permiten configurar el comportamiento sin modificar los scripts:

| Variable      | Descripción | Valor por defecto |
|---------------|-------------|------------------|
| `DNS_SERVER`  | Servidor DNS a usar para las consultas | `8.8.8.8` |
| `TARGET_URL`  | URL objetivo para pruebas HTTP/DNS/TLS | `example.com` |
| `LOG_PATH`    | Ruta de archivo donde se almacenan logs | `./out/logs.txt` |
| `RELEASE`     | Versión o nombre de release usado en empaquetado | `v1.0.0` |

## Uso
1. **Preparar entorno**  
   ```bash
   make tools
   ```
2. **Ejecutar el scrip principal**
    ```bash
   make run
   ```
3. **Ejecutar pruebas**
    ```bash
   make test
   ```
4. **Empaquetar salida reproducible**
    ```bash
   make pack
   ```

## Contrato de salidas
- Carpeta `out/`:
    - `dns.log`: resultados de consultas DNS.
    - `logs.txt`: logs combinados de DNS/HTTP/TLS
- Carpeta `dist/`:
    - `proyecto4-$(RELASE).tar.gz`: paquete reproducible que incluye scripts y evidencias.

# Bitácoras

Cada sprint se documenta en:

- `docs/bitacora-sprint-1.md`
- `docs/bitacora-sprint-2.md`
- `docs/bitacora-sprint-3.md`

Incluyen comandos ejecutados, salidas relevantes y decisiones tomadas.

Se valida que `dns.sh` retorne al menos una IP. Se define entonces ´test/dns.bats´

## Targets del Makefile

| Target | Descripción |
|--------|-------------|
| `help` | Muestra los targets disponibles y una breve explicación de cada uno. |
| `tools` | Verifica que las utilidades necesarias (`dig`, `bats`) estén instaladas en el sistema. |
| `run` | Ejecuta el script principal de Alumno2 (`src/dns.sh`) y genera los archivos de salida en `out/`. |
| `test` | Ejecuta los tests automatizados con Bats ubicados en la carpeta `tests/`. |
| `clean` | Elimina los archivos generados en la carpeta `out/` para dejar el entorno limpio. |
