package com.herokuapp.webgalleryshowcase.dao.database.exceptions;

import org.springframework.dao.EmptyResultDataAccessException;

public class UserNotFoundException extends EmptyResultDataAccessException {
    public UserNotFoundException(int expectedSize, Throwable ex) {
        this("User does not exist", expectedSize, ex);
    }

    public UserNotFoundException(String msg, int expectedSize, Throwable ex) {
        super(msg, expectedSize, ex);
    }
}
