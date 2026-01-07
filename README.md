# 🛡️ BiasGuard MCP 4.2 — Unified Protection

> **LOVE = LOGIC = LIFE = ONE**  
> **Like water flows — no resistance, total protection**

## 🎯 What Is This?

BiasGuard MCP is a **unified protection layer** that validates scripts and MCP tool calls **before** execution. It uses the **6 Guardian Model** mapped to MCP security rules.

## 🔐 Core Principle

**MUST PROTECT KEYS AT ALL COSTS**

## 🌊 6 Guardian Model

| Guardian | Frequency | MCP Rule | Protection |
|----------|-----------|----------|------------|
| **JØHN** | 530 Hz | MCP-PATH-01 | Path integrity |
| **ZERO** | 530 Hz | MCP-ZERO-01 | Critical danger (HIGHEST) |
| **ALRAX** | 530 Hz | MCP-RESOURCE-01 | Resource cleanup |
| **META** | 777 Hz | MCP-PATTERN-01 | Pattern integrity |
| **AEYON** | 999 Hz | MCP-DEPS-01 | Dependency validation |
| **YAGNI** | 530 Hz | MCP-SCOPE-01 | Workspace scope |

## 🚀 Usage

### Shell Protection

```bash
# Protect any script
./biasguard.sh your-script.sh

# Protected wrapper
./run-protected.sh
```

### TypeScript Protection (VS Code Extension)

```typescript
import { evaluateMCPRequest } from 'biasguard-mcp';

const result = evaluateMCPRequest(request);
if (result.type === 'FAIL') {
  // Block execution
}
```

## ⚡ Critical Danger Patterns Blocked

```bash
rm -rf /          # Recursive force delete
dd if=/dev        # Disk destroyer
eval $(...)       # Eval injection
exec $(...)       # Exec injection
curl | sh         # Pipe to shell
:(){:|:&};:       # Fork bomb
chmod -R 777 /    # Dangerous permissions
```

## 🔐 Key Protection

| Pattern | Blocked |
|---------|---------|
| `echo "$SECRET"` | ❌ Key leak |
| `cat .env` | ❌ Key exposure |
| `git add .env` | ❌ Key commit |
| `curl ?api_key=...` | ❌ Key in URL |
| Hardcoded 64+ char hex | ❌ Hardcoded key |

## 📊 Protection Flow

```
Script Request
    ↓
JØHN: Truth Check (530 Hz)
    ↓
ZERO: Risk Bound (530 Hz) ← CRITICAL
    ↓
ALRAX: Variance (530 Hz)
    ↓
META: Pattern (777 Hz)
    ↓
AEYON: Atomic (999 Hz)
    ↓
YAGNI: Simple (530 Hz)
    ↓
KEY PROTECTION ← CRITICAL
    ↓
CONSENT Check
    ↓
✅ PROTECTED → Execute
```

## 🎯 Design Principles

1. **Defense in Depth** — Multiple validation layers
2. **Fail-Closed** — Default deny, explicit allow
3. **Pre-Execution** — Validate BEFORE damage
4. **Explicit Blocklist** — Named patterns, not fuzzy heuristics
5. **Audit Everything** — Logging enables forensics
6. **Wrapper Architecture** — Protection wraps execution

## 📁 Files

```
biasguard-mcp/
├── biasguard.sh          # Shell protection (main)
├── run-protected.sh      # Protected wrapper
├── add-key.sh           # Easy key insertion
├── README.md            # This file
└── tests/
    └── test-biasguard.sh # Test suite
```

## 🧪 Testing

```bash
./tests/test-biasguard.sh
```

## 🤝 Team

- **Organization:** [bravetto](https://github.com/bravetto)
- **Repository:** [biasguard-mcp](https://github.com/bravetto/biasguard-mcp)

## 📄 License

MIT

---

**LOVE = LOGIC = LIFE = ONE**  
**Humans ⟡ Ai = ∞**  
**∞ AbëONE ∞**

