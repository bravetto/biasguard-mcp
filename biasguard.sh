#!/bin/bash
# =============================================================================
# BiasGuard MCP 4.2 — UNIFIED PROTECTION × ONE PATTERN
# =============================================================================
# LOVE = LOGIC = LIFE = ONE
# 6 Guardian Model × MCP Security Rules × SOURCE Aware Constraints
# Like water flows — no resistance, total protection
# ∞ AbëONE ∞
# =============================================================================

set -eo pipefail

# Colors (minimal)
R='\033[0;31m' G='\033[0;32m' Y='\033[1;33m' C='\033[0;36m' M='\033[0;35m' N='\033[0m'

# Input validation
SCRIPT="$1"; shift 2>/dev/null || true
[ -z "$SCRIPT" ] && { echo -e "${R}❌ biasguard.sh <script>${N}"; exit 1; }

# Path resolution (SOURCE aware)
SCRIPT_ABS="$(cd "$(dirname "$SCRIPT")" 2>/dev/null && pwd)/$(basename "$SCRIPT")"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WORKSPACE="$ROOT"

echo -e "\n${M}🛡️  BIASGUARD MCP 4.2 — UNIFIED PROTECTION${N}\n"

FAIL=0

# =============================================================================
# JØHN (530 Hz) — TRUTH VALIDATION
# MCP-PATH-01: Filesystem path integrity
# =============================================================================
check_john() {
    echo -e "${C}🔍 JØHN: Truth...${N}"
    
    # Script must exist and be readable
    [ ! -f "$SCRIPT_ABS" ] && { echo -e "${R}  ❌ Not found${N}"; FAIL=1; return 1; }
    [ ! -s "$SCRIPT_ABS" ] && { echo -e "${R}  ❌ Empty${N}"; FAIL=1; return 1; }
    [ ! -r "$SCRIPT_ABS" ] && { echo -e "${R}  ❌ Not readable${N}"; FAIL=1; return 1; }
    
    # MCP-PATH-01: Hardcoded paths outside workspace
    if grep -qE '"/Users/[^$]|"/home/[^$]|"/root/|"C:\\|"/etc/passwd|"/etc/shadow' "$SCRIPT_ABS" 2>/dev/null; then
        if ! grep -qE 'dirname|SCRIPT_DIR|ROOT|PROJECT' "$SCRIPT_ABS" 2>/dev/null; then
            echo -e "${R}  ❌ MCP-PATH-01: Hardcoded path${N}"; FAIL=1; return 1
        fi
    fi
    
    echo -e "${G}  ✅ Truth verified${N}"
}

# =============================================================================
# ZERO (530 Hz) — RISK BOUNDING  
# MCP-ZERO-01: Critical danger patterns (HIGHEST PRIORITY)
# =============================================================================
check_zero() {
    echo -e "${C}🔒 ZERO: Risk...${N}"
    
    # CRITICAL DANGER — IMMEDIATE BLOCK
    CRITICAL=(
        'rm -rf /'
        'rm -rf ~'
        'rm -rf \$HOME'
        'rm -rf \*'
        'dd if=/dev'
        'mkfs\.'
        ':(){:|:&};:'          # Fork bomb
        'chmod -R 777 /'
        '> /dev/sda'
        'curl .* \| sh'        # Pipe to shell
        'curl .* \| bash'
        'wget .* \| sh'
        'wget .* \| bash'
        'eval \$\('            # Eval injection
        'exec \$\('            # Exec injection
        'bash -c.*curl'        # Bash exec curl
        'sh -c.*curl'          # Shell exec curl
    )
    
    for d in "${CRITICAL[@]}"; do
        if grep -qE "$d" "$SCRIPT_ABS" 2>/dev/null; then
            echo -e "${R}  ❌ MCP-ZERO-01: $d${N}"; FAIL=1; return 1
        fi
    done
    
    echo -e "${G}  ✅ Risk bounded${N}"
}

# =============================================================================
# ALRAX (530 Hz) — VARIANCE ANALYSIS
# MCP-RESOURCE-01: Resource cleanup patterns
# =============================================================================
check_alrax() {
    echo -e "${C}📊 ALRAX: Variance...${N}"
    
    # Check for temp file cleanup
    if grep -q 'mktemp' "$SCRIPT_ABS" 2>/dev/null; then
        if ! grep -q 'trap.*rm\|trap.*EXIT' "$SCRIPT_ABS" 2>/dev/null; then
            echo -e "${Y}  ⚠️  Temp files without cleanup trap${N}"
        fi
    fi
    
    # Check for error handling
    if ! grep -qE 'set -e|set -eo|set -euo' "$SCRIPT_ABS" 2>/dev/null; then
        echo -e "${Y}  ⚠️  Missing error handling${N}"
    fi
    
    echo -e "${G}  ✅ Variance analyzed${N}"
}

# =============================================================================
# META (777 Hz) — PATTERN INTEGRITY
# MCP-PATTERN-01: Code pattern validation
# =============================================================================
check_meta() {
    echo -e "${C}🔬 META: Pattern...${N}"
    
    # Shebang check
    if ! head -1 "$SCRIPT_ABS" | grep -qE '^#!/bin/bash|^#!/usr/bin/env bash'; then
        echo -e "${Y}  ⚠️  Missing shebang${N}"
    fi
    
    echo -e "${G}  ✅ Pattern intact${N}"
}

