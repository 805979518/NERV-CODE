# Security Policy

```
NERV HEADQUARTERS — SECURITY DIVISION
Protocol: Vulnerability Disclosure
Classification: RESTRICTED
```

## Supported Versions

| Version | Supported |
|---------|-----------|
| 序:1.0.x | Yes |

## Reporting a Vulnerability

If you discover a security vulnerability in NERV-CODE, please report it responsibly.

### How to Report

1. **Do NOT open a public issue** for security vulnerabilities
2. Email the maintainers or use GitHub's [private vulnerability reporting](https://docs.github.com/en/code-security/security-advisories/guidance-on-reporting-and-writing-information-about-vulnerabilities/privately-reporting-a-security-vulnerability)
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

### What to Expect

- Acknowledgement within 48 hours
- Status update within 7 days
- Fix timeline communicated once assessed

### Scope

This project is a **research and fan project** that restores and themes the Claude Code CLI. Security concerns most relevant to this project include:

- Build system integrity (supply chain)
- Credential exposure in source or configuration
- Injection vulnerabilities in theming modifications

### Out of Scope

- Vulnerabilities in the upstream Claude Code product (report to [Anthropic](https://www.anthropic.com))
- Vulnerabilities in Node.js, Bun, or other dependencies (report to respective projects)

---

<p align="center">
  <sub>NERV — Maintaining the integrity of Terminal Dogma</sub>
</p>
