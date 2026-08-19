# SynapseAI Documentation

## Overview

SynapseAI is an intelligent agent orchestration platform designed for simplicity and developer experience. It provides a clean, modular architecture for building AI agents with persistent memory, extensible tools, and goal-driven execution.

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

# Set your API key
export OPENAI_API_KEY="your-api-key"

# Start development servers
make dev
```

The application will be available at:
- **Frontend**: http://localhost:2026
- **API**: http://localhost:8001

## Configuration

### Main Configuration (`config.yaml`)

```yaml
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

### Environment Variables

Key environment variables:

```bash
# Required
OPENAI_API_KEY=your-openai-api-key

# Optional
ANTHROPIC_API_KEY=your-anthropic-api-key
GEMINI_API_KEY=your-gemini-api-key
TAVILY_API_KEY=your-tavily-api-key
```

## Architecture

### System Overview

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
| **Middleware Chain** | 15 essential processing components |
| **Tool System** | Built-in + MCP + Community tools |
| **Memory Engine** | Persistent conversation memory |
| **Sandbox** | Isolated code execution |
| **Goal Tracker** | Autonomous task completion |

## Features

### 1. Agent Orchestration

SynapseAI uses LangGraph for intelligent agent orchestration:

```python
from synapse.agents import make_lead_agent

# Create an agent
agent = make_lead_agent(config)

# Run a conversation
response = await agent.ainvoke({
    "messages": [{"role": "user", "content": "Hello!"}]
})
```

### 2. Tool Integration

#### Built-in Tools

- **web_search**: Search the internet
- **code_execution**: Execute code in sandbox
- **file_operations**: Read/write files
- **ask_clarification**: Ask user for input

#### MCP Tools

Connect to external MCP servers:

```yaml
# extensions_config.json
{
  "mcp_servers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    }
  }
}
```

### 3. Memory System

Persistent memory across conversations:

```yaml
memory:
  enabled: true
  backend: "sqlite"  # or "postgres"
  max_tokens: 10000
  summarization:
    enabled: true
    trigger_tokens: 8000
```

### 4. Goal-Driven Execution

Set goals and let agents work autonomously:

```python
# Set a goal
await agent.ainvoke({
    "goal": "Research and summarize the latest AI trends",
    "max_continuations": 5
})
```

### 5. Sandbox Execution

Isolated code execution environment:

```yaml
sandbox:
  enabled: true
  type: "local"  # or "docker"
  docker:
    image: "python:3.12-slim"
    timeout: 300
```

## API Reference

### REST API

The Gateway API runs on port 8001:

```bash
# List available models
curl http://localhost:8001/api/models

# Create a thread
curl -X POST http://localhost:8001/api/threads

# Send a message
curl -X POST http://localhost:8001/api/threads/{thread_id}/messages \
  -H "Content-Type: application/json" \
  -d '{"content": "Hello!"}'
```

### Streaming

Stream responses in real-time:

```javascript
const response = await fetch('/api/threads/{thread_id}/stream', {
  method: 'POST',
  body: JSON.stringify({ content: 'Hello!' })
});

const reader = response.body.getReader();
while (true) {
  const { done, value } = await reader.read();
  if (done) break;
  console.log(new TextDecoder().decode(value));
}
```

## Development

### Project Structure

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

### Commands

```bash
# Development
make dev              # Start all services
make test             # Run tests
make lint             # Check code style
make format           # Format code

# Docker
make docker-up        # Start Docker services
make docker-down      # Stop Docker services
make docker-logs      # View logs
```

### Testing

```bash
# Backend tests
cd backend && uv run pytest tests/ -v

# Frontend tests
cd frontend && pnpm test

# E2E tests
cd frontend && pnpm test:e2e
```

## Deployment

### Docker Deployment

```bash
# Build and start
make docker-up

# View logs
make docker-logs

# Stop services
make docker-down
```

### Production Deployment

```bash
# Build frontend
cd frontend && pnpm build

# Start production servers
make start
```

## Troubleshooting

### Common Issues

1. **Port already in use**
   ```bash
   # Kill processes on port 8001
   lsof -ti:8001 | xargs kill -9
   ```

2. **Database connection errors**
   ```bash
   # Reset database
   rm -f backend/synapse.db
   ```

3. **Memory issues**
   ```bash
   # Clear cache
   rm -rf frontend/.next
   rm -rf backend/__pycache__
   ```

### Getting Help

- 📖 [Documentation](docs/)
- 🐛 [Issue Tracker](https://github.com/MauryaQbit/synapse-ai/issues)
- 💬 [Discussions](https://github.com/MauryaQbit/synapse-ai/discussions)

## License

MIT License - see [LICENSE](LICENSE) for details.

**Attribution**: This project is based on [SynapseAI](https://github.com/MauryaQbit/synapse-ai) by ByteDance, used under MIT License.
