#!/bin/bash

docker-compose down
rm -rf ./data

docker rmi backend
docker rmi backend:1.0.0

docker volume prune