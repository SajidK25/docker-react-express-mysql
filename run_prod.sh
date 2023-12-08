#!/bin/bash

file_path=".env"

cat <<EOL >"$file_path"
NODE_ENV=production
DB_NAME=example
DB_USER=root
EOL

docker compose down -v && docker compose up -d --build