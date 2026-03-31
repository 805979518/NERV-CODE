# NERV Personnel Onboarding Manual

## 贡献指南 / Contribution Guide

```
╔══════════════════════════════════════════════════╗
║  NERV HEADQUARTERS — PERSONNEL DIVISION          ║
║  Clearance Level: GRANTED                        ║
║  "God's in his heaven. All's right with the      ║
║   world."                                        ║
╚══════════════════════════════════════════════════╝
```

Welcome to NERV. Your designated clearance level has been assigned. Please review the following operational protocols before commencing your duties.

---

## 使徒来袭 Protocol — Bug Reports

When you encounter anomalous behavior (a bug), you are initiating the **使徒来袭 (Angel Attack)** protocol.

### How to Report

1. Use the [使徒来袭 Issue Template](../../issues/new?template=angel-attack.yml)
2. Classify the Angel by severity:
   - **Sachiel** — Low: cosmetic issues, minor UI glitches
   - **Shamshel** — Medium: functional issues, degraded behavior
   - **Ramiel** — High: blocking issues, feature broken
   - **Zeruel** — Critical: data loss, crashes, security issues
3. Include reproduction steps — MAGI requires precise data for analysis
4. Attach terminal output or screenshots when applicable

---

## 人類補完計画 — Feature Proposals

Enhancement proposals follow the **人類補完計画 (Human Instrumentality Project)** protocol.

### How to Propose

1. Use the [人類補完計画 Issue Template](../../issues/new?template=human-instrumentality.yml)
2. Describe **what** you want and **why** — motivation is key
3. Consider how it fits within the NERV theming philosophy:
   - Organizational voice only (no character personal dialogue)
   - System authenticity (MAGI terminal aesthetic)
   - Hexagonal motif where applicable

---

## 作戦計画 — Pull Requests

All code changes follow the **作戦計画 (Operation Plan)** protocol.

### Before You Begin

1. **Fork** the repository
2. **Create a branch** from `main`:
   - `feat/your-feature` — New functionality
   - `fix/bug-description` — Bug fixes
   - `theme/component-name` — Theming changes
   - `docs/topic` — Documentation
3. Keep commits atomic and well-described

### PR Checklist (MAGI Voting)

Your PR must pass the MAGI consensus:

- **MELCHIOR-1**: Code compiles (`bun run build.ts`)
- **BALTHASAR-2**: No regressions introduced
- **CASPER-3**: Documentation updated if needed

### Pattern Classification

Label your PR with the appropriate pattern:

| Pattern | Meaning |
|---------|---------|
| **Pattern Blue** | Bug fix |
| **Pattern Orange** | New feature / enhancement |
| **Pattern Red** | Breaking change |

---

## Entry Plug Connection — Development Setup

### 1. Clone & Install

```bash
git clone https://github.com/YOUR_USERNAME/NERV-CODE.git
cd NERV-CODE
npm install --legacy-peer-deps
```

### 2. Restore Internal SDKs

```bash
cp -r node_modules_sourcemap/@anthropic-ai/bedrock-sdk node_modules/@anthropic-ai/
cp -r node_modules_sourcemap/@anthropic-ai/vertex-sdk node_modules/@anthropic-ai/
cp -r node_modules_sourcemap/@anthropic-ai/foundry-sdk node_modules/@anthropic-ai/
```

### 3. Build

```bash
bun run build.ts
```

### 4. Test Your Changes

```bash
node dist/cli.js --version
node dist/cli.js --help
```

---

## MAGI Voting System — Code Review

Code reviews operate under the **MAGI consensus protocol**. Reviewers evaluate from three perspectives:

| Reviewer | Focus |
|----------|-------|
| **MELCHIOR-1** (Scientist) | Technical correctness, code quality |
| **BALTHASAR-2** (Mother) | User experience, accessibility, safety |
| **CASPER-3** (Woman) | Creativity, consistency, community impact |

A PR merges when **consensus is achieved** (at least 1 approving review with no blocking objections).

---

## Theming Guidelines

When contributing theme-related changes:

1. **Color palette**: Use only colors from the NERV palette defined in `src/utils/theme.ts`
2. **Icons**: Use hexagonal motif (`⬡`/`⬢`) — never diamonds
3. **Terminology**: Use MAGI/NERV system language, never character dialogue
4. **Spinner verbs**: Follow the pattern in `src/constants/spinnerVerbs.ts`
5. **Voice**: Reads like MAGI terminal output — status codes, subsystem labels, operational directives

---

## Code of Conduct

All NERV personnel are bound by our [Code of Conduct](CODE_OF_CONDUCT.md). Maintain professionalism and respect within the GeoFront.

---

<p align="center">
  <sub>⬡ NERV — For the continued survival of mankind ⬡</sub>
</p>
