# Use an official Python runtime as a parent image
FROM python:3.12-alpine

# Upgrade OS packages to pick up security fixes not yet in the base image
# (e.g. zlib 1.3.2-r1 for CVE-2026-85091)
RUN apk upgrade --no-cache

# Set work directory in the container
WORKDIR /app

# Install poetry directly via pip (avoids pulling in an OS-packaged,
# outdated python3-click through apt/pipx)
RUN pip install --no-cache-dir poetry

# Copy only requirements to cache them in docker layer
COPY /content/pyproject.toml /content/poetry.lock /app/

# Project initialization
RUN poetry install --no-interaction --no-ansi --no-root

# Copying the project files into the container
COPY /content/. /app/

# Expose webserver port
# EXPOSE 5000

# Run the webserver
CMD ["poetry", "run", "flask", "run", "-h", "0.0.0.0"]
