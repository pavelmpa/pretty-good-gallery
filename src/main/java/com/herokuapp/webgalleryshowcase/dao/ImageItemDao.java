package com.herokuapp.webgalleryshowcase.dao;

import com.herokuapp.webgalleryshowcase.domain.ImageItem;

import java.util.List;

public interface ImageItemDao {

    void uploadImage(ImageItem imageItem);

    ImageItem retrieveImage(int albumId, int imageItemId);

    List<ImageItem> retrieveThumbnailListByAlbum(int albumId, int fromItem, int amount);

    List<ImageItem> retrieveExploreThumbnailList(int fromItem, int amount);
}
