package com.sharearead.bookscatalog.domain.port.in;

import com.sharearead.bookscatalog.domain.model.Book;

import java.util.List;

public interface BookManagerUseCase {
    Book createBook(Book book, List<Long> genreIds);
    List<Book> getAllBooks();
    List<Book> getBooksByAuthor(Long authorId);
    List<Book> getBooksByGenre(Long genreId);
    List<Book> searchByTitle(String title);
}
