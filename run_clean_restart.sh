#!/bin/bash
docker compose down --rmi all -v \
&& docker system prune --all -f \
&& docker volume prune -f \
&& docker compose up -d --build