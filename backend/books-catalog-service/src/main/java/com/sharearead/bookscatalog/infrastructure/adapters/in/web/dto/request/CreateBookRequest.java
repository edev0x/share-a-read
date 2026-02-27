package com.sharearead.bookscatalog.infrastructure.adapters.in.web.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class CreateBookRequest {
    @NotBlank(message = "Book's title is required")
    private String title;

    @NotBlank(message = "Author id is required")
    private Integer authorId;

    @NotBlank(message = "ISBN is required")
    @Pattern(regexp = "^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$).*", message = "Invalid ISBN")
    private String isbn;
}
