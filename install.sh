#!/bin/bash

if [ -d /opt/confluent/etc/ksqldb ]; then
    export VERSION=5.5.x
else
    export VERSION=5.4.x
fi

./scripts/create-group-and-users.sh
./scripts/create-directories.sh
./scripts/install-scripts.sh
./scripts/change-configuration.sh
