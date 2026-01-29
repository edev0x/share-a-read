package com.sharearead.bookscatalog.infrastructure.adapter.out.persistence.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sharearead.bookscatalog.infrastructure.adapter.out.persistence.entities.Book;

public interface BookRepository extends JpaRepository<Book, Integer> {

}
