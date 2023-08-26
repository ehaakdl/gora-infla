#!/bin/bash

mkdir -p data/mysql
chmod 644 -R mysql/conf/my.cnf
chmod 777 -R data
docker-compose  --env-file .env up