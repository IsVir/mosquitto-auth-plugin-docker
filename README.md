# mosquitto-auth-plugin-docker
Dockerfile for building docker image with mosquitto & mosquitto auth plugin

## Supprted storages:

* PostgreSQL

## Getting started

Create file with enviroment variables (.env)

```bash
UID=1000 # User ID
GID=1000 # Group ID
CONFIG_PATH=/path/to/mosquitto.conf
DATA_DIR=/path/to/mosquitto/stirage/directory
```

Run commands:

```bash
cd /path/to/Dockerfile
docker build -t mosquitto-auth .
docker-compose up
```
