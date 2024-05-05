create table author(
	author_id int,
	author_name varchar(50),
	author_subject varchar(50),
	qualification varchar(50),
	primary key(author_id)
 );


create table genre(
	genre_id int,
	genre_count int,
	genre_name varchar(30) not null,
	primary key(genre_id)
);

create table vendor(
	vendor_id int,
	v_name varchar(50) not null,
	contact_no int unique not null,
	primary key(vendor_id)
);

create table publisher(
	pub_id int,
	pub_name varchar(50) not null,
	country varchar(20) not null,
	primary key(pub_id)
);

--5
create table lib(
	library_id int,
	library_name varchar(50) not null,
	contact_no int not null,
	primary key(library_id)
);

--6
create table members(
	mem_id int,
	first_name varchar(20) not null,
	last_name varchar(20) not null,
	state_name varchar(20) not null,
	city varchar(20) not null,
	pin_code varchar(20) not null,
	contact_no int not null,
	private_list text[],
	lib_id int,
	primary key(mem_id),
	foreign key(lib_id) references lib(library_id)
	
);




--7

create table employee(
	emp_id int,
	first_name varchar(20),
	last_name varchar(20),
	lib_id int,
	primary key(emp_id),
	foreign key(lib_id) references lib(library_id)
);

--8

create table books(
	book_id int,
	book_name varchar(50) unique not null,
	book_price int not null,
	book_count int,
	status int,
	author_id int,
	genre_id int,
	pub_id int,
	primary key(book_id),
	foreign key(author_id) references author(author_id),
	foreign key(genre_id) references genre(genre_id),
	foreign key(pub_id) references publisher(pub_id)
);

--9

create table admin_t(
	admin_id int,
	admin_name varchar(30) not null,
	library_id int,
	primary key(admin_id),
	foreign key(library_id) references lib(library_id)
);

--10

create table admin_contact_no(
	admin_id int,
	contact_no int not null,
	foreign key(admin_id) references admin_t(admin_id)
);

--11

create table emp_contact_no(
	emp_id int,
	contact_no int not null,
	primary key(emp_id,contact_no),
	foreign key(emp_id) references employee(emp_id)
);


--12

create table send_request(
	mem_id int,
	emp_id int,
	book_id int not null,
	book_title int not null,
	primary key(mem_id,emp_id),
	foreign key(mem_id) references members(mem_id),
	foreign key(emp_id) references employee(emp_id)
);

--13

create table library_address(
	library_id int,
	address varchar(50),
	primary key(library_id,address),
	foreign key(library_id) references lib(library_id)
);

--14

create table has(
	library_id int,
	book_id int,
	primary key(library_id,book_id),
	foreign key(library_id) references lib(library_id),
	foreign key(book_id) references books(book_id)
);

--15
create table issue(
	emp_id int,
	book_id int,
	issue_date date not null,
	return_status int not null,
	issue_status int not null,
	due_date date not null,
	primary key(emp_id,book_id),
	foreign key(emp_id) references employee(emp_id),
	foreign key(book_id) references books(book_id)
);

--16

create table sales(
	vendor_id int,
	book_id int,
	primary key(vendor_id,book_id),
	foreign key(vendor_id) references vendor(vendor_id),
	foreign key(book_id) references books(book_id)
);

ALTER TABLE issue
ADD COLUMN fine NUMERIC DEFAULT 0;

------------------Queries and indexes ----------------

--1) Search for Books by Genre
SELECT b.book_name, b.book_price, a.author_name
FROM books b
JOIN genre g ON b.genre_id = g.genre_id
JOIN author a ON b.author_id = a.author_id
WHERE g.genre_name = 'Historical Fiction';
-- using BTREE Index
CREATE INDEX idx_genre_name ON genre(genre_name);


--2) Details of Overdue Books
SELECT b.book_name, m.first_name, m.last_name, i.due_date
FROM issue i
JOIN books b ON i.book_id = b.book_id
JOIN members m ON i.emp_id = m.mem_id
WHERE i.return_status = 0 AND i.due_date < CURRENT_DATE;
-- using BTREE index
CREATE INDEX idx_issue_due_status ON issue(due_date, return_status);


--3)Total Number of Books by Publisher
SELECT p.pub_name, COUNT(b.book_id) AS Total_Books
FROM publisher p
JOIN books b ON p.pub_id = b.pub_id
GROUP BY p.pub_name;
-- using BTREE index
CREATE INDEX idx_books_publisher ON books(pub_id);


--4) Find All Employees Working in a Specific Library
SELECT e.first_name, e.last_name, l.library_name
FROM employee e
JOIN lib l ON e.lib_id = l.library_id
WHERE l.library_id = 2; 
-- using BTREE Index
CREATE INDEX idx_employee_lib ON employee(lib_id);


--5)  Find Specific Book Details
SELECT book_name, book_price, status
FROM books
WHERE book_id = 2; 
--using HASH index
CREATE INDEX idx_book_id ON books USING HASH (book_id);



--6) List books along with their genres and publishers, filtered by genre name and sorted by publisher name.
SELECT b.book_name, g.genre_name, p.pub_name
FROM books b
JOIN genre g ON b.genre_id = g.genre_id
JOIN publisher p ON b.pub_id = p.pub_id
WHERE g.genre_name = 'Historical Fiction'
ORDER BY p.pub_name;
-- using Multi-column index
CREATE INDEX idx_genre_publisher ON genre(genre_id, genre_name);
CREATE INDEX idx_books_genre_pub ON books(genre_id, pub_id);


