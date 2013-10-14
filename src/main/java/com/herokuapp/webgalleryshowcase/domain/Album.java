package com.herokuapp.webgalleryshowcase.domain;

import com.herokuapp.webgalleryshowcase.date.JsonDateSerializer;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import java.util.Date;

public class Album {

    private int id;
    @NotBlank(message = "You should fill title.")
    @Length(min = 10, max = 100)
    private String title;
    @Length(max = 400)
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
