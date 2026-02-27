package com.sharearead.bookscatalog.application.usecase;

import com.sharearead.bookscatalog.domain.model.Book;
import com.sharearead.bookscatalog.domain.port.in.BookManagerUseCase;
import com.sharearead.bookscatalog.domain.port.out.BookRepositoryPort;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class BookManagerUseCaseImpl implements BookManagerUseCase {
    private final BookRepositoryPort bookRepositoryPort;

    @Override
    public Book createBook(Book book, List<Long> genreIds) {
        return null;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Book> getAllBooks() {
        return bookRepositoryPort.findAll();
    }

    @Override
    public List<Book> getBooksByAuthor(Long authorId) {
        return List.of();
    }

    @Override
    public List<Book> getBooksByGenre(Long genreId) {
        return List.of();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Book> searchByTitle(String title) {
        return bookRepositoryPort.findByTitleContainingIgnoreCase(title);
    }
}
