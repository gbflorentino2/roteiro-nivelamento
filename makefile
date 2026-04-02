.PHONY: relatorio organizar-pastas clean

SHELL := /bin/bash
LOG_DIR := .
LOG_FILE_NAME := relatorio.txt
LOG_FILE := $(LOG_DIR)/$(LOG_FILE_NAME)
SCRIPT := relatorio.tcl

relatorio: $(SCRIPT)
	if [ ! -f "$(LOG_FILE)" ]; then \
		tclsh "$(SCRIPT)" > "$(LOG_FILE)" 2>&1; \
	fi

organizar-pastas:
	bash ./shell_test/organizador.sh

clean:
	rm -f "$(LOG_FILE)"
