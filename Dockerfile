# pull official base image
FROM python:3.8-buster

# set working directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV TZ="Europe/Kiev"

# set build args variables
ARG DEBIAN_FRONTEND
ARG DJANGO_SETTINGS_MODULE
ARG SECRET_KEY
ARG DEBUG
ARG DB_PSQL_NAME
ARG DB_PSQL_USER
ARG DB_PSQL_PASSWORD
ARG DB_PSQL_HOST
ARG DB_PSQL_PORT

# add app
COPY . .
COPY .env /usr/src/app/.env
RUN chmod +x /usr/src/app/entrypoint.sh

# install dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# django actions
RUN python manage.py migrate

# UNCOMMENT TO TURN ON TRANSLATION COMPILE FILES
#RUN python manage.py compilemessages --ignore venv


ENTRYPOINT ["/usr/src/app/entrypoint.sh"]