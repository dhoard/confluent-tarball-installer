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

log_banner "INFO" "BEGIN creating directories..."

log "INFO" "Creating /var/log/kafka ..."
mkdir -p /var/log/kafka
chown -R cp-kafka.confluent /var/log/kafka
chmod o-rwx /var/log/kafka
chmod g+rw /var/log/kafka

log "INFO" "Creating /var/log/confluent ..."
mkdir -p /var/log/confluent
chown -R cp-kafka.confluent /var/log/confluent
chmod o-rwx /var/log/confluent
chmod g+rw /var/log/confluent

log "INFO" "Creating /var/log/confluent/control-center ..."
mkdir -p /var/log/confluent/control-center
chmod o-rwx /var/log/confluent/control-center
chown -R cp-control-center.confluent /var/log/confluent/control-center

log "INFO" "Creating /var/lib/confluent ..."
mkdir -p /var/lib/confluent
chmod o-rwx /var/lib/confluent
chmod g+rwx /var/lib/confluent
chown -R cp-kafka.confluent /var/lib/confluent

log "INFO" "Creating /var/lib/confluent/control-center ..."
mkdir -p /var/lib/confluent/control-center
chmod o-rwx /var/lib/confluent/control-center
chown -R cp-control-center.confluent /var/lib/confluent/control-center

log_banner "INFO" "SUCCESS"
