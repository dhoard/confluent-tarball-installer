#!/bin/bash

mkdir -p ./logs
export LOG_DIR=./logs

/opt/confluent/bin/schema-registry-start /opt/confluent/etc/schema-registry/schema-registry.properties > schema-registry.log 2>&1
