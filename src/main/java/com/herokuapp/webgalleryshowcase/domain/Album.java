package com.herokuapp.webgalleryshowcase.domain;

import com.herokuapp.webgalleryshowcase.json.JsonDateSerializer;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

public class Album {

    private int id;
    private String title;
    private String description;
    private String userOwner;
    private boolean publicAccess;
    private int numberOfImages;
    private Date created;
    private Date lastModified;

    public int getNumberOfImages() {
        return numberOfImages;
    }

    public void setNumberOfImages(int numberOfImages) {
        this.numberOfImages = numberOfImages;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUserOwner() {
        return userOwner;
    }

    public void setUserOwner(String userOwner) {
        this.userOwner = userOwner;
    }

    public boolean isPublicAccess() {
        return publicAccess;
    }

    public void setPublicAccess(boolean publicAccess) {
        this.publicAccess = publicAccess;
    }

    public Date getCreated() {
        return created;
    }

    @JsonSerialize(using = JsonDateSerializer.class)
    public void setCreated(Date created) {
        this.created = created;
    }

    public Date getLastModified() {
        return lastModified;
    }

    public void setLastModified(Date lastModified) {
        this.lastModified = lastModified;
    }
}
