# PRD: NERV MAGI System Theme for Claude Code

## Overview

Transform the Claude Code TUI into a NERV/MAGI-themed terminal interface inspired by Neon Genesis Evangelion. The application retains full Claude Code functionality while presenting a complete NERV organizational aesthetic — color system, typography, iconography, spinner animations, welcome sequence, and system terminology.

## Design Principles

1. **Organizational voice only** — All text reflects NERV as an organization and MAGI as a system. No character personal dialogue (no Shinji, Asuka, Rei, Misato quotes).
2. **NERV RED dominance** — Primary brand color is the signature NERV vermillion-red, derived from the official fig leaf logo.
3. **Hexagonal motif** — The hexagon (`⬡` / `⬢`) replaces diamonds as the universal icon shape, referencing AT Field geometry and MAGI's hexagonal display panels.
4. **System authenticity** — UI text reads like MAGI terminal output: status codes, subsystem labels, and operational directives.

---

## Phase 1: Color System — `nerv-dark` Theme

### Source Palette (extracted from NERV logo reference)

| Token | Hex | RGB | Usage |
|-------|-----|-----|-------|
| `nerv-red` | `#B7282E` | `rgb(183, 40, 46)` | Primary brand, logo, key accents |
| `nerv-red-light` | `#D4494F` | `rgb(212, 73, 79)` | Hover states, shimmer, highlights |
| `nerv-red-dark` | `#8C1C22` | `rgb(140, 28, 34)` | Pressed states, deep accents |
| `nerv-red-muted` | `#6B2D32` | `rgb(107, 45, 50)` | Borders, subtle elements |
| `terminal-black` | `#0A0A0C` | `rgb(10, 10, 12)` | Primary background |
| `terminal-dark` | `#141418` | `rgb(20, 20, 24)` | Secondary background, panels |
| `terminal-gray` | `#1E1E24` | `rgb(30, 30, 36)` | Borders, separators |
| `text-primary` | `#E8E6E3` | `rgb(232, 230, 227)` | Main body text |
| `text-secondary` | `#9A9894` | `rgb(154, 152, 148)` | Secondary/muted text |
| `text-dim` | `#5A5856` | `rgb(90, 88, 86)` | Disabled, placeholder text |
| `amber-warn` | `#D4A017` | `rgb(212, 160, 23)` | Warning states |
| `green-confirm` | `#2D8B46` | `rgb(45, 139, 70)` | Success, approval states |
| `blue-info` | `#3A6EA5` | `rgb(58, 110, 165)` | Info, links, secondary actions |
| `eva-purple` | `#6B3FA0` | `rgb(107, 63, 160)` | Agent accent (Unit-01 reference) |
| `eva-orange` | `#E87D2A` | `rgb(232, 125, 42)` | Agent accent (Unit-00 reference) |
| `eva-blue` | `#3478B5` | `rgb(52, 120, 181)` | Agent accent (Unit-00 alt) |

### Theme Key Mapping (`src/utils/theme.ts`)

Add `'nerv-dark'` to `THEME_NAMES` and set as default. Full semantic mapping:

```
claude           → #B7282E  (nerv-red — primary brand)
claudeShimmer    → #D4494F  (nerv-red-light — animation shimmer)
secondary        → #D4494F  (nerv-red-light)
bashBorder       → #6B2D32  (nerv-red-muted)
autoAccept       → #2D8B46  (green-confirm)
warning          → #D4A017  (amber-warn)
error            → #B7282E  (nerv-red — errors in brand red)
success          → #2D8B46  (green-confirm)
info             → #3A6EA5  (blue-info)
text             → #E8E6E3  (text-primary)
textSecondary    → #9A9894  (text-secondary)
textDim          → #5A5856  (text-dim)
background       → #0A0A0C  (terminal-black)
backgroundSecondary → #141418  (terminal-dark)
border           → #1E1E24  (terminal-gray)
borderActive     → #B7282E  (nerv-red)
borderFocused    → #D4494F  (nerv-red-light)
cursor           → #B7282E  (nerv-red)
selectionBg      → #3A1A1D  (dark red tint)
```

### Agent Color Palette (`src/tools/AgentTool/agentColorManager.ts`)

