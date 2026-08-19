SYNAPSE_HOME ?= $(CURDIR)/.synapse
SYNAPSE_HOME := $(abspath $(SYNAPSE_HOME))
BACKEND_SANDBOX_HOME := $(abspath $(CURDIR)/sandbox)

install:
	uv sync --locked

dev:
	mkdir -p "$(SYNAPSE_HOME)" "$(BACKEND_SANDBOX_HOME)"
	PYTHONPATH=. PYTHONIOENCODING=utf-8 PYTHONUTF8=1 SYNAPSE_HOME="$(SYNAPSE_HOME)" uv run --locked uvicorn app.gateway.app:app --host 0.0.0.0 --port 8001 \
		--reload \
		--reload-include='*.yaml' \
		--reload-include='.env' \
		--reload-exclude='*.pyc' \
		--reload-exclude='__pycache__' \
		--reload-exclude="$(BACKEND_SANDBOX_HOME)" \
		--reload-exclude="$(SYNAPSE_HOME)"

gateway:
	PYTHONPATH=. PYTHONIOENCODING=utf-8 PYTHONUTF8=1 uv run --locked uvicorn app.gateway.app:app --host 0.0.0.0 --port 8001

test:
	PYTHONPATH=. PYTHONIOENCODING=utf-8 PYTHONUTF8=1 uv run pytest -m "not live" tests/ -v

test-live:
	SYNAPSE_RUN_LIVE_TESTS=1 PYTHONPATH=. PYTHONIOENCODING=utf-8 PYTHONUTF8=1 uv run pytest -m live tests/ -v -s

test-blocking-io:
	PYTHONPATH=. PYTHONIOENCODING=utf-8 PYTHONUTF8=1 uv run pytest tests/blocking_io -q --tb=short

lint:
	uv run ruff check .
	uv run ruff format --check .

format:
	uv run ruff check . --fix && uv run ruff format .

detect-blocking-io:
	@PYTHONPATH=. PYTHONIOENCODING=utf-8 PYTHONUTF8=1 uv run python ../scripts/detect_blocking_io_static.py --output ../.synapse/blocking-io-findings.json

migrate-rev:
	@if [ -z "$(MSG)" ]; then echo 'usage: make migrate-rev MSG="describe the change"'; exit 1; fi
	PYTHONPATH=. PYTHONIOENCODING=utf-8 PYTHONUTF8=1 uv run python scripts/_autogen_revision.py "$(MSG)"
