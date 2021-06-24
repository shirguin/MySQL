-- Задание №1
-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте
-- транзакции.

-- Создаем базу данных sample и таблицу users, аналогичную таблице в базе shop
DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;
USE sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- Переносим запись с id=1 из таблицы shop.users в таблицу sample.users.
start  transaction;
insert into sample.users (select * from shop.users where shop.users.id = 1);
commit;

-- Проверяем перенос
select * from sample.users;

-- Переносим записи с id = 4,5 из таблицы shop.users в таблицу sample.users.
start  transaction;
insert into sample.users (select * from shop.users where shop.users.id > 3 and shop.users.id < 6);
commit;

-- Проверяем перенос
select * from sample.users;
