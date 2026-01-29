package com.sharearead.bookscatalog.domain.model;

import java.util.Set;

import lombok.Data;

@Data
public class AuthorAggregate {
    private Integer id;
    private String name;
    private String nationality;
    private Set<BookAggregate> books;
}
