set -e
docker build --network=host -t 10.1.50.181:5000/unismart-java-base:1.0 . --network=host
