#!/bin/bash
echo "[CHAOS ENGINEERING] - Injecting failure into the database cluster to validate monitoring and alerting setup"

# 1. Forcefully kill one of the database replica nodes
docker stop zc-db-replica-v40

echo " Waiting 15 seconds for Prometheus to scrape the failure state and for Alertmanager to process the firing alert"
sleep 15

# 2. Check the health status of the remaining master node
echo "📋 Current Cluster Status:"
docker ps --filter "name=zc-db" --format "table {{.Names}}\t{{.Status}}"

echo " Checking if Alertmanager dispatched the firing notification..."