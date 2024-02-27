#!/bin/bash

docker compose -p "muellerprints-dev" down

docker compose -p "muellerprints-dev" \
		-f compose.yml \
		-f compose.dev.yml \
		--env-file .env.dev \
		up \
		--build \
    	--remove-orphans
#    	--force-recreate
