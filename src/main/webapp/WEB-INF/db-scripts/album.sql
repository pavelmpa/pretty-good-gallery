CREATE TABLE albums (
  id               SERIAL PRIMARY KEY,
  title            VARCHAR(200) NOT NULL,
  description      VARCHAR(400),
  number_of_images INTEGER DEFAULT 0,
  owner_user_id    INTEGER      NOT NULL,
  public_access    BOOL DEFAULT TRUE,
  created_time     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_modified    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT user_owner_fk FOREIGN KEY (owner_user_id) REFERENCES users (id)
  MATCH FULL ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE FUNCTION album_last_modified_update_stamp()
  RETURNS TRIGGER AS $album_stamp$
    BEGIN
        NEW.last_modified := CURRENT_TIMESTAMP;
        RETURN new();
    END;
$album_stamp$ LANGUAGE plpgsql;

CREATE TRIGGER album_update_stamp BEFORE INSERT OR UPDATE ON albums
FOR EACH ROW EXECUTE PROCEDURE album_last_modified_update_stamp();