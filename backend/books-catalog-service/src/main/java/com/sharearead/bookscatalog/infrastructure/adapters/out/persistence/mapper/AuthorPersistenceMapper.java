package com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.mapper;

import com.sharearead.bookscatalog.domain.model.Author;
import com.sharearead.bookscatalog.domain.model.Book;
import com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.entity.AuthorEntity;
import com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.entity.BookEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring", uses = { GenrePersistenceMapper.class })
public interface AuthorPersistenceMapper {
    @Mapping(target = "books", source = "books")
    Author toDomain(AuthorEntity entity);

    @Mapping(target = "id", source = "author.id")
    @Mapping(target = "fullName", source = "author.name")
    @Mapping(target = "books", ignore = true)
    AuthorEntity toEntity(Author author);

    @Mapping(target = "authorId",   source = "entity.author.id")
    @Mapping(target = "authorName", source = "entity.author.fullName")
    @Mapping(target = "genres",     source = "genres")
    Book bookToDomain(BookEntity entity);
}
