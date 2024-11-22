#!/bin/bash

echo "=> Launching Kafka Connect"

/etc/confluent/docker/run & disown

sleep 20
echo "=> Waiting for Kafka Connect to start listening on kafka-connect ⏳"

while [ `curl -s -o /dev/null -w %{http_code} http://kafka-connect:8083/connectors` -ne 200 ] ; do 
    echo $(date) " Kafka Connect listener HTTP state: " $(curl -s -o /dev/null -w %{http_code} http://kafka-connect:8083/connectors) " (waiting for 200)"
    sleep 5 
done

nc -vz kafka-connect 8083

echo "=> Creating Kafka Connect Cassandra sink"

./create-cassandra-sink.sh 

sleep infinity