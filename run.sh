#!/bin/bash

# Script to run the Wine + VNC + noVNC container
# Usage: ./run.sh [username] [password]

USERNAME=${1:-user}
PASSWORD=${2:-1}

echo "Creating shared directory..."
mkdir -p shared

echo "Running Wine + VNC + noVNC container..."
docker run -d \
  --name wine-desktop \
  -p 5901:5901 \
  -p 8080:8080 \
  -e VNC_USER="$USERNAME" \
  -e VNC_PASS="$PASSWORD" \
  -v $(pwd)/shared:/home/user/shared \
  --shm-size=2g \
  --restart unless-stopped \
  wine-novnc

if [ $? -eq 0 ]; then
    echo "Container started successfully!"
    echo "Access the desktop at: http://localhost:8080/vnc.html"
    echo "Username: $USERNAME"
    echo "Password: $PASSWORD"
else
    echo "Failed to start container"
    exit 1
fi