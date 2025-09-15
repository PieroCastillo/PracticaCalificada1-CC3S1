.PHONY: tools run test

tools:
	@which dig >/dev/null || (echo "Falta dig" && exit 1)

run:
	bash src/dns.sh

test:
	bats tests/