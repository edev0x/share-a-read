package com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.repository;

import com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.entity.AuthorEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AuthorJpaRepository extends JpaRepository<AuthorEntity, Long> {
    List<AuthorEntity> findByFullNameContainingIgnoreCase(String fullName);

    @Query("SELECT COUNT(b) > 0 FROM BookEntity b WHERE b.author.id = :authorId")
    boolean hasBooks(@Param("authorId") Long authorId);
}
