#!/bin/bash
docker stop unismart-redis
docker rm unismart-redis
docker run -itd \
	--name unismart-redis \
	-p 6379:6379 \
	-v /home/unismart/redis/data:/data \
	unismart-redis:6.2.4
