#!/bin/bash
chmod +x docker-entrypoint.sh 
docker build -t 10.1.50.181:5000/unismart-redis:6.2.6  . --network=host
