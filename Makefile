# Variables de configuración
# Usadas por los targets

SRC=src/logs.sh
DIST=dist
BIN=$(DIST)/logs.sh
PKG=$(DIST)/logs.tar.gz
SYSTEMD=systemd/logs.service
TESTS=tests/makefile.bats

.PHONY: all tools build run test pack clean help

all: build

tools:
	@echo "Verificando herramientas necesarias..."
	@command -v bash >/dev/null 2>&1  || { echo "La herramienta bash no está instalada."; exit 1; }
	@command -v awk  >/dev/null 2>&1  || { echo "La herramienta awk  no está instalada."; exit 1; }
	@command -v grep >/dev/null 2>&1  || { echo "La herramienta grep no está instalada."; exit 1; }
	@command -v sed  >/dev/null 2>&1  || { echo "La herramienta sed  no está instalada."; exit 1; }
	@command -v bats >/dev/null 2>&1  || { echo "La herramienta bats no está instalada."; exit 1; }
	@echo "Herramientas OK."

$(DIST):
	@mkdir -p $(DIST)

build: tools $(DIST)
	@echo "Copiando script a dist/..."
	@cp $(SRC) $(BIN)
	@chmod +x $(BIN)
	@echo "Copiando unidad systemd a dist/..."
	@cp $(SYSTEMD) $(DIST)/

# Caché incremental:
# solo ejecuta el target si no existe el archivo logs.out o
# si el script cambió
run: build
	@if [ ! -f $(DIST)/logs.out ] || [ $(SRC) -nt $(DIST)/logs.out ]; then \
        echo "Ejecutando script y generando logs.out..."; \
        bash $(BIN) > $(DIST)/logs.out; \
    else \
        echo "logs.out ya está actualizado. Nada que hacer."; \
    fi

test: build
	@echo "Ejecutando pruebas Bats..."
	@bats $(TESTS)

pack: build
	@echo "Empaquetando dist/ en $(PKG)..."
	@tar -czf $(PKG) -C $(DIST) .

clean:
	@echo "Limpiando archivos generados..."
	@rm -rf $(DIST)

help:
	@echo "Targets disponibles:"
	@echo "  tools   - Verifica herramientas necesarias"
	@echo "  build   - Prepara dist/ con scripts y unidad systemd"
	@echo "  run     - Ejecuta el script solo si hay cambios (caché incremental)"
	@echo "  test    - Ejecuta pruebas Bats"
	@echo "  pack    - Empaqueta dist/ en .tar.gz"
	@echo "  clean   - Elimina dist/"
	@echo "  help    - Muestra esta ayuda"
