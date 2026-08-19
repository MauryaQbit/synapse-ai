# AGENTS.md - SynapseAI

This file provides guidance to AI coding agents when working with SynapseAI code.

## Project Overview

SynapseAI is a simplified AI agent orchestration platform built on LangGraph. It provides intelligent agent routing, persistent memory, and extensible tool integration.

**Architecture**:
- **Gateway API** (port 8001): FastAPI REST API + embedded agent runtime
- **Frontend** (port 3000): Next.js web interface
- **Nginx** (port 2026): Unified reverse proxy entry point

**Key Principles**:
1. **Simplicity First**: Reduced complexity from SynapseAI's 42 middlewares to 15 essential ones
2. **Developer Experience**: Clean APIs, minimal configuration
3. **Modular Design**: Easy to extend and customize
4. **Production Ready**: Built-in security, monitoring, and scaling

## Project Structure

```
synapse-ai/
├── backend/
│   ├── packages/
│   │   ├── harness/          # Core agent framework (synapse.*)
│   │   └── extension-api/    # Extension contracts (synapse_extension_api.*)
│   └── app/                  # FastAPI Gateway (app.*)
├── frontend/                 # Next.js frontend
├── skills/                   # Agent skills
├── docs/                     # Documentation
└── docker/                   # Docker configuration
```

## Commands

**Root directory**:
```bash
make dev          # Start all services
make test         # Run tests
make lint         # Check code style
make format       # Format code
make stop         # Stop services
```

**Backend directory**:
```bash
cd backend && make dev      # Gateway API only
cd backend && make test     # Backend tests
cd backend && make lint     # Lint code
```

**Frontend directory**:
```bash
cd frontend && pnpm dev     # Frontend dev server
cd frontend && pnpm test    # Frontend tests
cd frontend && pnpm check   # Lint + type check
```

## Development Guidelines

### Code Style
- **Python**: ruff with line length 120
- **TypeScript**: ESLint + Prettier
- **Testing**: pytest (backend), Rstest (frontend)

### Testing
- Write tests for new features
- Run full test suite before commits
- Use markers: `@pytest.mark.integration`, `@pytest.mark.live`

### Documentation
- Update README.md for user-facing changes
- Update this file for architecture changes
- Keep docs in sync with code

## Architecture Details

### Agent System

**Lead Agent** (`backend/packages/harness/synapse/agents/lead_agent/`):
- Entry point: `make_lead_agent(config)`
- Dynamic model selection
- Tool loading and authorization
- System prompt generation

**Middleware Chain** (15 essential components):
1. DynamicContextMiddleware - Date/memory injection
2. SkillActivationMiddleware - Skill loading
3. ToolErrorHandlingMiddleware - Tool error recovery
4. SummarizationMiddleware - Context management
5. TodoMiddleware - Task tracking
6. TitleMiddleware - Auto-titling
7. MemoryMiddleware - Long-term memory
8. ViewImageMiddleware - Vision support
9. SubagentLimitMiddleware - Concurrency control
10. LoopDetectionMiddleware - Loop breaking
11. TokenBudgetMiddleware - Token limits
12. ClarificationMiddleware - User clarification
13. TerminalResponseMiddleware - Response handling
14. ModelLengthFinishReasonMiddleware - Length detection
15. SafetyFinishReasonMiddleware - Safety checks

### Tool System

**Built-in Tools**:
- `web_search` - Internet search
- `code_execution` - Sandboxed code execution
- `file_operations` - File read/write
- `ask_clarification` - User interaction

**MCP Integration**:
- Connect to external MCP servers
- Dynamic tool discovery
- Secure execution

### Memory System

**Features**:
- Persistent conversation memory
- Auto-summarization
- Knowledge extraction
- Multi-session recall

**Backends**:
- SQLite (default)
- PostgreSQL (optional)

### Sandbox System

**Modes**:
- Local: Direct filesystem access
- Docker: Isolated containers

**Security**:
- Path traversal protection
- Command injection prevention
- Resource limits

## Configuration

See `config.yaml` for all options. Key sections:
- `models`: LLM provider configuration
- `tools`: Enabled tools and settings
- `memory`: Memory backend and behavior
- `sandbox`: Execution environment
- `goals`: Autonomous task tracking

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes with tests
4. Run `make test` and `make lint`
5. Submit a pull request

## License

MIT License - see LICENSE file for details.

**Attribution**: This project is based on SynapseAI by ByteDance, used under MIT License.
