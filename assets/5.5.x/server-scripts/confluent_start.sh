#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

SCRIPTS=`ls -a ${DIR} | grep "^[0-9]" | grep "_confluent_"`

for SCRIPT in ${SCRIPTS}
do
   echo "Executing ${SCRIPT} start ..."
   ${DIR}/${SCRIPT} start
   sleep 60
done;

echo ""
systemctl | grep confluent
