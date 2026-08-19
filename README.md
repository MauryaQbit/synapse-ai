# ⚡ SynapseAI

**Intelligent Agent Orchestration Platform**

[![Python](https://img.shields.io/badge/Python-3.12%2B-3776AB?logo=python&logoColor=white)](./backend/pyproject.toml)
[![Node.js](https://img.shields.io/badge/Node.js-22%2B-339933?logo=node.js&logoColor=white)](./Makefile)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

> A simplified, developer-focused AI agent platform with intelligent orchestration, persistent memory, and extensible tool integration.

---

## What is SynapseAI?

SynapseAI is an open-source AI agent orchestration platform designed for **simplicity** and **developer experience**. It provides a clean, modular architecture for building intelligent agents that can:

- 🤖 Orchestrate multiple AI agents with intelligent routing
- 💾 Maintain persistent memory across conversations
- 🔧 Integrate with external tools via MCP protocol
- 📄 Execute code in sandboxed environments
- 🎯 Track and manage complex multi-step goals

### Key Improvements Over SynapseAI

| Feature | SynapseAI | SynapseAI |
|---------|----------|-----------|
| Configuration | 46 config modules, 1100+ line YAML | Single `config.yaml`, ~200 lines |
| Middleware | 42 middleware components | 15 essential middlewares |
| IM Channels | 7+ platform integrations | 3 core channels (Slack, Discord, Telegram) |
| Community Tools | 21 integrations | Curated 8 essential tools |
| Frontend | Complex multi-file components | Simplified, modular components |
| Documentation | Extensive but scattered | Focused, developer-friendly |

---

## Quick Start

### Prerequisites

- Python 3.12+
- Node.js 22+
- pnpm 10.26.2+

### Installation

```bash
# Clone the repository
git clone https://github.com/MauryaQbit/synapse-ai.git
cd synapse-ai

# Install dependencies
make install

# Configure the application
cp config.example.yaml config.yaml
cp extensions_config.example.json extensions_config.json

# Start development servers
make dev
```

The application will be available at `http://localhost:2026`.

### Docker Deployment

```bash
# Build and start with Docker
make up

# View logs
make docker-logs

# Stop services
make down
```

---

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                     Nginx (Port 2026)                   │
│                  Unified Entry Point                    │
└─────────────┬───────────────┬───────────────┬───────────┘
              │               │               │
┌─────────────▼───────┐ ┌─────▼─────────────┐ │
│   Frontend (3000)   │ │  Gateway (8001)   │ │
│   Next.js 16 App    │ │  FastAPI + Agent  │ │
│   React 19 UI       │ │  Runtime          │ │
└─────────────────────┘ └───────────────────┘ │
                                              │
                              ┌─────────────────┘
                              │
                    ┌─────────▼─────────┐
                    │  Agent Runtime    │
                    │  - Lead Agent     │
                    │  - Sub-Agents     │
                    │  - Tools          │
                    │  - Memory         │
                    └───────────────────┘
```

### Core Components

| Component | Purpose |
|-----------|---------|
| **Lead Agent** | Main orchestrator with LangGraph |
| **Middleware Chain** | Composable processing pipeline |
| **Tool System** | Built-in + MCP + Community tools |
| **Memory Engine** | Persistent conversation memory |
| **Sandbox** | Isolated code execution |
| **Goal Tracker** | Autonomous task completion |

---

## Configuration

SynapseAI uses a simplified configuration system:

```yaml
# config.yaml
app:
  name: "SynapseAI"
  version: "1.0.0"

models:
  - name: "gpt-4"
    provider: "openai"
    api_key: "${OPENAI_API_KEY}"
    
tools:
  enabled:
    - "web_search"
    - "code_execution"
    - "file_operations"

memory:
  enabled: true
  backend: "sqlite"

sandbox:
  enabled: true
  type: "local"
```

See [CONFIGURATION.md](docs/CONFIGURATION.md) for full details.

---

## Features

### 🎯 Goal-Driven Execution
Set goals and let agents autonomously work towards completion with automatic progress tracking.

### 🧠 Persistent Memory
Conversation context and learned knowledge persist across sessions.

### 🔧 Extensible Tools
Add new capabilities via MCP servers or custom Python tools.

### 📄 Document Processing
Upload and analyze documents with automatic conversion.

### 🎨 Modern UI
Clean, responsive interface with real-time streaming responses.

---

## Development

### Commands

```bash
make dev          # Start all services
make test         # Run backend tests
make lint         # Check code style
make format       # Format code
```

### Project Structure

```
synapse-ai/
├── backend/           # Python backend
│   ├── packages/      # Core packages
│   │   ├── harness/   # Agent framework
│   │   └── api/       # REST API
│   └── tests/         # Test suite
├── frontend/          # Next.js frontend
│   ├── src/           # Source code
│   └── tests/         # Frontend tests
├── skills/            # Agent skills
├── docs/              # Documentation
└── docker/            # Docker configuration
```

---

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Development Workflow

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Run `make test` and `make lint`
6. Submit a pull request

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Attribution

This project is a derivative work based on [SynapseAI](https://github.com/bytedance/synapse-ai) by ByteDance, used under the MIT License. The original work has been substantially modified and redesigned.

---

## Support

- 📖 [Documentation](docs/)
- 🐛 [Issue Tracker](https://github.com/MauryaQbit/synapse-ai/issues)
- 💬 [Discussions](https://github.com/MauryaQbit/synapse-ai/discussions)
