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

<p align="center">
  <a href="./README.md">English</a>
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

## 关于 NERV-CODE

**NERV-CODE** 是一个以《新世纪福音战士》(Neon Genesis Evangelion) 为主题重构的 Claude Code CLI (v2.1.88)。通过 npm 包的 sourcemap 还原完整的 TypeScript 源码，并融合 NERV/MAGI 风格主题。

**这是一个研究 & 粉丝项目** — 所有功能来自原始 Claude Code，我们只添加了 NERV 的"皮肤"。

---

## 快速开始

### 系统要求

- **Node.js** >= 18
- **Anthropic API Key** (用于实际对话)

### 一键安装

#### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/805979518/NERV-CODE/main/install.ps1 | iex
```

安装程序会：
1. 从 GitHub 下载并解压 NERV-CODE
2. 安装依赖 (Bun 或 npm)
3. 构建项目
4. 复制文件到 `%LOCALAPPDATA%\Programs\NERV-CODE`
5. 创建 `nerv` 命令
6. **提示输入 API Key 和 Base URL 配置**
7. 设置环境变量

安装完成后，重启终端，输入 `nerv` 即可启动。

#### Linux/macOS

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/805979518/NERV-CODE/main/install.sh)
```

### 安装后使用

```bash
nerv                    # 交互模式
nerv --version         # 查看版本
nerv --help            # 查看帮助
nerv -p "你好"          # 管道模式
```

### 配置

安装程序会在以下位置创建配置文件：
- **Windows**: `%LOCALAPPDATA%\Programs\NERV-CODE\config.json`
- **Linux/macOS**: `~/.nerv-config.json`

也可以通过环境变量设置：

```powershell
# Windows PowerShell
$env:ANTHROPIC_API_KEY = "sk-ant-your-key-here"
$env:ANTHROPIC_BASE_URL = "https://api.anthropic.com"
```

或直接编辑配置文件：

```json
{
  "apiKey": "sk-ant-your-key-here",
  "baseUrl": "https://api.anthropic.com"
}
```

---

## 架构

```
┌─────────────────────────────────────────────────────────┐
│                    NERV CODE CLI                         │
│              src/entrypoints/cli.tsx                     │
├─────────────────────────────────────────────────────────┤
│  MELCHIOR-1          BALTHASAR-2         CASPER-3       │
│  ┌─────────────┐    ┌──────────────┐   ┌────────────┐  │
│  │   对话引擎   │    │    工具系统   │   │   服务层   │  │
│  │             │    │  (45 个工具)  │   │            │  │
│  │ query.ts    │◄──►│ BashTool     │   │  API 客户端│  │
│  │ QueryEngine │    │ FileEdit     │   │  MCP 协议  │  │
│  │             │    │ AgentTool    │   │  上下文压缩 │  │
│  │             │    │ MCPTool      │   │  Hooks     │  │
│  │             │    │ ...          │   │  ...       │  │
│  └─────────────┘    └──────────────┘   └────────────┘  │
├─────────────────────────────────────────────────────────┤
│                   Terminal Dogma                         │
│  ┌─────────────┐  ┌──────────────┐  ┌───────────────┐  │
│  │ REPL UI     │  │ 权限系统     │  │ 设置层级      │  │
│  │ (React/Ink) │  │ (6 种模式)   │  │ (5 级继承)    │  │
│  └─────────────┘  └──────────────┘  └───────────────┘  │
└─────────────────────────────────────────────────────────┘
```

### 核心模块

| 模块 | 路径 | 职责 |
|------|------|------|
| 启动器 | `src/main.tsx` | CLI 初始化、命令路由 |
| 对话引擎 | `src/query.ts` + `src/QueryEngine.ts` | 有状态异步生成器、流式 SSE |
| 工具 | `src/tools/` (45 个工具) | BashTool, FileEdit, AgentTool, MCPTool 等 |
| 命令 | `src/commands/` (80+ 个命令) | commit, review, config 等 CLI 命令 |
| 组件 | `src/components/` | React (Ink) TUI 组件 |
| 服务 | `src/services/` | API 客户端、MCP、上下文压缩 |

