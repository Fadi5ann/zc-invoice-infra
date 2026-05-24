#!/bin/bash

#Environment variables
BACKUP_DIR="./backups"
CONTAINER_NAME="zc-db-master-v40"
DB_USER="root"
DB_PASS="rootpassword"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# Type of backup: hourly, daily, monthly default is daily
TYPE=$1 
if [ -z "$TYPE" ]; then
  TYPE="daily"
fi

# Create the directory if it doesn't exist
mkdir -p "$BACKUP_DIR/$TYPE"

echo "Starting $TYPE backup..."
# Take the backup from inside the container
docker exec $CONTAINER_NAME mysqldump -u$DB_USER -p$DB_PASS --all-databases > "$BACKUP_DIR/$TYPE/db_backup_$DATE.sql"

# Apply retention policy (Rétention)
if [ "$TYPE" == "hourly" ]; then
  # Delete backups older than 7 days
  find "$BACKUP_DIR/hourly" -type f -name "*.sql" -mtime +7 -exec rm {} \;
elif [ "$TYPE" == "daily" ]; then
  # Delete backups older than 30 days
  find "$BACKUP_DIR/daily" -type f -name "*.sql" -mtime +30 -exec rm {} \;
elif [ "$TYPE" == "monthly" ]; then
  # Delete backups older than 10 years (3650 days)
  find "$BACKUP_DIR/monthly" -type f -name "*.sql" -mtime +3650 -exec rm {} \;
fi

echo "Sauvegarde terminée avec succès : $BACKUP_DIR/$TYPE/db_backup_$DATE.sql"