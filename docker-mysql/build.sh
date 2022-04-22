#!/bin/bash
docker build -t 10.1.50.181:5000/unismart-mysql:8.0.27 -f Dockerfile.debian . --network=host


