-- Задание №3
-- В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.

HSET ip_address 127.0.0.1 1

-- Задание №4
-- При помощи базы данных Redis решите задачу поиска имени пользователя по электронному
-- адресу и наоборот, поиск электронного адреса пользователя по его имени.

SET Alex alex@mail.ru
SET alex@mail Alex
GET Alex
GET alex@mail.ru

-- Задание №5
-- Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

db.shop.insert({category: 'Материнские платы'})
db.shop.insert({category: 'Процессоры'})

db.shop.update({category: 'Материнские платы'}, {$set: { products:['Gigabyte H310M S2H', 'ASUS ROG MAXIMUS X HERO', 'MSI B250M GAMING PRO'] }})
db.shop.update({category: 'Процессоры'}, {$set: { products:['Intel Core i3-8100', 'AMD FX-8320E', 'Intel Core i5-7400'] }})
