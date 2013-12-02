package com.herokuapp.webgalleryshowcase.domain.dto;

import java.util.ArrayList;
import java.util.List;

public class ValidationErrorDto {

    private String message;
    private List<FieldErrorDto> fieldErrors = new ArrayList<>();

    public ValidationErrorDto() {
    }

    public ValidationErrorDto(String message) {
        this.message = message;
    }

    public void addFieldError(String field, String message) {
        fieldErrors.add(new FieldErrorDto(field, message));
    }

    public List<FieldErrorDto> getFieldErrors() {
        return fieldErrors;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
