package com.sharearead.bookscatalog.infrastructure.adapters.in.web.exception;

import com.sharearead.bookscatalog.domain.model.exception.AuthorNotFoundException;
import com.sharearead.bookscatalog.infrastructure.adapters.in.web.dto.response.ApiErrorResponse;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.stream.Collectors;

@Slf4j
@RestControllerAdvice(name = "GlobalExceptionHandler")
public class GlobalExceptionHandler {

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ApiErrorResponse<?>> handleIllegalArgumentException(IllegalArgumentException ex, HttpServletRequest httpServletRequest) {
        log.atError().log("IllegalArgumentException thrown: {}", ex.getMessage());

        ApiErrorResponse<?> apiResponse = new ApiErrorResponse<>(
            HttpStatus.BAD_REQUEST.value(),
            HttpStatus.BAD_REQUEST.getReasonPhrase(),
            null,
            httpServletRequest.getRequestURI()
        );

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(apiResponse);
    }

    @ExceptionHandler(AuthorNotFoundException.class)
    public ResponseEntity<ApiErrorResponse<?>> handleAuthorNotFoundException(AuthorNotFoundException ex, HttpServletRequest httpServletRequest) {
        log.atError().log("AuthorNotFoundException thrown: {}", ex.getMessage());

        ApiErrorResponse<?> apiResponse = new ApiErrorResponse<>(
            HttpStatus.NOT_FOUND.value(),
            HttpStatus.NOT_FOUND.getReasonPhrase(),
            ex.getMessage(),
            httpServletRequest.getRequestURI()
        );

        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(apiResponse);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ApiErrorResponse<?>> handleMethodArgumentNotValidException(MethodArgumentNotValidException ex, HttpServletRequest httpServletRequest) {
        log.atError().log("MethodArgumentNotValidException thrown: {}", ex.getMessage());

        String errors = ex.getBindingResult().getFieldErrors().stream()
            .map(e -> e.getField() + ": " + e.getDefaultMessage())
            .collect(Collectors.joining(", "));

        ApiErrorResponse<?> apiResponse = new ApiErrorResponse<>(
            HttpStatus.BAD_REQUEST.value(),
            HttpStatus.BAD_REQUEST.getReasonPhrase(),
            errors,
            httpServletRequest.getRequestURI()
        );

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(apiResponse);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiErrorResponse<?>> handleGeneric(Exception exception, HttpServletRequest httpServletRequest) {
        log.atError().log("Unexpected exception thrown: {}", exception.getMessage());

        ApiErrorResponse<?> apiResponse = new ApiErrorResponse<>(
            HttpStatus.INTERNAL_SERVER_ERROR.value(),
            HttpStatus.INTERNAL_SERVER_ERROR.getReasonPhrase(),
            null,
            httpServletRequest.getRequestURI()
        );

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(apiResponse);
    }
}
