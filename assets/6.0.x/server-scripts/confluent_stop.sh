#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

SCRIPTS=`ls -ra ${DIR} | grep "^[0-9]" | grep "_confluent_"`

for SCRIPT in ${SCRIPTS}
do
   echo "Executing ${SCRIPT} stop ..."
   ${DIR}/${SCRIPT} stop
   sleep 30
done;

JAVA_PROCESS_COUNT=`ps -ef | grep java | grep -v grep | wc -l`

# Assumes only Confluent Java processes
if [ "${JAVA_PROCESS_COUNT}" = "0" ]; then
   systemctl reset-failed
fi

systemctl | grep confluent
