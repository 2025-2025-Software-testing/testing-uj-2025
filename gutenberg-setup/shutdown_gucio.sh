#!/bin/sh

docker rm -f gutenberg-proxy
docker rm -f gutenberg-celery
docker rm -f gutenberg-backend
docker rm -f gutenberg-redis
docker rm -f gutenberg-db

echo "T H E Y   A R E   A L L   D E A D"
