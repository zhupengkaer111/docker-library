#!/bin/bash

sudo sysctl net.ipv6.conf.all.disable_ipv6=1

docker build \
  -t "10.1.50.181:5000/unismart/minio:RELEASE.2021-03-10T05-11-33Z.fips" \
  --network=host .


sudo sysctl net.ipv6.conf.all.disable_ipv6=0
