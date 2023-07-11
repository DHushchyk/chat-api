#!/bin/bash

echo "# Running collectstatic"
python manage.py collectstatic --clear --noinput
python manage.py compilemessages --ignore venv

echo "# Applying permissions to static and media dirs: 'Other' Read & Execute"
chmod -R o+rx /usr/src/app/media/
chmod -R o+rx /usr/src/app/static/

echo "# Starting server"
#gunicorn --access-logfile - --workers 3 -t 300 --log-level debug --bind 0.0.0.0:8000 core.wsgi:application
gunicorn --access-logfile - --workers 3 -t 300 --log-level debug --bind 0.0.0.0:8000 core.wsgi:application