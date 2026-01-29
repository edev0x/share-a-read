#!/bin/bash

echo "Setting up Kong access..."

# Get namespace
NAMESPACE="infra"

# Check if Kong service exists
if ! kubectl get svc kong -n $NAMESPACE &> /dev/null; then
    echo "❌ Kong service not found in namespace $NAMESPACE"
    exit 1
fi

echo "Kong service found!"

# Start port forwarding
echo "Starting port forwarding..."
echo "   - Proxy API: http://localhost:8000"
echo "   - Admin API: http://localhost:8001"
echo "   - Manager GUI: http://localhost:8002"
echo ""
echo "Press Ctrl+C to stop"

kubectl port-forward svc/kong 8000:8000 8001:8001 8002:8002 -n $NAMESPACE