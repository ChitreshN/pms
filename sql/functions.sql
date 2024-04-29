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
