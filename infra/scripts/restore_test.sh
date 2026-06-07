#!/bin/bash

set -eo pipefail

BACKUP_DIR="/backup-vault"
RESTORE_DB_HOST="${RESTORE_DB_HOST:-zc-restore-test-v200}"
RESTORE_DB_USER="root"
RESTORE_DB_PASS="${DB_ROOT_PASSWORD:-rootpassword}"

echo "Locating latest daily backup for recovery validation testing..."

LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/daily/*.sql 2>/dev/null | head -1)

if [ -z "$LATEST_BACKUP" ]; then
  echo "Error: No daily backup files found in $BACKUP_DIR/daily"
  exit 1
fi

echo "Testing restore file:"
echo "$LATEST_BACKUP"

echo "Waiting for restore-test MySQL to be ready..."

until MYSQL_PWD="$RESTORE_DB_PASS" mysqladmin ping \
  -h "$RESTORE_DB_HOST" \
  -u "$RESTORE_DB_USER" \
  --silent >/dev/null 2>&1; do
  sleep 2
done

echo "Restore-test MySQL is ready."

echo "Cleaning restore-test server before restore..."

MYSQL_PWD="$RESTORE_DB_PASS" mysql \
  -h "$RESTORE_DB_HOST" \
  -u "$RESTORE_DB_USER" \
  -e "
    SET GLOBAL read_only = OFF;
    SET GLOBAL super_read_only = OFF;
  " || true

echo "Restoring backup into isolated restore-test database server..."

if MYSQL_PWD="$RESTORE_DB_PASS" mysql \
  -h "$RESTORE_DB_HOST" \
  -u "$RESTORE_DB_USER" < "$LATEST_BACKUP"; then

  echo "Weekly restore check passed successfully."

  if [ -n "$SLACK_WEBHOOK_URL" ]; then
    curl -X POST -H 'Content-type: application/json' \
      --data "{\"text\":\"*[WEEKLY RESTORE TEST PASSED]*\\n*Target File:* \`$(basename "$LATEST_BACKUP")\`\\n*Result:* \`Backup restored successfully into isolated restore-test DB\`\\n*Timestamp:* \`$(date +'%Y-%m-%d %H:%M:%S')\`\"}" \
      "$SLACK_WEBHOOK_URL"
  fi

  exit 0
else
  echo "Alert: Restore test failed."

  if [ -n "$SLACK_WEBHOOK_URL" ]; then
    curl -X POST -H 'Content-type: application/json' \
      --data "{\"text\":\"*[CRITICAL] - WEEKLY RESTORE TEST FAILED*\\n*Target File:* \`$(basename "$LATEST_BACKUP")\`\\n*Danger:* Backup file could not be restored successfully.\\n*Timestamp:* \`$(date +'%Y-%m-%d %H:%M:%S')\`\"}" \
      "$SLACK_WEBHOOK_URL"
  fi

  exit 1
fi