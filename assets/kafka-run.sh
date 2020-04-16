#!/bin/bash

export LOG_DIR=./logs

/opt/confluent/bin/kafka-server-start /opt/confluent/etc/kafka/server.properties
