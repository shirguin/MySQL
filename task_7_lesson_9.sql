-- Задание №7
-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от
-- текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с
-- 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый
-- вечер", с 00:00 до 6:00 — "Доброй ночи".

-- Создаем базу данных для выполнения задания
drop database if exists task_7;
create database task_7;
use task_7;

-- Создаем процедуру HELLO, используя оператор IF 
drop procedure if exists hello;
delimiter //
create procedure hello()
begin
	if(CURTIME() between '06:00:00' and '12:00:00') then
		SELECT 'Доброе утро';
	elseif(CURTIME() between '12:00:00' and '18:00:00') then
		select 'Добрый день';
	elseif(CURTIME() between '18:00:00' AND '00:00:00') then
		select 'Добрый вечер';
	else
		select  'Доброй ночи';
	end if;
end //
delimiter ;

-- Проверяем
call hello();