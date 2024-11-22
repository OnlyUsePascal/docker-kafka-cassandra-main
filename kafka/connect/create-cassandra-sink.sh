#!/bin/sh


# echo "Starting Twitter Sink"
# curl -s \
#      -X POST http://localhost:8083/connectors \
#      -H "Content-Type: application/json" \
#      -d '{
#   "name": "twittersink",
#   "config":{
#     "connector.class": "com.datastax.oss.kafka.sink.CassandraSinkConnector",
#     "value.converter": "org.apache.kafka.connect.json.JsonConverter",
#     "value.converter.schemas.enable": "false",  
#     "key.converter": "org.apache.kafka.connect.json.JsonConverter",
#     "key.converter.schemas.enable":"false",
#     "tasks.max": "10",
#     "topics": "twittersink",
#     "contactPoints": "cassandradb",
#     "loadBalancing.localDc": "datacenter1",
#     "topic.twittersink.kafkapipeline.twitterdata.mapping": "location=value.location, tweet_date=value.datetime, tweet=value.tweet, classification=value.classification",
#     "topic.twittersink.kafkapipeline.twitterdata.consistencyLevel": "LOCAL_QUORUM"
#   }

# }'

echo "Starting Weather Sink"
curl -s \
     -X DELETE http://localhost:8083/connectors/weathersink

curl -s \
     -X POST http://localhost:8083/connectors \
     -H "Content-Type: application/json" \
     -d @config-weathersink.json

echo "Starting Faker Sink"
curl -s \
     -X DELETE http://localhost:8083/connectors/fakersink

curl -s \
     -X POST http://localhost:8083/connectors \
     -H "Content-Type: application/json" \
     -d @config-faker.json