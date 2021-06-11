-- 4.(по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе
-- и мае. Месяцы заданы в виде списка английских названий (may, august)

use shop;

-- посмотрим на весь список пользователей
select * from users;

-- Выведем список пользователей согласно заданного условия
-- Вариант 1
select name, birthday_at from users where DATE_FORMAT(birthday_at, '%M') = 'may' or DATE_FORMAT(birthday_at, '%M') = 'august';

-- Вариант 2
select name, birthday_at from users where DATE_FORMAT(birthday_at, '%M') in ('may', 'august');

