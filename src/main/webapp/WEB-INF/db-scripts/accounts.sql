CREATE TABLE account_authorities (
  id        SERIAL PRIMARY KEY,
  authority VARCHAR
);

INSERT INTO account_authorities (authority) VALUES ('ROLE_USER');
INSERT INTO account_authorities (authority) VALUES ('ROLE_ADMIN');

CREATE TABLE accounts (
  email                   VARCHAR PRIMARY KEY,
  password                VARCHAR(30) NOT NULL,
  authorities             INTEGER     NOT NULL REFERENCES account_authorities (id),
  not_expired             BOOLEAN     NOT NULL DEFAULT TRUE,
  not_locked              BOOLEAN     NOT NULL DEFAULT TRUE,
  credentials_not_expired BOOLEAN     NOT NULL DEFAULT TRUE,
  enabled                 BOOLEAN     NOT NULL DEFAULT TRUE
);

CREATE TABLE user_profiles (
  id             SERIAL PRIMARY KEY,
  first_name     VARCHAR(40),
  last_name      VARCHAR(40),
  email          VARCHAR            NOT NULL UNIQUE REFERENCES accounts (email),
  username       VARCHAR(20) UNIQUE NOT NULL,
  join_timestamp TIMESTAMP          NOT NULL DEFAULT CURRENT_TIMESTAMP
);