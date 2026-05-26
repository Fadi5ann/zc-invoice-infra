#!/bin/bash
echo "[CHAOS ENGINEERING] - Injecting failure into a replica viaAuto-Scale Mode"

#  Retrieve the ID of a container belonging to the service
# This command finds any container matching your service name prefix
TARGET_CONTAINER_ID=$(docker ps --filter "name=zc-app-v30" --format "{{.ID}}" | head -n 1)

if [ -z "$TARGET_CONTAINER_ID" ]; then
    echo "Error: No active container found for service zc-app-v30"
    exit 1
fi

echo "Target container identified for crash: $TARGET_CONTAINER_ID"

#  Simulate a sudden crash
docker kill $TARGET_CONTAINER_ID

echo "Waiting 15s for the monitoring system to detect the failure"
sleep 15

#  Verify resilience
echo -e "\n Current status of application replicas:"
docker ps --filter "name=zc-app-v30" --format "table {{.Names}}\t{{.Status}}"

# Perform a health check via the Load Balancer (Nginx)
# We test if the API still returns HTTP 200 despite one replica being offline
RESPONSE=$(curl -o /dev/null -s -w "%{http_code}" http://localhost/api/metrics)

echo -e "\n Load Balancer Health Check HTTP Code: $RESPONSE"

if [ "$RESPONSE" == "200" ]; then
    echo "SUCCESS:The Load Balancer re-routed traffic to surviving replicas"
else
    echo "FAILURE:service is no longer responding properly"
fi