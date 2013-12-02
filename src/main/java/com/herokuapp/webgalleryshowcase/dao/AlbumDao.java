package com.herokuapp.webgalleryshowcase.dao;

import com.herokuapp.webgalleryshowcase.domain.Album;

import java.util.List;

public interface AlbumDao {

    List<Album> retrieveUserAlbums(String userEmail);

    Album createAlbum(Album album);

    Album retrieveAlbum(int albumId);

    boolean deleteAlbum(int albumId);

    Album updateAlbum(Album album);
}
