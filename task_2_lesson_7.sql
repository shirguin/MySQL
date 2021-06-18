-- Задание №2
-- Выведите список товаров products и разделов catalogs, который соответствует товару.

use shop;

select products.name, catalogs.name as title
from products
join catalogs on (products.catalog_id = catalogs.id)
order by title;