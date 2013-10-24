package com.herokuapp.webgalleryshowcase.service.validators;

import com.herokuapp.webgalleryshowcase.domain.Album;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class AlbumValidator implements Validator {
    @Override
    public boolean supports(Class<?> clazz) {
        return Album.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        ValidationUtils.rejectIfEmpty(errors, "title", "title.empty", "Title field is required.");

        Album album = (Album) target;
        album.setTitle(album.getTitle().trim());
        album.setDescription(album.getDescription().trim());

        if (album.getTitle().length() > 100) {
            errors.rejectValue("title", "title.toLong", "Maximal title length is 100 characters.");
        }
        if (album.getDescription().length() > 300) {
            errors.rejectValue("description", "description.toLong", "Maximal description length is 300");
        }
    }
}
