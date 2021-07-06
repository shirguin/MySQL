-- В этом файле примеры триггеров, функций и процедур

use wallpaper_shop;

								# Триггеры

-- Создаем триггер BEFORE INSERT для таблицы countries. Название страны не должно быть NULL
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

-- Смотрим создался триггер или нет.
show triggers;

-- Проверяем работу триггера
INSERT INTO countries (country_name) VALUES ('Канада');-- успешно
INSERT INTO countries (country_name) VALUES (NULL);-- Триггер сработал

-- Создаем триггер BEFORE UPDATE для таблицы countries. Название страны не должно быть NULL
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

-- Смотрим создался триггер или нет.
show triggers;

-- Проверяем работу триггера
update countries 
set country_name = null 
where id = 5;-- триггер сработал

-- Создадим еще 3 триггера, которые будут заполнять таблицу logs
-- Для этого создаем таблицу logs типа Archive.
drop table if exists logs;
create table  logs (
	created_at DATETIME not null,
	table_name VARCHAR(50) not null,
	str_id BIGINT(20) not null,
	name_value VARCHAR(50) not null
) ENGINE = ARCHIVE;

-- Создаем триггер для таблицы users
drop trigger if exists	log_users;
delimiter //
create trigger log_users after insert on users
for each row
begin
	insert into logs (created_at, table_name, str_id, name_value)
	values (NOW(), 'users', new.id, new.lastname);
end //
delimiter ;

-- Создаем триггер для таблицы catalogs
drop trigger if exists log_catalogs;
delimiter //
create trigger log_catalogs after insert on catalogs
for each row
begin
	insert into logs (created_at, table_name, str_id, name_value)
	values (NOW(), 'catalogs', new.id, new.group_name);
end //
delimiter ;

-- Создаем триггер для таблицы products
drop trigger if exists log_products;
delimiter //
create trigger log_products after insert on products
for each row
begin
	insert into logs (created_at, table_name, str_id, name_value)
	values (NOW(), 'products', new.id, new.product_article);
end //
delimiter ;

-- Проверяем, создались триггеры или нет.
show triggers;

-- Проверяем работу триггера таблицы users
select * from logs;

insert into users (`firstname`, `lastname`, `birthday`, `email`, `phone`, `hometown`, `password_hash`, `created_at`, `updated_at`) VALUES ('Алексей', 'Иванов', '1974-10-28', 'guiseppe48@example.org', '353767759', 'Москва', 'e60054307a525cde0ac27a1300312b72b16bb2fa', '1992-08-16 22:18:50', '1987-05-07 05:00:14');

select * from logs;-- триггер сработал, в таблице logs появилась соответствующая запись

-- Проверяем работу триггера таблицы catalogs
insert into catalogs (group_name)
values ('Мелочевка');

select * from catalogs;
select * from logs; -- все отработало правильно

-- Проверяем работу триггера таблицы products
insert into products (product_article, manufacturer_id)
values ('888851', 2),
		('888852', 2);
	
select * from logs; -- все отработало правильно

								# Процедуры

-- Создаем процедуру вывода рейтинга обоев. Входным параметром будет количество ТОР артикулов для вывода
drop procedure if exists top;
delimiter //
create procedure top (in top_number INT)
begin
	select products.product_article as 'Артикул',
		manufacturers.manufacturer_name as 'Производитель',
		count(user_id) as 'Количество пользователей'
	from likes
	join products on (product_id = products.id)		
	join manufacturers on (manufacturer_id = manufacturers.id)
	group by products.id
	order by count(user_id) desc
	limit top_number;	
end //
delimiter ;

-- Проверяем работу процедуры
call top(10);

-- Создаем процедуру вывода данных пользователей, возраст которых находится в указанном диапазоне лет
drop procedure if exists users_age_interval;
delimiter //
create procedure users_age_interval (in start_age int, in finish_age int)
begin
	select users.firstname as 'Имя',
		users.lastname as 'Фамилия',
		users.hometown as 'Город',
		users.email as 'email',
		(year(current_date()) - year(users.birthday)) as 'Возраст'
	from users
	where (year(current_date()) - year(users.birthday)) >= start_age and
		(year(current_date()) - year(users.birthday)) <= finish_age
	
	order by (year(current_date()) - year(users.birthday));	
end//
delimiter ;

-- Проверяем работу процедуры
 
call users_age_interval(30, 35);
call users_age_interval(18, 45);

-- Создадим процедуру автозаказа на пополнение склада. Процедура будет выводить список товара, количество
-- которого на складе меньше указанного параметра и сортировать по производителю.
drop procedure if exists order_supplier;
delimiter //
create procedure order_supplier (in min_balance int)
begin
	select products.product_article as 'Артикул',
		manufacturers.manufacturer_name as 'Производитель',
		storehause.quantity as 'Количество'
	from storehause
	join products on (product_id = products.id)
	join manufacturers on (manufacturer_id = manufacturers.id)
	where storehause.quantity < min_balance
	order by manufacturers.manufacturer_name;
end//
delimiter ;

-- Проверяем работу процедуры
call order_supplier(6);
call order_supplier(20);

-- Доработаем процедуру order_supplier. Создадим процедуру которая будет получать три параметра,
-- минимальный остаток, количество товара для заказа(как правило это 6 или 12 рулонов) и id производителя. 
-- В этом случае будет сразу формироваться заявка на фабрику. Сортировать будем по артикулу так, как фабрика будет одна.
drop procedure if exists order_manufacturer;
delimiter //
create procedure order_manufacturer (in min_balance int, in order_number int, manufactur_id bigint)
begin
	select products.product_article as 'Артикул',
		manufacturers.manufacturer_name as 'Производитель',
		storehause.quantity as 'Количество',
		order_number as 'Заказ, шт'
	from storehause
	join products on (product_id = products.id)
	join manufacturers on (manufacturer_id = manufacturers.id)
	where storehause.quantity < min_balance and 
		manufacturers.id = manufactur_id
	order by products.product_article;
end//
delimiter ;

-- Проверяем работу процедуры
call order_manufacturer(4, 12, 11);
call order_manufacturer(6, 12, 1);

								# ФУНКЦИИ

-- Создаем функцию вычисления возраста пользователя. Передавать в функцию будем id пользователя,
-- а возвращать функция будет возраст пользователя.

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

-- Проверяем работу функции
select user_age (302);
select user_age (330);

-- Создаем функцию расчета необходимого колличества руллонов обоев. Для примера функции,
-- рассмотрим самый простой пример комнаты, где одно окно и одна дверь(площадь окна - 3м, двери - 1,6 м).
-- В функцию будем передавать периметр комнаты и высоту потолка. Возвращать функция будет колличество руллонов.

-- Первая функция будет считать обои шириной 0,53 м
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

-- Вторая функция будет считать обои шириной 1,06 м
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

select number_rolls_1 (18.6, 2.7); -- 9 рулонов 0,53
select number_rolls_2 (18.6, 2.7); -- 5 рулонов 1,06
