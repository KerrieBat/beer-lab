CREATE DATABASE brewrepo;

# MAIN TABLES:

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(100) UNIQUE,
  password_digest VARCHAR(200)
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
  srm INT,
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
  attenuation INT
);

CREATE TABLE styles (
  id SERIAL PRIMARY KEY,
  name VARCHAR(200)
);

# JOIN TABLES:

CREATE TABLE user_hops (
  id SERIAL PRIMARY KEY,
  hop_id INT,
  user_recipe_id INT,
  aa REAL
);

CREATE TABLE master_hops (
  id SERIAL PRIMARY KEY,
  hop_id INT,
  master_recipe_id INT,
  add_time INT,
  ibu INT
);

CREATE TABLE user_fermentables (
  id SERIAL PRIMARY KEY,
  fermentable_id INT,
  user_recipe_id INT,
  ppg INT
);

CREATE TABLE master_fermentables (
  id SERIAL PRIMARY KEY,
  fermentable_id INT,
  master_recipe_id INT,
  target_ppg INT
);

# EXAMPLE DATA:

INSERT INTO master_recipes (name, srm, mash_temp, mash_time, ferment_temp, style_id, user_id, yeast_id)
VALUES ('Example Pale Ale', 9, 67, 60, 19, 1, 1, 1), ('Example IPA', 21, 64, 60, 17, 2, 1, 2);

INSERT INTO user_recipes (volume, user_id, master_recipe_id)
VALUES (21, 1, 1), (30, 1, 2);

INSERT INTO styles (name)
VALUES ('Pale Ale'), ('IPA');

INSERT INTO yeasts (name, attenuation)
VALUES ('SF-05 American Ale', 80), ('Wyeast 1272', 76);

INSERT INTO hops (name)
VALUES ('East Kent Goldings'), ('Citra'), ('Galaxy');

INSERT INTO fermentables (name)
VALUES ('Pale Malt'), ('Light Crystal'), ('Wheat');

INSERT INTO master_fermentables (fermentable_id, master_recipe_id, target_ppg)
VALUES (1, 1, 37), (3, 1, 25), (1, 2, 40), (2, 2, 14);

INSERT INTO user_fermentables (fermentable_id, user_recipe_id, ppg)
VALUES (1, 1, 35), (3, 1, 30), (1, 2, 35), (2, 2, 32);

INSERT INTO master_hops (hop_id, master_recipe_id, add_time, ibu)
VALUES (1, 1, 60, 19), (2, 1, 30, 7), (1, 2, 60, 36), (3, 2, 10, 11);

INSERT INTO user_hops (hop_id, user_recipe_id, aa)
VALUES (1, 1, 8.4), (2, 1, 13.2), (1, 2, 10.6), (3, 2, 7.5);
