#!/bin/bash
# =============================================================================
# ADD KEY — SO EASY YOUR EYES BLEED 💉
# =============================================================================
# Usage: ./scripts/add-key.sh vercel
# ∞ AbëONE ∞
# =============================================================================

R='\033[0;31m' G='\033[0;32m' Y='\033[1;33m' C='\033[0;36m' M='\033[0;35m' N='\033[0m'

KEY="$1"

if [ -z "$KEY" ]; then
    echo -e "\n${M}🔑 ADD KEY — Pick one:${N}\n"
    echo "  ./scripts/add-key.sh vercel"
    echo "  ./scripts/add-key.sh sendgrid"
    echo "  ./scripts/add-key.sh twilio"
    echo "  ./scripts/add-key.sh hubspot"
    echo "  ./scripts/add-key.sh stripe"
    echo "  ./scripts/add-key.sh openai"
    echo ""
    exit 0
fi

echo -e "\n${M}🔑 ADD KEY: $KEY${N}\n"

case "$KEY" in
    vercel)
        echo -e "${C}Get token: ${Y}https://vercel.com/account/tokens${N}\n"
        read -p "Paste Vercel API Token: " VALUE
        export VERCEL_API_TOKEN="$VALUE"
        echo "export VERCEL_API_TOKEN=\"$VALUE\"" >> ~/.zshrc
        echo -e "\n${G}✅ Added! Run: source ~/.zshrc${N}"
        ;;
    sendgrid)
        echo -e "${C}Get key: ${Y}https://app.sendgrid.com/settings/api_keys${N}\n"
        read -p "Paste SendGrid API Key: " VALUE
        export SENDGRID_API_KEY="$VALUE"
        echo "export SENDGRID_API_KEY=\"$VALUE\"" >> ~/.zshrc
        echo -e "\n${G}✅ Added! Run: source ~/.zshrc${N}"
        ;;
    twilio)
        echo -e "${C}Get creds: ${Y}https://console.twilio.com${N}\n"
        read -p "Paste Account SID: " SID
        read -p "Paste Auth Token: " TOKEN
        export TWILIO_ACCOUNT_SID="$SID"
        export TWILIO_AUTH_TOKEN="$TOKEN"
        echo "export TWILIO_ACCOUNT_SID=\"$SID\"" >> ~/.zshrc
        echo "export TWILIO_AUTH_TOKEN=\"$TOKEN\"" >> ~/.zshrc
        echo -e "\n${G}✅ Added! Run: source ~/.zshrc${N}"
        ;;
    hubspot)
        echo -e "${C}Get key: ${Y}https://app.hubspot.com/settings/api-key${N}\n"
        read -p "Paste HubSpot API Key: " VALUE
        export HUBSPOT_API_KEY="$VALUE"
        echo "export HUBSPOT_API_KEY=\"$VALUE\"" >> ~/.zshrc
        echo -e "\n${G}✅ Added! Run: source ~/.zshrc${N}"
        ;;
    stripe)
        echo -e "${C}Get key: ${Y}https://dashboard.stripe.com/apikeys${N}\n"
        read -p "Paste Stripe Secret Key: " VALUE
        export STRIPE_SECRET_KEY="$VALUE"
        echo "export STRIPE_SECRET_KEY=\"$VALUE\"" >> ~/.zshrc
        echo -e "\n${G}✅ Added! Run: source ~/.zshrc${N}"
        ;;
    openai)
        echo -e "${C}Get key: ${Y}https://platform.openai.com/api-keys${N}\n"
        read -p "Paste OpenAI API Key: " VALUE
        export OPENAI_API_KEY="$VALUE"
        echo "export OPENAI_API_KEY=\"$VALUE\"" >> ~/.zshrc
        echo -e "\n${G}✅ Added! Run: source ~/.zshrc${N}"
        ;;
    *)
        echo -e "${Y}Custom key: $KEY${N}\n"
        read -p "Paste value: " VALUE
        export "$KEY"="$VALUE"
        echo "export $KEY=\"$VALUE\"" >> ~/.zshrc
        echo -e "\n${G}✅ Added! Run: source ~/.zshrc${N}"
        ;;
esac

echo -e "\n${C}Or just run now:${N}"
echo -e "${G}source ~/.zshrc && ./scripts/run-unify-protected.sh${N}\n"

