-- Authors seed
INSERT INTO authors (fullname, nationality) VALUES
    ('Roque Lopez', 'Salvadoreño'),
    ('Miguel de Cervantes', 'Español'),
    ('Gabriel Garcia Marquez', 'Colombiano'),
    ('Robert C. Martin', 'Estadounidense')
ON CONFLICT DO NOTHING;

INSERT INTO books (title, isbn, total_samples, author_id, created_by)
SELECT 'Las historias prohibidas de pulgarcito', '9783161489025', 5, id, 'SYSTEM' FROM authors WHERE fullname = 'Roque Lopez'
UNION ALL
SELECT 'Don Quijote de la Mancha', '0000132350882', 5, id, 'SYSTEM' FROM authors WHERE fullname = 'Miguel de Cervantes'
UNION ALL
SELECT '100 años de soledad', '0000123450883', 5, id, 'SYSTEM' FROM authors WHERE fullname = 'Gabriel Garcia Marquez'
UNION ALL
SELECT 'Clean Code', '0000123450343', 5, id, 'SYSTEM' FROM authors WHERE fullname = 'Robert C. Martin';