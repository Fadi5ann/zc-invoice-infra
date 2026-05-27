#!/bin/bash

# Exit immediately if a command exits with a non-zero status
# pipefail ensures docker exec failures aren't masked by the redirection '>'
set -eo pipefail

# Determine script directory and load environment variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/../.env"

if [ -f "$ENV_FILE" ]; then
    set -a
    source "$ENV_FILE"
    set +a
elif [ -z "$SLACK_WEBHOOK_URL" ]; then
    echo "Error: .env file missing at $ENV_FILE and SLACK_WEBHOOK_URL is not set."
    exit 1
fi

# Configuration of absolute paths for cron job safety
BACKUP_DIR="$SCRIPT_DIR/../backups"
CONTAINER_NAME="zc-db-master-v40"
DB_USER="${DB_USER:-root}"
DB_PASS="${DB_ROOT_PASSWORD:-rootpassword}"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
SLACK_WEBHOOK="$SLACK_WEBHOOK_URL"

# Determine backup type (hourly, daily, monthly). Default is daily.
TYPE=$1 
if [ -z "$TYPE" ]; then
  TYPE="daily"
fi

# Ensure backup destination subfolder exists
mkdir -p "$BACKUP_DIR/$TYPE"

# Match file naming and Slack titles exactly to your PFE Backup Strategy document
if [ "$TYPE" == "hourly" ]; then
  FILE_NAME="hourly-snapshot-$DATE.sql"
  MSG_TITLE=" [PFE INFRASTRUCTURE] - Hourly Snapshot"
elif [ "$TYPE" == "daily" ]; then
  FILE_NAME="perfect-sauvegarde-complete-$DATE.sql"
  MSG_TITLE=" [PFE INFRASTRUCTURE] - Daily Full Backup"
elif [ "$TYPE" == "monthly" ]; then
  FILE_NAME="archive-mensuelle-hors-site-$DATE.sql"
  MSG_TITLE=" [PFE INFRASTRUCTURE] - Monthly Off-Site Archive"
fi

echo "Executing Strategy: $MSG_TITLE"

# Dump databases securely from inside the target Docker container
# Note: if docker exec fails, set -o pipefail catches it
if docker exec -e MYSQL_PWD="$DB_PASS" $CONTAINER_NAME mysqldump -u "$DB_USER" --all-databases --single-transaction --set-gtid-purged=OFF > "$BACKUP_DIR/$TYPE/$FILE_NAME" 2>/dev/null && [ -s "$BACKUP_DIR/$TYPE/$FILE_NAME" ]; then
  
  echo "Success: $FILE_NAME generated in $BACKUP_DIR/$TYPE/"
  BACKUP_SIZE=$(du -sh "$BACKUP_DIR/$TYPE/$FILE_NAME" | cut -f1)
  
  # Send successful backup notification to Slack (Green Indicator)
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"*$MSG_TITLE Successful*\\n*File Name:* \`$FILE_NAME\`\\n*Size:* \`$BACKUP_SIZE\`\\n*Status:* \`Verified and Secured\`\\n*Timestamp:* \`$(date +'%Y-%m-%d %H:%M:%S')\`\"}" $SLACK_WEBHOOK
else
  echo "Critical Error: Backup strategy pipeline execution failed!"
  
  # Send critical failure alert notification to Slack (Red Alert)
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"*[STRATEGY ALERT] - BACKUP PIPELINE FAILED*\\n*Type:* \`$TYPE\`\\n*Error:* Unable to extract dump from container $CONTAINER_NAME or out of storage space.\\n*Timestamp:* \`$(date +'%Y-%m-%d %H:%M:%S')\`\"}" $SLACK_WEBHOOK
  exit 1
fi

# Execute data retention limits to clean up old unneeded snapshot assets
if [ -d "$BACKUP_DIR/$TYPE" ]; then
  if [ "$TYPE" == "hourly" ]; then
    # Keep hourly snapshots for exactly 7 days (7 * 1440 mins)
    find "$BACKUP_DIR/hourly" -type f -name "*.sql" -mmin +10080 -delete
  elif [ "$TYPE" == "daily" ]; then
    # Keep daily full backups for 30 days
    find "$BACKUP_DIR/daily" -type f -name "*.sql" -mtime +30 -delete
  elif [ "$TYPE" == "monthly" ]; then
    # Keep monthly archives for 10 years (3650 days)
    find "$BACKUP_DIR/monthly" -type f -name "*.sql" -mtime +3650 -delete
  fi
fi