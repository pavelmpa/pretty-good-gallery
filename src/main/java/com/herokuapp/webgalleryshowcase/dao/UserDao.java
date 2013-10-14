package com.herokuapp.webgalleryshowcase.dao;

import com.herokuapp.webgalleryshowcase.domain.User;

public interface UserDao {

    void addUser(User user);

    User getUserByEmail(String email);
}
