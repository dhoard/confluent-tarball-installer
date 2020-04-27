#!/bin/bash

export LOG_DIR=./logs

/opt/confluent/bin/schema-registry-server-start /opt/confluent/etc/schema-registry/schema-registry.properties
