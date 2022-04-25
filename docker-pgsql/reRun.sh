#!/bin/bash
docker stop unismart-pgsql
docker rm unismart-pgsql
docker run -itd \
	--name unismart-pgsql \
	-p 5432:5432 \
	-e POSTGRES_PASSWORD=Unilumin123* \
	-e POSTGRES_USER=ulm2 \
	unismart-pgsql:1.14.0
