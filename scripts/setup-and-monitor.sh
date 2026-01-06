#!/bin/bash

# =================================================================
# AppDynamics Script
# Purpose: Prepares Ubuntu for AppD & performs basic health checks
# Components: OS Prep, Networking, and Process Watchdog
# =================================================================

# 1. OS PREPARATION (The "Phase 1" Essentials)
echo "Checking OS Dependencies..."
sudo apt update && sudo apt install -y libaio1 libncurses5 tar unzip curl

# Fix for common AppDynamics library hang
if [ ! -f /usr/lib/x86_64-linux-gnu/libaio.so.1 ]; then
    echo "Fixing libaio symlink..."
    sudo ln -s /lib/x86_64-linux-gnu/libaio.so.1 /usr/lib/x86_64-linux-gnu/libaio.so.1
fi

# 2. NETWORKING & FIREWALL (EUM & Events Service Ports)
echo "Configuring Firewall..."
sudo ufw allow 7001/tcp # EUM HTTP
sudo ufw allow 8090/tcp # Controller Comm
sudo ufw allow 9080/tcp # Events Service
sudo ufw reload

# 3. TIME SYNCHRONIZATION
echo "Setting Timezone..."
sudo timedatectl set-timezone America/New_York

# 4. HEALTH CHECK WATCHDOG (The "Detective" Logic)
check_service() {
    local SERVICE=$1
    if systemctl is-active --quiet "$SERVICE"; then
        echo "[OK] $SERVICE is running."
    else
        echo "[ALERT] $SERVICE is down! Attempting restart..."
        sudo systemctl restart "$SERVICE"
    fi
}

# Example: Check Nginx (or your AppD Controller)
check_service "nginx"

echo "Setup and Health Check Complete."
