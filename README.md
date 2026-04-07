<p align="center">
  <img src="https://img.shields.io/badge/NERV-CODE-cc1418?style=for-the-badge&labelColor=0A0A0C" alt="NERV CODE" />
  <img src="https://img.shields.io/badge/MAGI_SYSTEM-ONLINE-2D8B46?style=for-the-badge&labelColor=0A0A0C" alt="MAGI SYSTEM ONLINE" />
  <img src="https://img.shields.io/badge/version-2.1.88-D4494F?style=for-the-badge&labelColor=0A0A0C" alt="Version" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-blue?style=flat-square" alt="License" />
  <img src="https://img.shields.io/badge/node-%3E%3D18.0.0-green?style=flat-square" alt="Node" />
  <img src="https://img.shields.io/badge/bun-%3E%3D1.0-orange?style=flat-square" alt="Bun" />
  <img src="https://img.shields.io/badge/base-Claude_Code_v2.1.88-8C1C22?style=flat-square" alt="Base Version" />
</p>

```
 ███╗   ██╗███████╗██████╗ ██╗   ██╗     ██████╗ ██████╗ ██████╗ ███████╗
 ████╗  ██║██╔════╝██╔══██╗██║   ██║    ██╔════╝██╔═══██╗██╔══██╗██╔════╝
 ██╔██╗ ██║█████╗  ██████╔╝██║   ██║    ██║     ██║   ██║██║  ██║█████╗
 ██║╚██╗██║██╔══╝  ██╔══██╗╚██╗ ██╔╝    ██║     ██║   ██║██║  ██║██╔══╝
 ██║ ╚████║███████╗██║  ██║ ╚████╔╝     ╚██████╗╚██████╔╝██████╔╝███████╗
 ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝  ╚═══╝      ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
```

<p align="center">
  <b>God's in his heaven. All's right with the world.</b>
</p>

---

## About NERV-CODE

**NERV-CODE** is a Claude Code CLI (v2.1.88) themed after Neon Genesis Evangelion. It restores complete TypeScript source code through npm package sourcemaps and applies the NERV/MAGI aesthetic theme.

**This is a research & fan project** — all functionality comes from the original Claude Code. We only added the NERV "skin".

---

## Quick Start

### Prerequisites

- **Node.js** >= 18
- **Anthropic API Key** (for actual conversations)

### One-Click Installation

#### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/805979518/NERV-CODE/main/install.ps1 | iex
```

The installer will:
1. Download and extract NERV-CODE from GitHub
2. Install dependencies (Bun or npm)
3. Build the project
4. Copy files to `%LOCALAPPDATA%\Programs\NERV-CODE`
5. Create the `nerv` command
6. **Prompt for API Key and Base URL configuration**
7. Set up environment variables

After installation, restart your terminal and run `nerv` to start.

#### Linux/macOS

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/805979518/NERV-CODE/main/install.sh)
```

### Post-Installation Usage

```bash
nerv                    # Interactive mode
nerv --version          # Show version
nerv --help             # Show help
nerv -p "hello"         # Pipe mode
```

### Configuration

The installer creates a configuration file at:
- **Windows**: `%LOCALAPPDATA%\Programs\NERV-CODE\config.json`
- **Linux/macOS**: `~/.nerv-config.json`

You can also set environment variables:

```powershell
# Windows PowerShell
$env:ANTHROPIC_API_KEY = "sk-ant-your-key-here"
$env:ANTHROPIC_BASE_URL = "https://api.anthropic.com"
```

Or edit the config file directly:

```json
{
  "apiKey": "sk-ant-your-key-here",
  "baseUrl": "https://api.anthropic.com"
}
```

