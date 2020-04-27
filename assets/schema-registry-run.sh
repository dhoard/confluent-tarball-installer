#!/bin/bash

export LOG_DIR=./logs

/opt/confluent/bin/schema-registry-start /opt/confluent/etc/schema-registry/schema-registry.properties 2>&1 | tee -a schema-registry.log
