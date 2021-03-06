#!/usr/bin/env bash

set -o errexit

if [[ ! -d "app/staticfiles" ]]; then python app/manage.py collectstatic --noinput; fi

python app/manage.py migrate
gunicorn --bind="${BIND:-127.0.0.1:8000}" --workers="${WORKERS:-1}" --pythonpath=app app.wsgi
