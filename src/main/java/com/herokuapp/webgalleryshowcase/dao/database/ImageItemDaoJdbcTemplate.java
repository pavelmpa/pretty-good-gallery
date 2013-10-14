package com.herokuapp.webgalleryshowcase.dao.database;

import com.herokuapp.webgalleryshowcase.dao.ImageItemDao;
import com.herokuapp.webgalleryshowcase.dao.database.exceptions.ImageNotFoundException;
import com.herokuapp.webgalleryshowcase.domain.ImageItem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
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
public class ImageItemDaoJdbcTemplate implements ImageItemDao {

    private Logger log = LoggerFactory.getLogger(ImageItemDaoJdbcTemplate.class);

    private static final String UPLOAD_IMAGE = "INSERT INTO image_items " +
            "(file_name, content_type, title, file_content, album_holder_id)" +
            " VALUES (:fileName, :contentType, :title, :fileContent, :albumHolderId)";

    private static final String RETRIEVE_IMAGE = "SELECT * FROM image_items " +
            "WHERE id = :imageItemId AND album_holder_id = :albumId";

    private static final String RETRIEVE_THUMBNAIL_ID_LIST = "SELECT id FROM image_items " +
            "WHERE album_holder_id = :albumId LIMIT :amount OFFSET :from_item";

    private static final String RETRIEVE_IMAGE_INFO =
            "SELECT id, file_name, content_type, upload_timestamp, title, album_holder_id " +
                    "FROM image_items WHERE id = :imageId AND album_holder_id = :albumId";

    private static final String RETRIEVE_THUMBNAILS_lIST =
            "SELECT id, file_name, upload_timestamp, title, content_type FROM image_items " +
                    "WHERE album_holder_id = :albumId ORDER BY id LIMIT :amount OFFSET :fromItem";

    private NamedParameterJdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        jdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    @Override
    public void uploadImage(ImageItem item) {
        SqlParameterSource params = new BeanPropertySqlParameterSource(item);
        log.debug(item.toString());
        jdbcTemplate.update(UPLOAD_IMAGE, params);
    }

    @Override
    public ImageItem retrieveImage(int albumId, int imageItemId) {

        Map<String, Integer> paramMap = new HashMap<>();
        paramMap.put("albumId", albumId);
        paramMap.put("imageItemId", imageItemId);

        ImageItem imageItem;

        try {
            imageItem = jdbcTemplate.queryForObject(RETRIEVE_IMAGE, paramMap, imageItemRowMapper);
        } catch (EmptyResultDataAccessException ex) {
            throw new ImageNotFoundException(ex);
        }
        return imageItem;
    }

    @Override
    public List<Integer> retrieveThumbnailsIdList(int albumId, int fromItem, int amount) {

        Map<String, Integer> paramMap = new HashMap<>();
        paramMap.put("amount", amount);
        paramMap.put("from_item", fromItem);
        paramMap.put("albumId", albumId);

        return jdbcTemplate.queryForList(RETRIEVE_THUMBNAIL_ID_LIST, paramMap, Integer.class);
    }

    @Override
    public List<ImageItem> retrieveThumbnailsId(int albumId, int fromItem, int amount) {

        Map<String, Integer> paramMap = new HashMap<>();
        paramMap.put("amount", amount);
        paramMap.put("fromItem", fromItem);
        paramMap.put("albumId", albumId);

        return jdbcTemplate.query(RETRIEVE_THUMBNAILS_lIST, paramMap, thumbnailRowMapper);
    }

    private final RowMapper<ImageItem> imageItemRowMapper = new RowMapper<ImageItem>() {
        @Override
        public ImageItem mapRow(ResultSet resultSet, int rowNum) throws SQLException {
            ImageItem imageItem = new ImageItem();

            imageItem.setId(resultSet.getInt("id"));
            imageItem.setFileName(resultSet.getString("file_name"));
            imageItem.setTitle(resultSet.getString("title"));
            imageItem.setContentType(resultSet.getString("content_type"));
            imageItem.setFileContent(resultSet.getBytes("file_content"));
            imageItem.setAlbumHolderId(resultSet.getInt("album_holder_id"));
            imageItem.setUploadTime(resultSet.getDate("upload_timestamp"));

            return imageItem;
        }
    };

    private final RowMapper<ImageItem> thumbnailRowMapper = new RowMapper<ImageItem>() {
        @Override
        public ImageItem mapRow(ResultSet resultSet, int rowNum) throws SQLException {
            ImageItem imageItem = new ImageItem();

            imageItem.setId(resultSet.getInt("id"));
            imageItem.setFileName(resultSet.getString("file_name"));
            imageItem.setTitle(resultSet.getString("title"));
            imageItem.setContentType(resultSet.getString("content_type"));
            imageItem.setUploadTime(resultSet.getDate("upload_timestamp"));

            return imageItem;
        }
    };
}
