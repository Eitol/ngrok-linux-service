#!/usr/bin/env bash

INSTALL_PATH="/opt/ngrok"

rm -rf ${INSTALL_PATH}

# check the arch
ARCH=`uname -m`
if [[ ${ARCH} != "arm" && ${ARCH} != "x86_64" ]]; then
    echo "ERROR: This script cant'n be run in this cpu architecture. Valid: arm or x86_64"
    exit -1
fi

mkdir ${INSTALL_PATH}

# check params
if [ "$#" -eq 1 ]; then
    sed -i -e "s/<add_your_token_here>/$1/g" "./config.yml"
fi

cp "./config.yml" "${INSTALL_PATH}"

# Copy ngrok executable
cp "./bin/ngrok-${ARCH}" "${INSTALL_PATH}/ngrok"
chmod +x ${INSTALL_PATH}/ngrok

# Install service
cp "./ngrok.service" "/etc/systemd/system/"
systemctl daemon-reload
systemctl enable ngrok.service
systemctl start ngrok.service
