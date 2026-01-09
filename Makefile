# Makefile para Odisea Wiki

QUARTO=quarto
PYTHON=python3

preview:
	$(QUARTO) preview

render:
	$(QUARTO) render

json:
	$(PYTHON) scripts/md_to_json.py

html:
	$(PYTHON) scripts/md_to_html.py

all: render export-json

.PHONY: preview render html export-json all
