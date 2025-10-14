# SagePick Infrastructure

Complete Docker infrastructure setup for SagePick microservices project with event-driven architecture.

## 🏗 Architecture Overview

This setup provides:

- **3 PostgreSQL databases** (one for each microservice)
- **RabbitMQ** for event-driven communication between services
- **Redis** for caching and session storage
- **MinIO** for object storage
- **pgAdmin** for database management via web UI

## 🚀 Quick Start

1. **Clone and navigate to the project:**

   ```bash
   cd sagepick.infra
   ```

2. **Start all services:**

   ```bash
   docker-compose up -d
   ```

3. **Check if all services are running:**
   ```bash
   docker-compose ps
   ```

## 📋 Services & Ports

| Service              | Container Name            | Port | Web UI                 |
| -------------------- | ------------------------- | ---- | ---------------------- |
| PostgreSQL (Web)     | sagepick_postgres_web     | 5433 | -                      |
| PostgreSQL (Backend) | sagepick_postgres_backend | 5434 | -                      |
| PostgreSQL (AI)      | sagepick_postgres_ai      | 5435 | -                      |
| pgAdmin              | sagepick_pgadmin          | 5050 | http://localhost:5050  |
| Redis                | sagepick_redis            | 6379 | -                      |
| RabbitMQ             | sagepick_rabbitmq         | 5672 | http://localhost:15672 |
| MinIO                | sagepick_minio            | 9000 | http://localhost:9001  |

## 🔗 Connection Strings

### From Docker Network (service-to-service)

```bash
# Web Service DB
postgresql://web_user:web_password123@postgres-web:5432/sagepick_web

# Backend Service DB
postgresql://backend_user:backend_password123@postgres-backend:5432/sagepick_backend

# AI Service DB
postgresql://ai_user:ai_password123@postgres-ai:5432/sagepick_ai

# Redis
redis://redis:6379

# RabbitMQ
amqp://admin:admin123@rabbitmq:5672

# MinIO
http://minio:9000
```

### From Host Machine (for development)

```bash
# Web Service DB
postgresql://web_user:web_password123@localhost:5433/sagepick_web

# Backend Service DB
postgresql://backend_user:backend_password123@localhost:5434/sagepick_backend

# AI Service DB
postgresql://ai_user:ai_password123@localhost:5435/sagepick_ai

# Redis
redis://localhost:6379

# RabbitMQ
amqp://admin:admin123@localhost:5672

# MinIO
http://localhost:9000
```

## 📁 Project Structure

```
sagepick.infra/
├── data/                    # Persistent data storage
│   ├── postgres_web/       # Web service database data
│   ├── postgres_backend/   # Backend service database data
│   ├── postgres_ai/        # AI service database data
│   ├── redis/              # Redis cache data
│   ├── rabbitmq/           # RabbitMQ data
│   └── minio/              # MinIO object storage
├── env/                     # Environment configuration
│   ├── postgres.web.env    # Web DB config
│   ├── postgres.backend.env # Backend DB config
│   ├── postgres.ai.env     # AI DB config
│   ├── rabbitmq.env        # RabbitMQ config
│   ├── minio.env          # MinIO config
│   └── pgadmin.env        # pgAdmin config
├── docker-compose.yml      # Main orchestration file
├── init.sh                 # Initialize data folders and env files
├── start.sh                # Start all services
├── stop.sh                 # Stop all services
└── README.md               # This file
```

## 🛠 Management Commands

### Start Services

```bash
# Start all services
docker-compose up -d

# Start specific service
docker-compose up -d postgres-web

# View logs
docker-compose logs -f rabbitmq
```

### Stop Services

```bash
# Stop all services
docker-compose down

# Stop and remove volumes (⚠ DELETES DATA)
docker-compose down -v
```

### Database Operations

```bash
# Connect to database directly
docker exec -it sagepick_postgres_web psql -U web_user -d sagepick_web

# Backup database
docker exec sagepick_postgres_web pg_dump -U web_user sagepick_web > backup.sql

# Restore database
docker exec -i sagepick_postgres_web psql -U web_user -d sagepick_web < backup.sql
```

## 🔧 Troubleshooting

### Port Conflicts

If you get port conflicts, edit the ports in `docker-compose.yml`:

```yaml
ports:
  - "5433:5432" # Change 5433 to any available port
```

### Permission Issues

```bash
# Fix data folder permissions
sudo chown -R $USER:$USER ./data/
```

### Service Not Starting

```bash
# Check service logs
docker-compose logs [service-name]

# Recreate service
docker-compose up -d --force-recreate [service-name]
```

## 🚀 Production Notes

Before going to production:

1. Change all default passwords
2. Use environment variables for sensitive data
3. Enable SSL/TLS for external connections
4. Set up proper backup strategies
5. Configure monitoring and logging
6. Use secrets management

---

**Happy coding! 🎉**
