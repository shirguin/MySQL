-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы
-- типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10.
-- Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.

use shop;

-- Меняем тип данных на varchar, что бы было как в задании
alter table users modify created_at varchar(20);
alter table users modify updated_at varchar(20);

-- Смотрим что находится в столбцах created_at и updated_at
select * from users;

-- Создаем дополнительные столбцы с типом DATETIME
alter table users
  add (created_at_dt DATETIME,
       updated_at_dt DATETIME);
      
-- Проверяем изменения
select * from users;

-- Заполняем данные в новые столбцы в нужном формате
update users set created_at_dt=STR_TO_DATE(created_at, '%Y-%m-%d %H:%i:%s');
update users set updated_at_dt=STR_TO_DATE(updated_at, '%Y-%m-%d %H:%i:%s');

-- Проверяем изменения
select * from users;

-- Удаляем столбцы, где дата и время были в формате varchar, а новые переименовываем
alter table users
  drop column created_at,
  drop column updated_at,
  rename column created_at_dt to created_at,
  rename column updated_at_dt to updated_at;
  
-- Проверяем изменения
select * from users;
