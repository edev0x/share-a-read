package com.sharearead.bookscatalog.domain.port.out;

import com.sharearead.bookscatalog.domain.model.Book;
import com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.entity.GenreEntity;

import java.util.List;
import java.util.Set;

public interface BookRepositoryPort {
    Book save(Book book, Set<GenreEntity> genreEntities);
    List<Book> findAll();
    List<Book> findByTitleContainingIgnoreCase(String title);
    List<Book> findByAuthorId(Long authorId);
    List<Book> findByGenreId(Long genreId);
    boolean existsById(Long id);
}
