#!/bin/bash
docker stop unismart-mysql
docker rm unismart-mysql
docker run -itd \
	--name unismart-mysql \
	-p 3306:3306 \
	-e MYSQL_ROOT_PASSWORD=Unilumin123* \
	-e MYSQL_PASSWORD=Unilumin123* \
	-e MYSQL_USER=ulm2 \
	unismart-mysql:8.0.27
