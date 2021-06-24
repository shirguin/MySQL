-- Задание №2
-- Создайте представление, которое выводит название name товарной позиции из таблицы
-- products и соответствующее название каталога name из таблицы catalogs.

use shop;

-- Создаем представление по заданным параметрам
create or replace view prod as
	select products.name AS p_name, catalogs.name AS c_name
	from products
	join catalogs on products.catalog_id = catalogs.id
	order by catalogs.id;

-- Проверяем список таблиц
show tables;

-- Выводим содержимое представления prod
select * from prod;
