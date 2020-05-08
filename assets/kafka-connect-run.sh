#!/bin/bash

/opt/confluent/bin/connect-distributed /opt/confluent/etc/kafka/connect-distributed.properties >> kafka-connect.log 2>&1
