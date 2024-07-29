#!/bin/sh
podman-compose exec agent bash -c "cat /app/jobs/*.yml | /app/.venv/bin/jenkins-jobs update"
