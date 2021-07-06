-- В этом файле примеры представлений.

use wallpaper_shop;

-- VIEW Описание артикула (Артикул/Производитель/Бренд/Коллекция)

create or replace view list_wallpaper_properties as 
	select products.product_article as 'Артикул',
		manufacturers.manufacturer_name as 'Производитель',
		wallpaper_brands.wallpaper_brand_name as 'Бренд',
		wallpaper_collections.wallpaper_collection_name as 'Коллекция'		
	from products
	join manufacturers on (manufacturer_id = manufacturers.id)
	join wallpaper_brands on (wallpaper_brand_id = wallpaper_brands.id)
	join wallpaper_collections on (wallpaper_collection_id = wallpaper_collections.id)
	order by manufacturers.manufacturer_name;

-- Проверяем

select *
from list_wallpaper_properties;

-- VIEW Данные по скидкам пользователей

create or replace view users_data as 
	select users.firstname  as 'Имя',
		users.lastname as 'Фамилия',
		users.hometown as 'Город',
		discounts.discount as 'Скидка клиента'
	from users
	join discounts on (users.id = discounts.user_id)
	order by users.lastname;

-- Проверяем

select *
from users_data;
		
-- VIEW Данные по остаткам склада

create or replace view balans_storehause as 
	select products.product_article as 'Артикул',
		manufacturers.manufacturer_name as 'Производитель',
		storehause.quantity as 'Количество',
		storehause.price as 'Цена',
		(storehause.quantity * storehause.price) as 'Сумма'
from storehause
join products on (storehause.product_id = products.id)
join manufacturers on (manufacturer_id = manufacturers.id)
order by products.product_article;

-- Проверяем

select *
from balans_storehause;

