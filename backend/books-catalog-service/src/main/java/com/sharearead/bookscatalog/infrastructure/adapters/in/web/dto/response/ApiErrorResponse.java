package com.sharearead.bookscatalog.infrastructure.adapters.in.web.dto.response;

import lombok.*;

import java.time.LocalDateTime;

@Data
public class ApiErrorResponse<T> {
    private int status;
    private String error;
    private String message;
    private String path;
    private LocalDateTime timestamp = LocalDateTime.now();
    private T data;

    public ApiErrorResponse(int status, String error, String message, String path) {
        this.status = status;
        this.error = error;
        this.message = message;
        this.path = path;
    }

    public ApiErrorResponse(int status, String error, String message, String path, T data) {
        this(status, error, message, path);
        this.data = data;
    }
}
