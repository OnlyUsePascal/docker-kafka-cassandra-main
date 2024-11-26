"""Produce openweathermap content to 'weather' kafka topic."""
import asyncio
import configparser
from datetime import datetime
import os
import time
import json
import requests
from collections import namedtuple
from websocket import send
from dataprep.connector import connect
from kafka import KafkaProducer

KAFKA_BROKER_URL = os.environ.get("KAFKA_BROKER_URL")
TOPIC_NAME = os.environ.get("TOPIC_NAME")
SLEEP_TIME = int(os.environ.get("SLEEP_TIME", 60))
COOLDOWN = 10
API_BASE_URL = "https://api.gemini.com/v1"
API_ENDPOINTS = ['btcusd', 'ethusd']


def json_serializer(data):
    return json.dumps(data, default=str).encode("utf-8")


def run():
    iterator = 0
    producer = KafkaProducer(
        bootstrap_servers=[KAFKA_BROKER_URL],
        value_serializer=json_serializer
    )

    while True:
        # generate link
        URL = API_BASE_URL + '/pubticker/' + API_ENDPOINTS[iterator]
        
        # get data
        try:
            print('=> getting data')
            response = requests.get(URL)
            data_raw = response.json()

            _timestamp = data_raw['volume']['timestamp'] / 1000
            _date = datetime.fromtimestamp(_timestamp)
            keys = list(data_raw['volume'].keys())

            # send data
            print('=> sending data')
            data_clean = {
                'time': _date,
                'symbols': keys[:2],
                'bid': data_raw['bid'],
                'ask': data_raw['ask'],
                'last': data_raw['last'],
            }

            print(json_serializer(data_clean))
            producer.send(TOPIC_NAME, value=data_clean)

        except Exception as err:
            print('[!] Something went wrong!')
            print(err)

        finally:
            # cooldown + update iterator
            print('=> resetting....')
            time.sleep(COOLDOWN)
            iterator = (iterator + 1) % len(API_ENDPOINTS)


if __name__ == "__main__":
    run()
