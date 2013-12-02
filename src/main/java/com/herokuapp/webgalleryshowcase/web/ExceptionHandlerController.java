package com.herokuapp.webgalleryshowcase.web;

import com.herokuapp.webgalleryshowcase.dao.database.exceptions.ImageNotFoundException;
import com.herokuapp.webgalleryshowcase.domain.dto.ValidationErrorDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.util.List;

@ControllerAdvice
public class ExceptionHandlerController extends ResponseEntityExceptionHandler {

    private final Logger log = LoggerFactory.getLogger(ExceptionHandlerController.class);

    @ExceptionHandler(value = {DataAccessResourceFailureException.class})
    protected ResponseEntity<Object> handleDataAccessResourceFailure(DataAccessResourceFailureException ex, WebRequest request) {
        log.error("Database connection problems.", ex);

        String bodyOfResponse = "Database connection problems.";
        HttpStatus httpStatus = HttpStatus.SERVICE_UNAVAILABLE;

        return handleExceptionInternal(ex, bodyOfResponse, new HttpHeaders(), httpStatus, request);
    }

    @ExceptionHandler(value = {DataAccessException.class})
    protected ResponseEntity<Object> handleDataAccess(DataAccessException ex, WebRequest request) {
        log.error("Database access problems.", ex);

        String bodyOfResponse = "Database access problems.";
        HttpStatus httpStatus = HttpStatus.SERVICE_UNAVAILABLE;

        return handleExceptionInternal(ex, bodyOfResponse, new HttpHeaders(), httpStatus, request);
    }

    @ExceptionHandler(value = {ImageNotFoundException.class})
    protected ResponseEntity<Object> handelImageNotFoundExceptions(ImageNotFoundException ex, WebRequest request) {
        log.error("Image not found.", ex);

        String bodyOfResponse = "This image does not exist.";
        HttpStatus httpStatus = HttpStatus.NOT_FOUND;

        return handleExceptionInternal(ex, bodyOfResponse, new HttpHeaders(), httpStatus, request);
    }

    @ExceptionHandler(value = {EmptyResultDataAccessException.class})
    protected ResponseEntity<Object> handelEmptyResultExceptions(EmptyResultDataAccessException ex, WebRequest request) {
        log.error("Result was not found in database.", ex);

        String bodyOfResponse = "This item does not exist.";
        HttpStatus httpStatus = HttpStatus.NOT_FOUND;

        return handleExceptionInternal(ex, bodyOfResponse, new HttpHeaders(), httpStatus, request);
    }

    @ExceptionHandler(value = {MaxUploadSizeExceededException.class})
    protected ResponseEntity<Object> handledMaxUploadExceeded(MaxUploadSizeExceededException ex, WebRequest request) {
        log.error("Max upload file size exceeded.", ex);

        String bodyOfResponse = "Max upload file size exceeded.";
        HttpStatus httpStatus = HttpStatus.BAD_REQUEST;

        return handleExceptionInternal(ex, bodyOfResponse, new HttpHeaders(), httpStatus, request);
    }

    @Override
    protected ResponseEntity<Object> handleBindException(BindException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        Object o = processFieldErrors(ex.getFieldErrors());
        return new ResponseEntity<>(o, HttpStatus.BAD_REQUEST);
    }

    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        log.debug(ex.getMessage());
        Object o = processFieldErrors(ex.getBindingResult().getFieldErrors());
        return new ResponseEntity<>(o, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(value = {Exception.class})
    protected ResponseEntity<Object> handleAllExceptions(Exception ex, WebRequest request) {
        log.error("Exception handled by GlobalExceptionHandler", ex);

        String bodyOfResponse = "Something goes wrong.";
        HttpStatus httpStatus = HttpStatus.SERVICE_UNAVAILABLE;

        return handleExceptionInternal(ex, bodyOfResponse, new HttpHeaders(), httpStatus, request);
    }

    private ValidationErrorDto processFieldErrors(List<FieldError> fieldErrors) {
        final String message = "You have some errors here.";
        ValidationErrorDto validationError = new ValidationErrorDto(message);

        for (FieldError fieldError : fieldErrors) {
            validationError.addFieldError(fieldError.getField(), fieldError.getDefaultMessage());
        }

        return validationError;
    }
}
