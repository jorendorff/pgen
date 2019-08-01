PY_OUT = js_parser/parser_tables.py
RS_OUT = rust/generated_parser/src/lib.rs
PYTHON = python3

all: $(PY_OUT) $(RS_OUT)

# Incomplete list of files that contribute to the dump file.
SOURCE_FILES = \
jsparagus/gen.py \
js_parser/esgrammar.pgen \
js_parser/generate_js_parser_tables.py \
js_parser/parse_esgrammar.py \
js_parser/es-simplified.esgrammar

EMIT_FILES = $(SOURCE_FILES) jsparagus/emit.py

DUMP_FILE = js_parser/parser_generated.jsparagus_dump

$(DUMP_FILE): $(SOURCE_FILES)
	$(PYTHON) -m js_parser.generate_js_parser_tables --progress -o $@

$(PY_OUT): $(EMIT_FILES) $(DUMP_FILE)
	$(PYTHON) -m js_parser.generate_js_parser_tables --progress -o $@ $(DUMP_FILE)

$(RS_OUT): $(EMIT_FILES) $(DUMP_FILE)
	$(PYTHON) -m js_parser.generate_js_parser_tables --progress -o $@ $(DUMP_FILE)

check: $(PY_OUT)
	./test.sh

jsdemo: $(PY_OUT)
	$(PYTHON) -m js_parser.try_it

.PHONY: all check jsdemo
