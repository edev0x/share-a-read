package com.sharearead.bookscatalog.domain.model;

import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Builder
@With
public class Book {
    private final Long id;
    private final String title;
    private final String isbn;
    private final int totalSamples;
    private final Long authorId;
    private final String authorName;
    private final List<Genre> genres;
    private final LocalDateTime createdAt;
    private final String createdBy;
    private final LocalDateTime updatedAt;
    private final String updatedBy;

    public static Book newBook(String title, String isbn, int totalSamples, Long authorId, List<Long> genreIds) {
        return Book.builder()
                .title(title)
                .isbn(isbn)
                .totalSamples(totalSamples)
                .authorId(authorId)
                .build();
    }
}
