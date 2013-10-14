package com.herokuapp.webgalleryshowcase.dao;

import com.herokuapp.webgalleryshowcase.domain.ImageItem;

import java.util.List;

public interface ImageItemDao {

    void uploadImage(ImageItem imageItem);

    ImageItem retrieveImage(int albumId, int imageItemId);

    List<Integer> retrieveThumbnailsIdList(int albumId, int fromItem, int amount);

    List<ImageItem> retrieveThumbnailsId(int albumId, int fromItem, int amount);
}
