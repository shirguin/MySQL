drop database if exists example;
create database if not exists example character set 'utf8mb4';
use example;
/*Создание таблицы*/
create table users (
  id SERIAL primary KEY,
  name VARCHAR(50) COMMENT 'Имя пользователя'
);
/*Заполнение таблицы*/
insert into users values
  (default, 'Алексей'),
  (default, 'Иван'),
  (default, 'Петр'),
  (default, 'Сергей');
/*Удаление строки из таблицы по условию*/
delete from users where  id > 2 limit 1;
/*добавление строки в таблицу*/
insert into users values (default, 'Андрей');
/*Вывод всех данных из таблицы*/
select * from example.users;
