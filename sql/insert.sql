-- author table
INSERT INTO author (author_id, author_name, author_subject, qualification)
VALUES
(1, 'J.K. Rowling', 'Fantasy', 'PhD in English Literature'),
(2, 'Stephen King', 'Horror', 'Bachelor of Arts in English'),
(3, 'George R.R. Martin', 'Fantasy', 'Master of Fine Arts'),
(4, 'Agatha Christie', 'Mystery', 'Bachelor of Arts in French'),
(5, 'Arthur C. Clarke', 'Science Fiction', 'PhD in Physics');

-- genre table
INSERT INTO genre (genre_id, genre_name)
VALUES
(1, 'Fantasy'),
(2, 'Horror'),
(3, 'Mystery'),
(4, 'Science Fiction'),
(5, 'Thriller');

-- vendor table
INSERT INTO vendor (vendor_id, v_name, contact_no)
VALUES
(1, 'Books Etc.', 11122),
(2, 'Read More Books', 44455),
(3, 'Book Haven', 77788),
(4, 'Page Turners', 1234),
(5, 'Bookworms', 9876);

-- publisher table
INSERT INTO publisher (pub_id, pub_name, country)
VALUES
(1, 'Penguin Random House', 'USA'),
(2, 'HarperCollins', 'UK'),
(3, 'Simon & Schuster', 'USA'),
(4, 'Hachette Livre', 'France'),
(5, 'Macmillan Publishers', 'USA');

-- members table
INSERT INTO members (mem_id, first_name, last_name, state_name, city, pin_code, contact_no)
VALUES
(1, 'Emily', 'Brown', 'California', 'Los Angeles', '90001', 555666),
(2, 'Daniel', 'Smith', 'New York', 'New York City', '10001', 88899),
(3, 'Olivia', 'Johnson', 'Texas', 'Houston', '77001', 11122),
(4, 'James', 'Davis', 'Florida', 'Miami', '33101', 44455),
(5, 'Sophia', 'Martinez', 'Illinois', 'Chicago', '60601', 777888);

-- lib table
INSERT INTO lib (library_id, library_name, contact_no)
VALUES
(1, 'City Public Library', 12345),
(2, 'Town Community Library', 23456),
(3, 'Village Reading Room', 34567),
(4, 'County Library', 45678),
(5, 'Metropolitan Library', 56789);

-- employee table
INSERT INTO employee (emp_id, first_name, last_name, designation)
VALUES
(1, 'Michael', 'Johnson', 'Librarian'),
(2, 'Sarah', 'Williams', 'Manager'),
(3, 'David', 'Smith', 'Assistant Librarian'),
(4, 'Jennifer', 'Brown', 'Clerk'),
(5, 'James', 'Jones', 'Security Guard');

-- books table
INSERT INTO books (book_id, book_name, book_price, status, author_id, genre_id, pub_id, vendor_id, emp_id)
VALUES
(1, 'Harry Potter and the Sorcerer''s Stone', 20, 1, 1, 1, 1, 1, 1),
(2, 'The Shining', 15, 1, 2, 2, 2, 2, 2),
(3, 'Murder on the Orient Express', 12, 1, 4, 3, 3, 3, 3),
(4, '2001: A Space Odyssey', 18, 1, 5, 4, 4, 4, 4),
(5, 'Gone Girl', 10, 1, 2, 5, 5, 5, 5);

-- admin_t table
INSERT INTO admin_t (admin_id, admin_name, library_id)
VALUES
(1, 'Admin 1', 1),
(2, 'Admin 2', 2),
(3, 'Admin 3', 3),
(4, 'Admin 4', 4),
(5, 'Admin 5', 5);

-- admin_contact_no table
INSERT INTO admin_contact_no (admin_id, contact_no)
VALUES
(1, 12345),
(2, 23456),
(3, 34567),
(4, 45678),
(5, 56789);

-- emp_contact_no table
INSERT INTO emp_contact_no (emp_id, contact_no)
VALUES
(1, 555666),
(2, 888999),
(3, 111222),
(4, 444555),
(5, 777888);

-- send_request table
INSERT INTO send_request (mem_id, emp_id, book_id, book_title)
VALUES
(1, 1, 1, 'Harry Potter and the Sorcerer''s Stone'),
(2, 2, 2, 'The Shining'),
(3, 3, 3, 'Murder on the Orient Express'),
(4, 4, 4, '2001: A Space Odyssey'),
(5, 5, 5, 'Gone Girl');

-- library_address table
INSERT INTO library_address (library_id, address)
VALUES
(1, '123 Main St, Los Angeles, CA 90001'),
(2, '456 Elm St, New York City, NY 10001'),
(3, '789 Oak St, Houston, TX 77001'),
(4, '101 Pine St, Miami, FL 33101'),
(5, '202 Maple St, Chicago, IL 60601');

-- has table
INSERT INTO has (library_id, book_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
