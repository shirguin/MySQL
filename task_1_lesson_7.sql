-- Задание №1
-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

use shop;

-- Заполним таблицу orders
insert into orders values
  (default, 1, default, default),
  (default, 1, default, default),
  (default, 2, default, default);

-- Выводим список пользователей, которые сделали хотя бы 1 заказ
select name
from users
join orders on (orders.user_id = users.id)
group by users.name
having COUNT(orders.id) > 0