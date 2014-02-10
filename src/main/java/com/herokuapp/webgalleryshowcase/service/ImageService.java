package com.herokuapp.webgalleryshowcase.service;

import org.springframework.web.multipart.MultipartFile;

public interface ImageService {
    public void uploadImage(MultipartFile file, String title, int albumId);
}
