-- Задание №5
-- Создайте двух пользователей которые имеют доступ к базе данных shop. Первому
-- пользователю shop_read должны быть доступны только запросы на чтение данных, второму
-- пользователю shop — любые операции в пределах базы данных shop.


-- Создаем пользователя shop_read
drop user if exists 'shop_reader'@'localhost';
create user 'shop_reader'@'localhost' IDENTIFIED with sha256_password by '123';

-- Задаем права. Доступны только запросы на чтение данных из базы shop
grant usage, select on shop.* to 'shop_reader'@'localhost';

-- Выводим список пользователей
select host, user from mysql.user;



-- Создаем пользователя shop - доступны любые операции в пределах базы данных shop
drop user if exists 'shop'@'localhost';
create user 'shop'@'localhost' IDENTIFIED with sha256_password by '123';

-- Задаем права. Доступны любые операции в пределах базы данных shop
grant all on shop.* to 'shop'@'localhost';
grant grant option on shop.* to 'shop'@'localhost';

-- Выводим список пользователей
select host, user from mysql.user;


