#!/usr/bin/env bats

setup() {
    #cd ..
    make clean > /dev/null
}

teardown() {
    make clean > /dev/null
}

@test "tools verifica herramientas necesarias" {
    run make tools
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Herramientas OK." ]]
}

@test "build copia scripts y unidad systemd a dist/" {
    run make build
    [ "$status" -eq 0 ]
    [ -f "dist/logs.sh" ]
    [ -f "dist/logs.service" ]
}

@test "run genera logs.out si no existe" {
    make build > /dev/null
    rm -f dist/logs.out
    run make run
    [ "$status" -eq 0 ]
    [ -f "dist/logs.out" ]
}

@test "run no rehace logs.out si no hay cambios" {
    make run > /dev/null
    before=$(stat -c %Y dist/logs.out)
    sleep 1
    run make run
    after=$(stat -c %Y dist/logs.out)
    [ "$before" -eq "$after" ]
}

@test "pack genera el archivo .tar.gz" {
    make build > /dev/null
    run make pack
    [ "$status" -eq 0 ]
    [ -f "dist/logs.tar.gz" ]
}

@test "clean elimina dist/" {
    make build > /dev/null
    run make clean
    [ "$status" -eq 0 ]
    [ ! -d "dist" ]
}