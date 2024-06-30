#!/bin/bash

# Check if at least one argument (service name) is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <service_name> [scale_count]"
    echo "Please provide a service name as the first argument."
    echo "Optionally, provide a scale count as the second argument (default is 4)."
    exit 1
fi

# Store the service name argument
SERVICE_NAME="$1"

# Check if a second argument (scale count) is provided, otherwise default to 4
if [ $# -ge 2 ]; then
    SCALE_COUNT="$2"
else
    SCALE_COUNT=4
fi

# Run the docker compose command
docker compose -f compose.yml \
    -f compose.dev.yml \
    -p muellerprints-dev \
    up -d \
    --scale "$SERVICE_NAME"="$SCALE_COUNT" "$SERVICE_NAME"
