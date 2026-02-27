package com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.entity.BookEntity;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface BookJpaRepository extends JpaRepository<BookEntity, Long> {
    List<BookEntity> findByTitleContainingIgnoreCase(String title);
    List<BookEntity> findByAuthorId(Long authorId);

    @Query("SELECT DISTINCT b FROM BookEntity b JOIN b.genres g WHERE g.id = :genreId")
    List<BookEntity> findByGenreId(Long genreId);

    @Query(value = "SELECT * FROM books ORDER BY RANDOM() LIMIT 1", nativeQuery = true)
    Optional<BookEntity> findRandomBook();
}
