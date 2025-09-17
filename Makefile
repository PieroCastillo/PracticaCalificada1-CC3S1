.PHONY: help tools run test clean

help:
	@echo "Targets disponibles:"
	@echo "  tools   -> Verifica utilidades necesarias"
	@echo "  run     -> Ejecuta el script de DNS"
	@echo "  test    -> Ejecuta pruebas Bats"
	@echo "  clean   -> Limpia la carpeta out/"

tools:
	@which dig >/dev/null || (echo "Falta dig" && exit 1)
	@which bats >/dev/null || (echo "Falta bats" && exit 1)

run:
	bash src/dns.sh

test:
	bats tests/

clean:
	rm -rf out/*
