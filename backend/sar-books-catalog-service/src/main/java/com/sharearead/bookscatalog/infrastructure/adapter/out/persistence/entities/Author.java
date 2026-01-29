package com.sharearead.bookscatalog.infrastructure.adapter.out.persistence.entities;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "authors")
@NoArgsConstructor
@AllArgsConstructor
public class Author {
    @Column(name = "fullname")
    private String name;

    @Column(name = "nationality")
    private String nationality;

    @OneToMany(mappedBy = "author")
    private List<Book> books;
}
