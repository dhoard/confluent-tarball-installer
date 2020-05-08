#!/bin/bash

#set -x

#
# Function to handle errors
#
function catch_errors() {
    echo "[ERROR]"
    echo "[ERROR] Errors ... aborting execution";
    echo "[ERROR]"
    echo "[ERROR] ------------------------------------------------------------------------"
    echo "[ERROR] FAILURE"
    echo "[ERROR] ------------------------------------------------------------------------"

    exit 1;
}

#
# Function to log a message
#
function log() {
    echo "[${1}] ${2}"
}

#
# Function to log a message as a banner
#
function log_banner() {
    echo "[${1}] ------------------------------------------------------------------------"
    echo "[${1}] ${2}"
    echo "[${1}] ------------------------------------------------------------------------"
}

#
# Trap any non 0 exit codes
#
trap catch_errors ERR;

#
# Get the working directory
#
WORKING_DIRECTORY=${PWD}

log_banner "INFO" "BEGIN Group and user creation ..."

log "INFO" "Creating group [confluent] ..."
getent group confluent > /dev/null || groupadd -r confluent

SHELL=/bin/bash
HOME_ROOT=/home
USERS="cp-control-center cp-kafka cp-kafka-connect cp-kafka-rest cp-ksql cp-schema-registry"
for USER in $USERS
do
    log "INFO" "Creating user [$USER] ..."
    mkdir -p $HOME_ROOT/$USER
    chown -R $USER.confluent $HOME_ROOT/$USER
    getent passwd $USER > /dev/null || /usr/sbin/useradd --comment "$USER" --shell $SHELL -M -r -g confluent --home $HOME_ROOT/$USER $USER
    usermod -d $HOME_ROOT/$USER
done;

log_banner "INFO" "END Group and user creation"
