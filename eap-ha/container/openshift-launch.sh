#!/bin/sh

$JBOSS_HOME/bin/standalone.sh -c standalone-ha.xml -b 0.0.0.0 -bmanagement 127.0.0.1 -Djboss.bind.address.private=${IP_ADDR} -Djboss.node.name=${HOSTNAME}
