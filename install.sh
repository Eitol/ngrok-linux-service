#!/usr/bin/env bash

INSTALL_PATH="/opt"

# check params
if [ "$#" -ne 1 ]; then
    echo "you must indicate the authtoken as a parameter."
    echo "example: bash install 8lbGOyaS5a8nQPDDDrrzeu_2fPgG7JTPmpt5ZtsUdHjT"
    exit -1
fi

# check the arch
ARCH=`uname -p`
if [[ ${ARCH} != "arm" && ${ARCH} != "x86_64" ]]; then
    echo "ERROR: This script cant'n be run in this cpu architecture. Valid: arm or x86_64"
    exit -1
fi

# Copy ngrok executable
cp "./bin/ngrok-${ARCH}" "${INSTALL_PATH}/ngrok"

# Install service
cp "./ngrok.service" "/etc/systemd/system/"
systemctl daemon-reload
systemctl enable ngrok.service
systemctl start ngrok.service
