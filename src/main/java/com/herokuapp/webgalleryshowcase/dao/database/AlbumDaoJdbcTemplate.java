package com.herokuapp.webgalleryshowcase.dao.database;

import com.herokuapp.webgalleryshowcase.dao.AlbumDao;
import com.herokuapp.webgalleryshowcase.domain.Album;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class AlbumDaoJdbcTemplate implements AlbumDao {

    private final Logger log = LoggerFactory.getLogger(AlbumDaoJdbcTemplate.class);

    private final static String ADD_ALBUM = "INSERT INTO albums (title, description, owner_user_id) " +
            "VALUES (:title, :description, (SELECT id FROM users WHERE email = :userOwner))";

    private final static String UPDATE_ALBUM = "UPDATE albums SET  title = :title, description = :description WHERE album_id = :albumId;";

    private final static String DELETE_ALBUM = "DELETE FROM albums WHERE album_id = :albumId";

    private final static String RETRIEVE_ALBUM =
            "SELECT album_id, title, description, public_access, created_time, last_modified, email AS user_owner " +
                    "FROM albums INNER JOIN users ON owner_user_id = users.id WHERE album_id = :albumId";

    private final static String RETRIEVE_ALL_USER_ALBUMS_BY_EMIL =
            "SELECT album_id, title, description, public_access, created_time, last_modified, email AS user_owner " +
                    "FROM albums INNER JOIN users ON owner_user_id = users.id where email = :email";

    private NamedParameterJdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        jdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    @Override
    public void createAlbum(Album album) {
        SqlParameterSource params = new BeanPropertySqlParameterSource(album);
        jdbcTemplate.update(ADD_ALBUM, params);
    }

    @Override
    public Album retrieveAlbum(int albumId) {
        SqlParameterSource params = new MapSqlParameterSource("albumId", albumId);
        return jdbcTemplate.queryForObject(RETRIEVE_ALBUM, params, albumRowMapper);
    }

    @Override
    public void deleteAlbum(int albumId) {   //ToDo: What return?
        SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(albumId);
        int rowsDeleted = jdbcTemplate.update(DELETE_ALBUM, parameterSource);
        log.info("Album was deleted. Rows: " + rowsDeleted);
    }

    @Override
    public void updateAlbum(Album album) {
        SqlParameterSource updateParams = new BeanPropertySqlParameterSource(album);
        jdbcTemplate.update(UPDATE_ALBUM, updateParams);
    }

    @Override
    public List<Album> retrieveUserAlbums(String ownerEmail) {
        Map<String, String> map = new HashMap<>();
        map.put("email", ownerEmail);
        return jdbcTemplate.query(RETRIEVE_ALL_USER_ALBUMS_BY_EMIL, map, albumRowMapper);
    }

    private final RowMapper<Album> albumRowMapper = new RowMapper<Album>() {
        @Override
        public Album mapRow(ResultSet resultSet, int i) throws SQLException {
            Album album = new Album();

            album.setId(resultSet.getInt("album_id"));
            album.setTitle(resultSet.getString("title"));
            album.setDescription(resultSet.getString("description"));
            album.setUserOwner(resultSet.getString("user_owner"));
            album.setPublicAccess(resultSet.getBoolean("public_access"));
            album.setCreated(resultSet.getDate("created_time"));
            album.setLastModified(resultSet.getDate("last_modified"));

            return album;
        }
    };
}