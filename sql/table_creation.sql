create table author(
	author_id int,
	author_name varchar(50),
	author_subject varchar(50),
	qualification varchar(50),
	primary key(author_id)
);


create table genre(
	genre_id int,
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


create table members(
	mem_id int,
	first_name varchar(20) not null,
	last_name varchar(20) not null,
	state_name varchar(20) not null,
	city varchar(20) not null,
	pin_code varchar(20) not null,
	contact_no int not null,
	primary key(mem_id)
 
);


create table lib(
	library_id int,
	library_name varchar(50) not null,
	contact_no int not null,
	primary key(library_id)
);


create table employee(
	emp_id int,
	first_name varchar(20),
	last_name varchar(20),
	designation varchar(20),
	primary key(emp_id)
);


create table books(
	book_id int,
	book_name varchar(50) unique not null,
	book_price int not null,
	status int,
	author_id int,
	genre_id int,
	pub_id int,
	vendor_id int,
	emp_id int,
	primary key(book_id),
	foreign key(author_id) references author(author_id),
	foreign key(genre_id) references genre(genre_id),
	foreign key(pub_id) references publisher(pub_id),
	foreign key(vendor_id) references vendor(vendor_id),
	foreign key(emp_id) references employee(emp_id)
);

create table admin_t(
	admin_id int,
	admin_name varchar(30) not null,
	library_id int,
	primary key(admin_id),
	foreign key(library_id) references lib(library_id)
);


create table admin_contact_no(
	admin_id int,
	contact_no int not null,
	foreign key(admin_id) references admin_t(admin_id)
);


create table emp_contact_no(
	emp_id int,
	contact_no int not null,
	primary key(emp_id,contact_no),
	foreign key(emp_id) references employee(emp_id)
);

create table send_request(
	mem_id int,
	emp_id int,
	book_id int not null,
	book_title varchar(100) not null,
	primary key(mem_id,emp_id),
	foreign key(mem_id) references members(mem_id),
	foreign key(emp_id) references employee(emp_id)
);


create table library_address(
	library_id int,
	address varchar(50),
	primary key(library_id,address),
	foreign key(library_id) references lib(library_id)
);


create table has(
	library_id int,
	book_id int,
	primary key(library_id,book_id),
	foreign key(library_id) references lib(library_id),
	foreign key(book_id) references books(book_id)
);
