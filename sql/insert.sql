INSERT INTO author (author_name, author_subject, qualification) VALUES
('John Doe', 'Literature', 'PhD'),
('Jane Smith', 'Physics', 'MSc'),
('Alice Johnson', 'Mathematics', 'PhD'),
('Chris Lee', 'Chemistry', 'PhD'),
('Patricia Brown', 'History', 'MSc'),
('Michael Davis', 'Biology', 'PhD'),
('Elizabeth Martinez', 'English', 'MA'),
('James Wilson', 'Philosophy', 'PhD'),
('Linda Moore', 'Sociology', 'PhD'),
('Barbara Taylor', 'Economics', 'PhD'),
('Steven Anderson', 'Computer Science', 'MS'),
('Susan Thomas', 'Political Science', 'MA'),
('Robert Jackson', 'Arts', 'MFA'),
('Jessica White', 'Environmental Science', 'MS');


INSERT INTO genre (genre_name, genre_count) VALUES
('Fiction', 30),
('Non-Fiction', 25),
('Science Fiction', 12),
('Romance', 15),
('Thriller', 10),
('Mystery', 20),
('Biography', 18),
('History', 11),
('Children', 14),
('Fantasy', 13),
('Horror', 9),
('Self-help', 7),
('Adventure', 16),
('Cooking', 8);

insert into genre(genre_name,genre_count) values('Travel',6);


INSERT INTO vendor (v_name, contact_no) VALUES
('ABC Books', 9876543210),
('XYZ Supplies', 9876543211),
('QuickBooks', 9876543212),
('Major Reads', 9876543213),
('Epic Store', 9876543214),
('Nova Books', 9876543215),
('Penguin Supplies', 9876543216),
('Book Nation', 9876543217),
('Readers Delight', 9876543218),
('Lit Supply', 9876543219),
('Bookify Vendors', 9876543220),
('Bookmasters', 9876543221),
('Global Reads', 9876543222),
('Book Stash', 9876543223),
('Readers Corner',9876543224);



INSERT INTO publisher (pub_name, country) VALUES
('HarperCollins', 'USA'),
('Penguin Random House', 'USA'),
('Simon and Schuster', 'USA'),
('Hachette Livre', 'France'),
('Macmillan', 'USA'),
('Pearson', 'UK'),
('Scholastic', 'USA'),
('OReilly Media', 'USA'),
('Wiley', 'USA'),
('McGraw-Hill', 'USA'),
('Cengage', 'USA'),
('Elsevier', 'Netherlands'),
('SAGE Publications', 'USA'),
('Taylor & Francis', 'UK'),
('Springer Nature','Germany');

INSERT INTO lib (library_name, contact_no) VALUES
('Downtown Library', 1234567890),
('Central Library', 1234567891),
('West End Library', 1234567892),
('East Side Library', 1234567893),
('North Branch Library', 1234567894),
('South Library', 1234567895),
('City College Library', 1234567896),
('University Main Library', 1234567897),
('Public Library of Science', 1234567898),
('Neighborhood Library',1234567899);


INSERT INTO members (first_name, last_name, state_name, city, pin_code, contact_no, lib_id) VALUES
('Emily', 'Rogers', 'California', 'Los Angeles', '90001', 1234567890, 1),
('David', 'Smith', 'New York', 'New York City', '10001', 1234567891, 2),
('Sophia', 'Brown', 'Texas', 'Houston', '77001', 1234567892, 3),
('Jacob', 'Wilson', 'Florida', 'Miami', '33101', 1234567893, 4),
('Isabella', 'Martinez', 'Illinois', 'Chicago', '60007', 1234567894, 5),
('Ethan', 'Davis', 'Pennsylvania', 'Philadelphia', '19019', 1234567895, 6),
('Madison', 'Garcia', 'Arizona', 'Phoenix', '85001', 1234567896, 7),
('Oliver', 'Lee', 'Nevada', 'Las Vegas', '89030', 1234567897, 8),
('Ava', 'Hernandez', 'Ohio', 'Columbus', '43085', 1234567898, 9),
('William', 'Jones', 'Michigan', 'Detroit', '48201', 1234567899, 10),
('Sophia', 'Lopez', 'Georgia', 'Atlanta', '30301', 1234567800, 1),
('James', 'Miller', 'Washington', 'Seattle', '98101', 1234567801, 2),
('Charlotte', 'Davis', 'Colorado', 'Denver', '80014', 1234567802, 3),
('Logan', 'Wilson', 'Massachusetts', 'Boston', '02101', 1234567803, 4),
('Lily', 'Moore', 'Oregon', 'Portland', '97201',1234567804,5);




