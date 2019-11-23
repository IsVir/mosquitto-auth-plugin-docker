FROM alpine:latest

ENV MOSQUITTO_VERSION="1.5.9"

ADD https://mosquitto.org/files/source/mosquitto-$MOSQUITTO_VERSION.tar.gz /tmp
ADD https://github.com/jpmens/mosquitto-auth-plug/archive/master.zip /tmp

RUN apk update && apk upgrade && apk add bash && apk add python3 && \
	apk add python3-dev && apk add make && apk add g++ && \
	apk add openssl-dev && apk add libc-dev && \
    tar -zxf /tmp/mosquitto-$MOSQUITTO_VERSION.tar.gz -C /tmp && \
    unzip /tmp/master.zip -d /tmp && adduser -D mosquitto && \
    cd /tmp/mosquitto-$MOSQUITTO_VERSION && make WITH_UUID=no && \
    make install && cd /tmp/mosquitto-auth-plug-master && \
	sed 's/MYSQL ?= yes/MYSQL ?= no/g' config.mk.in > config.mk && \
	sed -i 's/POSTGRES ?= yes/POSTGRES ?= yes/g' config.mk && \
	sed -i 's/MOSQUITTO_SRC =/MOSQUITTO_SRC = \/tmp\/mosquitto-'"$MOSQUITTO_VERSION"'/g' config.mk && \
	sed -i 's/OPENSSLDIR = \/usr/OPENSSLDIR = \/usr\/include\/openssl/g' config.mk && \
	make && mkdir /var/lib/mosquitto && cp auth-plug.so /var/lib/mosquitto && rm -rf /tmp/* && \
	mkdir /mosquitto && mkdir /mosquitto/config /mosquitto/data /mosquitto/log

VOLUME ["/mosquitto/config", "/mosquitto/data", "/mosquitto/log"]

EXPOSE 1883

ENTRYPOINT ["mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]