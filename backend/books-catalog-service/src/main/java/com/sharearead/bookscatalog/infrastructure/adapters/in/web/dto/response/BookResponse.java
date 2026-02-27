package com.sharearead.bookscatalog.infrastructure.adapters.in.web.dto.response;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
public class BookResponse {
    private Long id;
    private String title;
    private String isbn;
    private int totalSamples;
    private Long authorId;
    private String authorName;
    private List<GenreResponse> genres;
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;
}
