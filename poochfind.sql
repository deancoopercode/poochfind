CREATE DATABASE poochfind;


CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(100) NOT NULL,
  password_digest VARCHAR(400) NOT NULL,
  poochname VARCHAR(100),
  poochbreed VARCHAR(100),
  poochimageurl VARCHAR(500)
);

ALTER TABLE users add column username VARCHAR(100);
ALTER TABLE users add column imageurl VARCHAR(500);




CREATE TABLE friendships (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  friend_id INTEGER
);


CREATE TABLE posts (
  id SERIAL4 PRIMARY KEY,
  content VARCHAR(5000)
)
