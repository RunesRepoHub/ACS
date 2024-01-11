#!/bin/bash

# Navigate to the Dockers directory
cd ~/ACS/Dockers

# Loop over each docker-compose file
for compose_file in *.yml; do
    # Bring the containers down
    docker compose -f "$compose_file" down

    # Pull the latest images for the defined services
    docker compose -f "$compose_file" pull

    # Bring the containers back up
    docker compose -f "$compose_file" up -d
done

echo "All Docker containers have been updated."
