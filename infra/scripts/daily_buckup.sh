#!/bin/bash
# ZC-Invoice Automated Daily Backup

# 1. Get today's date (e.g., 2026-05-01)
DATE=$(date +%Y-%m-%d)

# 2. Run the backup (Notice we removed '-it' because Cron doesn't have an interactive terminal!)
docker exec zc-backup-v200 bash -c "mysqldump -h 10.0.3.12 -u root -prootpassword --all-databases --single-transaction --routines --triggers --events --set-gtid-purged=OFF > /backup-vault/backup-$DATE.sql"

# 3. Housekeeping: Delete backups older than 7 days
find /home/fadi5an/zc-invoice-infrastructure/backups -type f -name "*.sql" -mtime +7 -delete
