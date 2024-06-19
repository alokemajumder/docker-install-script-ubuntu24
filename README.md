# Docker Installation Script for Ubuntu 24.04

This repository contains a shell script to automate the installation of Docker on Ubuntu 24.04. The script is interactive, providing options to skip certain steps based on user input, and includes checks and feedback to ensure a smooth installation process.

## Features

- **Interactive Prompts:** The script asks for user confirmation at key steps, allowing the user to skip certain steps if desired.
- **Checks and Feedback:** The script includes checks to ensure commands are available and provides feedback on the installation process.
- **Sample Deployment:** The script includes an option to deploy a sample Nginx container to verify the Docker installation and demonstrate container deployment.

## Prerequisites

Before running the script, ensure you have:

- A machine running Ubuntu 24.04.
- A user account with `sudo` privileges.
- An internet connection to download necessary packages.

## Usage Instructions

1. Clone the repository

2.  Make the script executable
    
3.  Run the script
    

## Script Overview

The script performs the following actions:

1.  **Update System:** Optionally updates the package list and upgrades all installed packages.
2.  **Install Prerequisites:** Installs required packages for Docker.
3.  **Add Docker GPG Key:** Adds Docker’s official GPG key for package verification.
4.  **Set Up Repository:** Sets up the Docker APT repository.
5.  **Install Docker:** Installs Docker Engine, CLI, and containerd.
6.  **Start and Enable Docker:** Starts the Docker service and enables it to start on boot.
7.  **Verify Installation:** Optionally verifies the Docker installation by running a test container.
8.  **User Group Management:** Optionally adds the current user to the `docker` group to allow running Docker commands without `sudo`.
9.  **Deploy Sample Container:** Optionally deploys a sample Nginx container to test Docker.


## Contributing

Contributions are welcome! Submit a pull request for any improvements or fixes.

## License

This project is licensed under the MIT License


## Support

If you encounter any issues or have questions, please open an issue in the repository 
