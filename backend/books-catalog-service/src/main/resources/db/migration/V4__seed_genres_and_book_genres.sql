INSERT INTO genres (name, description) VALUES
    ('Novela', 'Genero narrativo'),
    ('Poesía', 'Genero lírico'),
    ('Tecnología', 'Ingeniería de Software, Ciencias de la Computación y Programación'),
    ('Mejores Prácticas', 'Estandares de programación, destrezas y codigo limpio')
ON CONFLICT (name) DO NOTHING;

INSERT INTO book_genres (book_id, genre_id)
SELECT b.id, g.id FROM books b, genres g
WHERE b.title = 'Clean Code'
  AND g.name IN ('Tecnología', 'Mejores Prácticas')
ON CONFLICT DO NOTHING;

INSERT INTO book_genres (book_id, genre_id)
SELECT b.id, g.id FROM books b, genres g
WHERE b.title = 'Las historias prohibidas de pulgarcito'
  AND g.name IN ('Novela')
ON CONFLICT DO NOTHING;

INSERT INTO book_genres (book_id, genre_id)
SELECT b.id, g.id FROM books b, genres g
WHERE b.title = 'Don Quijote de la Mancha'
  AND g.name IN ('Novela')
ON CONFLICT DO NOTHING;

INSERT INTO book_genres (book_id, genre_id)
SELECT b.id, g.id FROM books b, genres g
WHERE b.title = '100 años de soledad'
  AND g.name IN ('Novela')
ON CONFLICT DO NOTHING;