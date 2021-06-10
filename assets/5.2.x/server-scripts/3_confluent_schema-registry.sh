#!/bin/bash

SERVICE=confluent-schema-registry
ACTION=${1}
SCRIPT_NAME=`basename "$0"`

systemctl reset-failed

case "${ACTION}"
in
   start)  systemctl start ${SERVICE};;
   stop)   systemctl stop ${SERVICE};;
   status) systemctl status | grep ${SERVICE};;
   *) echo "Usage: ${SCRIPT_NAME} start"; echo "       ${SCRIPT_NAME} stop"; exit -1;
esac
