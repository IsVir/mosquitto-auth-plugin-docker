# Mosquitto with auth plugin (auth-plug.so)

Dockerfile for building docker image with mosquitto (mqtt server) & auth plugin

## Supported storages:

* PostgreSQL

## Getting started

Create file with enviroment variables (.env)

```bash
touch .env
```

Edit file with lines bellow

```bash
UID=1000 # User ID
GID=1000 # Group ID
CONFIG_PATH=/path/to/mosquitto.conf
DATA_DIR=/path/to/mosquitto/stirage/directory
```

Run commands

```bash
docker build -t mosquitto-auth .
docker-compose up
```
