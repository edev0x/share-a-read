package com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.mapper;

import com.sharearead.bookscatalog.domain.model.Book;
import com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.entity.AuthorEntity;
import com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.entity.BookEntity;
import com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.entity.GenreEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.Set;

@Mapper(componentModel = "spring", uses = { GenrePersistenceMapper.class })
public interface BookPersistenceMapper {
    @Mapping(target = "authorId",   source = "entity.author.id")
    @Mapping(target = "authorName", source = "entity.author.fullName")
    @Mapping(target = "genres",     source = "entity.genres")
    Book toDomain(BookEntity entity);

    @Mapping(target = "id", source = "book.id")
    @Mapping(target = "author", source = "authorEntity")
    @Mapping(target = "genres", source = "genreEntities")
    BookEntity toEntity(Book book, AuthorEntity authorEntity, Set<GenreEntity> genreEntities);
}
