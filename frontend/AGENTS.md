# AGENTS.md - SynapseAI Frontend

This file provides guidance to AI coding agents when working with the SynapseAI frontend.

## Project Overview

SynapseAI Frontend is a Next.js 16 web interface for an AI agent system. It communicates with a LangGraph-based backend to provide thread-based AI conversations with streaming responses, artifacts, and a skills/tools system.

**Stack**: Next.js 16, React 19, TypeScript 5.8, Tailwind CSS 4, pnpm 10.26.2. Requires Node.js 22+ and pnpm 10.26.2+.

### Core Dependencies

- **LangGraph SDK** (`@langchain/langgraph-sdk` ^1.5.3) — Agent orchestration and streaming
- **LangChain Core** (`@langchain/core` ^1.1.15) — Fundamental AI building blocks
- **TanStack Query** (`@tanstack/react-query` ^5.90.17) — Server state management
- **UI**: Shadcn UI, Radix UI, Tailwind CSS

## Commands

| Command | Purpose |
|---------|---------|
| `pnpm dev` | Dev server with Turbopack (http://localhost:3000) |
| `pnpm build` | Production build |
| `pnpm check` | Lint + type check (run before committing) |
| `pnpm lint` | ESLint only |
| `pnpm lint:fix` | ESLint with auto-fix |
| `pnpm format` | Prettier check |
| `pnpm test` | Run unit tests with Rstest |
| `pnpm test:e2e` | Run E2E tests with Playwright (Chromium) |
| `pnpm typecheck` | TypeScript type check |
| `pnpm start` | Start production server |

## Architecture

```
Frontend (Next.js) → LangGraph SDK → LangGraph Backend (lead_agent)
                                            ├── Sub-Agents
                                            └── Tools & Skills
```

The frontend is a stateful chat application. Users create **threads** (conversations), send messages, set thread-scoped goals, and receive streamed AI responses.

### Source Layout (`src/`)

- **`app/`** — Next.js App Router routes
- **`components/`** — React components
  - `ui/` — Shadcn UI primitives
  - `workspace/` — Chat page components
  - `landing/` — Landing page sections
- **`core/`** — Business logic
  - `threads/` — Thread management
  - `api/` — API client
  - `auth/` — Authentication
  - `memory/` — Memory system
  - `skills/` — Skill management
  - `settings/` — User settings
- **`hooks/`** — Shared React hooks
- **`lib/** — Utilities

## Code Style

- **Imports**: Enforced ordering, alphabetized
- **Unused variables**: Prefix with `_`
- **Class names**: Use `cn()` from `@/lib/utils`
- **Path alias**: `@/*` maps to `src/*`

## Environment Variables

```env
# Backend API URLs (optional, nginx proxy used by default)
NEXT_PUBLIC_BACKEND_BASE_URL=http://localhost:8001
NEXT_PUBLIC_LANGGRAPH_BASE_URL=http://localhost:8001/api
```

## Testing

- **Unit tests**: `tests/unit/` with Rstest
- **E2E tests**: `tests/e2e/` with Playwright
- **DOM tests**: `.dom.test.ts` files for React component tests

## Resources

- [LangGraph Documentation](https://langchain-ai.github.io/langgraph/)
- [Next.js App Router](https://nextjs.org/docs/app)
- [TanStack Query](https://tanstack.com/query/latest)

## Contributing

1. Follow the established `src/` structure
2. Add TypeScript types and error handling
3. Write tests under `tests/unit/` and `tests/e2e/`
4. Run `pnpm check` before committing
5. Update this file when architecture changes
