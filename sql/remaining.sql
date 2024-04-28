--------------Genre--------
CREATE OR REPLACE FUNCTION get_genre_information(g_id INT) RETURNS
TABLE(g_name VARCHAR,g_count int, b_name VARCHAR) AS $$
BEGIN
RETURN QUERY
SELECT g.genre_name, g.genre_count,books.book_name
FROM genre g
inner join books on books.genre_id = g.genre_id
WHERE g.genre_id = g_id;
END;
$$ LANGUAGE plpgsql;
drop function get_genre_information;

select * from get_genre_information(1);



--------------author----------
CREATE OR REPLACE FUNCTION get_author_information(a_id INT) RETURNS
TABLE(bok_name VARCHAR,g_name VARCHAR) AS $$
BEGIN
RETURN QUERY
SELECT books.book_name,genre.genre_name
FROM author
inner join books on books.author_id = author.author_id
inner join genre on books.genre_id = genre.genre_id
WHERE author.author_id = a_id;
END;
$$ LANGUAGE plpgsql;
drop function get_author_information;
select * from get_author_information(1);



----------------Book ------------
CREATE OR REPLACE FUNCTION get_book_information(b_name varchar) RETURNS
TABLE(total_count int , available_count int , price int ) AS $$
BEGIN
RETURN QUERY
SELECT books.book_name,genre.genre_name
FROM books

WHERE books.book_name = b_name;
END;
$$ LANGUAGE plpgsql;
drop function get_book_information;
select * from get_book_information(1);

------------------------roles----------------------------------------

CREATE ROLE administrator;
CREATE ROLE employee;
CREATE ROLE members;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO administrator;


-- Grant all privileges on all tables in schema public to employee
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO employee;

-- Revoke privileges on specific tables from employee
REVOKE ALL PRIVILEGES ON TABLE public.admin FROM employee;
REVOKE ALL PRIVILEGES ON TABLE public.lib FROM employee;
REVOKE ALL PRIVILEGES ON TABLE public.employee FROM employee;

set role employee;

select * from employee;

reset role;


GRANT SELECT ON author, genre, members,publisher, lib, books, issue TO members;

set role members;

insert into author values(1,'shir');

reset role;

----------------book_title info---------------------------------------
CREATE OR REPLACE FUNCTION get_book_counts(book_title_param VARCHAR(50))
RETURNS TABLE (
    total_count bigINT,
    available_count bigINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        COUNT(*) AS total_count,
        COUNT(*) FILTER (WHERE status = 1) AS available_count
    FROM
        books
    WHERE
        book_name = book_title_param;
END; $$
LANGUAGE plpgsql;

select * from get_book_counts('The Great Escape');

select * from books;
drop function get_book_counts(varchar);