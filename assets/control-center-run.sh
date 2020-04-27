#!/bin/bash

/opt/confluent/bin/control-center-start /opt/confluent/etc/confluent-control-center/control-center-production.properties 2>&1 | tee -a control-center.log
