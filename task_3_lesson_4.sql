-- Повторить все действия CRUD.
-- создание базы и таблиц, а также заполнение таблиц данными делал в 1 и 2 задании 

-- Создадим несколько запросов
use vk;
-- отберем всех пользователей мужчин
select users.firstname, users.lastname from users where id in (select user_id from profiles where gender = 'm');

-- отберем всех пользователей у которых почта ...@example.org
select * from users where email like '%@example.org';

-- отберем Имя, Фамилию и адрес эл.почты пользователей, родившихся в 2003 году
select users.firstname, users.lastname, users.email from users where id in (select user_id from profiles where birthday between '2003-01-01' and '2003-12-31');

-- Проверим, есть или нет пользователь с id равным 1000
select * from users where id = 1000;

-- Внесем в таблицу нового пользователя с id=1000
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('1000', 'Мария', 'Иванова', 'mariy@yandex.ru', '28рр9dc1b248aррb66388cfc3bc2c6f968f28b0d', '7777777777');

-- Сделаем запрос на пользователя с id=1000
select * from users where id = 1000;

-- Изменим Фамилию пользователя с id=1000
update users set users.lastname = 'Петрова' where id = 1000;

-- Проверяем изменения
select * from users where id = 1000;

-- Удаляем пользователя с id = 1000
delete from users where id = 1000;

-- Проверяем изменения
select * from users where id = 1000;

