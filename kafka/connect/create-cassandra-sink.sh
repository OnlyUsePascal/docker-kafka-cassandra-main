#!/bin/sh

echo "=> Starting Weather Sink"
curl -s \
     -X DELETE http://localhost:8083/connectors/weathersink

curl -s \
     -X POST http://localhost:8083/connectors \
     -H "Content-Type: application/json" \
     -d @config-weathersink.json

echo "=> Starting Faker Sink"
curl -s \
     -X DELETE http://localhost:8083/connectors/fakersink

curl -s \
     -X POST http://localhost:8083/connectors \
     -H "Content-Type: application/json" \
     -d @config-fakersink.json

echo "=> Starting Custom Sink"
curl -s \
     -X DELETE http://localhost:8083/connectors/customsink

curl -s \
     -X POST http://localhost:8083/connectors \
     -H "Content-Type: application/json" \
     -d @config-customsink.json