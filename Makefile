MODEL ?=
FORMAT ?= stl

.PHONY: bootstrap doctor models check check-all export

bootstrap:
	./scripts/bootstrap


doctor:
	./scripts/scad doctor


models:
	@./scripts/scad list

check:
	@test -n "$(MODEL)" || (echo "Usage: make check MODEL=path/to/model.scad" >&2; exit 2)
	./scripts/scad check "$(MODEL)"

check-all:
	./scripts/scad check-all

export:
	@test -n "$(MODEL)" || (echo "Usage: make export MODEL=path/to/model.scad FORMAT=stl" >&2; exit 2)
	./scripts/scad export "$(FORMAT)" "$(MODEL)"
