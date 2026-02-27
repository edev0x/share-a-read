package com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.mapper;

import com.sharearead.bookscatalog.domain.model.Genre;
import com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.entity.GenreEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface GenrePersistenceMapper {
   @Mapping(target = "books", ignore = true)
   GenreEntity toEntity(Genre genre);

   Genre toDomain(GenreEntity entity);
}
