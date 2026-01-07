#!/bin/bash
# =============================================================================
# AbëKEYs — Radically Simple × BiasGuard Protected
# =============================================================================
# YAGNI: Only essential operations
# JØHN: Truth validation on every key
# Abë: Coherent, unified key management
# ∞ ONE ∞
# =============================================================================

set -eo pipefail

R='\033[0;31m' G='\033[0;32m' Y='\033[1;33m' C='\033[0;36m' M='\033[0;35m' N='\033[0m'
ZSHRC="$HOME/.zshrc"

# =============================================================================
# JØHN: Truth Validation
# =============================================================================
truth() {
    local V="$1"
    [ -z "$V" ] && return 1                                          # Empty
    echo "$V" | grep -qiE 'your|placeholder|xxx|replace' && return 1 # Placeholder
    echo "$V" | grep -qE '^/|^~' && return 1                         # Path not key
    return 0
}

# =============================================================================
# Abë: Store (coherent, no duplicates)
# =============================================================================
store() {
    local K="$1" V="$2"
    truth "$V" || { echo -e "${R}❌ Invalid${N}"; return 1; }
    grep -v "^export $K=" "$ZSHRC" > "$ZSHRC.tmp" 2>/dev/null || true
    mv "$ZSHRC.tmp" "$ZSHRC" 2>/dev/null || true
    echo "export $K=\"$V\"" >> "$ZSHRC"
    export "$K"="$V"
    echo -e "${G}✅ $K${N}"
}

# =============================================================================
# YAGNI: Only 3 commands (add, list, sync)
# =============================================================================
KEYS="VERCEL_API_TOKEN SENDGRID_API_KEY TWILIO_ACCOUNT_SID TWILIO_AUTH_TOKEN HUBSPOT_API_KEY STRIPE_SECRET_KEY OPENAI_API_KEY GITHUB_TOKEN"

add() {
    local K="$1"
    echo -e "\n${M}🔑 $K${N}\n"
    case "$K" in
        vercel)   echo "https://vercel.com/account/tokens"; read -sp "Token: " V; echo; store VERCEL_API_TOKEN "$V" ;;
        sendgrid) echo "https://app.sendgrid.com/settings/api_keys"; read -sp "Key: " V; echo; store SENDGRID_API_KEY "$V" ;;
        twilio)   echo "https://console.twilio.com"; read -sp "SID: " S; echo; read -sp "Token: " T; echo; store TWILIO_ACCOUNT_SID "$S"; store TWILIO_AUTH_TOKEN "$T" ;;
        hubspot)  echo "https://app.hubspot.com/settings/api-key"; read -sp "Key: " V; echo; store HUBSPOT_API_KEY "$V" ;;
        stripe)   echo "https://dashboard.stripe.com/apikeys"; read -sp "Key: " V; echo; store STRIPE_SECRET_KEY "$V" ;;
        openai)   echo "https://platform.openai.com/api-keys"; read -sp "Key: " V; echo; store OPENAI_API_KEY "$V" ;;
        github)   echo "https://github.com/settings/tokens"; read -sp "Token: " V; echo; store GITHUB_TOKEN "$V" ;;
        *)        read -sp "$K: " V; echo; store "$K" "$V" ;;
    esac
}

list() {
    echo -e "\n${M}🔑 Keys${N}\n"
    for K in $KEYS; do [ -n "${!K:-}" ] && echo -e "  ${G}✅ $K${N}" || echo -e "  ${Y}○  $K${N}"; done
    echo
}

sync() {
    echo -e "\n${M}🔄 Sync${N}\n"
    [ -z "${VERCEL_API_TOKEN:-}" ] && { echo -e "${R}Run: ./abekeys.sh add vercel${N}"; return 1; }
    T=$(curl -s "https://api.vercel.com/v2/teams" -H "Authorization: Bearer $VERCEL_API_TOKEN" | grep -o '"id":"[^"]*"' | head -1 | cut -d'"' -f4)
    [ -z "$T" ] && { echo -e "${R}No team${N}"; return 1; }
    echo -e "${G}Team: $T${N}\n"
    for K in $KEYS; do
        V="${!K:-}"; [ -z "$V" ] && continue
        echo -n "  $K... "
        curl -s -X POST "https://api.vercel.com/v1/env?teamId=$T" \
            -H "Authorization: Bearer $VERCEL_API_TOKEN" \
            -H "Content-Type: application/json" \
            -d "{\"key\":\"$K\",\"value\":\"$V\",\"type\":\"encrypted\",\"target\":[\"production\",\"preview\",\"development\"]}" 2>/dev/null | grep -qE '"id"|already' && echo -e "${G}✅${N}" || echo -e "${Y}⚠️${N}"
    done
    echo -e "\n${G}Done${N}\n"
}

# =============================================================================
# ONE: Single entry point
# =============================================================================
echo -e "\n${M}🔑 AbëKEYs${N}"
case "${1:-}" in
    add)  add "${2:-}" ;;
    list) list ;;
    sync) sync ;;
    *)    echo -e "\n${C}add <key> | list | sync${N}\n" ;;
esac
