#!/bin/bash

#set -x

#
# Function to handle errors
#
function catch_errors() {
    echo "[ERROR]"
    echo "[ERROR] Errors aborting execution";
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

log_banner "INFO" "BEGIN Script installation"

# ZooKeeper
log "INFO" "Installing ZooKeeper run script"
cp $SERVER_SCRIPTS_ROOT/zookeeper-run.sh /home/cp-kafka
chmod u+x /home/cp-kafka/zookeeper-run.sh
chown -R cp-kafka.confluent /home/cp-kafka/*

# ZooKeeper systemd
log "INFO" "Installing ZooKeeper systemd script"
cp $SERVER_SERVICES_ROOT/confluent-zookeeper.service /etc/systemd/system/confluent-zookeeper.service
chown root.root /etc/systemd/system/confluent-zookeeper.service
chmod 644 /etc/systemd/system/confluent-zookeeper.service

# Kafka
log "INFO" "Installing Kafka run script"
cp $SERVER_SCRIPTS_ROOT/kafka-run.sh /home/cp-kafka
chmod u+x /home/cp-kafka/kafka-run.sh
chown -R cp-kafka.confluent /home/cp-kafka/*

# Kafka systemd
log "INFO" "Installing ZooKeeper systemd script"
cp $SERVER_SERVICES_ROOT/confluent-server.service /etc/systemd/system/confluent-server.service
chown root.root /etc/systemd/system/confluent-kafka.service
chmod 644 /etc/systemd/system/confluent-kafka.service

# Schema Registry
log "INFO" "Installing Schema Registry run script"
cp $SERVER_SCRIPTS_ROOT/schema-registry-run.sh /home/cp-schema-registry
chmod u+x /home/cp-schema-registry/schema-registry-run.sh
chown -R cp-schema-registry.confluent /home/cp-schema-registry*

log "INFO" "Installing Schema Registry systemd script"
cp $SERVER_SERVICES_ROOT/confluent-schema-registry.service /etc/systemd/system/confluent-schema-registry.service
chown root.root /etc/systemd/system/confluent-schema-registry.service
chmod 644 /etc/systemd/system/confluent-schema-registry.service

# KSQL
log "INFO" "Installing KSQL/ksqlDB run script"
cp $SERVER_SCRIPTS_ROOT/ksql-run.sh /home/cp-ksql
chmod u+x /home/cp-ksql/ksql-run.sh
chown -R cp-ksql.confluent /home/cp-ksql/*

log "INFO" "Installing KSQL/ksqlDB systemd script"
cp $SERVER_SERVICES_ROOT/confluent-ksql.service /etc/systemd/system/confluent-ksql.service
chown root.root /etc/systemd/system/confluent-ksql.service
chmod 644 /etc/systemd/system/confluent-ksql.service

# KSQL
log "INFO" "Installing Kafka Connect script"
cp $SERVER_SCRIPTS_ROOT/kafka-connect-run.sh /home/cp-kafka-connect
chmod u+x /home/cp-kafka-connect/kafka-connect-run.sh
chown -R cp-kafka-connect.confluent /home/cp-kafka-connect/*

log "INFO" "Installing Kafka Connect systemd script"
cp ./assets/confluent-kafka-connect.service /etc/systemd/system/confluent-kafka-connect.service
chown root.root /etc/systemd/system/confluent-kafka-connect.service
chmod 644 /etc/systemd/system/confluent-kafka-connect.service

# Control Center
log "INFO" "Installing Control Center run script"
cp $SERVER_SCRIPTS_ROOT/control-center-run.sh /home/cp-control-center
chmod u+x /home/cp-control-center/control-center-run.sh
chown -R cp-control-center.confluent /home/cp-control-center/*

log "INFO" "Installing Control Center systemd script"
cp $SERVER_SERVICES_ROOT/confluent-control-center.service /etc/systemd/system/confluent-control-center.service
chown root.root /etc/systemd/system/confluent-control-center.service
chmod 644 /etc/systemd/system/confluent-control-center.service

# Systemd reload
log "INFO" "Running systemd daemon-reload"
systemctl daemon-reload

# Admin shell scripts
log "INFO" "Install administration scripts"
cp $SERVER_SCRIPTS_ROOT/1_confluent_zookeeper.sh /
cp $SERVER_SCRIPTS_ROOT/2_confluent_server.sh /
cp $SERVER_SCRIPTS_ROOT/3_confluent_schema-registry.sh /
cp $SERVER_SCRIPTS_ROOT/4_confluent_control-center.sh /
cp $SERVER_SCRIPTS_ROOT/5_confluent_kafka-connect.sh /
cp $SERVER_SCRIPTS_ROOT/6_confluent_ksql.sh /
cp $SERVER_SCRIPTS_ROOT/_confluent_kafka-rest.sh /
cp $SERVER_SCRIPTS_ROOT/confluent_delete_logs.sh /
cp $SERVER_SCRIPTS_ROOT/confluent_start.sh /
cp $SERVER_SCRIPTS_ROOT/confluent_status.sh /
cp $SERVER_SCRIPTS_ROOT/confluent_stop.sh /
chmod u+x /*.sh

log_banner "INFO" "END Script installation"
