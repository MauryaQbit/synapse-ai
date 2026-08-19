# Contributing to SynapseAI

Thank you for your interest in contributing to SynapseAI! This guide will help you set up your development environment and understand our development workflow.

## Development Environment Setup

We offer two development environments. **Docker is recommended** for the most consistent and hassle-free experience.

### Option 1: Docker Development (Recommended)

Docker provides a consistent, isolated environment with all dependencies pre-configured.

#### Prerequisites

- Docker Desktop or Docker Engine
- pnpm (for frontend)

#### Setup Steps

1. **Configure the application**:
   ```bash
   # Copy example configuration
   cp config.example.yaml config.yaml
   
   # Set your API keys
   export OPENAI_API_KEY="your-key-here"
   # or edit config.yaml directly
   ```

2. **Start Docker services**:
   ```bash
   make docker-up
   ```

3. **Access the application**:
   - Frontend: http://localhost:2026
   - API: http://localhost:8001

### Option 2: Local Development

#### Prerequisites

- Python 3.12+
- Node.js 22+
- pnpm 10.26.2+

#### Setup Steps

1. **Install dependencies**:
   ```bash
   make install
   ```

2. **Configure the application**:
   ```bash
   cp config.example.yaml config.yaml
   ```

3. **Start development servers**:
   ```bash
   make dev
   ```

## Development Workflow

### Code Style

- **Python**: ruff with line length 120
- **TypeScript**: ESLint + Prettier
- **Testing**: pytest (backend), Rstest (frontend)

### Testing

```bash
# Run all tests
make test

# Run specific test file
cd backend && uv run pytest tests/test_specific.py -v

# Run with coverage
cd backend && uv run pytest --cov=synapse tests/
```

### Code Quality

```bash
# Check code style
make lint

# Format code
make format

# Type checking
cd frontend && pnpm typecheck
```

## Project Structure

```
synapse-ai/
├── backend/
│   ├── packages/
│   │   ├── harness/          # Core agent framework
│   │   └── extension-api/    # Extension contracts
│   └── app/                  # FastAPI Gateway
├── frontend/                 # Next.js frontend
├── skills/                   # Agent skills
├── docs/                     # Documentation
└── docker/                   # Docker configuration
```

## Key Components

### Backend

- **Lead Agent**: Main orchestrator using LangGraph
- **Middleware Chain**: 15 essential middlewares
- **Tool System**: Built-in + MCP + Community tools
- **Memory Engine**: Persistent conversation memory
- **Sandbox**: Isolated code execution

### Frontend

- **Next.js 16**: React 19 with App Router
- **Tailwind CSS**: Modern styling
- **TanStack Query**: Server state management
- **LangGraph SDK**: Agent communication

## Contributing Guidelines

### 1. Fork and Clone

```bash
git clone https://github.com/your-username/synapse-ai.git
cd synapse-ai
git remote add upstream https://github.com/MauryaQbit/synapse-ai.git
```

### 2. Create a Branch

```bash
git checkout -b feature/your-feature-name
```

### 3. Make Changes

- Follow the code style guidelines
- Write tests for new features
- Update documentation as needed

### 4. Test Your Changes

```bash
make test
make lint
```

### 5. Submit a Pull Request

- Provide a clear description
- Reference any related issues
- Include screenshots for UI changes

## Reporting Issues

- Use the GitHub issue tracker
- Include reproduction steps
- Provide environment details
- Attach relevant logs

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Attribution

This project is based on DeerFlow by ByteDance. We acknowledge the original authors for their contributions.