--7)Get complete details of books by a specific author without accessing the main 'books' table.
SELECT book_id, book_name, book_price
FROM books
WHERE author_id = 3;  
--using Covering index
CREATE INDEX idx_books_covering ON books(author_id, book_id, book_name, book_price);


--8) Maintain unique contact numbers for vendors.
--unique index
CREATE UNIQUE INDEX idx_vendor_contact_no ON vendor(contact_no);


--9) Find members who have a specific book in their private list.
SELECT first_name, last_name
FROM members
WHERE private_list @> ARRAY['Book']; 
--using GIN index
CREATE INDEX idx_member_private_list ON members USING GIN (private_list);


---------------------Trigger---------------
-- Auto-Calculating Fines


CREATE OR REPLACE FUNCTION calculate_fine()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.return_status = 1 AND CURRENT_DATE > NEW.due_date THEN
        NEW.fine := (CURRENT_DATE - NEW.due_date) * 50; 
    ELSE
        NEW.fine := 0; 
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_calculate_fine
BEFORE UPDATE ON issue
FOR EACH ROW
WHEN (NEW.return_status = 1)
EXECUTE FUNCTION calculate_fine();



-----------Function -----------------
--function to find the total fine for a user 
CREATE OR REPLACE FUNCTION calculate_total_fines(mem_id_arg INT)
RETURNS NUMERIC AS $$
DECLARE
    total_fines NUMERIC;
BEGIN
    SELECT SUM(fine) INTO total_fines
    FROM issue
    WHERE mem_id = mem_id_arg;
    IF total_fines IS NULL THEN
        total_fines := 0;
    END IF;
    RETURN total_fines;
END;
$$ LANGUAGE plpgsql;

SELECT calculate_total_fines(1);









-- INSERT INTO author (author_id, author_name, author_subject, qualification) VALUES
-- (1, 'Herman Melville', 'Literature', 'M.A.'),
-- (2, 'F. Scott Fitzgerald', 'Literature', 'B.A.'),
-- (3, 'Leo Tolstoy', 'Literature', 'Ph.D.');

-- INSERT INTO genre (genre_id, genre_name) VALUES
-- (1, 'Classic Fiction'),
-- (2, 'Modernist Literature'),
-- (3, 'Historical Fiction');

-- INSERT INTO vendor (vendor_id, v_name, contact_no) VALUES
-- (1, 'Books Wholesale Ltd.', 9988776),
-- (2, 'Literary Finds Inc.', 887766);
-- INSERT INTO publisher (pub_id, pub_name, country) VALUES
-- (1, 'Penguin Classics', 'USA'),
-- (2, 'Scribner', 'USA'),
-- (3, 'Vintage Books', 'USA');
-- INSERT INTO lib (library_id, library_name, contact_no) VALUES
-- (1, 'Central Library', 9876543),
-- (2, 'West End Library', 9876544);
-- INSERT INTO members (mem_id, first_name, last_name, state_name, city, pin_code, contact_no, lib_id, private_list) VALUES
-- (101, 'John', 'Doe', 'California', 'Los Angeles', '90001', 1234567890, 1, '{"Fiction", "Non-Fiction"}'),
-- (102, 'Jane', 'Smith', 'New York', 'New York', '10001', 1234567891, 2, '{"Mystery", "Sci-fi"}'),
-- (103, 'Alice', 'Johnson', 'Texas', 'Houston', '77001', 1234567892, 1, '{"Historical", "Biography"}');
-- INSERT INTO employee (emp_id, first_name, last_name, lib_id) VALUES
-- (201, 'Bob', 'White', 1),
-- (202, 'Emily', 'Brown', 2)
-- (103,'pawan','green',3);
-- INSERT INTO books (book_id, book_name, book_price, book_count, status, author_id, genre_id, pub_id) VALUES
-- (201, 'Moby Dick', 20, 5, 1, 1, 1, 1),
-- (202, 'The Great Gatsby', 15, 2, 1, 2, 2, 2),
-- (203, 'War and Peace', 25, 8, 1, 3, 3, 3);
-- INSERT INTO admin_t (admin_id, admin_name, library_id) VALUES
-- (301, 'Linda Grey', 1),
-- (302, 'Martin Blue', 2);
-- INSERT INTO admin_contact_no (admin_id, contact_no) VALUES
-- (301, 1122334),
-- (302, 2233445);
-- INSERT INTO emp_contact_no (emp_id, contact_no) VALUES
-- (201, 33445567),
-- (202, 44556688);
-- INSERT INTO send_request (mem_id, emp_id, book_id, book_title) VALUES
-- (101, 201, 201, 1),
-- (102, 202, 202, 2);
-- INSERT INTO library_address (library_id, address) VALUES
-- (1, '123 Main St'),
-- (2, '456 Side St');
-- INSERT INTO has (library_id, book_id) VALUES
-- (1, 201),
-- (1, 202),
-- (2, 203);
-- INSERT INTO issue (emp_id, book_id, issue_date, return_status, issue_status, due_date, fine) VALUES
-- (201, 201, '2023-01-01', 0, 1, '2023-01-31', 0),
-- (202, 202, '2023-01-05', 0, 1, '2023-02-05', 0); -- Example of a late return, should trigger a fine calculation on update

-- INSERT INTO sales (vendor_id, book_id) VALUES
-- (1, 201),
-- (2, 202);











