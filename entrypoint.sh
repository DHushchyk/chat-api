#!/bin/bash

echo "# Running collectstatic"
python manage.py collectstatic --clear --noinput
python manage.py compilemessages --ignore venv

echo "# Applying permissions to static and media dirs: 'Other' Read & Execute"
chmod -R o+rx /usr/src/app/media/
chmod -R o+rx /usr/src/app/static/

echo "# Starting server"
gunicorn --reload core.wsgi:application -b 0.0.0.0:8000