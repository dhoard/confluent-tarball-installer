#!/bin/bash

SERVICE=confluent-server
ACTION=${1}
SCRIPT_NAME=`basename "$0"`

systemctl reset-failed

case "${ACTION}"
in
   start)  systemctl start ${SERVICE}; sleep 60;;
   stop)   systemctl stop ${SERVICE};;
   status) systemctl status | grep ${SERVICE};;
   *) echo "Usage: ${SCRIPT_NAME} start"; echo "       ${SCRIPT_NAME} stop"; exit -1;
esac
