#!/bin/bash

docker compose -p "muellerprints-dev" down \
    	--remove-orphans

docker compose -p "muellerprints-dev" \
		-f compose.yml \
		-f compose.dev.yml \
		--env-file .env.dev \
		up \
		--build \
    	--force-recreate
