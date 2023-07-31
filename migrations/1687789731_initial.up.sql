CREATE TABLE IF NOT EXISTS articles (
    id INT PRIMARY KEY,
    title VARCHAR(100),
    content TEXT,
    author VARCHAR(100),
    published BOOLEAN,
    created_date TIMESTAMP not null default current_timestamp,
    updated_date TIMESTAMP not null default current_timestamp
);

COMMIT;