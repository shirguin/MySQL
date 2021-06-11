-- ¬ таблице складских запасов storehouses_products в поле value могут встречатьс€ самые
-- разные цифры: 0, если товар закончилс€ и выше нул€, если на складе имеютс€ запасы.
-- Ќеобходимо отсортировать записи таким образом, чтобы они выводились в пор€дке
-- увеличени€ значени€ value. ќднако нулевые запасы должны выводитьс€ в конце, после всех записей.

use shop;

-- ƒл€ примера создадим таблицу tbl и заполним ее

DROP TABLE IF EXISTS tbl;
CREATE TABLE tbl (
  id INT NOT NULL,
  value INT DEFAULT NULL
);
INSERT INTO tbl VALUES (1, 230);
INSERT INTO tbl VALUES (2, 0);
INSERT INTO tbl VALUES (3, 405);
INSERT INTO tbl VALUES (4, 0);
INSERT INTO tbl VALUES (5, 2500);
INSERT INTO tbl VALUES (6, 1);

-- ѕровер€ем изменени€
select * from tbl;

-- —ортируем записи и получаем нужный результат
select value from tbl order by case when value = 0 then 1 else 0 end, value;