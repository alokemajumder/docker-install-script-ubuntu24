#!/bin/bash


# Docker Installation Script for Ubuntu 24.04
# Author: Aloke Majumder
# GitHub: https://github.com/alokemajumder/docker-install-script-ubuntu24
# Description: This script automates the installation of Docker on Ubuntu 24.04, including necessary checks and optional steps for verification and deployment.


# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to prompt for user confirmation
prompt_confirm() {
    while true; do
        read -r -p "$1 [y/n]: " response
        case "$response" in
            [yY][eE][sS]|[yY])
                return 0
                ;;
            [nN][oO]|[nN])
                return 1
                ;;
            *)
                echo "Please answer yes or no."
                ;;
        esac
    done
}

# Function to check internet connection
check_internet_connection() {
    if command_exists curl; then
        curl -s https://www.google.com > /dev/null
    else
        ping -c 1 google.com > /dev/null
    fi

    if [ $? -eq 0 ]; then
        echo "Internet connection detected."
    else
        echo "No internet connection detected. Please ensure you have an active internet connection and try again."
        exit 1
    fi
}

# Function to check Ubuntu version
check_ubuntu_version() {
    local version
    version=$(lsb_release -rs)
    if [[ "$version" == "24.04" ]]; then
        echo "Ubuntu 24.04 detected."
    elif [[ "$version" < "24.04" ]]; then
        echo "Detected Ubuntu version: $version. This script is intended for Ubuntu 24.04."
        if prompt_confirm "Do you want to continue with the installation on this version?"; then
            echo "Continuing with the installation..."
        else
            echo "Installation aborted."
            exit 1
        fi
    else
        echo "Unsupported Ubuntu version: $version. This script is intended for Ubuntu 24.04."
        exit 1
    fi
}

# Check for internet connection
check_internet_connection

# Check Ubuntu version
check_ubuntu_version

# Update package list and upgrade all packages
echo "Updating package list and upgrading installed packages..."
sudo apt update && sudo apt upgrade -y

# Install prerequisite packages
echo "Installing prerequisite packages..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s official GPG key
echo "Adding Docker’s official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the Docker repository
echo "Setting up Docker repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package list again to include Docker packages
echo "Updating package list to include Docker packages..."
sudo apt update

# Install Docker Engine, CLI, and containerd
echo "Installing Docker Engine, CLI, and containerd..."
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker service
echo "Starting and enabling Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

# Verify Docker installation by running a test container
echo "Verifying Docker installation by running a test container..."
if sudo docker run hello-world; then
    echo "Docker installed and verified successfully!"
else
    echo "Docker installation verification failed!"
    exit 1
fi

# Show Docker version
echo "Displaying Docker version..."
docker --version

# Add the current user to the docker group
echo "Adding current user to the docker group..."
sudo usermod -aG docker $USER
echo "Please log out and back in for the changes to take effect."

# Function to deploy a sample Nginx container
deploy_sample_container() {
    echo "Pulling the Nginx image from Docker Hub..."
    if docker pull nginx; then
        echo "Running an Nginx container..."
        if docker run --name my-nginx -d -p 8080:80 nginx; then
            echo "Nginx container is running. Access it at http://localhost:8080"
        else
            echo "Failed to run the Nginx container!"
        fi
    else
        echo "Failed to pull the Nginx image!"
    fi
}

# Deploy a sample Docker container
if prompt_confirm "Do you want to deploy a sample Nginx container to test Docker?"; then
    deploy_sample_container
else
    echo "Skipping deployment of sample Nginx container."
fi

echo "Docker installation and setup completed successfully!"
