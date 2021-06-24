-- Задание №3
-- по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены
-- разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и
-- 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в
-- соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.

-- Создаем базу данных для выполнения задания
drop database if exists task_3;
create database task_3;
use task_3;

-- Создаем таблицу и вносим данные из задания
drop table if exists data_table;
create table data_table (created_at DATE);
insert into data_table (created_at) 
values ('2018-08-01'), ('2018-08-04'), ('2018-08-16'), ('2018-08-17');

-- Выводим содержимое таблицы
select * from data_table;

-- Сколько не пытался не смог найти решение задачи без применения дополнительной таблицы с длинным insert
-- или применения циклов.
-- В сети нашел только одно решение, которое работает правильно и это просто select.
-- Написано хитро, но очень громозко. Сам бы не догодался.


-- правильное решение
select 
	time_period.selected_date as  day,
	(select exists(select * from data_table where created_at = day)) as flag
from
	(SELECT v.* FROM 
		(SELECT ADDDATE('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) selected_date FROM
			(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t0,
		    (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
		    (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,
		    (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t3,
		    (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t4) v
	WHERE selected_date BETWEEN '2018-08-01' AND '2018-08-31') as time_period
order by day;



