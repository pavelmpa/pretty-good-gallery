package com.herokuapp.webgalleryshowcase.dao.database;

import com.herokuapp.webgalleryshowcase.dao.AlbumDao;
import com.herokuapp.webgalleryshowcase.domain.Album;
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


    private final static String CREATE_ALBUM =
            "INSERT INTO web_gallery.albums (title, description, owner_user_id) " +
                    "VALUES (:title, :description, (SELECT web_gallery.users.id FROM web_gallery.users WHERE email = :userOwner)) " +
                    "RETURNING (web_gallery.albums.id)";

    private final static String UPDATE_ALBUM = "UPDATE web_gallery.albums SET  title = :title, description = :description WHERE id = :id RETURNING (id)";

    private final static String DELETE_ALBUM = "DELETE FROM web_gallery.albums WHERE id = :albumId";

    private final static String RETRIEVE_ALBUM =
            "SELECT web_gallery.albums.id, title, description, public_access, created_time, last_modified, email AS user_owner, " +
                    "(SELECT COUNT(*) FROM web_gallery.image_items " +
                    "WHERE web_gallery.image_items.album_holder_id = web_gallery.albums.id) AS images_number " +
                    "FROM web_gallery.albums INNER JOIN web_gallery.users ON owner_user_id = web_gallery.users.id WHERE web_gallery.albums.id = :albumId";

    private final static String RETRIEVE_ALL_USER_ALBUMS_BY_EMIL =
            "SELECT web_gallery.albums.id, title, description, public_access, created_time, last_modified, email AS user_owner, " +
                    "(SELECT COUNT(*) FROM web_gallery.image_items " +
                    "WHERE web_gallery.image_items.album_holder_id = web_gallery.albums.id) AS images_number " +
                    "FROM web_gallery.albums INNER JOIN web_gallery.users ON owner_user_id = web_gallery.users.id where email = :email";

    private NamedParameterJdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        jdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    @Override
    public Album createAlbum(Album album) {
        SqlParameterSource params = new BeanPropertySqlParameterSource(album);
        int newAlbumId = jdbcTemplate.queryForObject(CREATE_ALBUM, params, Integer.class);

        return this.retrieveAlbum(newAlbumId);
    }

    @Override
    public Album retrieveAlbum(int albumId) {
        SqlParameterSource params = new MapSqlParameterSource("albumId", albumId);
        return jdbcTemplate.queryForObject(RETRIEVE_ALBUM, params, albumRowMapper);
    }

    @Override
    public boolean deleteAlbum(int albumId) {
        SqlParameterSource parameterSource = new MapSqlParameterSource("albumId", albumId);
        return jdbcTemplate.update(DELETE_ALBUM, parameterSource) > 0;
    }

    @Override
    public Album updateAlbum(Album album) {
        SqlParameterSource updateParams = new BeanPropertySqlParameterSource(album);
        int updatedAlbumId = jdbcTemplate.queryForObject(UPDATE_ALBUM, updateParams, Integer.class);
        return this.retrieveAlbum(updatedAlbumId);
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

            album.setId(resultSet.getInt("id"));
            album.setTitle(resultSet.getString("title"));
            album.setDescription(resultSet.getString("description"));
            album.setUserOwner(resultSet.getString("user_owner"));
            album.setPublicAccess(resultSet.getBoolean("public_access"));
            album.setCreated(resultSet.getDate("created_time"));
            album.setLastModified(resultSet.getDate("last_modified"));
            album.setNumberOfImages(resultSet.getInt("images_number"));

            return album;
        }
    };
}