Map the 8 agent slot colors to EVA unit colors:

| Slot | Color | Reference |
|------|-------|-----------|
| 0 | `#6B3FA0` | Unit-01 Purple |
| 1 | `#E87D2A` | Unit-00 Orange |
| 2 | `#B7282E` | Unit-02 Red |
| 3 | `#3478B5` | Unit-00 Blue |
| 4 | `#2D8B46` | NERV Green |
| 5 | `#D4A017` | NERV Amber |
| 6 | `#D4494F` | Unit-02 Light Red |
| 7 | `#9A9894` | MAGI Gray |

---

## Phase 2: Icons & Spinner

### Figure Constants (`src/constants/figures.ts`)

```typescript
export const DIAMOND_OPEN = '\u2B21'   // ⬡ (hexagon outline)
export const DIAMOND_FILLED = '\u2B22' // ⬢ (hexagon filled)
```

All UI locations using `◇` / `◆` automatically inherit the hexagonal motif.

### Spinner Animation (`src/components/Spinner.tsx`)

Replace spinner frames with single-hexagon pulse:

```typescript
frames: ['⬡', '⬢']
```

Interval: 400ms (slow, deliberate pulse — system heartbeat feel).

---

## Phase 3: Branding & Welcome Screen

### Product Constants (`src/constants/product.ts`)

```
PRODUCT_NAME  → "NERV CODE"
PRODUCT_URL   → unchanged (keep functional)
```

### Welcome Screen (`src/components/LogoV2/`)

Replace `Clawd.tsx` ASCII art with the complete NERV emblem. The logo combines:
- **Upper half**: The fig leaf silhouette (半片无花果叶) — asymmetric, organic contour
- **Middle**: The overlaid "NERV" lettering integrated into the leaf
- **Lower half**: The circular motto arc ("God's in his heaven. All's right with the world.")

**NERV emblem** — terminal ASCII art (~31 lines x 75 cols), high-resolution using Unicode block characters (`█▀▄`):

```
                                   ▄▄▄▄██████
                                   ▄█████████████
                                 ▄██████████████▀
                     ▄▄         ▄███████████████     ▄▄
                    ▀██▄         ██████████████▀ ▄▄██████▄███▄
                      ▀█▄        ██████████████ ▄██████████████
                        ▀█▄     ██████████████▄█████████████████▄▄
                          ▀█▄▄▄████████████████████████████████████▄
                            ▀████████████████████████████████████████
                             ▀██████████████████████████████████████
                               ▀██████████████████████████████████▀
             ▀████▄    ▀███▀▀████▀████████████████████████████▀▀
               █████▄    █   ████  ▀████████████████████▀▀▀▀▀
               █▀█████   █   ████   █▀████████████████▀
               █  ▀████▄ █   ████▄███  ▀███████████████████▄
               █    ▀█████   ████   █    ████████████████████
               █      ▀███   ████      ▄█ ▀███████████████████
             ▄▄█▄       ▀█  ▄████▄▄▄▄▄██▀   ▀█████████████████
        █▀█  ▀▀ ▀           ██▄▄▄████▄ ▀▄▄▄▄▄▄▀████████████████
         ██▄                 ████   ████ ▀████  ▀███████████████
         ███                 ████    ████  ████▄  ▀███████████
          ▄▀                 ████▄▄▄███▀    ▀████▄  ███████████▄
           ███               ████▀████▄       ▀██████ ███████████
           ▀▀▄▄              ████  ▀████▄       ▀████  ▀█████████
            ▀███             ████    ▀████▄       ▀██    ▀██████
             ▀███▄▄         ▀▀▀▀▀▀▀    ▀▀▀▀▀        ▀      ▀████
               ▀██▀▄                                         ▀██
                 ▀████▄                                   ▄ ██▄▀▀
                    ████                               ▄████▄▀
                     ▀▀ ██▀ ▄▄                    ▄▄▄▀████▀
                         ▀▀█▄█ ███▀▄▄▄▄▄▄▄▄▄▄▄▄▄▀▀███▄
                              ▀▀█▀▄█▀▄██ ███▄█▀█ ▀▀▀
```

