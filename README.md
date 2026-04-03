<p align="center">
  <img src="https://img.shields.io/badge/NERV-CODE-cc1418?style=for-the-badge&labelColor=0A0A0C" alt="NERV CODE" />
  <img src="https://img.shields.io/badge/MAGI_SYSTEM-ONLINE-2D8B46?style=for-the-badge&labelColor=0A0A0C" alt="MAGI SYSTEM ONLINE" />
  <img src="https://img.shields.io/badge/version-序:1.0.0-D4494F?style=for-the-badge&labelColor=0A0A0C" alt="Version" />
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

##本项目完全建立在**[Ax1i1om/NERV-CODE](https://github.com/Ax1i1om/NERV-CODE)**之上，做了Windows适配，以及Minimax API适配。

## ⬡ 一键安装 (One-Click Install)

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/805979518/NERV-CODE/main/install.ps1 | iex
```

安装后重启终端，输入 `nerv` 即可启动。

---

## 第壱話: MAGI System Online

**NERV-CODE** 是以《新世纪福音战士》(Neon Genesis Evangelion) 为主题重构的 Claude Code CLI (v2.1.88)。通过 npm 包的 sourcemap 还原完整的 TypeScript 源码，并融合 NERV/MAGI 风格主题。

**这是一个研究 & 粉丝项目** — 所有功能来自原始 Claude Code，我们只添加了 NERV 的"皮肤"。

---

## 第弐話: 功能特点

- **NERV 主题界面** — NERV 红 (#B7282E) 配色、六边形 AT Field 元素
- **MAGI System 身份** — AI 自我介绍为 NERV 人工智能部门操作终端
- **完整 Claude Code 功能** — 45+ 工具、80+ 命令、多智能体系统
- **EVA 风格提示语** — 60+ NERV 主题 spinner 动词 (MAGI Analyzing、AT Field Calculating...)
- **交互式 TUI** — React/Ink 构建的终端界面

---

## 第参話: 快速开始

### 系统要求

- **Node.js** >= 18
- **Bun** >= 1.0 (推荐，用于构建)
- **Anthropic API Key** (用于实际对话)

### 安装后运行

```bash
nerv                    # 交互模式
nerv --version         # 查看版本
nerv --help             # 查看帮助
nerv -p "你好"          # 管道模式
```

### API Key 配置

设置环境变量：
```powershell
# Windows PowerShell
$env:ANTHROPIC_API_KEY = "sk-ant-your-key-here"
```

或在命令行运行：
```bash
ANTHROPIC_API_KEY=sk-ant-your-key-here nerv -p "hello"
```

---

## 第肆話: 架构 — MAGI System Configuration

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

### 核心模块

| 模块 | 路径 | 职责 |
|------|------|------|
| Bootstrap | `src/main.tsx` | CLI 初始化、命令路由 |
| Conversation Engine | `src/query.ts` + `src/QueryEngine.ts` | 状态机异步生成器、流式 SSE |
| Tools | `src/tools/` (45 工具) | BashTool、FileEdit、AgentTool、MCPTool 等 |
| Commands | `src/commands/` (80+ 命令) | CLI 命令 (commit、review、config 等) |
| Components | `src/components/` | React (Ink) TUI 组件 |
| Services | `src/services/` | API 客户端、MCP、上下文压缩 |

### 多智能体系统

三种智能体类型，EVA 风格隔离级别：

| 类型 | 隔离级别 | EVA 类比 |
|------|---------|---------|
| **SubAgent** | 完全上下文隔离 | 独立插入栓 |
| **Fork** | 共享提示缓存 | 虚拟插入栓系统 |
| **Teammate** | 独立进程、文件邮箱 | 多EVA出击 |

---

## 第伍話: NERV 主题系统

### 色彩系统 (`nerv-dark` 主题)

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

### 欢迎界面

带无花果叶剪影的 NERV 标志，以 NERV 红色渲染。

> *God's in his heaven. All's right with the world.*

---

## 作戦計画: 路线图

| 阶段 | 版本 | 代号 | 状态 | 描述 |
|------|------|------|------|------|
| **序** | 1.0.0 | You Are (Not) Alone | **当前** | 初始开源发布。源码还原 + NERV 主题化。 |
| **破** | 2.0.0 | You Can (Not) Advance | 计划中 | 扩展主题化（错误界面、权限提示、生命周期消息）。插件系统。 |
| **Q** | 3.0.0 | You Can (Not) Redo | 计划中 | 重构。多智能体自定义 MAGI 共识模式。 |
| **終** | 3.0+1.0 | Thrice Upon a Time | 计划中 | 功能完整。稳定发布。完整 NERV 集成。 |

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
│   └── utils/                 # Git、模型、认证、设置
├── shims/                      # 构建时模块填充
├── scripts/                    # 构建和工具脚本
│   ├── copy-sdks.ps1          # SDK 复制脚本 (Windows)
│   └── nerv.bat               # Windows 入口脚本
├── docs/                       # 文档
├── .github/                    # Issue 和 PR 模板
├── build.ts                    # Bun 打包配置
├── install.sh                  # 一键安装脚本 (Unix)
├── install.ps1                 # 一键安装脚本 (Windows)
├── package.json               # 依赖 (84+)
└── tsconfig.json              # TypeScript 配置
```

---

## 构建系统

使用 **Bun Bundler** 通过 4 个自定义插件将 TypeScript 编译为单个 ESM bundle：

| 插件 | 用途 |
|------|------|
| `bun-bundle-shim` | 将构建时 `feature()` 转换为运行时 `Set.has()` (78 个特性开关) |
| `react-compiler-runtime` | 重定向 `react/compiler-runtime` 到 npm 包 |
| `native-stubs` | 将 8 个内部/原生包填充为空模块 |
| `text-loader` | 将 `.md`/`.txt` 文件作为字符串导出导入 |

详细构建文档见 [docs/BUILD.md](docs/BUILD.md)。

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
