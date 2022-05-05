set -e
docker build --network=host -t 10.1.50.181:5000/unismart-business:189 . --network=host
