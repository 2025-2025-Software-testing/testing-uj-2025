#!/bin/sh

docker exec -it gutenberg-backend ./manage.py createsuperuser
