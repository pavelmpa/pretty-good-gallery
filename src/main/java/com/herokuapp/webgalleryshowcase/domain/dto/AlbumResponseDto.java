package com.herokuapp.webgalleryshowcase.domain.dto;

import com.herokuapp.webgalleryshowcase.domain.Album;

public class AlbumResponseDto {

    private String message;
    private Album album;

    public AlbumResponseDto() {
    }

    public AlbumResponseDto(String message, Album album) {
        this.message = message;
        this.album = album;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Album getAlbum() {
        return album;
    }

    public void setAlbum(Album album) {
        this.album = album;
    }
}