---

## NERV 主题系统

### 配色系统 (`nerv-dark` 主题)

| 颜色 | Hex | 用途 |
|------|-----|------|
| `nerv-red` | `#B7282E` | 主品牌色、Logo、重点 |
| `nerv-red-light` | `#D4494F` | 悬停状态、闪烁效果 |
| `terminal-black` | `#0A0A0C` | 主背景 |
| `text-primary` | `#E8E6E3` | 主文字 |
| `eva-purple` | `#6B3FA0` | 智能体配色 (EVA Unit-01) |
| `eva-orange` | `#E87D2A` | 智能体配色 (EVA Unit-00) |

### 六边形主题

所有菱形图标 (`◇`/`◆`) 替换为六边形 (`⬡`/`⬢`)，参考 AT Field 几何结构和 MAGI 六边形显示面板。

### MAGI Spinner 动词 (60+)

```
MAGI Analyzing...        Pattern Blue Scanning...     AT Field Calculating...
CASPER Processing...      BALTHASAR Evaluating...      MELCHIOR Reasoning...
Terminal Dogma Accessing... Entry Plug Connecting...   S2 Engine Initializing...
Dead Sea Scrolls Parsing... SEELE Protocol Decrypting... Eva Cage Preparing...
```

---

## 项目结构

```
NERV-CODE/
├── src/                        # TypeScript 源码 (1,884 文件)
│   ├── entrypoints/cli.tsx     # CLI 入口点
│   ├── main.tsx                # 引导和命令路由
│   ├── tools/                  # 45 工具实现
│   ├── commands/               # 80+ CLI 命令
│   ├── services/               # API、MCP、压缩等
│   ├── components/             # React (Ink) TUI 组件
│   ├── constants/              # NERV 主题提示语和动词
│   └── utils/                  # Git、模型、认证、设置
├── shims/                      # 构建时模块填充
├── scripts/                    # 构建和工具脚本
│   ├── copy-sdks.ps1          # SDK 复制脚本 (Windows)
│   └── nerv.bat               # Windows 入口脚本
├── docs/                       # 文档
├── .github/                    # Issue 和 PR 模板
├── build.ts                    # Bun 打包配置
├── install.ps1                 # 一键安装脚本 (Windows)
├── install.sh                  # 一键安装脚本 (Unix)
├── package.json               # 依赖 (84+)
└── tsconfig.json              # TypeScript 配置
```

---

## 致谢

本项目站在巨人的肩膀上：
- **[Ax1i1om/NERV-CODE](https://github.com/Ax1i1om/NERV-CODE)** — NERV-CODE 原设计者
- **[zxdxjtu/claude-code-sourcemap](https://github.com/zxdxjtu/claude-code-sourcemap)** — 原始 sourcemap 提取和源码还原方法论
- **[ChinaSiro/claude-code-sourcemap](https://github.com/ChinaSiro/claude-code-sourcemap)** — 构建系统、文档和社区贡献

### 免责声明

- **Claude Code** 源码版权归 [Anthropic, PBC](https://www.anthropic.com) 所有。本项目从公开的 npm 包重构，仅用于**研究和教育目的**，不可商业使用。
- **新世纪福音战士** (新世紀エヴァンゲリオン) 由庵野秀明 / Gainax / khara, Inc. 创作。本项目中所有 NERV/MAGI/EVA 引用均为**粉丝致敬，仅供娱乐**。与权利持有人无任何关联或背书。

---

## 许可证

[MIT 许可证](LICENSE)

**重要**: 原始 Claude Code 源码版权归 Anthropic, PBC 所有。EVA/NERV 引用为粉丝致敬 — 见 [LICENSE](LICENSE) 完整声明。

---

<p align="center">
  <b>NERV — God's in his heaven. All's right with the world.</b><br/>
  <sub>⬡ MELCHIOR-1: APPROVE ⬡ BALTHASAR-2: APPROVE ⬡ CASPER-3: APPROVE ⬡</sub>
</p>
