#!/bin/bash

# If a .env file exists next to this script (or when run from repo root), load it.
# Put DATABASE_URL="postgresql://..." in that .env for docker-compose and local runs.
if [ -f .env ]; then
  # shellcheck disable=SC1091
  set -o allexport; source .env; set +o allexport
fi

export TEST_DATABASE_MYSQL='mysql://root:secret@(127.0.0.1:3444)/mysql?parseTime=true&multiStatements=true'
# Prefer TEST_DATABASE_POSTGRESQL if set; otherwise use DATABASE_URL (if provided); otherwise fall back to local test DB.
export TEST_DATABASE_POSTGRESQL="${TEST_DATABASE_POSTGRESQL:-${DATABASE_URL:-postgres://postgres:secret@127.0.0.1:3445/postgres?sslmode=disable}}"
export TEST_DATABASE_COCKROACHDB='cockroach://root@127.0.0.1:3446/defaultdb?sslmode=disable'
