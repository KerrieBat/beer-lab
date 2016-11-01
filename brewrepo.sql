CREATE DATABASE brewrepo;

# MAIN TABLES:

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(100) UNIQUE,
  password VARCHAR(200)
);

CREATE TABLE user_recipes (
  id SERIAL PRIMARY KEY,
  volume INT,
  user_id INT,
  master_recipe_id INT
);

CREATE TABLE master_recipes (
  id SERIAL PRIMARY KEY,
  name VARCHAR(200),
  mash_temp INT,
  mash_time INT,
  ferment_temp INT,
  style_id INT,
  user_id INT,
  yeast_id INT
);

CREATE TABLE hops (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE fermentables (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE yeasts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  attenuation REAL
);

CREATE TABLE styles (
  id SERIAL PRIMARY KEY,
  name VARCHAR(200)
);

# JOIN TABLES:

CREATE TABLE hops_user_recipes (
  id SERIAL PRIMARY KEY,
  hop_id INT,
  user_recipe_id INT,
  aa REAL
);

CREATE TABLE hops_master_recipes (
  id SERIAL PRIMARY KEY,
  hop_id INT,
  master_recipe_id INT,
  add_time INT,
  ibu INT
);

CREATE TABLE fermentables_user_recipes (
  id SERIAL PRIMARY KEY,
  fermentable_id INT,
  user_recipe_id INT,
  ppg INT,
  srm INT
);

CREATE TABLE fermentables_master_recipes (
  id SERIAL PRIMARY KEY,
  fermentable_id INT,
  master_recipe_id INT,
  target_extraction REAL
);
