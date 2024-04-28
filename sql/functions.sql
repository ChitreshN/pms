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

--6

create table lib(
	library_id int,
	library_name varchar(50) not null,
	contact_no int not null,
	primary key(library_id)
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

10

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
	book_title text not null,
	primary key(mem_id,emp_id,book_id),
	foreign key(mem_id) references members(mem_id),
	foreign key(emp_id) references employee(emp_id)
);
select * from send_request;
insert into send_request values(1,1,2,'The Great Escape');

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



create or replace function Insert_data(
    in p_table_name varchar(50),
    in p_column_values varchar(150)
)
returns void
as $$

declare
res varchar(50);
values_arr text[];

begin
	values_arr := string_to_array(p_column_values,',');
    case p_table_name
        when 'author' then
            insert into author values (cast(values_arr[1] as integer),values_arr[2],
									   values_arr[3],values_arr[4]);
			raise notice 'inserion into % is successful',p_table_name;
        when 'genre' then
            insert into genre(genre_id, genre_count, genre_name) values (cast(values_arr[1] as integer),values_arr[2],values_arr[3]);
			raise notice 'inserion into % is successful',p_table_name;
        when 'vendor' then
            insert into vendor(vendor_id, v_name, contact_no) values (cast(values_arr[1] as integer),values_arr[2],cast(values_arr[3] as integer));
			raise notice 'inserion into % is successful',p_table_name;
        when 'publisher' then
           	insert into publisher(pub_id, pub_name, country) values (cast(values_arr[1] as integer),values_arr[2],values_arr[3]);
			raise notice 'inserion into % is successful',p_table_name;
        when 'members' then
            insert into members(mem_id, first_name, last_name, state_name, city, pin_code, contact_no,private_list,lib_id) values (cast(values_arr[1] as integer),
																											  values_arr[2],
																											  values_arr[3],
																											  values_arr[4],
																											  values_arr[5],
																											  cast(values_arr[6] as integer),
																											  cast(values_arr[7] as integer),
								  string_to_array(values_arr[8],','),
								  cast(values_arr[9] as integer));
																											  
			raise notice 'inserion into % is successful',p_table_name;																								
        when 'lib' then
            insert into lib(library_id, library_name, contact_no) values (cast(values_arr[1] as integer),values_arr[2],
																		 cast(values_arr[3] as integer));
			raise notice 'inserion into % is successful',p_table_name;															 
        when 'employee' then
            insert into employee(emp_id, first_name, last_name,lib_id) VALUES (cast(values_arr[1] as integer),values_arr[2],values_arr[3],
																					cast(values_arr[4] as integer));
			raise notice 'inserion into % is successful',p_table_name;																		
        when 'books' then
            insert into books(book_id, book_name, book_price, book_count, status, author_id, genre_id, pub_id) VALUES (cast(values_arr[1] as integer),values_arr[2],
																																		 cast(values_arr[3] as integer),cast(values_arr[4] as integer),
																																		 values_arr[5],cast(values_arr[6] as integer),
																																		 cast(values_arr[7] as integer),cast(values_arr[8] as integer));
			raise notice 'inserion into % is successful',p_table_name;																															 
        when 'admin_t' then
            insert into admin_t(admin_id, admin_name, library_id) VALUES (cast(values_arr[1] as integer),values_arr[2],cast(values_arr[3] as intger));
			raise notice 'inserion into % is successful',p_table_name;
        when 'admin_contact_no' then
            insert into admin_contact_no(admin_id, contact_no) VALUES (cast(values_arr[1] as integer),cast(values_arr[2] as integer));
			raise notice 'inserion into % is successful',p_table_name;
        when 'emp_contact_no' then
            insert into emp_contact_no(emp_id, contact_no) VALUES (cast(values_arr[1] as integer),cast(values_arr[2] as integer));
			raise notice 'inserion into % is successful',p_table_name;
        when 'send_request' then
            insert into send_request(mem_id, emp_id, book_id, book_title) values (cast(values_arr[1] as integer),cast(values_arr[2] as integer),
																				 cast(values_arr[3] as integer),
																				 values_arr[4]);
			raise notice 'inserion into % is successful',p_table_name;																	 
        when 'library_address' then
            insert into library_address(library_id, address) values (cast(values_arr[1] as integer),values_arr[2]);
			raise notice 'inserion into % is successful',p_table_name;
        when 'has' then
            insert into has(library_id, book_id) values (cast(values_arr[1] as integer),cast(values_arr[2] as integer));
			raise notice 'inserion into % is successful',p_table_name;
        when 'issue' then
            insert into issue(emp_id, book_id,issue_date,return_status,issue_status,due_date) values (cast(values_arr[1] as integer),cast(values_arr[2] as integer),
							values_arr[3],
							cast(vlaues_arr[4] as integer),cast(values_arr[5] as integer),values_arr[6]);
							
			raise notice 'inserion into % is successful',p_table_name;
        when 'sales' then
            insert into sales(vendor_id, book_id) values (cast(values_arr[1] as integer),cast(values_arr[2] as integer));
			raise notice 'inserion into % is successful',p_table_name;
        else
            -- error should be handled if invalid table name provided
            raise exception 'invalid table name';
    end case;
		
