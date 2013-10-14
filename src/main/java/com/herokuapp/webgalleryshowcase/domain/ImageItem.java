package com.herokuapp.webgalleryshowcase.domain;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

public class ImageItem {

    private Integer id;
    private String fileName;
    private String contentType;
    @Length(max = 200, message = "Image title too long. Maximum length 200 symbols.")
    private String title;
    private Integer albumHolderId;
    private byte[] fileContent;
    private Date uploadTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String fileType) {
        this.contentType = fileType;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getAlbumHolderId() {
        return albumHolderId;
    }

    public void setAlbumHolderId(Integer albumHolderId) {
        this.albumHolderId = albumHolderId;
    }

    public byte[] getFileContent() {
        return fileContent;
    }

    public void setFileContent(byte[] fileContent) {
        this.fileContent = fileContent;
    }

    public Date getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(Date uploadTime) {
        this.uploadTime = uploadTime;
    }
}