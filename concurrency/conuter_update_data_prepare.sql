-- Reference: https://www.postgresql.org/files/developer/concurrency.pdf

-- https://blog.2ndquadrant.com/postgresql-anti-patterns-read-modify-write-cycles/



DROP TABLE IF EXISTS web_pages;
CREATE TABLE web_pages ( id integer, page_url VARCHAR, hits INTEGER);
INSERT INTO web_pages VALUES (1, 'a.com/index.html', 0), (2, 'a.com/navigate.html',0);
SELECT * FROM web_pages;