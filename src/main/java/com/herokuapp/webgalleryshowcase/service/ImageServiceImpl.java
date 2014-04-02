package com.herokuapp.webgalleryshowcase.service;

import com.herokuapp.webgalleryshowcase.dao.ImageItemDao;
import com.herokuapp.webgalleryshowcase.domain.ImageItem;
import com.herokuapp.webgalleryshowcase.service.exceptions.FileUploadException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;

@Service
public class ImageServiceImpl implements ImageService {

    private Logger log = LoggerFactory.getLogger(ImageServiceImpl.class);

    @Autowired
    private ImageItemDao imageItemDao;

    public void uploadImage(MultipartFile file, String title, int albumId) {

        byte[] imageContent;
        BufferedImage bufferedImage;
        try {
            imageContent = file.getBytes();

            ByteArrayInputStream bis = new ByteArrayInputStream(imageContent);
            bufferedImage = ImageIO.read(bis);
        } catch (IOException e) {
            log.debug("Uploading file IO exception.");
            throw new FileUploadException("File upload problem", e);
        }

        String fileName = replaceSpacesWithUnderscore(file.getOriginalFilename());
        ImageItem imageItem = new ImageItem();

        imageItem.setFileName(fileName);
        imageItem.setTitle(title);
        imageItem.setContentType(file.getContentType());
        imageItem.setWidth(bufferedImage.getWidth());
        imageItem.setHeight(bufferedImage.getHeight());
        imageItem.setFileContent(imageContent);
        imageItem.setAlbumHolderId(albumId);

        imageItemDao.uploadImage(imageItem);

        log.debug("Image has been successfully uploaded.");
    }

    private String replaceSpacesWithUnderscore(String string) {
        return string.replace(' ', '_');
    }
}
