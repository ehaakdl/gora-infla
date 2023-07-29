#!/bin/bash

mkdir -p data/mysql
chmod 777 -R data
docker-compose  --env-file .env up