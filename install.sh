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

log_banner "INFO" "Installing"

JAVA=`command -v java`

if [ "$JAVA" = "" ]; then
    log "ERROR" "No java found. Java 8 or 11 is required"
    exit -1
fi

log "INFO" "Java found [$JAVA]"

if [ ! -f /opt/confluent/bin/zookeeper-server-start ]; then
    log "ERROR" "Confluent Platform doesn't appear to be installed in /opt/confluent"
    exit -1
fi

log "INFO" "Confluent Platform found [/opt/confluent]"

export VERSION=Incompatible

COUNT=`grep "v6.1" /opt/confluent/share/doc/confluent-control-center/version.txt | wc -l || true`
if [ "1" != "$COUNT" ]; then
  log "ERROR" "This code is only for Confluent Platform 6.1.x"
  log_banner "ERROR" "Installation failed"
  exit 1
fi

export SCRIPTS_ROOT=./assets/scripts
export SERVER_SCRIPTS_ROOT=./assets/server-scripts
export SERVER_SERVICES_ROOT=./assets/server-services
export VALUES_ROOT=./assets/values

$SCRIPTS_ROOT/create-group-and-users.sh
$SCRIPTS_ROOT/create-directories.sh
$SCRIPTS_ROOT/install-scripts.sh
$SCRIPTS_ROOT/change-configuration.sh

log_banner "INFO" "Installation successful"
