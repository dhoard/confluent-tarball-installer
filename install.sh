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

log "INFO" "Confluent Platform found [/opt/confluent] ..."

export VERSION=

COUNT=`grep "v5.5" /opt/confluent/share/doc/confluent-control-center/version.txt | wc -l || true`
if [ "1" = "$COUNT" ]; then
  export VERSION=5.5.x
fi

COUNT=`grep "v5.4" /opt/confluent/share/doc/confluent-control-center/version.txt | wc -l || true`
if [ "1" = "$COUNT" ]; then
  export VERSION=5.4.x
fi

COUNT=`grep "v5.3" /opt/confluent/share/doc/confluent-control-center/version.txt | wc -l || true`
if [ "1" = "$COUNT" ]; then
  export VERSION=5.3.x
fi

if [ "" = VERSION ]; then
  log "ERROR" "Unknown/unsupported version"
  exit 1
fi

if [ -d /opt/confluent/etc/ksql ]; then
  # 5.3.x does not contain a ksql-production-server.properties, we create it for consistency
  if [ ! -f /opt/confluent/etc/ksql/ksql-production-server.properties ]; then
    cp /opt/confluent/etc/ksql/ksql-server.properties /opt/confluent/etc/ksql/ksql-production-server.properties
  fi
fi

log "INFO" "Version $VERSION..."

./scripts/create-group-and-users.sh
./scripts/create-directories.sh
./scripts/install-scripts.sh
./scripts/change-configuration.sh

log_banner "INFO" "Installation successful"
