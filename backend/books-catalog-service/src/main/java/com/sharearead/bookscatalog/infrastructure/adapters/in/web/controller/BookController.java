package com.sharearead.bookscatalog.infrastructure.adapters.in.web.controller;

import com.sharearead.bookscatalog.domain.port.in.BookManagerUseCase;
import com.sharearead.bookscatalog.infrastructure.adapters.in.web.dto.response.BookResponse;
import com.sharearead.bookscatalog.infrastructure.adapters.in.web.mapper.BookWebMapper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/books")
@RequiredArgsConstructor
@Tag(name = "Books", description = "Books catalog API")
public class BookController {
    private final BookManagerUseCase bookManagerUseCase;
    private final BookWebMapper mapper;

    @GetMapping("/list")
    @Operation(summary = "List all books")
    public ResponseEntity<List<BookResponse>> getAllBooks() {
        return ResponseEntity.ok(bookManagerUseCase.getAllBooks().stream().map(mapper::toResponse).toList());
    }
}
