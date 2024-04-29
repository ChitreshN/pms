-- status and details of issues
CREATE VIEW issued_books AS
SELECT i.emp_id, i.book_id, i.issue_date, i.return_status, i.issue_status, i.due_date,
       b.book_name, b.book_price
FROM issue i
JOIN books b ON i.book_id = b.book_id;

-- employee details along with library contacts
CREATE VIEW employee_details AS
SELECT e.emp_id, e.first_name, e.last_name,
       l.library_name, l.contact_no AS library_contact
FROM employee e
JOIN lib l ON e.lib_id = l.library_id;

-- member details along with library details for admin
CREATE VIEW member_details AS
SELECT m.mem_id, m.first_name, m.last_name, m.state_name, m.city, m.pin_code, m.contact_no,
       l.library_name, l.contact_no AS library_contact
FROM members m
JOIN lib l ON m.lib_id = l.library_id;

-- book details along with related information
CREATE VIEW book_details AS
SELECT b.book_id, b.book_name, b.book_price, b.book_count, b.status,
       a.author_name, a.author_subject, a.qualification,
       g.genre_name,
       p.pub_name, p.country,
       v.v_name, v.contact_no
FROM books b
JOIN author a ON b.author_id = a.author_id
JOIN genre g ON b.genre_id = g.genre_id
JOIN publisher p ON b.pub_id = p.pub_id
JOIN vendor v ON b.vendor_id = v.vendor_id;

-- overdue books
CREATE VIEW overdue_books AS
SELECT i.emp_id, i.book_id, i.issue_date, i.due_date,
       m.first_name, m.last_name, l.library_name
FROM issue i
JOIN members m ON i.mem_id = m.mem_id
JOIN lib l ON m.lib_id = l.library_id
WHERE i.issue_status = 1 AND i.due_date < CURRENT_DATE;

-- number of members in each library
CREATE VIEW member_library_summary AS
SELECT l.library_name, COUNT(m.mem_id) AS member_count
FROM lib l
LEFT JOIN members m ON l.library_id = m.lib_id
GROUP BY l.library_name;
