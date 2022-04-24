chmod +x docker-entrypoint.sh 
docker build -t 10.1.50.181:5000/unismart-zookeeper:3.8.0 . --network=host
