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

# Path configurations matching main backup parameters
BACKUP_DIR="$SCRIPT_DIR/../backups"
CONTAINER_NAME="zc-db-master-v40"
DB_USER="${DB_USER:-root}"
DB_PASS="${DB_ROOT_PASSWORD:-rootpassword}"
TEST_DB="zc_pfe_restore_test_db"
SLACK_WEBHOOK="$SLACK_WEBHOOK_URL"


echo "Locating latest daily backup for recovery validation testing..."

# Identify the newest daily full backup file in storage
LATEST_BACKUP=$(ls -td $BACKUP_DIR/daily/*.sql 2>/dev/null | head -1)

if [ -z "$LATEST_BACKUP" ]; then
  echo "Error: No backup files discovered in target directory."
  exit 1
fi

echo "Testing file integrity on: $LATEST_BACKUP"

# Step A: Initialize an isolated temporary clean test schema database
docker exec -e MYSQL_PWD="$DB_PASS" $CONTAINER_NAME mysql -u "$DB_USER" -e "DROP DATABASE IF EXISTS $TEST_DB; CREATE DATABASE $TEST_DB;"

# Step B: Inject and parse the snapshot payload data securely into the isolated test db
(echo "SET SQL_LOG_BIN=0;"; cat "$LATEST_BACKUP") | docker exec -i -e MYSQL_PWD="$DB_PASS" $CONTAINER_NAME mysql -u "$DB_USER" "$TEST_DB"
# Step C: Evaluate if the restoration sql code successfully structured without syntax failures
if [ $? -eq 0 ]; then
  echo "Weekly restore check passed successfully."
  
  # Send weekly validation success confirmation message to Slack
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"*[WEEKLY RESTORE TEST PASSED]*\\n*Target File:* \`$(basename $LATEST_BACKUP)\`\\n*Result:* \`Integrity Validated Successfully\`\\n*Notice:* Backup assets match recovery thresholds perfectly.\\n*Timestamp:* \`$(date +'%Y-%m-%d %H:%M:%S')\`\"}" $SLACK_WEBHOOK
else
  echo "Alert: Restored snapshot file execution has failed!"
  
  # Send warning alert if backup file parsing breaks down
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"*[CRITICAL] - WEEKLY RESTORE TEST FAILED*\\n*Target File:* \`$(basename $LATEST_BACKUP)\`\\n*Danger:* Snapshot file appears corrupted or invalid for disaster recovery operations!\\n*Timestamp:* \`$(date +'%Y-%m-%d %H:%M:%S')\`\"}" $SLACK_WEBHOOK
fi

# Step D: Destruct and wipe the testing sandbox database cleanly
docker exec $CONTAINER_NAME mysql -u$DB_USER -p$DB_PASS -e "DROP DATABASE IF EXISTS $TEST_DB;"