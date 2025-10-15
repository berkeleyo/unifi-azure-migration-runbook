#!/usr/bin/env bash
set -euo pipefail
sudo apt-get update
sudo apt-get install -y ca-certificates gnupg curl openjdk-11-jre-headless
echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
curl -fsSL https://dl.ui.com/unifi/unifi-repo.gpg | sudo gpg --dearmor -o /usr/share/keyrings/unifi-repo.gpg
sudo apt-get update && sudo apt-get install -y unifi
sudo systemctl enable --now unifi
echo "UniFi installed. Open https://<PUBLIC_IP>:8443 to finish setup (restore backup)."
