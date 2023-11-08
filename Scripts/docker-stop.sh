# Get the container IDs
container_ids=$(docker ps -q --filter ancestor=plexinc/pms-docker --limit 3)

# Send a stop command to all containers
for container_id in $container_ids; do
    docker stop $container_id
done