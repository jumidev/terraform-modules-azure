.ONESHELL:
SHELL=bash

format:
	@echo formatting tf files...
	@set -eu
	@for d in $$(find * -type d ) ; do \
		echo $$d ; \
		terraform fmt $$d ; \
	done
