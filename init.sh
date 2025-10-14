#!/bin/bash

echo "Initializing SagePick Infrastructure..."
echo "========================================"

# Create main data directory
echo "Creating data directory structure..."

# Create all data subdirectories
mkdir -p data/postgres_web
mkdir -p data/postgres_backend  
mkdir -p data/postgres_ai
mkdir -p data/redis
mkdir -p data/rabbitmq
mkdir -p data/minio

# Set proper permissions for data directories
echo "Setting proper permissions..."
chmod 755 data/
chmod 755 data/postgres_web
chmod 755 data/postgres_backend
chmod 755 data/postgres_ai
chmod 755 data/redis
chmod 755 data/rabbitmq
chmod 755 data/minio

# Create env directory if it doesn't exist
mkdir -p env

# Function to create env file if it doesn't exist or is empty
create_env_file() {
    local file_path="$1"
    local content="$2"
    
    if [ ! -f "$file_path" ] || [ ! -s "$file_path" ]; then
        echo "Creating $file_path with default credentials..."
        echo "$content" > "$file_path"
    else
        echo "$file_path already exists and has content, skipping..."
    fi
}

echo "Creating environment files with default credentials..."

# PostgreSQL Web Service Environment
create_env_file "env/postgres.web.env" "POSTGRES_DB=sagepick_web
POSTGRES_USER=web_user
POSTGRES_PASSWORD=web_password123"

# PostgreSQL Backend Service Environment
create_env_file "env/postgres.backend.env" "POSTGRES_DB=sagepick_backend
POSTGRES_USER=backend_user
POSTGRES_PASSWORD=backend_password123"

# PostgreSQL AI Service Environment
create_env_file "env/postgres.ai.env" "POSTGRES_DB=sagepick_ai
POSTGRES_USER=ai_user
POSTGRES_PASSWORD=ai_password123"

# RabbitMQ Environment
create_env_file "env/rabbitmq.env" "RABBITMQ_DEFAULT_USER=admin
RABBITMQ_DEFAULT_PASS=admin123"

# MinIO Environment
create_env_file "env/minio.env" "MINIO_ROOT_USER=admin
MINIO_ROOT_PASSWORD=admin123"

# pgAdmin Environment
create_env_file "env/pgadmin.env" "PGADMIN_DEFAULT_EMAIL=admin@sagepick.dev
PGADMIN_DEFAULT_PASSWORD=admin"

echo ""
echo "Data directory structure created successfully!"
echo ""
echo "Created directories:"
echo "  data/"
echo "    postgres_web/     # Web service database"
echo "    postgres_backend/ # Backend service database"
echo "    postgres_ai/      # AI service database"
echo "    redis/            # Redis cache data"
echo "    rabbitmq/         # RabbitMQ message queue data"
echo "    minio/            # MinIO object storage data"
echo "  env/                # Environment files"
echo ""
echo "Environment files created/verified:"
echo "  env/postgres.web.env"
echo "  env/postgres.backend.env"
echo "  env/postgres.ai.env"
echo "  env/rabbitmq.env"
echo "  env/minio.env"
echo "  env/pgadmin.env"
echo ""
echo "Infrastructure initialization complete!"
echo ""
echo "Next steps:"
echo "  1. Run: ./start.sh (to start all services)"
echo "  2. Or run: docker-compose up -d"
