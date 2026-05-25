#!/bin/bash

# Configuration of absolute paths for cron job safety
PROJECT_DIR="/home/fadi5an/zc-invoice-infrastructure/infra/backups"
BACKUP_DIR="$PROJECT_DIR/backups"  # Absolute path to the backup directory
CONTAINER_NAME="zc-db-master-v40"
DB_USER="root"
DB_PASS="rootpassword"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
SLACK_WEBHOOK=''

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
  MSG_TITLE="🔹 [PFE INFRASTRUCTURE] - Hourly Snapshot"
elif [ "$TYPE" == "daily" ]; then
  FILE_NAME="perfect-sauvegarde-complete-$DATE.sql"
  MSG_TITLE=" [PFE INFRASTRUCTURE] - Daily Full Backup"
elif [ "$TYPE" == "monthly" ]; then
  FILE_NAME="archive-mensuelle-hors-site-$DATE.sql"
  MSG_TITLE=" [PFE INFRASTRUCTURE] - Monthly Off-Site Archive"
fi

echo "Executing Strategy: $MSG_TITLE..."

# Dump databases from inside the target Docker container
docker exec $CONTAINER_NAME mysqldump -u$DB_USER -p$DB_PASS --all-databases --single-transaction --set-gtid-purged=OFF > "$BACKUP_DIR/$TYPE/$FILE_NAME"
# Verify execution status and that the generated backup file is not empty
if [ $? -eq 0 ] && [ -s "$BACKUP_DIR/$TYPE/$FILE_NAME" ]; then
  echo "Success: $FILE_NAME generated in $BACKUP_DIR/$TYPE/"
  
  # Send successful backup notification to Slack (Green Indicator)
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"*$MSG_TITLE Successful*\\n*File Name:* \`$FILE_NAME\`\\n*Size:* \`$(du -sh $BACKUP_DIR/$TYPE/$FILE_NAME | cut -f1)\`\\n*Status:* \`Verified and Secured\`\\n*Timestamp:* \`$(date +'%Y-%m-%d %H:%M:%S')\`\"}" $SLACK_WEBHOOK
else
  echo "Critical Error: Backup strategy pipeline execution failed!"
  
  # Send critical failure alert notification to Slack (Red Alert)
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"*[STRATEGY ALERT] - BACKUP PIPELINE FAILED*\\n*Type:* \`$TYPE\`\\n*Error:* Unable to extract dump from container $CONTAINER_NAME or out of storage space.\\n*Timestamp:* \`$(date +'%Y-%m-%d %H:%M:%S')\`\"}" $SLACK_WEBHOOK
  exit 1
fi

# Execute data retention limits to clean up old unneeded snapshot assets
if [ "$TYPE" == "hourly" ]; then
  # Keep hourly snapshots for 7 days
  find "$BACKUP_DIR/hourly" -type f -name "*.sql" -mtime +7 -exec rm {} \;
elif [ "$TYPE" == "daily" ]; then
  # Keep daily full backups for 30 days
  find "$BACKUP_DIR/daily" -type f -name "*.sql" -mtime +30 -exec rm {} \;
elif [ "$TYPE" == "monthly" ]; then
  # Keep monthly archives for 10 years (3650 days)
  find "$BACKUP_DIR/monthly" -type f -name "*.sql" -mtime +3650 -exec rm {} \;
fi