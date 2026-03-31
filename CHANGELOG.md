# CHANGELOG — 作戦記録

All notable changes to this project will be documented in this file.

Version naming follows the *Rebuild of Evangelion* theatrical series:
**序 (Jo)** → **破 (Ha)** → **Q** → **終 (Shin)**

---

## [序:1.0.0] - 2026-03-31 — You Are (Not) Alone

> *The first Angel has appeared. NERV-CODE goes public.*

### 第壱話: Source Restoration

- Restored complete Claude Code v2.1.88 TypeScript source from npm sourcemap
- 1,884 TypeScript/TSX source files (~510K lines)
- 4 custom Bun bundler plugins for compatibility
- Full build pipeline: TypeScript → single ESM bundle (~22MB)
- One-click install script (`install.sh`)

### 第弐話: NERV Theming

- `nerv-dark` color theme (NERV vermillion red `#cc1418` + terminal black `#0A0A0C`)
- Hexagonal motif: `⬡`/`⬢` replacing diamond icons (AT Field geometry)
- MAGI system spinner with 60+ operation verbs:
  - MAGI Analyzing, Processing, Consulting, Deliberating
  - Pattern Blue Scanning, Pattern Orange Analyzing
  - CASPER Processing, BALTHASAR Evaluating, MELCHIOR Reasoning
  - Terminal Dogma Accessing, Central Dogma Querying
  - Entry Plug Connecting, LCL Pressurizing
  - ...and 50+ more
- NERV welcome screen with fig leaf emblem
- Product name: `NERV CODE` / CLI command: `nerv`
- MAGI system prompt preamble
- EVA unit colors for agent palette (Unit-00, Unit-01, Unit-02)

### 第参話: Open Source

- Project restructured for open-source release
- MIT License with Anthropic copyright notice
- Full English and Chinese documentation
- EVA-themed GitHub community templates (使徒来袭, 人類補完計画, 作戦計画)
- Contributing guide (NERV Personnel Onboarding Manual)
- Security policy

### Credits

- Source restoration methodology: [zxdxjtu/claude-code-sourcemap](https://github.com/zxdxjtu/claude-code-sourcemap/tree/main)
- Build system & community: [ChinaSiro/claude-code-sourcemap](https://github.com/ChinaSiro/claude-code-sourcemap)
- Original source: [Anthropic](https://www.anthropic.com) — Claude Code v2.1.88
- EVA tribute: Hideaki Anno / khara, Inc. — for entertainment purposes only

---

*God's in his heaven. All's right with the world.*
