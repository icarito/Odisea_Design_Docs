# Makefile para Odisea Wiki

QUARTO=quarto
PYTHON=python3

preview:
	$(QUARTO) preview

render:
	$(QUARTO) render

export-json:
	$(PYTHON) scripts/md_to_json.py

all: render export-json

.PHONY: preview render export-json all
