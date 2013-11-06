CREATE TABLE images (
  id               SERIAL PRIMARY KEY,
  file_name        VARCHAR   NOT NULL,
  title            VARCHAR(300),
  content_type     VARCHAR   NOT NULL,
  upload_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  album_holder_id  INTEGER   NOT NULL,
  file_content     BYTEA,
  CONSTRAINT album_holder_fk FOREIGN KEY (album_holder_id) REFERENCES albums (album_id)
  MATCH FULL ON UPDATE NO ACTION ON DELETE NO ACTION
);