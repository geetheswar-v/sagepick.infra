#!/bin/bash

echo "Starting SagePick Infrastructure..."
echo "=================================="

# Create data directories if they don't exist
mkdir -p data/{postgres_web,postgres_backend,postgres_ai,redis,rabbitmq,minio}

# Set proper permissions
sudo chown -R $USER:$USER ./data/ 2>/dev/null || true

# Start all services
docker-compose up -d

echo ""
echo "Services started successfully!"
echo ""
echo "Access your services:"
echo "  - pgAdmin (Database UI): http://localhost:5050"
echo "  - RabbitMQ (Message Queue UI): http://localhost:15672"  
echo "  - MinIO (Object Storage UI): http://localhost:9001"
echo ""
echo "Check service status:"
echo "  docker-compose ps"
echo ""
echo "View logs:"
echo "  docker-compose logs -f [service-name]"