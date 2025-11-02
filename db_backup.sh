#!/bin/bash

DB_NAME="meow_database"
DB_USER="backup"
DB_PASS="BackupPass123!"
BACKUP_FILE="/tmp/db_backup_$(date +%F_%H-%M-%S).sql"
ARCHIVE_FILE="${BACKUP_FILE}.tar.gz"
STORAGE_ACCOUNT="salemstorage123"
BLOB_CONTAINER="backups"

mysqldump -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_FILE"

tar -czf "$ARCHIVE_FILE" "$BACKUP_FILE"

az login --identity --allow-no-subscriptions > /dev/null 2>&1
az storage blob upload \
  --account-name "$STORAGE_ACCOUNT" \
  --container-name "$BLOB_CONTAINER" \
  --file "$ARCHIVE_FILE" \
  --name "$(basename $ARCHIVE_FILE)" \
  --auth-mode login

rm -f "$BACKUP_FILE" "$ARCHIVE_FILE"