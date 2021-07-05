-- Задание №1
-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users,
-- catalogs и products в таблицу logs помещается время и дата создания записи, название
-- таблицы, идентификатор первичного ключа и содержимое поля name.

use shop;

-- создаем таблицу logs типа Archive.
drop table if exists logs;
create table  logs (
	created_at DATETIME not null,
	table_name VARCHAR(50) not null,
	str_id BIGINT(20) not null,
	name_value VARCHAR(50) not null
) ENGINE = ARCHIVE;

-- Решать поставленную задачу будем с помощью триггеров.

-- Создаем триггер для таблицы users
drop trigger if exists	log_users;
delimiter //
create trigger log_users after insert on users
for each row
begin
	insert into logs (created_at, table_name, str_id, name_value)
	values (NOW(), 'users', new.id, new.name);
end //
delimiter ;

-- Создаем триггер для таблицы catalogs
drop trigger if exists log_catalogs;
delimiter //
create trigger log_catalogs after insert on catalogs
for each row
begin
	insert into logs (created_at, table_name, str_id, name_value)
	values (NOW(), 'catalogs', new.id, new.name);
end //
delimiter ;

-- Создаем триггер для таблицы products
drop trigger if exists log_products;
delimiter //
create trigger log_products AFTER INSERT ON products
for each row
begin
	insert into logs (created_at, table_name, str_id, name_value)
	values (NOW(), 'products', new.id, new.name);
end //
delimiter ;

-- Проверяем, создались триггеры или нет.
show triggers;

-- Проверяем работу триггера таблицы users
select * from users;
select * from logs;

insert into users (name, birthday_at) values ('Владимир', '1975-03-05');

select * from users;-- Новый пользователь появился в таблице
select * from logs;-- триггер сработал, в таблице logs появилась соответствующая запись

-Пробуем как будет работать тригер при внесении данных списком
insert into users (name, birthday_at)
values ('Оксана', '1964-01-06'),
		('Денис', '2000-02-03'),
		('Петр', '1996-05-29');

select * from users;
select * from logs; -- все отработало правильно

-- Проверяем работу триггера таблицы catalogs
select * from catalogs;
select * from logs;

insert into catalogs (name)
values ('Куллера'),
		('Аксессуары');

select * from catalogs;
select * from logs; -- все отработало правильно

-- Проверяем работу триггера таблицы products
select * from products;
select * from logs;

insert into products (name, description, price, catalog_id)
values ('Gigabyte H840Р S2H', 'Материнская плата Gigabyte', 14790.00, 2),
		('MSI Х350 GAMING PRO', 'Материнская плата MSI', 5060.00, 2);
	
select * from products;
select * from logs; -- все отработало правильно
