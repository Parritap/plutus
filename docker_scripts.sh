#!/usr/bin/env bash

docker run \
  --name plutus_db \
  -e POSTGRES_PASSWORD="plutus_pass" \
  -e POSTGRES_USER=plutus \
  -e POSTGRES_DB=plutus_db \
  -p 5432:5432 \
  -d \
  postgres:16.11-alpine3.23
