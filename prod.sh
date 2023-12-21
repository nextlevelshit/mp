#!/bin/bash

docker compose --env-file .env.prod up --build --remove-orphans --force-recreate
