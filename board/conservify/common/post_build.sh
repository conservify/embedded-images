#!/bin/bash

# Create dropbear host key.
if [ ! -d ${TARGET_DIR}/etc/dropbear ]; then
    rm ${TARGET_DIR}/etc/dropbear
    mkdir -p ${TARGET_DIR}/etc/dropbear
fi

if [ ! -f ${TARGET_DIR}/etc/dropbear/dropbear_rsa_host_key ]; then
    dropbearkey -t rsa -f ${TARGET_DIR}/etc/dropbear/dropbear_rsa_host_key
fi

# Allow the user creating the image to login over SSH.
if [ -f ~/.ssh/id_rsa.pub ]; then
    if [ -f ${TARGET_DIR}/root/.ssh/authorized_keys ]; then
        rm ${TARGET_DIR}/root/.ssh/authorized_keys
    fi

    cp ~/.ssh/id_rsa.pub ${TARGET_DIR}/root/.ssh/authorized_keys
fi
