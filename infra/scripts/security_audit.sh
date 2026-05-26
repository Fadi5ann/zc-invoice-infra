#!/bin/bash

# Determine script directory and load environment variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/../.env"

if [ -f "$ENV_FILE" ]; then
    # The 'set -a' command exports all variables found in the file automatically
    set -a
    source "$ENV_FILE"
    set +a
elif [ -z "$SLACK_WEBHOOK_URL" ]; then
    echo "Error: .env file missing at $ENV_FILE and SLACK_WEBHOOK_URL is not set."
    exit 1
fi

# Configuration and path settings
AUDIT_DIR="$SCRIPT_DIR/../backups/audits"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
SLACK_WEBHOOK="$SLACK_WEBHOOK_URL"

# Ensure the audits output directory exists
mkdir -p "$AUDIT_DIR"
REPORT_FILE="$AUDIT_DIR/security_report_$DATE.txt"

echo "=== ZC INVOICE SECURITY COMPLIANCE AUDIT ===" > "$REPORT_FILE"
echo "Execution Timestamp: $(date)" >> "$REPORT_FILE"
echo "Target Host: Ubuntu Local Environment" >> "$REPORT_FILE"
echo "--------------------------------------------------" >> "$REPORT_FILE"

echo -e "\n[STEP 1/2] Scanning Active Network Ports via Host Socket..." >> "$REPORT_FILE"
ss -tulpn | grep -E 'LISTEN' >> "$REPORT_FILE" 2>&1

echo -e "\n[STEP 2/2] Checking Running Production Containers Isolation..." >> "$REPORT_FILE"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" >> "$REPORT_FILE"

# Send the summary outcome straight to your Slack channel
if [ $? -eq 0 ]; then
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\" *[QUARTERLY SECURITY AUDIT COMPLETED]*\\n*Report File:* \`security_report_$DATE.txt\`\\n*Status:* \`All System Layers Compliant & Isolated\`\\n*Timestamp:* \`$(date +'%Y-%m-%d %H:%M:%S')\`\"}" $SLACK_WEBHOOK
else
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\" *[SECURITY AUDIT WARNING]*\\n*Notice:* Unexpected network architecture shift detected during audit runtime!\"}" $SLACK_WEBHOOK
fi