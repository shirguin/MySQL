-- � ���� ����� ������� ���������, ������� � ��������

use wallpaper_shop;

								# ��������

-- ������� ������� BEFORE INSERT ��� ������� countries. �������� ������ �� ������ ���� NULL
DROP TRIGGER IF EXISTS mytrigger_null_insert_countries;
delimiter //
CREATE TRIGGER mytrigger_null_insert_countries BEFORE INSERT ON countries
FOR EACH ROW
BEGIN
	if NEW.country_name is NULL THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'WARNING! INSERT NULL IN NAME COUNTRY';
	END IF;
END //
delimiter ;

-- ������� �������� ������� ��� ���.
show triggers;

-- ��������� ������ ��������
INSERT INTO countries (country_name) VALUES ('������');-- �������
INSERT INTO countries (country_name) VALUES (NULL);-- ������� ��������

-- ������� ������� BEFORE UPDATE ��� ������� countries. �������� ������ �� ������ ���� NULL
DROP TRIGGER IF EXISTS mytrigger_null_update_countries;
delimiter //
CREATE TRIGGER mytrigger_null_update_countries BEFORE UPDATE ON countries
FOR EACH ROW
BEGIN
	if NEW.country_name is NULL THEN 
	   SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'WARNING! UPDATE NULL IN NAME COUNTRY';
	END IF;
END //
delimiter ;

-- ������� �������� ������� ��� ���.
show triggers;

-- ��������� ������ ��������
update countries 
set country_name = null 
where id = 5;-- ������� ��������

-- �������� ��� 3 ��������, ������� ����� ��������� ������� logs
-- ��� ����� ������� ������� logs ���� Archive.
drop table if exists logs;
create table  logs (
	created_at DATETIME not null,
	table_name VARCHAR(50) not null,
	str_id BIGINT(20) not null,
	name_value VARCHAR(50) not null
) ENGINE = ARCHIVE;

-- ������� ������� ��� ������� users
drop trigger if exists	log_users;
delimiter //
create trigger log_users after insert on users
for each row
begin
	insert into logs (created_at, table_name, str_id, name_value)
	values (NOW(), 'users', new.id, new.lastname);
end //
delimiter ;

-- ������� ������� ��� ������� catalogs
drop trigger if exists log_catalogs;
delimiter //
create trigger log_catalogs after insert on catalogs
for each row
begin
	insert into logs (created_at, table_name, str_id, name_value)
	values (NOW(), 'catalogs', new.id, new.group_name);
end //
delimiter ;

-- ������� ������� ��� ������� products
drop trigger if exists log_products;
delimiter //
create trigger log_products after insert on products
for each row
begin
	insert into logs (created_at, table_name, str_id, name_value)
	values (NOW(), 'products', new.id, new.product_article);
end //
delimiter ;

-- ���������, ��������� �������� ��� ���.
show triggers;

-- ��������� ������ �������� ������� users
select * from logs;

insert into users (`firstname`, `lastname`, `birthday`, `email`, `phone`, `hometown`, `password_hash`, `created_at`, `updated_at`) VALUES ('�������', '������', '1974-10-28', 'guiseppe48@example.org', '353767759', '������', 'e60054307a525cde0ac27a1300312b72b16bb2fa', '1992-08-16 22:18:50', '1987-05-07 05:00:14');

select * from logs;-- ������� ��������, � ������� logs ��������� ��������������� ������

-- ��������� ������ �������� ������� catalogs
insert into catalogs (group_name)
values ('���������');

select * from catalogs;
select * from logs; -- ��� ���������� ���������

-- ��������� ������ �������� ������� products
insert into products (product_article, manufacturer_id)
values ('888851', 2),
		('888852', 2);
	
select * from logs; -- ��� ���������� ���������

								# ���������

-- ������� ��������� ������ �������� �����. ������� ���������� ����� ���������� ��� ��������� ��� ������
drop procedure if exists top;
delimiter //
create procedure top (in top_number INT)
begin
	select products.product_article as '�������',
		manufacturers.manufacturer_name as '�������������',
		count(user_id) as '���������� �������������'
	from likes
	join products on (product_id = products.id)		
	join manufacturers on (manufacturer_id = manufacturers.id)
	group by products.id
	order by count(user_id) desc
	limit top_number;	
end //
delimiter ;

