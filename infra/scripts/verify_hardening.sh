#!/bin/bash
echo "Verifying System Hardening Status"

#  Check if UFW Firewall is active
if sudo ufw status | grep -q "Status: active"; then
    echo "Firewall (UFW) is active."
else
    echo "WARNING: Firewall is inactive!"
fi

# Check if only essential ports are open
sudo ufw status | grep -E "80|443|22"