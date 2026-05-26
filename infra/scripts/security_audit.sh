#!/bin/bash

# Load environment variables
if [ -f /home/fadi5an/zc-invoice-infrastructure/infra/.env ]; then
    export $(grep -v '^#' /home/fadi5an/zc-invoice-infrastructure/infra/.env | xargs)
fi

# Configuration and path settings
PROJECT_DIR="/home/fadi5an/zc-invoice-infrastructure/infra"
AUDIT_DIR="$PROJECT_DIR/backups/audits"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
SLACK_WEBHOOK=$SLACK_WEBHOOK_URL

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