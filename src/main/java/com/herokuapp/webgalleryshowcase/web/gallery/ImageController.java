package com.herokuapp.webgalleryshowcase.web.gallery;

import com.herokuapp.webgalleryshowcase.dao.ImageItemDao;
import com.herokuapp.webgalleryshowcase.domain.ImageItem;
import com.herokuapp.webgalleryshowcase.service.ImageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/albums/{albumId}")
public class ImageController {

    private final Logger log = LoggerFactory.getLogger(ImageController.class);

    @Autowired
    private ImageItemDao imageItemDao;
    @Autowired
    private ImageService imageService;

    @RequestMapping("/upload")
    public String displayUploadImage() {
        return "uploadImage";
    }

    @RequestMapping(value = "/images/{imageId}/{fileName}",
            method = RequestMethod.GET,
            produces = {"image/jpeg", "image/jpg", "image/png"})
    public
    @ResponseBody
    byte[] showImage(@PathVariable("albumId") Integer albumId,
                     @PathVariable("imageId") Integer imageId,
                     @PathVariable("fileName") String fileName,
                     HttpServletResponse response) {
        ImageItem imageItem = imageItemDao.retrieveImage(albumId, imageId);

        if (imageItem == null) return new byte[0];

        response.setContentType(imageItem.getContentType());
        response.setHeader("Content-Disposition", "inline; filename=\"" + imageItem.getFileName() + "\"");
        response.setHeader("Cache-Control", "max-age=3600");

        return imageItem.getFileContent();
    }

    @RequestMapping(value = "/images", method = RequestMethod.GET)
    public
    @ResponseBody
    List<ImageItem> uploadImage(@PathVariable int albumId, @RequestParam int fromItem, @RequestParam int amount) {
        return imageItemDao.retrieveThumbnailListByAlbum(albumId, fromItem, amount);
    }

    @RequestMapping(value = "/images", method = RequestMethod.POST)
    public ResponseEntity<String> uploadFile(@PathVariable Integer albumId,
                                             @RequestParam("title") String title,
                                             @RequestParam("file") MultipartFile file) throws IOException {
        log.debug("Upload new image.");
        if (file.isEmpty()) {
            return new ResponseEntity<>("Uploading bad file problem.", HttpStatus.BAD_REQUEST);
        }

        if (!isContentTypeValid(file.getContentType())) {
            return new ResponseEntity<>("This type of file does not support.", HttpStatus.BAD_REQUEST);
        }

        imageService.uploadImage(file, title, albumId);
        return new ResponseEntity<>("Image uploaded successfully.", HttpStatus.CREATED);
    }

    @RequestMapping(value = "/images/{imageId}", method = RequestMethod.DELETE)
    public ResponseEntity<String> deleteImage(@PathVariable("imageId") Integer imageId) {
        log.debug("Delete image " + imageId);
        ResponseEntity<String> response;

        if (imageItemDao.deleteImage(imageId)) {
            response = new ResponseEntity<>("Image has been deleted successfully.", HttpStatus.OK);
        } else {
            response = new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return response;
    }

    private boolean isContentTypeValid(String fileContentType) {
        return fileContentType.equals(MediaType.IMAGE_JPEG_VALUE) || fileContentType.equals(MediaType.IMAGE_PNG_VALUE);
    }
}
