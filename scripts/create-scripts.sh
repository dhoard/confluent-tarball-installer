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

log_banner "INFO" "BEGIN Script configuration ..."

echo "cp ./assets/zookeeper-run.sh /home/cp-kafka"
echo "chmod u+x /home/cp-kafka/zookeeper-run.sh"

echo "cp ./assets/kafka-run.sh /home/cp-kafka"
echo "chmod u+x /home/cp-kafka/kafka-run.sh"

echo "chown -R cp-kafka.confluent /home/cp-kafka/*"

log_banner "INFO" "SUCCESS"
