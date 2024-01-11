#!/bin/bash

docker compose -p "muellerprints" down

docker compose -p "muellerprints" \
		-f compose.yml \
		--env-file .env \
		up \
		-d \
		--build \
		--remove-orphans \
		--force-recreate
