#!/bin/bash

set -e

# Check that all required environment variables are set
if [ -z "$POSTGRES_USER" ] || [ -z "$POSTGRES_PASS" ] || [ -z "$POSTGRES_DBNAME" ] || [ -z "$POSTGRES_HOST_WRITER" ] || [ -z "$POSTGRES_PORT" ]; then
    echo "Error: One or more required environment variables are not set."
    exit 1
fi



# Connect to the database and initialize it with the schema
PGPASSWORD="$POSTGRES_PASS" psql -h "$POSTGRES_HOST_WRITER" -p "$POSTGRES_PORT" -U "$POSTGRES_USER" -d "$POSTGRES_DBNAME" -f /tmp/pgstac.sql
# Clean up the temporary schema file


echo "PostgreSQL database initialization complete."
exec "$@"
