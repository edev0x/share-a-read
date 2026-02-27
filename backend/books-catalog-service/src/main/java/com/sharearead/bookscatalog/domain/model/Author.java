package com.sharearead.bookscatalog.domain.model;

import java.util.Set;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Author {
    private Integer id;
    private String name;
    private String nationality;
    private Set<Book> books;
}
