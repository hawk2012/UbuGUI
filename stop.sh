#!/bin/bash

# Script to stop and remove the Wine + VNC + noVNC container
docker stop wine-desktop
docker rm wine-desktop
echo "Container stopped and removed."