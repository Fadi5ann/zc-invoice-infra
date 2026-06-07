#!/bin/bash

set -eo pipefail

BACKUP_DIR="/backup-vault"
DB_HOST="${DB_HOST:-zc-db-master-v40}"
DB_USER="root"
DB_PASS="${DB_ROOT_PASSWORD:-rootpassword}"

DATE=$(date +"%Y-%m-%d_%H-%M-%S")

TYPE="$1"
if [ -z "$TYPE" ]; then
  TYPE="daily"
fi

case "$TYPE" in
  hourly)
    FILE_NAME="hourly-snapshot-$DATE.sql"
    MSG_TITLE="[PFE INFRASTRUCTURE] - Hourly Snapshot"
    ;;
  daily)
    FILE_NAME="perfect-sauvegarde-complete-$DATE.sql"
    MSG_TITLE="[PFE INFRASTRUCTURE] - Daily Full Backup"
    ;;
  monthly)
    FILE_NAME="archive-mensuelle-hors-site-$DATE.sql"
    MSG_TITLE="[PFE INFRASTRUCTURE] - Monthly Off-Site Archive"
    ;;
  *)
    echo "Error: Invalid backup type '$TYPE'. Use hourly, daily, or monthly."
    exit 1
    ;;
esac

mkdir -p "$BACKUP_DIR/$TYPE"

echo "Executing Strategy: $MSG_TITLE"

if MYSQL_PWD="$DB_PASS" mysqldump \
  -h "$DB_HOST" \
  -u "$DB_USER" \
  --all-databases \
  --single-transaction \
  --set-gtid-purged=OFF \
  > "$BACKUP_DIR/$TYPE/$FILE_NAME" && [ -s "$BACKUP_DIR/$TYPE/$FILE_NAME" ]; then

  echo "Success: $FILE_NAME generated in $BACKUP_DIR/$TYPE/"
  BACKUP_SIZE=$(du -sh "$BACKUP_DIR/$TYPE/$FILE_NAME" | cut -f1)

  if [ -n "$SLACK_WEBHOOK_URL" ]; then
    curl -X POST -H 'Content-type: application/json' \
      --data "{\"text\":\"*$MSG_TITLE Successful*\\n*File Name:* \`$FILE_NAME\`\\n*Size:* \`$BACKUP_SIZE\`\\n*Status:* \`Verified and Secured\`\\n*Timestamp:* \`$(date +'%Y-%m-%d %H:%M:%S')\`\"}" \
      "$SLACK_WEBHOOK_URL"
  fi
else
  echo "Critical Error: Backup strategy pipeline execution failed!"

  if [ -n "$SLACK_WEBHOOK_URL" ]; then
    curl -X POST -H 'Content-type: application/json' \
      --data "{\"text\":\"*[STRATEGY ALERT] - BACKUP PIPELINE FAILED*\\n*Type:* \`$TYPE\`\\n*Error:* Unable to extract dump from $DB_HOST or out of storage space.\\n*Timestamp:* \`$(date +'%Y-%m-%d %H:%M:%S')\`\"}" \
      "$SLACK_WEBHOOK_URL"
  fi

  exit 1
fi

if [ "$TYPE" == "hourly" ]; then
  find "$BACKUP_DIR/hourly" -type f -name "*.sql" -mmin +10080 -delete
elif [ "$TYPE" == "daily" ]; then
  find "$BACKUP_DIR/daily" -type f -name "*.sql" -mtime +30 -delete
elif [ "$TYPE" == "monthly" ]; then
  find "$BACKUP_DIR/monthly" -type f -name "*.sql" -mtime +3650 -delete
fi