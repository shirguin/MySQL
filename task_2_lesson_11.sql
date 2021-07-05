-- Задание №2
-- (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

use shop;

-- Создадим новую таблицу для этого задания

drop table if exists users_2; 
create table users_2 (
	id SERIAL primary key,
	name VARCHAR(255),
	`created_at` DATETIME default CURRENT_TIMESTAMP,
 	`updated_at` DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

-- Напишем процедуру для заполнения таблицы users_2. В качестве параметра будем передавать
-- количество пользователей, которое нужно создать.
drop procedure if exists insert_users2 ;
delimiter //
create procedure insert_users2(number_users2 bigint)
begin
	declare i bigint default 0;
	while number_users2 > 0 do
		insert into users_2(name) values  (CONCAT('user_', i));
		SET i = i + 1;
		SET number_users2 = number_users2 - 1;
	end while;
end //
delimiter ;


-- Проверяем как работает процедура
select * from users_2;

call insert_users2(100);

call insert_users2(1000000); -- Нужно очень много времени

select * from users_2
order by id desc
limit 10;
