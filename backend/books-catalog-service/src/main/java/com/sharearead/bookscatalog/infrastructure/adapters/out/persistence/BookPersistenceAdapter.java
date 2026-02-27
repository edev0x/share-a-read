package com.sharearead.bookscatalog.infrastructure.adapters.out.persistence;

import com.sharearead.bookscatalog.domain.model.Book;
import com.sharearead.bookscatalog.domain.model.exception.AuthorNotFoundException;
import com.sharearead.bookscatalog.domain.port.out.BookRepositoryPort;
import com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.entity.AuthorEntity;
import com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.entity.GenreEntity;
import com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.mapper.BookPersistenceMapper;
import com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.repository.AuthorJpaRepository;
import com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.repository.BookJpaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Set;

@Component
@RequiredArgsConstructor
public class BookPersistenceAdapter implements BookRepositoryPort {
    private final BookJpaRepository bookJpaRepository;
    private final AuthorJpaRepository authorJpaRepository;
    private final BookPersistenceMapper bookPersistenceMapper;

    @Override
    public Book save(Book book, Set<GenreEntity> genres) {
        AuthorEntity author = authorJpaRepository.findById(book.getAuthorId())
            .orElseThrow(() -> new AuthorNotFoundException(book.getAuthorId()));

        return bookPersistenceMapper.toDomain(bookJpaRepository.save(bookPersistenceMapper.toEntity(book, author, genres)));
    }

    @Override
    public List<Book> findAll() {
        return bookJpaRepository.findAll().stream().map(bookPersistenceMapper::toDomain).toList();
    }

    @Override
    public List<Book> findByTitleContainingIgnoreCase(String title) {
        return bookJpaRepository.findByTitleContainingIgnoreCase(title).stream().map(bookPersistenceMapper::toDomain).toList();
    }

    @Override
    public List<Book> findByAuthorId(Long authorId) {
        return List.of();
    }

    @Override
    public List<Book> findByGenreId(Long genreId) {
        return List.of();
    }

    @Override
    public boolean existsById(Long id) {
        return bookJpaRepository.existsById(id);
    }
}
