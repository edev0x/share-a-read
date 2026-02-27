package com.sharearead.bookscatalog.application.dto.command;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record EditBookCommand (
    @NotBlank(message = "Book's title is required") String title,
    @NotBlank(message = "ISBN is required") @Size(max = 13, min = 13, message = "ISBN must contain 13 characters") String isbn,
    @Min(value = 0, message = "Min value of samples is zero") @NotNull(message = "Total samples must no be null") Integer totalSamples,
    @NotNull(message = "Author id must not be null") Integer authorId) {
}