INSERT INTO employee (first_name, last_name, lib_id) VALUES
('Mark', 'Johnson', 1),
('Laura', 'Wilson', 1),
('Tommy', 'Lee', 2),
('Jessica', 'Taylor', 2),
('Lucas', 'Moore', 3),
('Julia', 'Anderson', 3),
('Charles', 'Brown', 4),
('Angela', 'White', 4),
('Evan', 'Davis', 5),
('Mia', 'Martin', 5),
('Nicholas', 'Thompson', 6),
('Rachel', 'Garcia', 6),
('Edward', 'Martinez', 7),
('Olivia', 'Hernandez', 7),
('Jack', 'Clark', 8),
('Sophie', 'Rodriguez', 8),
('Max', 'Lewis', 9),
('Amelia', 'Walker', 9),
('Ethan', 'Allen', 10),
('Emma','Young',10);


INSERT INTO books (book_name, book_price, status, author_id, genre_id, pub_id) VALUES
('The Great Adventure', 20, 1, 1, 1, 1),
('Science and You', 25, 1, 2, 2, 2),
('Mystery of the Abyss', 15, 1, 3, 5, 3),
('Romantic Tales', 30, 1, 4, 4, 4),
('Biography of a Scientist', 18, 1, 5, 7, 5),
('The History of Rome', 22, 1, 6, 8, 6),
('Children’s Stories', 12, 1, 7, 9, 7),
('Philosophical Thoughts', 28, 1, 8, 6, 8),
('The Chemistry of Food', 16, 1, 9, 14, 9),
('The Solar System', 21, 1, 10, 2, 10),
('The Art of War', 25, 1, 11, 11, 11),
('Political Theories', 27, 1, 12, 12, 12),
('Learning Java', 19, 1, 13, 2, 13),
('The Story of Art', 17, 1, 14, 11, 14),
('Deep Sea Exploration', 23, 1, 14, 5, 15),
('Advanced Mathematics', 29, 1, 3, 3, 1),
('Economic Policies', 20, 1, 10, 10, 2),
('Gardening Basics', 13, 1, 5, 14, 3),
('Introduction to AI', 32, 1, 13, 12, 4),
('World War II',24,1,6,8,5);


INSERT INTO emp_contact_no (emp_id, contact_no) VALUES
(1, 9876543201),
(2, 9876543202),
(3, 9876543203),
(4, 9876543204),
(5, 9876543205),
(6, 9876543206),
(7, 9876543207),
(8, 9876543208),
(9, 9876543209),
(10, 9876543210),
(11, 9876543211),
(12, 9876543212),
(13, 9876543213),
(14, 9876543214),
(15,9876543215);


INSERT INTO send_request (mem_id, book_id) VALUES
(1, 5),
(2, 10),
(3, 14),
(4, 2),
(5, 1),
(6, 4),
(7, 3),
(8, 8),
(9, 7),
(10, 9);
--1,1,16,

INSERT INTO library_address (library_id, address) VALUES
(1, '101 Main St'),
(2, '202 South St'),
(3, '303 East Ave'),
(4, '404 West Blvd'),
(5, '505 North Rd'),
(6, '606 Central Ln'),
(7, '707 Suburb St'),
(8, '808 Outer Ave'),
(9, '909 Metro Blvd'),
(10, '100 Downtown Rd');



INSERT INTO has (library_id, book_id) VALUES
(5, 1),
(5, 2),
(7, 3),
(6, 4),
(1, 5),
(1, 6),
(9,7),
(8, 8),
(10,9),
(2, 10),
(2, 11),
(3, 12),
(8, 13),
(9, 14),
(1, 15),
(2, 16),
(3, 17),
(6, 18),
(7, 19),
(4, 20);


INSERT INTO issue (emp_id, mem_id, book_id, issue_date, return_status, issue_status, due_date) VALUES
(1, 1, 5, '2022-01-15', 0, 1, '2022-02-15'),
(2, 2, 10, '2022-01-16', 1, 1, '2022-02-16'),
(3, 3, 15, '2022-01-17', 0, 1, '2022-02-17'),
(4, 4, 2, '2022-01-18', 1, 1, '2022-02-18'),
(5, 5, 1, '2022-01-19', 0, 1, '2022-02-19'),
(6, 6, 4, '2022-01-20', 1, 1, '2022-02-20'),
(7, 7, 3, '2022-01-21', 0, 1, '2022-02-21'),
(8, 8, 8, '2022-01-22', 1, 1, '2022-02-22'),
(9, 9, 7, '2022-01-23', 0, 1, '2022-02-23'),
(10, 10, 9, '2022-01-24',1,1,'2022-02-24');



INSERT INTO sales (vendor_id, book_id) VALUES
(1, 5),
(2, 10),
(3, 15),
(4, 2),
(5, 1),
(6, 4),
(7, 3),
(8, 8),
(9,7),
(10,9);
