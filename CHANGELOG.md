# Changelog

All notable changes to SynapseAI will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-08-20

### Added

- **Initial Release**: SynapseAI v1.0.0 - Intelligent Agent Orchestration Platform

#### Core Features

- **Simplified Architecture**: Reduced from SynapseAI's 42 middlewares to 15 essential components
- **Developer-Friendly Configuration**: Single `config.yaml` with ~200 lines instead of 1100+ line YAML
- **Clean Project Structure**: Reorganized for better maintainability

#### Agent System

- **Lead Agent**: Main orchestrator with LangGraph integration
- **Smart Tool Routing**: Intelligent tool selection and authorization
- **Goal-Driven Execution**: Autonomous task completion with progress tracking
- **Persistent Memory**: Long-term conversation context and knowledge extraction

#### Tool Integration

- **Built-in Tools**: Web search, code execution, file operations
- **MCP Protocol**: External tool integration via Model Context Protocol
- **Sandbox Execution**: Isolated code execution environment

#### User Interface

- **Modern Design**: Clean, responsive interface with real-time streaming
- **Dark Mode**: Full dark theme support
- **Voice Input**: Browser speech recognition integration
- **Document Processing**: Upload and analyze documents with automatic conversion

#### Development Experience

- **Simplified Setup**: One-command installation and configuration
- **Docker Support**: Containerized deployment with Docker Compose
- **Hot Reload**: Development servers with automatic reload
- **Comprehensive Testing**: Backend (pytest) and frontend (Rstest) test suites

#### Configuration

- **Single Config File**: Simplified `config.yaml` with clear documentation
- **Environment Variables**: Sensitive data via environment variables
- **Hot Reload**: Runtime configuration changes without restart

#### Security

- **Session Management**: Secure session handling with JWT
- **Rate Limiting**: Built-in rate limiting protection
- **CORS Protection**: Configurable cross-origin resource sharing
- **Path Traversal Protection**: File system security measures

#### Documentation

- **Comprehensive Guides**: Setup, configuration, and development documentation
- **API Reference**: Complete API documentation
- **Architecture Overview**: System design and component descriptions
- **Contributing Guidelines**: Clear contribution workflow

### Improved Over SynapseAI

| Aspect | SynapseAI 2.1.0 | SynapseAI 1.0.0 |
|--------|----------------|-----------------|
| Configuration | 46 modules, 1100+ lines | Single file, ~200 lines |
| Middlewares | 42 components | 15 essential components |
| IM Channels | 7+ platforms | 3 core channels |
| Community Tools | 21 integrations | 8 curated tools |
| Frontend Complexity | Multi-file components | Simplified, modular |
| Documentation | Extensive but scattered | Focused, developer-friendly |
| Setup Time | Complex multi-step | One-command installation |

### Technical Details

- **Python**: 3.12+ with modern type hints
- **Node.js**: 22+ with Next.js 16
- **LangGraph**: 1.2.9+ for agent orchestration
- **FastAPI**: 0.115.0+ for REST API
- **React**: 19.0.0 for frontend UI
- **TypeScript**: 5.8.2 for type safety

### Credits

This project is a derivative work based on [SynapseAI](https://github.com/bytedance/synapse-ai) by ByteDance, used under the MIT License. The original work has been substantially modified and redesigned.

---

## Previous SynapseAI Versions

For the original SynapseAI changelog, see [SynapseAI CHANGELOG.md](https://github.com/bytedance/synapse-ai/blob/main/CHANGELOG.md).
