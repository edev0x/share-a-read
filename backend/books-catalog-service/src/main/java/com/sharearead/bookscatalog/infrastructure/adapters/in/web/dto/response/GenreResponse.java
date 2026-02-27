package com.sharearead.bookscatalog.infrastructure.adapters.in.web.dto.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class GenreResponse {
    private Long id;
    private String name;
}