end;

$$ language plpgsql;


SELECT Insert_data('vendor', '11, appa rao, 12567809');


select * from books;

----------------------publisher info---------------------------------
CREATE OR REPLACE FUNCTION get_publisher_informati(pub_i INT) RETURNS
TABLE(name varchar(50), countr varchar(20),n varchar(50)) AS $$
BEGIN
return query
SELECT p.pub_name, p.country, books.book_name
FROM publisher as p
inner join books on p.pub_id=books.pub_id
WHERE p.pub_id = pub_i;
END;
$$ LANGUAGE plpgsql;

select * from get_publisher_informati(1);

drop function get_publisher_informati(integer);


-------------------------------member info--------------------------

CREATE OR REPLACE FUNCTION get_member_inform(mem_i INT) RETURNS
TABLE(name varchar(50), addres varchar(225), contac_no int, private_lis text [], book_i int)
AS $$
BEGIN
return query
select cast(members.first_name || members.last_name as varchar(50)), cast(members.state_name|| ' ' || members.city as varchar(100)) ,
members.contact_no,members.private_list, issue.book_id from members
inner join send_request on send_request.mem_id=members.mem_id
inner join employee on employee.emp_id=send_request.emp_id
inner join issue on employee.emp_id=issue.emp_id
where members.mem_id=mem_i;
END;
$$ LANGUAGE plpgsql;

select * from get_member_inform(2);

drop function get_member_inform(integer);
	  
select * from members;
	  
-------------------------------------member info-----------------------------

CREATE OR REPLACE FUNCTION get_member_info(mem_i INT) RETURNS
TABLE(name varchar(50), addres varchar(225), contac_no int, private_lis text [], lib_name varchar)
AS $$
BEGIN
return query
select cast(members.first_name || members.last_name as varchar(50)), cast(members.state_name|| ' ' || members.city as varchar(100)) ,
members.contact_no,members.private_list, lib.library_name from lib
inner join members on members.lib_id=lib.library_id
inner join send_request on send_request.mem_id=members.mem_id
inner join employee on employee.emp_id=send_request.emp_id
inner join issue on employee.emp_id=issue.emp_id
where members.mem_id=mem_i;
END;
$$ LANGUAGE plpgsql;

select * from get_member_info(2);

------------------------------------ employee------------------------------

CREATE OR REPLACE FUNCTION get_employee_information(emp_i INT) RETURNS
TABLE(first_name VARCHAR, last_name VARCHAR,contact_no INT,b_name varchar)
AS $$
BEGIN
RETURN QUERY
select e.first_name,e.last_name,e1.contact_no,books.book_name from books
inner join issue on issue.book_id=books.book_id
inner join employee as e on e.emp_id=issue.emp_id
inner join emp_contact_no as e1 on e1.emp_id=e.emp_id
where e.emp_id=emp_i;
END;
$$ LANGUAGE plpgsql;


select * from get_employee_information(1);

------------------------------------vendor---------------------

CREATE OR REPLACE FUNCTION get_vendor_information(v_id INT) RETURNS
TABLE(v_name VARCHAR, contact_no INT,b_name varchar) AS $$
BEGIN
RETURN QUERY
SELECT v.v_name, v.contact_no , books.book_name
FROM vendor v
inner join sales on v.vendor_id=sales.vendor_id
inner join books on sales.book_id=books.book_id
WHERE v.vendor_id = v_id;
END;
$$ LANGUAGE plpgsql;

select * from get_vendor_information(1);

drop function get_vendor_information(integer);


-----------------------------------------------publisher------------------

CREATE OR REPLACE FUNCTION get_publisher_information(p_id INT) RETURNS
TABLE(pub_name VARCHAR, country VARCHAR,b_name varchar) AS $$
BEGIN
RETURN QUERY
SELECT p.pub_name, p.country,books.book_name
FROM publisher p
inner join books on books.pub_id=p.pub_id
WHERE p.pub_id = p_id;
END;
$$ LANGUAGE plpgsql;

drop function get_publisher_information(integer);

select * from get_publisher_information(1);

----------------------------------