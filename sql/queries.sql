-- List all books along with their authors and genres:
SELECT b.book_name, a.author_name, g.genre_name
FROM books b
JOIN author a ON b.author_id = a.author_id
JOIN genre g ON b.genre_id = g.genre_id;

--Find all books published by a specific publisher along with their prices:
SELECT b.book_name, b.book_price
FROM books b
JOIN publisher p ON b.pub_id = p.pub_id
WHERE p.pub_name = 'HarperCollins';

-- List all books available in a specific library along with their authors:
SELECT b.book_name, a.author_name
FROM books b
JOIN has h ON b.book_id = h.book_id
JOIN lib l ON h.library_id = l.library_id
JOIN author a ON b.author_id = a.author_id
WHERE l.library_name = 'City Library';

--Find all books requested by members and the employee handling the request:
SELECT b.book_name, m.first_name AS member_first_name, m.last_name AS member_last_name,
       e.first_name AS employee_first_name, e.last_name AS employee_last_name
FROM send_request sr
JOIN books b ON sr.book_id = b.book_id
JOIN members m ON sr.mem_id = m.mem_id
JOIN employee e ON sr.emp_id = e.emp_id;

--List all books priced above a certain value along with their publishers:
SELECT b.book_name, b.book_price, p.pub_name
FROM books b
JOIN publisher p ON b.pub_id = p.pub_id
WHERE b.book_price > 10;
