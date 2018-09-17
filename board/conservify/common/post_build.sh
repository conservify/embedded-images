#!/bin/bash

set -xe

# ----------------------------------------------------------
# Pre-generate dropbear host key.
if [ ! -d ${TARGET_DIR}/etc/dropbear ]; then
    rm ${TARGET_DIR}/etc/dropbear
    mkdir -p ${TARGET_DIR}/etc/dropbear
fi

if [ ! -f ${TARGET_DIR}/etc/dropbear/dropbear_rsa_host_key ]; then
    dropbearkey -t rsa -f ${TARGET_DIR}/etc/dropbear/dropbear_rsa_host_key
fi

# ----------------------------------------------------------
# Allow the user creating the image to login over SSH.
if [ -f ~/.ssh/id_rsa.pub ]; then
    if [ -f ${TARGET_DIR}/root/.ssh/authorized_keys ]; then
        rm ${TARGET_DIR}/root/.ssh/authorized_keys
    fi

    cp ~/.ssh/id_rsa.pub ${TARGET_DIR}/root/.ssh/authorized_keys
fi

# ----------------------------------------------------------
# Create and copy private area
PRIVATE=${BR2_EXTERNAL_CONSERVIFY_PATH}/private
if [ -d $PRIVATE ]; then
    TARGET_PRIVATE=${TARGET_DIR}/etc/private
    HOSTNAME=$(head -n 1 ${TARGET_DIR}/etc/hostname)
    echo "Using HOSTNAME=${HOSTNAME}"

    mkdir -p ${TARGET_PRIVATE}
    chmod 700 ${TARGET_PRIVATE}
    cp ${PRIVATE}/*.id_rsa* ${TARGET_PRIVATE}
    chmod 600 ${TARGET_PRIVATE}/*.id_rsa
    chmod 600 ${TARGET_PRIVATE}/*.id_rsa.pub

    if [ -f ${PRIVATE}/user.id_rsa.dropbear ]; then
        SSH_DIR=${TARGET_DIR}/root/.ssh
        mkdir -p ${SSH_DIR}
        cp ${PRIVATE}/user.id_rsa ${SSH_DIR}/id_rsa.openssh
        cp ${PRIVATE}/user.id_rsa.dropbear ${SSH_DIR}/id_rsa
        cp ${PRIVATE}/user.id_rsa.pub ${SSH_DIR}/id_rsa.pub
        chmod 700 ${SSH_DIR}
        chmod 600 ${SSH_DIR}/id_rsa*
    fi

    # Copy per-machine configuration.
    if [ -f ${PRIVATE}/${HOSTNAME}.env ]; then
        cp -ar ${PRIVATE}/${HOSTNAME}.env ${TARGET_PRIVATE}/private.env
    else
        echo "No per-machine configuration found!"
    fi

    # Copy wireguard setup from secure/private area.
    if [ -d ${PRIVATE}/wg/${HOSTNAME} ]; then
        mkdir -p ${TARGET_PRIVATE}/wg
        cp -ar ${PRIVATE}/wg/${HOSTNAME}/* ${TARGET_PRIVATE}/wg
        chmod 700 ${TARGET_PRIVATE}/wg
        chmod 600 ${TARGET_PRIVATE}/wg/*
    else
        echo "No wireguard configuration found!"
    fi
else
    echo "No local private area."
fi
