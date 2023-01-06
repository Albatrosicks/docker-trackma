#!/bin/sh

# symlink config
if [ ! -e /root/.trackma ]; then
    ln -s /config /root/.trackma
fi

# configure account and settings
python /opt/trackma/config.py

exec python /usr/bin/trackma-qt
