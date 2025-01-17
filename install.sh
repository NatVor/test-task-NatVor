#!/bin/bash

# Update the system
echo "Updating the system..."
sudo apt-get update && sudo apt-get upgrade -y

# Install Docker
echo "Installing Docker..."
# Install necessary dependencies for Docker
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Add Docker repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
# Update package list and install Docker
sudo apt-get update
sudo apt-get install docker-ce -y

# Install Docker Compose
echo "Installing Docker Compose..."
sudo apt-get update
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
