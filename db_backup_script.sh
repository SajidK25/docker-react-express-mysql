#!/bin/bash

if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <databaseuser> <servicename> <password> <databasename> <outputfile>"
    exit 1
fi

DB_USER="$1"
SERVICE_NAME="$2"
PASSWORD="$3"
DB_NAME="$4"
OUTPUT_FILE="$5"

NOW=$(date +"%Y-%m-%d-%H-%M-%S")
DUMP_COMMAND="docker compose exec $SERVICE_NAME /usr/bin/mysqldump -u $DB_USER --password=$PASSWORD $DB_NAME > $(pwd)/$OUTPUT_FILE-$NOW.sql"

eval "$DUMP_COMMAND"

if [ $? -eq 0 ]; then
    echo "Database backup completed successfully. Output file: $OUTPUT_FILE"
else
    echo "Error: Database backup failed."
fi
