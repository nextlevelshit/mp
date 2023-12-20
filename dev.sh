#!/bin/bash

docker compose --env-file .env up --build --remove-orphans --force-recreate