This is the **full-detail version** for terminals >= 80 columns. Features:
- Fig leaf silhouette (upper half) with organic asymmetric contour
- "NERV" lettering (left-center, rows 12-18) integrated into the leaf
- Circular motto arc (bottom rows) forming the "God's in his heaven" border

**Compact version** (~19 lines x 50 cols) for terminals 60-79 columns:

```
                   ▄▄▄
                   ▄▄███████
            ▄     ▄████████   ▄
           ▀█▄    ████████▀▄███████
             ▀█▄ ▄███████████████████▄
               ▀███████████████████████
                 ▀███████████████████▀
        ███  ▀█ ███▀█████████████▀▀
        █▀██▄ █ ███▄█▀█████████▄▄
        █  ▀███ ███ ▀  ███████████▄
       ▄█▄   ▀█ ███▄▄██ ▀██████████
     █          ███▀██████▀█████████
     ▀█         ███ ███ ▀██▄▀██████▄
      ██        ██████▄   ▀███▀█████▄
       ██       ███ ▀███    ▀█  ▀███
        ▀█▄                       ██
          ▀█▄                   ▄▄█▀
            ▀▀█▄▄▄▄        ▄▄▄▀▀▀
                 ▀▀▀▀▀▀▀▀▀▀
```

Both versions rendered in `nerv-red` (`#B7282E`). The motto text "God's in his heaven. All's right with the world." is printed below the emblem as a separate styled line.

Logo selection logic:
- **>= 80 cols**: Full-detail version (31 lines)
- **60-79 cols**: Compact version (19 lines)
- **< 60 cols**: Text-only condensed (see CondensedLogo below)

Layout structure:

```
┌──────────────────────────────────────────────────────────────┐
│                                                              │
│              [NERV EMBLEM ASCII ART]                         │
│                                                              │
│       God's in his heaven. All's right with the world.       │
│                                                              │
│  ─────────────────────────────────────────────────────────   │
│                                                              │
│   MAGI SYSTEM ver 2.1.88             STATUS: ONLINE          │
│   CASPER .... NOMINAL                                        │
│   BALTHASAR . NOMINAL                                        │
│   MELCHIOR .. NOMINAL                                        │
│                                                              │
│   > Initializing command interface...                        │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

### Condensed Logo (`src/components/LogoV2/CondensedLogo.tsx`)

For narrow terminals (<70 cols):

```
⬢ NERV CODE — MAGI SYSTEM ONLINE
  God's in his heaven. All's right with the world.
```

---

## Phase 4: System Terminology

### Spinner Verbs (`src/constants/spinnerVerbs.ts`)

Replace ALL 200+ verbs with MAGI/NERV system terminology:

```typescript
export const SPINNER_VERBS = [
  // MAGI Processing
  'MAGI Analyzing',
  'MAGI Processing',
  'MAGI Consulting',
  'MAGI Deliberating',
  'Pattern Blue Scanning',
  'Pattern Orange Analyzing',
  'Sync Rate Calculating',
  'AT Field Calculating',
  'Harmonics Testing',

  // Subsystem Operations
  'CASPER Processing',
  'BALTHASAR Evaluating',
  'MELCHIOR Reasoning',
  'Terminal Dogma Accessing',
  'Central Dogma Querying',
  'Pribnow Box Monitoring',
  'Sigma Unit Calibrating',

  // System Status
  'Entry Plug Connecting',
  'LCL Pressurizing',
  'Umbilical Cable Routing',
  'S2 Engine Initializing',
  'Absolute Terror Field Deploying',
  'Progressive Knife Sharpening',
  'N2 Reactor Charging',
  'Dummy Plug Loading',

  // NERV Operations
  'GeoFront Mapping',
  'Eva Cage Preparing',
  'Launch Pad Aligning',
  'Catapult Charging',
  'Bakelite Injecting',
  'SEELE Protocol Decrypting',
  'Dead Sea Scrolls Parsing',
  'Human Instrumentality Evaluating',

  // Formal Operations
  'Code 601 Executing',
  'Priority Alpha Processing',
  'Protocol Verifying',
  'Clearance Authenticating',
  'Telemetry Correlating',
  'Waveform Analyzing',
  'Containment Monitoring',
  'Reconnaissance Compiling',
  'Tactical Assessing',
  'Strategic Modeling',
]
```

### System Prompt Flavor (`src/constants/prompts.ts`)

Inject NERV identity preamble before `SYSTEM_PROMPT_DYNAMIC_BOUNDARY`:

```
[NERV ARTIFICIAL INTELLIGENCE DIVISION]
MAGI System — Personality Transplant OS
"God's in his heaven. All's right with the world."

