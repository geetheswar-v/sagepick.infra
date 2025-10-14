#!/bin/bash

echo "Stopping SagePick Infrastructure..."
echo "===================================="

# Stop all services
docker-compose down

echo ""
echo "All services stopped!"
echo ""
echo "Data is preserved in ./data/ folder"
echo ""
echo "To remove all data (DESTRUCTIVE):"
echo "  docker-compose down -v"