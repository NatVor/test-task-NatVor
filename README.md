# Test Task for NatVor

This repository contains a project setup for deploying a web application to Azure using Terraform, Ansible, Docker, and GitHub Actions.

## Prerequisites

Before starting, ensure you have the following tools installed:

- **Docker**: [Install Docker](https://docs.docker.com/engine/install/ubuntu/)
- **Docker Compose**: [Install Docker Compose](https://docs.docker.com/compose/install/)
- **Ansible**: [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)
- **Terraform**: [Install Terraform](https://www.terraform.io/downloads.html)
- **Azure CLI**: [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

## Deployment Instructions

### Clone the repository

Clone the repository to your Docker host:

```bash
git clone git@github.com:NatVor/test-task-NatVor.git
cd test-task-NatVor
docker-compose up -d
