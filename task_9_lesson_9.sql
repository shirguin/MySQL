-- Задание №9
-- (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух
-- предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.

DROP database if EXISTS task_9;
create database task_9;
use task_9;

-- Пишем функцию FIBONACCI
drop function if exists FIBONACCI;
delimiter //
create function FIBONACCI (numb int)
returns int
deterministic
begin
	declare counter, resul int;
	set counter = numb;
	set resul = 0;
	while counter > 0 do
		set resul = resul + counter;
		set counter = counter - 1;
	end while;
	return resul;
end //

delimiter ;

SHOW CREATE function FIBONACCI;

select FIBONACCI(5);
select FIBONACCI(10);
select FIBONACCI(15);