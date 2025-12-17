#!/bin/sh

set -e

# Check Docker
if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is not installed"
  exit 1
fi

# Check Docker daemon
if ! docker info >/dev/null 2>&1; then
  echo "Docker is installed but the daemon is not running"
  exit 1
fi

# Check Docker Compose v2
if ! docker compose version >/dev/null 2>&1; then
  echo "Docker Compose v2 is not installed"
  exit 1
fi

echo "Docker and Docker Compose v2 are installed and working"

git clone https://github.com/KSIUJ/gutenberg.git || { echo "Couldn't clone Gutenberg" >&2; exit 1; }
cd gutenberg || { echo "Couldn't move into the Gutenberg directory" >&2; exit 1; }
git checkout bc5cf17 || { echo "Culdn't checkout into the \`Release v4.0.0-rc3\` version" >&2; exit 1; }
git reset --hard bc5cf17 || { echo "Couldn't reset into the \`Release v4.0.0-rc3\` version" >&2; exit 1; }

cd .. || { echo "Couldn't move back into the super directory" >&2; exit 1; }
cp docker_settings.py gutenberg/backend/gutenberg/settings/docker_settings.py || { echo "Couldn't copy settings" >&2; exit 1; }
rm gutenberg/Dockerfile
cp Dockerfile gutenberg/Dockerfile
cp secrets gutenberg/secrets -r

cd gutenberg || { echo "Couldn't move into the Gutenberg directory" >&2; exit 1; }
docker compose up --build
