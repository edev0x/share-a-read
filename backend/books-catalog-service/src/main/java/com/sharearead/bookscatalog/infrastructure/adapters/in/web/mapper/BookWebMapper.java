package com.sharearead.bookscatalog.infrastructure.adapters.in.web.mapper;

import com.sharearead.bookscatalog.domain.model.Book;
import com.sharearead.bookscatalog.domain.model.Genre;
import com.sharearead.bookscatalog.infrastructure.adapters.in.web.dto.response.BookResponse;
import com.sharearead.bookscatalog.infrastructure.adapters.in.web.dto.response.GenreResponse;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface BookWebMapper {
    BookResponse toResponse(Book book);
    GenreResponse genreToResponse(Genre genre);
}
