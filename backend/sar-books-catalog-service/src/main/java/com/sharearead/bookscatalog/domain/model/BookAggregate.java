package com.sharearead.bookscatalog.domain.model;

import lombok.Data;

@Data
public class BookAggregate {
    private Integer id;
    private String title;
    private Integer totalSamples;
}
