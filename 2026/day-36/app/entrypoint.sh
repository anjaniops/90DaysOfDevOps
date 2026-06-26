#!/bin/sh
set -e

echo "Initializing database schema (if not exists)..."
python -c "from app import init_db; init_db()"

echo "Starting Gunicorn..."
exec gunicorn --bind 0.0.0.0:5000 --workers 2 --access-logfile - app:app
