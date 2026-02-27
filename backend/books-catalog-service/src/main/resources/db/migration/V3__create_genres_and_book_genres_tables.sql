-- Genres lookup table
CREATE TABLE IF NOT EXISTS genres (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(500)
);

-- Join table: many books <-> many genres
CREATE TABLE IF NOT EXISTS book_genres (
    book_id  INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,

    PRIMARY KEY (book_id, genre_id),

    CONSTRAINT fk_book_genres_book
    FOREIGN KEY (book_id)  REFERENCES books(id)  ON DELETE CASCADE,
    CONSTRAINT fk_book_genres_genre
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE RESTRICT
);

CREATE INDEX idx_book_genres_genre ON book_genres(genre_id);
