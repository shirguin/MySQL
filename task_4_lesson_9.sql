-- Задание №4
-- (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте
-- запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих
-- записей.

-- Создаем базу данных для этого задания
drop database if exists task_4;
create database task_4;
use task_4;

-- Создаем таблицу и вносим данные
drop table if exists data_table;
create table data_table (created_at DATE);
insert into data_table (created_at) 
values ('2018-08-01'), ('2018-08-04'), ('2018-08-09'), ('2018-08-11'),
	   ('2018-08-12'), ('2018-08-15'), ('2018-08-16'), ('2018-08-17'),
	   ('2018-08-19'), ('2018-08-22'), ('2018-08-26'), ('2018-08-31');

-- Выводим содержимое таблицы
select * from data_table;

-- Удаляем все записи кроме 5 самых свежих
delete from data_table
where created_at not in(
	select *
	from (
		select * from data_table
		order by created_at desc
		limit 5) as resume
	);
	
-- Выводим содержимое таблицы
select * from data_table
order by created_at desc;