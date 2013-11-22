CREATE TABLE user_authorities (
  id        SERIAL PRIMARY KEY,
  authority VARCHAR NOT NULL
);

INSERT INTO user_authorities (authority) VALUES ('ROLE_USER');
INSERT INTO user_authorities (authority) VALUES ('ROLE_ADMIN');

CREATE TABLE users (
  id             SERIAL PRIMARY KEY,
  first_name     VARCHAR(40),
  last_name      VARCHAR(40),
  email          VARCHAR            NOT NULL UNIQUE,
  username       VARCHAR(20) UNIQUE NOT NULL,
  password       VARCHAR            NOT NULL,
  authorities    INTEGER            NOT NULL DEFAULT 1 REFERENCES user_authorities (id),
  enabled        BOOLEAN            NOT NULL DEFAULT TRUE,
  join_timestamp TIMESTAMP          NOT NULL DEFAULT CURRENT_TIMESTAMP
);
