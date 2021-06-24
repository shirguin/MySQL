-- Задание №8
-- В таблице products есть два текстовых поля: name с названием товара и description с его
-- описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля
-- принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь
-- того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям
-- NULL-значение необходимо отменить операцию.

use shop;

-- Создаем триггер BEFORE INSERT для таблицы products
DROP TRIGGER IF EXISTS mytrigger_null_insert;
delimiter //
CREATE TRIGGER mytrigger_null_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	if NEW.name is NULL and NEW.description is NULL THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'WARNING! NULL IN TWO FIELDS';
	END IF;
END //
delimiter ;

-- Создаем триггер BEFORE UPDATE для таблицы products
DROP TRIGGER IF EXISTS mytrigger_null_update;
delimiter //
CREATE TRIGGER mytrigger_null_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	if NEW.name is NULL AND NEW.description is null or 
	   NEW.name is NULL AND OLD.description is null or 
	   OLD.name is NULL AND NEW.description is null THEN 
	   SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'WARNING! UPDATE NULL IN TWO FIELDS';
	END IF;
END //
delimiter ;

-- Смотрим создались триггеры или нет.
show triggers;

-- Проверяем работу триггеров
INSERT INTO products (name, description, price, catalog_id)
VALUES (NULL, NULL, 7000, 2); -- Триггер сработал

INSERT INTO products (name, description, price, catalog_id)
VALUES ("GeForce GTX 1080", NULL , 15000, 12); -- работает все правильно
INSERT INTO products (name, description, price, catalog_id)
VALUES ("NULL", "Видео карта", 85000, 12);-- работает все правильно

select * from products;

update products
set description = null 
where price = 85000; -- Триггер работает





