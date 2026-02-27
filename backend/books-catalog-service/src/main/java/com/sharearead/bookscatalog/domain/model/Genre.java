package com.sharearead.bookscatalog.domain.model;

import lombok.Builder;
import lombok.Getter;
import lombok.With;

@Getter
@Builder
@With
public class Genre {
    private final Long id;
    private final String name;

    public static Genre newGenre(String name, String description) {
        return Genre.builder()
            .name(name)
            .build();
    }
}

