DROP SCHEMA IF EXISTS web_gallery CASCADE;
CREATE SCHEMA web_gallery;

-- ------------------------------------------------------------------------
-- Table web_gallery.user_authorities
-- ------------------------------------------------------------------------

CREATE TABLE web_gallery.user_authorities (
  id        SERIAL PRIMARY KEY,
  authority VARCHAR NOT NULL
);

INSERT INTO web_gallery.user_authorities (authority) VALUES ('ROLE_USER');
INSERT INTO web_gallery.user_authorities (authority) VALUES ('ROLE_ADMIN');

-- ------------------------------------------------------------------------
-- Table web_gallery.users
-- ------------------------------------------------------------------------

CREATE TABLE web_gallery.users (
  id             SERIAL PRIMARY KEY,
  first_name     VARCHAR(40),
  last_name      VARCHAR(40),
  email          VARCHAR            NOT NULL UNIQUE,
  username       VARCHAR(20) UNIQUE NOT NULL,
  password       VARCHAR            NOT NULL,
  authorities    INTEGER            NOT NULL DEFAULT 1,
  enabled        BOOLEAN            NOT NULL DEFAULT TRUE,
  join_timestamp TIMESTAMP          NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT authorities_fk FOREIGN KEY (authorities) REFERENCES web_gallery.user_authorities (id)
  MATCH FULL ON UPDATE NO ACTION ON DELETE RESTRICT
);

-- ------------------------------------------------------------------------
-- Table web_gallery.albums
-- ------------------------------------------------------------------------

CREATE TABLE web_gallery.albums (
  id               SERIAL PRIMARY KEY,
  title            VARCHAR(200) NOT NULL,
  description      VARCHAR(400),
  number_of_images INTEGER DEFAULT 0,
  owner_user_id    INTEGER      NOT NULL,
  public_access    BOOL DEFAULT TRUE,
  created_time     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_modified    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT user_owner_fk FOREIGN KEY (owner_user_id) REFERENCES web_gallery.users (id)
  MATCH FULL ON UPDATE NO ACTION ON DELETE CASCADE
);

-- ------------------------------------------------------------------------
-- Function web_gallery.album_last_modified_update_stamp()
-- ------------------------------------------------------------------------

DROP FUNCTION IF EXISTS web_gallery.album_last_modified_update_stamp() RESTRICT;

CREATE OR REPLACE FUNCTION web_gallery.album_last_modified_update_stamp()
  RETURNS TRIGGER AS '
BEGIN
  NEW.last_modified := CURRENT_TIMESTAMP;
  RETURN NEW;
END;
' LANGUAGE plpgsql;

-- ------------------------------------------------------------------------
-- Trigger album_update_stamp
-- ------------------------------------------------------------------------

DROP TRIGGER IF EXISTS album_update_stamp ON web_gallery.albums RESTRICT;

CREATE TRIGGER album_update_stamp BEFORE INSERT OR UPDATE ON web_gallery.albums
FOR EACH ROW EXECUTE PROCEDURE web_gallery.album_last_modified_update_stamp();

-- ------------------------------------------------------------------------
-- Table web_gallery.images
-- ------------------------------------------------------------------------

CREATE TABLE web_gallery.image_items (
  id               SERIAL PRIMARY KEY,
  file_name        VARCHAR   NOT NULL,
  title            VARCHAR(300),
  content_type     VARCHAR   NOT NULL,
  upload_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  album_holder_id  INTEGER   NOT NULL,
  width            INTEGER   NOT NULL,
  height           INTEGER   NOT NULL,
  file_content     BYTEA,
  CONSTRAINT album_holder_fk FOREIGN KEY (album_holder_id) REFERENCES web_gallery.albums (id)
  MATCH FULL ON UPDATE NO ACTION ON DELETE CASCADE
);