---

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    NERV CODE CLI                         │
│              src/entrypoints/cli.tsx                     │
├─────────────────────────────────────────────────────────┤
│  MELCHIOR-1          BALTHASAR-2         CASPER-3       │
│  ┌─────────────┐    ┌──────────────┐   ┌────────────┐  │
│  │ Conversation │    │    Tools     │   │  Services  │  │
│  │   Engine     │    │  (45 tools)  │   │            │  │
│  │             │    │              │   │  API       │  │
│  │ query.ts    │◄──►│ BashTool     │   │  MCP       │  │
│  │ QueryEngine │    │ FileEdit     │   │  Compact   │  │
│  │             │    │ AgentTool    │   │  Hooks     │  │
│  │             │    │ MCPTool      │   │  Auth      │  │
│  │             │    │ ...          │   │  ...       │  │
│  └─────────────┘    └──────────────┘   └────────────┘  │
├─────────────────────────────────────────────────────────┤
│                   Terminal Dogma                         │
│  ┌─────────────┐  ┌──────────────┐  ┌───────────────┐  │
│  │ REPL UI     │  │ Permissions  │  │ Settings      │  │
│  │ (React/Ink) │  │ (6 modes)    │  │ (5 levels)    │  │
│  └─────────────┘  └──────────────┘  └───────────────┘  │
└─────────────────────────────────────────────────────────┘
```

### Core Modules

| Module | Path | Responsibility |
|--------|------|----------------|
| Bootstrap | `src/main.tsx` | CLI initialization, command routing |
| Conversation Engine | `src/query.ts` + `src/QueryEngine.ts` | Stateful async generator, streaming SSE |
| Tools | `src/tools/` (45 tools) | BashTool, FileEdit, AgentTool, MCPTool etc. |
| Commands | `src/commands/` (80+ commands) | CLI commands (commit, review, config etc.) |
| Components | `src/components/` | React (Ink) TUI components |
| Services | `src/services/` | API client, MCP, context compression |

---

## NERV Theme System

### Color System (`nerv-dark` theme)

| Color | Hex | Usage |
|-------|-----|-------|
| `nerv-red` | `#B7282E` | Main brand color, logo, accents |
| `nerv-red-light` | `#D4494F` | Hover states, glow effects |
| `terminal-black` | `#0A0A0C` | Main background |
| `text-primary` | `#E8E6E3` | Main text |
| `eva-purple` | `#6B3FA0` | Agent color (EVA Unit-01) |
| `eva-orange` | `#E87D2A` | Agent color (EVA Unit-00) |

### Hexagon Theme

All diamond icons (`◇`/`◆`) replaced with hexagons (`⬡`/`⬢`), referencing AT Field geometry and MAGI hexagonal display panels.

### MAGI Spinner Verbs (60+)

```
MAGI Analyzing...        Pattern Blue Scanning...     AT Field Calculating...
CASPER Processing...      BALTHASAR Evaluating...      MELCHIOR Reasoning...
Terminal Dogma Accessing... Entry Plug Connecting...   S2 Engine Initializing...
Dead Sea Scrolls Parsing... SEELE Protocol Decrypting... Eva Cage Preparing...
```

---

## Project Structure

```
NERV-CODE/
├── src/                        # TypeScript source (1,884 files)
│   ├── entrypoints/cli.tsx     # CLI entry point
│   ├── main.tsx                # Bootstrap and command routing
│   ├── tools/                  # 45 tool implementations
│   ├── commands/               # 80+ CLI commands
│   ├── services/               # API, MCP, compression etc.
│   ├── components/             # React (Ink) TUI components
│   ├── constants/              # NERV theme prompts and verbs
│   └── utils/                  # Git, models, auth, settings
├── shims/                      # Build-time module shims
├── scripts/                    # Build and tool scripts
│   ├── copy-sdks.ps1          # SDK copy script (Windows)
│   └── nerv.bat               # Windows entry script
├── docs/                       # Documentation
├── .github/                    # Issue and PR templates
├── build.ts                    # Bun bundler configuration
├── install.ps1                 # One-click install script (Windows)
├── install.sh                  # One-click install script (Unix)
├── package.json                # Dependencies (84+)
└── tsconfig.json               # TypeScript configuration
```

---

## Acknowledgments

This project stands on the shoulders of giants:
- **[Ax1i1om/NERV-CODE](https://github.com/Ax1i1om/NERV-CODE)** — Original NERV-CODE designer
- **[zxdxjtu/claude-code-sourcemap](https://github.com/zxdxjtu/claude-code-sourcemap)** — Original sourcemap extraction and source restoration methodology
- **[ChinaSiro/claude-code-sourcemap](https://github.com/ChinaSiro/claude-code-sourcemap)** — Build system, documentation and community contributions

### Disclaimer

- **Claude Code** source code is copyright [Anthropic, PBC](https://www.anthropic.com). This project reconstructs from publicly available npm packages, for **research and educational purposes only**, not for commercial use.
- **Neon Genesis Evangelion** (新世纪エヴァンゲリオン) created by Hideaki Anno / Gainax / khara, Inc. All NERV/MAGI/EVA references in this project are **fan tributes, for entertainment only**. No affiliation or endorsement by rights holders.

---

## License

[MIT License](LICENSE)

**Important**: Original Claude Code source is copyright Anthropic, PBC. EVA/NERV references are fan tributes — see [LICENSE](LICENSE) for full disclaimer.

---

<p align="center">
  <b>NERV — God's in his heaven. All's right with the world.</b><br/>
  <sub>⬡ MELCHIOR-1: APPROVE ⬡ BALTHASAR-2: APPROVE ⬡ CASPER-3: APPROVE ⬡</sub>
</p>
