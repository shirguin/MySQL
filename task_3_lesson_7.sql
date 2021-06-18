-- Задание №3
-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label,
-- name). Поля from, to и label содержат английские названия городов, поле name — русское.
-- Выведите список рейсов flights с русскими названиями городов.

-- Создаем базу данных
drop database if exists task3;
create database task3;
use task3;

-- Создаем таблицы из условия задания
drop table if exists flights;
create table flights(
id SERIAL primary key,
`from` VARCHAR(50), 
`to` VARCHAR(50)
);

drop table if exists cities;
create table cities(
label VARCHAR(50) PRIMARY KEY, 
name VARCHAR(50)
);

-- Заполняем таблицы
insert into flights values
  (default, 'moscow', 'omsk'),
  (default, 'novgorod', 'kazan'),
  (default, 'irkutsk', 'moscow'),
  (default, 'omsk', 'irkutsk'),
  (default, 'moscow', 'kazan');
 
insert into cities values
  ('moscow', 'Москва'),
  ('irkutsk', 'Иркутск'),
  ('novgorod', 'Новгород'),
  ('kazan', 'Казань'),
  ('omsk', 'Омск');
 
-- Выводим список рейсов на Английском
select *
from flights;

-- Вариант 1(используем вложенные запросы)
-- Выводим список рейсов на русском
select id ,
	(select name from cities where label = `from`) as `from`,
	(select name from cities where label = `to`) as `to`
from flights
order by id;

-- Для наглядности выводим оба списка рейсов сразу.
select id , `from`, `to`,
	(select name from cities where label = `from`) as `от куда`,
	(select name from cities where label = `to`) as `куда`
from flights
order by id;

-- Вариант 2(используем JOIN)
-- Выводим список рейсов на русском
select id, c.name as `от куда`, c1.name as `куда`
from flights f 
join cities c on f.`from` = c.label
join cities c1 on f.`to` =  c1.label
order by id;

-- Для наглядности выводим оба списка рейсов сразу.
select id, `from`, `to`, c.name as `от куда`, c1.name as `куда`
from flights f 
join cities c on f.`from` = c.label
join cities c1 on f.`to` =  c1.label
order by id;

