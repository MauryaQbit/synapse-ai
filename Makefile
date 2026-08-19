# SynapseAI - Intelligent Agent Orchestration Platform

.PHONY: help config check install dev start stop clean test lint format docker-up docker-down docker-logs

BASH ?= bash
BACKEND_UV_RUN = cd backend && uv run

# Detect OS for Windows compatibility
ifeq ($(OS),Windows_NT)
    SHELL := cmd.exe
    PYTHON ?= python
    RUN_WITH_GIT_BASH = call scripts\run-with-git-bash.cmd
else
    PYTHON ?= python3
    RUN_WITH_GIT_BASH =
endif

FRONTEND_PNPM = $(PYTHON) ../scripts/pnpm.py

help:
	@echo "SynapseAI Development Commands:"
	@echo ""
	@echo "  make setup           - Interactive setup wizard"
	@echo "  make config          - Generate local config files"
	@echo "  make check           - Check system requirements"
	@echo "  make install         - Install all dependencies"
	@echo ""
	@echo "Development:"
	@echo "  make dev             - Start all services (hot-reload)"
	@echo "  make start           - Start production services"
	@echo "  make stop            - Stop all services"
	@echo "  make clean           - Clean up temporary files"
	@echo ""
	@echo "Testing & Quality:"
	@echo "  make test            - Run all tests"
	@echo "  make lint            - Check code style"
	@echo "  make format          - Format code"
	@echo ""
	@echo "Docker:"
	@echo "  make docker-up       - Start Docker services"
	@echo "  make docker-down     - Stop Docker services"
	@echo "  make docker-logs     - View Docker logs"

## Setup
config:
	@$(PYTHON) ./scripts/configure.py

check:
	@$(PYTHON) ./scripts/check.py

install:
	@echo "Installing backend dependencies..."
	@cd backend && uv sync --locked
	@echo "Installing frontend dependencies..."
	@cd frontend && $(FRONTEND_PNPM) install
	@echo "✓ All dependencies installed"

## Development
dev:
	@echo "Starting SynapseAI in development mode..."
	@$(RUN_WITH_GIT_BASH) ./scripts/serve.sh --dev

start:
	@echo "Starting SynapseAI in production mode..."
	@$(RUN_WITH_GIT_BASH) ./scripts/serve.sh --prod

stop:
	@echo "Stopping services..."
	@$(RUN_WITH_GIT_BASH) ./scripts/serve.sh --stop

clean:
	@echo "Cleaning temporary files..."
	@rm -rf .deer-flow
	@rm -rf backend/.deer-flow
	@rm -rf frontend/.next
	@echo "✓ Cleaned"

## Testing & Quality
test:
	@echo "Running backend tests..."
	@cd backend && uv run pytest tests/ -v --tb=short
	@echo "Running frontend tests..."
	@cd frontend && $(FRONTEND_PNPM) test

lint:
	@echo "Checking code style..."
	@cd backend && uv run ruff check .
	@cd frontend && $(FRONTEND_PNPM) lint

format:
	@echo "Formatting code..."
	@cd backend && uv run ruff format .
	@cd frontend && $(FRONTEND_PNPM) format:write

## Docker
docker-up:
	@echo "Starting Docker services..."
	@docker compose -f docker/docker-compose.yaml up -d

docker-down:
	@echo "Stopping Docker services..."
	@docker compose -f docker/docker-compose.yaml down

docker-logs:
	@docker compose -f docker/docker-compose.yaml logs -f
