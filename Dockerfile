# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.17-v4.3.1

ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 py3-pip py3-qt5 ca-certificates tzdata ttf-freefont && ln -sf python3 /usr/bin/python
RUN update-ca-certificates
RUN python3 -m ensurepip
RUN pip3 install --no-cache pip==21.3.1
RUN pip3 install --no-cache --upgrade setuptools pyinotify envparse requests PyQt5 Pillow poetry \
 && rm -rf /root/.cache

ARG TRACKMA_VERSION=master

RUN apk add --no-cache --update --virtual build-dependencies wget unzip && \
    wget -O /tmp/trackma-$TRACKMA_VERSION.zip https://github.com/z411/trackma/archive/$TRACKMA_VERSION.zip && \
    ls -l /tmp && \
    mkdir -p /opt && \
    unzip /tmp/trackma-$TRACKMA_VERSION.zip -d /opt && \
    mv /opt/trackma* /opt/trackma &&\
    cd /opt/trackma && \
    poetry build && \
    pip3 install dist/trackma-*-py3-none-any.whl && \
    rm -rf /tmp/trackma-$TRACKMA_VERSION.zip && \
    apk del build-dependencies

VOLUME /config

# Copy the start script.

COPY /rootfs/opt/trackma/config.py /opt/trackma/config.py

COPY /rootfs/opt/trackma/trackma/lib/libshikimori.py /usr/lib/python3.10/site-packages/trackma/lib/libshikimori.py

COPY /rootfs/startapp.sh /startapp.sh

RUN set-cont-env APP_NAME "trackma"
