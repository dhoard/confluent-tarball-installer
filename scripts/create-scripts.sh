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

cp ./assets/zookeeper-run.sh /home/cp-kafka
chmod u+x /home/cp-kafka/zookeeper-run.sh

cp ./assets/kafka-run.sh /home/cp-kafka
chmod u+x /home/cp-kafka/kafka-run.sh

chown -R cp-kafka.confluent /home/cp-kafka/*

cp ./assets/schema-registry-run.sh /home/cp-schema-registry
chmod u+x /home/cp-schema-registry/schema-registry-run.sh

chown -R cp-schema-registry /home/cp-schema-registry/*

cp ./assets/control-center-run.sh /home/cp-control-center
chmod u+x /home/cp-control-center/control-center-run.sh

chown -R cp-control-center.confluent /home/cp-control-center/*

cp ./assets/ksql-run.sh /home/cp-ksql
chmod u+x /home/cp-ksql/ksql-run.sh

chown -R cp-ksql /home/cp-ksql/*


log_banner "INFO" "SUCCESS"
