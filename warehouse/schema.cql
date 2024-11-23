CREATE TABLE IF NOT EXISTS weatherreport (
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

TRUNCATE kafkapipeline.weatherreport;


CREATE TABLE IF NOT EXISTS kafkapipeline.fakerdata (
  name TEXT,
  address TEXT,
  year INT,
  phone TEXT, 
  dob DATE,
  country TEXT,
  created_at DATE,
  fav_color TEXT,
  email TEXT,
  locale TEXT,
  PRIMARY KEY (name, address)
);

TRUNCATE kafkapipeline.fakerdata;


