#!/usr/bin/env bats

@test "dns.sh genera dns.log" {
  run bash src/dns.sh
  [ -f out/dns.log ]
}

@test "dns.sh genera al menos una IP" {
  run bash src/dns.sh
  [ -s out/dns_ips.log ]
}

@test "dns.sh genera archivo de IPs únicas" {
  run bash src/dns.sh
  [ -f out/dns_unique.log ]
}
