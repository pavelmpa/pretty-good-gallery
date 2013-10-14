package com.herokuapp.webgalleryshowcase.dao.database.exceptions;

import org.springframework.dao.EmptyResultDataAccessException;

public class ImageNotFoundException extends EmptyResultDataAccessException {

    public ImageNotFoundException(Throwable ex) {
        this("Requested image does not exist", 1, ex);
    }

    public ImageNotFoundException(String msg, int expectedSize, Throwable ex) {
        super(msg, expectedSize, ex);
    }
}
