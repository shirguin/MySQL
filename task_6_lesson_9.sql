-- Задание №6
-- (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password,
-- содержащие первичный ключ, имя пользователя и его пароль. Создайте представление
-- username таблицы accounts, предоставляющий доступ к столбца id и name. Создайте
-- пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы
-- извлекать записи из представления username.

-- Создаем базу данных для выполнения задания
drop database if exists task_6;
create database task_6;
use task_6;

-- Создаем таблицу из условия задания
drop table if exists accounts;
create table accounts (
	id SERIAL primary key,
	name VARCHAR(50),
	password VARCHAR(50)
);

-- Заполняем таблицу
insert into accounts values
	(default, 'Иван', '123'),
	(default, 'Сергей', '123'),
	(default, 'Анна', '123'),
	(default, 'Петр', '123');

-- Проверяем
select * from accounts;

-- Создаем представление username
create or replace view username(user_id, user_name) as 
	select id, name
	from accounts;

-- Выводим содержимое созданного представления
select * from username;


-- Создаем пользователя 'shop_reader' 
drop user if exists 'user_read'@'localhost';
create user 'user_read'@'localhost' IDENTIFIED with sha256_password by '123';

-- Задаем права. Доступ только к одной таблице (представлению) username.
-- Права только на просмотр.
grant select on task_6.username to 'user_read'@'localhost';

-- Выводим список пользователей
select host, user from mysql.user;

