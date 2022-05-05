#!/bin/bash
docker stop unismart-mainserver
docker rm unismart-mainserver
docker-compose up -d main-server
