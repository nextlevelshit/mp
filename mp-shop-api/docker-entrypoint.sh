#!/bin/sh

if [ "$NODE_ENV" = "production" ]; then
  npm run production
else
  npm run start
fi
