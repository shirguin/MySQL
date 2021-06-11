-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

use shop;

-- Смотрим что находится в столбцах created_at и updated_at
select * from users;

-- Запоняем оба столбца для всех строк текущей датой
update users set users.created_at = now();
update users set users.updated_at = now();

-- Проверяем изменения
select * from users;