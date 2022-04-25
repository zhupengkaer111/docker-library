#!/bin/bash
docker build -t 10.1.50.181:5000/unismart-pgsql:13.5 . --network=host
