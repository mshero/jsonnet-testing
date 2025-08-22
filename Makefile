
.PHONY: help lint format test all

all: ## run all targets
all: vendor format lint test

vendor:
	@jb install; \
	if [ $$? -gt 0 ]; then \
		echo "Initialize... FAIL"; \
	else \
		echo "Initialize... OK"; \
	fi


help:
	@echo "Load Test Automation Jsonnet Build Help:"
	@echo
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

format: ## run jsonnetfmt --test for .jsonnet and .libsonnet files
	@FAILED_FILES=""; \
	for file in $(shell ls lib/*.libsonnet lib/*.jsonnet); do \
		jsonnetfmt --test "$$file"; \
		if [ $$? -gt 0 ]; then \
			FAILED_FILES="$${FAILED_FILES} $$file"; \
		fi; \
	done; \
	if [ -n "$$FAILED_FILES" ]; then \
		echo "Invalid formatting"; \
		for file in $${FAILED_FILES}; do \
			echo "  -> $${file}"; \
		done; \
		exit 1; \
	else \
		echo "Formatting... OK"; \
	fi

lint: ## run linter for .jsonnet and .libsonnet files
	@jsonnet-lint lib/*.libsonnet; \
	LIBSONNET_RESULT=$$?; \
	jsonnet-lint lib/*.jsonnet; \
	JSONNET_RESULT=$$?; \
	if [ $$LIBSONNET_RESULT -gt 0 ] || [ $$JSONNET_RESULT -gt 0 ]; then \
		exit 1; \
	else \
		echo "Linting... OK"; \
	fi


test: ## run unit tests for *_test.jsonnet files
	@FAILED_FILES=""; \
	echo "Test execution\n"; \
	for file in $(shell ls lib/*_test.jsonnet); do \
		echo "Running $${file}"; jsonnet "$${file}"; \
		if [ $$? -gt 0 ]; then \
			FAILED_FILES="$${FAILED_FILES} $${file}"; \
		fi; \
	done; \
	if [ -n "$$FAILED_FILES" ]; then \
		echo "Test execution... FAIL"; \
		for file in $${FAILED_FILES}; do \
			echo "  -> $${file}"; \
		done; \
		exit 1; \
	else \
		echo "Test execution... OK"; \
	fi