CASPER-3 / BALTHASAR-2 / MELCHIOR-1: CONSENSUS ACHIEVED
Operator clearance: GRANTED
```

This is cosmetic flavor text — it must NOT alter Claude's actual behavior or capabilities.

### Status Messages / UI Microcopy

Key replacements across components:

| Original | NERV Version |
|----------|-------------|
| "Thinking..." | "MAGI Deliberating..." |
| "Working..." | "Processing..." |
| "Done" | "Operation Complete" |
| "Error" | "WARNING: Abnormal Termination" |
| "Connecting..." | "Entry Plug Connecting..." |
| "Ready" | "All Systems Nominal" |
| Tool approval prompt | "MAGI requires operator authorization" |
| Auto-accept banner | "NERV AUTO-EXECUTE PROTOCOL ACTIVE" |
| Cost display prefix | "MAGI Resource Consumption" |
| Session end | "God's in his heaven. All's right with the world." |

---

## Phase 5: Deep Integration

### Message Components (`src/components/messages/*.tsx`)

Add subtle NERV system prefixes to assistant message headers:

```
[MAGI] Response text here...
```

User messages remain unprefixed (operator input).

### Permission Prompts

Style permission dialogs with NERV classification language:

```
⬢ MAGI AUTHORIZATION REQUEST
  Tool: bash
  Command: npm install
  Classification: STANDARD OPERATION
  [Allow] [Deny] [Always Allow]
```

### Error Boundaries

Error screens display:

```
⬢ ABNORMAL TERMINATION DETECTED
  Pattern: [error type]
  Source:  [file:line]

  MAGI recommends: [recovery suggestion]

  God's in his heaven. All's right with the world.
```

### Session Lifecycle

- **Start**: MAGI boot sequence (welcome screen)
- **Running**: All system text uses NERV terminology
- **Exit**: Display "God's in his heaven. All's right with the world." as final line

---

## Implementation Order

| Phase | Scope | Files | Risk |
|-------|-------|-------|------|
| 1 | Color system | `theme.ts`, `agentColorManager.ts` | Low — additive |
| 2 | Icons & Spinner | `figures.ts`, `Spinner.tsx` | Low — constant swaps |
| 3 | Welcome screen | `Clawd.tsx`, `WelcomeV2.tsx`, `CondensedLogo.tsx`, `product.ts` | Medium — layout |
| 4 | System terminology | `spinnerVerbs.ts`, `prompts.ts`, message components | Medium — many files |
| 5 | Deep integration | Permission prompts, error screens, lifecycle | Medium — scattered |

Each phase is independently shippable and testable. Phase 1 alone transforms the visual feel. Phases 1-3 constitute the MVP.

---

## Non-Goals

- No changes to Claude's AI behavior, capabilities, or system prompt logic
- No changes to the build system or package structure
- No new runtime dependencies
- No changes to keybindings or command structure
- No character personal dialogue or quotes
- No animated ASCII sequences beyond the spinner

## Acceptance Criteria

- [ ] `nerv-dark` theme renders correctly in 256-color and truecolor terminals
- [ ] NERV fig leaf logo displays faithfully in terminals >= 70 columns wide
- [ ] Spinner shows `⬡` / `⬢` hexagon pulse at 400ms interval
- [ ] All 200+ spinner verbs replaced with NERV/MAGI terminology
- [ ] Welcome screen shows MAGI boot sequence with subsystem status
- [ ] Session exit displays "God's in his heaven. All's right with the world."
- [ ] No character personal dialogue anywhere in the application
- [ ] Build compiles and passes existing test suite
- [ ] ANSI fallback theme degrades gracefully on limited terminals
