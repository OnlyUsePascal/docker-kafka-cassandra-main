CREATE TABLE weatherreport (
  forecastdate TIMESTAMP,
  location TEXT,
  description TEXT,
  temp FLOAT,
  feels_like FLOAT,
  temp_min FLOAT,
  temp_max FLOAT,
  pressure FLOAT,
  humidity FLOAT,
  wind FLOAT,
  sunrise BIGINT,
  sunset BIGINT,
  PRIMARY KEY (location, forecastdate)
);

CREATE TABLE twitterdata (
  tweet_date TIMESTAMP,
  location TEXT,
  tweet TEXT,
  classification TEXT,
  PRIMARY KEY (location, tweet_date)
);

CREATE TABLE IF NOT EXISTS kafkapipeline.fakerdata (
  name TEXT,
  address TEXT,
  year INT,
  PRIMARY KEY (name, address)
);