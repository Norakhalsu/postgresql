# PostgreSQL with Docker

Docker commands used to create and manage the PostgreSQL training environment.

## 1. Create PostgreSQL Container

```bash
docker run --name postgres-training \
  -e POSTGRES_USER=nora \
  -e POSTGRES_PASSWORD=******** \
  -e POSTGRES_DB=training_store \
  -p 5432:5432 \
  -d postgres:17
```

This creates:

- Container: `postgres-training`
- PostgreSQL version: `17`
- User: `nora`
- Database: `training_store`
- Port: `5432`

## 2. Check Docker

```bash
docker info
```

## 3. Show Running Containers

```bash
docker ps
```

## 4. Connect to PostgreSQL

```bash
docker exec -it postgres-training psql -U nora -d training_store
```

Successful connection:

```text
training_store=#
```

## 5. Stop PostgreSQL

```bash
docker stop postgres-training
```

## 6. Start PostgreSQL Again

```bash
docker start postgres-training
```

## 7. Reconnect After Starting

```bash
docker exec -it postgres-training psql -U nora -d training_store
```

## 8. Exit psql

Inside PostgreSQL:

```sql
\q
```

## Useful Docker Commands

Show all containers, including stopped containers:

```bash
docker ps -a
```

View PostgreSQL container logs:

```bash
docker logs postgres-training
```

Check container status:

```bash
docker inspect postgres-training
```