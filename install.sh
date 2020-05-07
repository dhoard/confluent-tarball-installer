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

log_banner "INFO" "Installing ..."

JAVA=`command -v java`

if [ "$JAVA" = "" ]; then
    log "ERROR" "No java found. Java 8 or 11 is required"
    exit -1
fi

log "INFO" "Java found [$JAVA] ..."

if [ ! -f /opt/confluent/bin/zookeeper-server-start ]; then
    log "ERROR" "Confluent Platform doesn't appear to be installed in /opt/confluent"
    exit -1
fi

echo "INFO" "Confluent Platform found [/opt/confluent] ..."

if [ -d /opt/confluent/etc/ksqldb ]; then
    export VERSION=5.5.x
else
    export VERSION=5.4.x
fi

./scripts/create-group-and-users.sh
./scripts/create-directories.sh
./scripts/install-scripts.sh
./scripts/change-configuration.sh

log_banner "INFO" "Installation successful"
