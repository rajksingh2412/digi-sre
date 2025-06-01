#!/bin/bash

set -e

# Update system packages
sudo apt-get update && sudo apt-get upgrade -y

# Install Docker and Docker Compose
sudo apt-get install -y docker.io docker-compose

# Enable Docker on boot
sudo systemctl enable docker
sudo systemctl start docker

# Clone your repo or pull your folder setup (adjust as needed)
# Example: git clone https://github.com/your/repo.git /srv/my-app
# OR: copy files manually if using `scp`

### repo where code is pushed.
git clone https://github.com/your-username/your-repo.git /srv/app
cd /srv/app
docker-compose up -d
# Navigate to the app folder (adjust this to your directory)
cd /srv/my-app

# Make sure certs folder exists and has the right files
if [ ! -f certs/local.crt ] || [ ! -f certs/local.key ]; then
  echo "❌ Certificates not found in certs/. Please add local.crt and local.key."
  exit 1
fi

# Update hosts file for local domain resolution
echo "127.0.0.1 gitea.localdomain.com grafana.localdomain.com auth.localdomain.com" | sudo tee -a /etc/hosts

# Launch your stack
sudo docker-compose up -d

echo "✅ Setup complete. You can access your services at:"
echo "   https://gitea.localdomain.com"
echo "   https://grafana.localdomain.com"
echo "   https://auth.localdomain.com"
