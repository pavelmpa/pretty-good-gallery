CREATE TABLE images (
  id               SERIAL PRIMARY KEY,
  file_name        VARCHAR   NOT NULL,
  title            VARCHAR(300),
  content_type     VARCHAR   NOT NULL,
  upload_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  album_holder_id  INTEGER REFERENCES albums (album_id),
  file_content     BYTEA
)