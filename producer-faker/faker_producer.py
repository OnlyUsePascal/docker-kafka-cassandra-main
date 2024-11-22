"""Produce openweathermap content to 'weather' kafka topic."""
import asyncio
import configparser
import os
import time
from collections import namedtuple
from websocket import send
from dataprep.connector import connect
from kafka import KafkaProducer
from faker import Faker
import json

KAFKA_BROKER_URL = os.environ.get("KAFKA_BROKER_URL")
TOPIC_NAME = os.environ.get("TOPIC_NAME")
SLEEP_TIME = int(os.environ.get("SLEEP_TIME", 60))

faker = Faker()

def get_registered_user():
    return {
        "name": faker.name(),
        "address": faker.address(),
        "year": faker.year(), 
        "phone" : faker.phone_number(),
        "dob" : faker.date_of_birth(),
        "country" : faker.country(), 
        "created_at" : faker.date(),
        "fav_color" : faker.color(),
        "email" : faker.email(),
        "locale" : faker.locale()
    }

def json_serializer(data):
    return json.dumps(data, default=str).encode("utf-8")
    
def run():
    cooldown = 10

    print("Setting up Weather producer at {}".format(KAFKA_BROKER_URL))
    producer = KafkaProducer(
        bootstrap_servers=[KAFKA_BROKER_URL],
        value_serializer=json_serializer
    )
    
    while True:
        # get fake data
        print(f'=> Creating user...')
        user = get_registered_user()
        
        # send data to kaf
        print(f'=> Sending to Kafka: {user}')
        producer.send(TOPIC_NAME, value=user)
        time.sleep(cooldown)

if __name__ == "__main__":
    run()