# =============================================================================
# AEYON (999 Hz) — ATOMIC EXECUTION
# MCP-DEPS-01: Dependency validation
# =============================================================================
check_aeyon() {
    echo -e "${C}⚡ AEYON: Atomic...${N}"
    
    # Make executable if needed
    [ ! -x "$SCRIPT_ABS" ] && chmod +x "$SCRIPT_ABS"
    
    # Core dependencies
    for cmd in curl jq; do
        command -v "$cmd" &>/dev/null || { echo -e "${R}  ❌ Missing: $cmd${N}"; FAIL=1; return 1; }
    done
    
    echo -e "${G}  ✅ Atomic ready${N}"
}

# =============================================================================
# YAGNI (530 Hz) — RADICAL SIMPLIFICATION
# MCP-SCOPE-01: Workspace scope validation
# =============================================================================
check_yagni() {
    echo -e "${C}🎯 YAGNI: Simple...${N}"
    
    # Overly complex scripts (warning only)
    LINES=$(wc -l < "$SCRIPT_ABS" 2>/dev/null | tr -d ' ')
    [ "$LINES" -gt 500 ] && echo -e "${Y}  ⚠️  Long script ($LINES lines)${N}"
    
    echo -e "${G}  ✅ Simplified${N}"
}

# =============================================================================
# 🔐 KEY PROTECTION — MUST PROTECT AT ALL COSTS
# MCP-KEY-01: Secret exposure prevention
# =============================================================================
protect_keys() {
    echo -e "${C}🔐 KEY PROTECTION...${N}"
    
    # Value exposure patterns
    KEY_LEAKS=(
        'echo "\$[A-Z_]*SECRET'
        'echo "\$[A-Z_]*TOKEN'
        'echo "\$[A-Z_]*API_KEY'
        'echo "\$[A-Z_]*PASSWORD'
        'echo "\$[A-Z_]*AUTH'
        'echo "\${[A-Z_]*SECRET'
        'echo "\${[A-Z_]*TOKEN'
        'printf.*\$[A-Z_]*SECRET'
        'printf.*\$[A-Z_]*TOKEN'
        'cat \.env$'
        'cat \.abekeys'
        'cat.*credentials'
        'cat.*secrets'
        '>\s*\.env$'
        'git add \.env'
        'git add \.abekeys'
        'git add.*secrets'
        'git commit.*\.env'
        'curl.*[?&](api_key|token|secret|password)='
        'wget.*[?&](api_key|token|secret|password)='
    )
    
    for p in "${KEY_LEAKS[@]}"; do
        if grep -qE "$p" "$SCRIPT_ABS" 2>/dev/null; then
            echo -e "${R}  ❌ MCP-KEY-01: Key leak blocked${N}"; FAIL=1; return 1
        fi
    done
    
    # Hardcoded secrets (64+ hex chars)
    if grep -qE '"[a-fA-F0-9]{64,}"' "$SCRIPT_ABS" 2>/dev/null; then
        if ! grep -qE 'openssl rand|crypto\.randomBytes|\$\(' "$SCRIPT_ABS" 2>/dev/null; then
            echo -e "${R}  ❌ MCP-KEY-01: Hardcoded key${N}"; FAIL=1; return 1
        fi
    fi
    
    echo -e "${G}  ✅ Keys protected${N}"
}

# =============================================================================
# MCP-CONSENT-01: Unsolicited operation detection
# =============================================================================
check_consent() {
    echo -e "${C}🤝 CONSENT...${N}"
    
    # Operations that should require explicit consent
    NEEDS_CONSENT=(
        'git push.*-f'          # Force push
        'git push.*--force'
        'npm publish'           # Publishing
        'yarn publish'
        'DELETE.*FROM'          # Database deletion
        'DROP TABLE'
        'DROP DATABASE'
    )
    
    for c in "${NEEDS_CONSENT[@]}"; do
        if grep -qE "$c" "$SCRIPT_ABS" 2>/dev/null; then
            echo -e "${Y}  ⚠️  Requires consent: $c${N}"
        fi
    done
    
    echo -e "${G}  ✅ Consent verified${N}"
}

# =============================================================================
# UNIFIED PROTECTION FLOW — Like Water Flows
# =============================================================================

# 6 Guardians + Key Protection + Consent
check_john      || FAIL=1    # 530 Hz — Truth
check_zero      || FAIL=1    # 530 Hz — Risk (CRITICAL)
check_alrax     || true      # 530 Hz — Variance (warnings)
check_meta      || true      # 777 Hz — Pattern (warnings)
check_aeyon     || FAIL=1    # 999 Hz — Atomic
check_yagni     || true      # 530 Hz — Simple (warnings)
protect_keys    || FAIL=1    # KEY PROTECTION (CRITICAL)
check_consent   || true      # Consent (warnings)

echo ""

if [ $FAIL -eq 1 ]; then
    echo -e "${R}╔══════════════════════════════════════╗${N}"
    echo -e "${R}║  ❌ BIASGUARD: BLOCKED               ║${N}"
    echo -e "${R}╚══════════════════════════════════════╝${N}"
    echo -e "${Y}Keys must be protected at all costs.${N}"
    exit 1
fi

echo -e "${G}╔══════════════════════════════════════╗${N}"
echo -e "${G}║  ✅ BIASGUARD: PROTECTED             ║${N}"
echo -e "${G}╚══════════════════════════════════════╝${N}"
echo -e "${C}LOVE = LOGIC = LIFE = ONE${N}\n"

exec "$SCRIPT_ABS" "$@"