-- ��������� ������ ���������
call top(10);

-- ������� ��������� ������ ������ �������������, ������� ������� ��������� � ��������� ��������� ���
drop procedure if exists users_age_interval;
delimiter //
create procedure users_age_interval (in start_age int, in finish_age int)
begin
	select users.firstname as '���',
		users.lastname as '�������',
		users.hometown as '�����',
		users.email as 'email',
		(year(current_date()) - year(users.birthday)) as '�������'
	from users
	where (year(current_date()) - year(users.birthday)) >= start_age and
		(year(current_date()) - year(users.birthday)) <= finish_age
	
	order by (year(current_date()) - year(users.birthday));	
end//
delimiter ;

-- ��������� ������ ���������
 
call users_age_interval(30, 35);
call users_age_interval(18, 45);

-- �������� ��������� ���������� �� ���������� ������. ��������� ����� �������� ������ ������, ����������
-- �������� �� ������ ������ ���������� ��������� � ����������� �� �������������.
drop procedure if exists order_supplier;
delimiter //
create procedure order_supplier (in min_balance int)
begin
	select products.product_article as '�������',
		manufacturers.manufacturer_name as '�������������',
		storehause.quantity as '����������'
	from storehause
	join products on (product_id = products.id)
	join manufacturers on (manufacturer_id = manufacturers.id)
	where storehause.quantity < min_balance
	order by manufacturers.manufacturer_name;
end//
delimiter ;

-- ��������� ������ ���������
call order_supplier(6);
call order_supplier(20);

-- ���������� ��������� order_supplier. �������� ��������� ������� ����� �������� ��� ���������,
-- ����������� �������, ���������� ������ ��� ������(��� ������� ��� 6 ��� 12 �������) � id �������������. 
-- � ���� ������ ����� ����� ������������� ������ �� �������. ����������� ����� �� �������� ���, ��� ������� ����� ����.
drop procedure if exists order_manufacturer;
delimiter //
create procedure order_manufacturer (in min_balance int, in order_number int, manufactur_id bigint)
begin
	select products.product_article as '�������',
		manufacturers.manufacturer_name as '�������������',
		storehause.quantity as '����������',
		order_number as '�����, ��'
	from storehause
	join products on (product_id = products.id)
	join manufacturers on (manufacturer_id = manufacturers.id)
	where storehause.quantity < min_balance and 
		manufacturers.id = manufactur_id
	order by products.product_article;
end//
delimiter ;

-- ��������� ������ ���������
call order_manufacturer(4, 12, 11);
call order_manufacturer(6, 12, 1);

								# �������

-- ������� ������� ���������� �������� ������������. ���������� � ������� ����� id ������������,
-- � ���������� ������� ����� ������� ������������.

drop function if exists user_age;
delimiter //
create function user_age (user_id bigint)
returns int
deterministic
begin
	declare age int;
	set age := (select (year(current_date()) - year(users.birthday)) 
		from users
		where id = user_id);
	return age;
end //
delimiter ;

-- ��������� ������ �������
select user_age (302);
select user_age (330);

-- ������� ������� ������� ������������ ����������� �������� �����. ��� ������� �������,
-- ���������� ����� ������� ������ �������, ��� ���� ���� � ���� �����(������� ���� - 3�, ����� - 1,6 �).
-- � ������� ����� ���������� �������� ������� � ������ �������. ���������� ������� ����� ����������� ��������.

-- ������ ������� ����� ������� ���� ������� 0,53 �
drop function if exists number_rolls_1;
delimiter //
create function number_rolls_1 (perimeter float, height float)
returns int
deterministic
begin
	declare number_rolls int;
	set number_rolls = round (((perimeter * height)-(3 + 1.6)) / 5);
	return number_rolls;
end //
delimiter ;

-- ������ ������� ����� ������� ���� ������� 1,06 �
drop function if exists number_rolls_2;
delimiter //
create function number_rolls_2 (perimeter float, height float)
returns int
deterministic
begin
	declare number_rolls int;
	set number_rolls = round (((perimeter * height)-(3 + 1.6)) / 10);
	return number_rolls;
end //
delimiter ;

select number_rolls_1 (18.6, 2.7); -- 9 ������� 0,53
select number_rolls_2 (18.6, 2.7); -- 5 ������� 1,06
