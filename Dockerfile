# pull official base image
FROM python:3.11-buster

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

# copy the whole project to your docker home directory.
COPY . $DockerHOME

# install dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# port where the Django app runs
EXPOSE 5000

# django actions
RUN python manage.py migrate

# start the server on port 5000, this is what EB listens for
CMD ["python", "manage.py", "runserver", "0.0.0.0:5000"]