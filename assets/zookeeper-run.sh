#!/bin/bash

export LOG_DIR=./logs

/opt/confluent/bin/zookeeper-server-start /opt/confluent/etc/kafka/zookeeper.properties
