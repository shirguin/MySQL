-- В этом файле примеры характерных выборок.

use wallpaper_shop;

-- 1. Выведем все флизелиновые обои зеленого цвета с узором дамаск и отсортируем по цене

select products.product_article as 'Артикул',
		wallpaper_collections.wallpaper_collection_name as 'Коллекция',
		wallpaper_brands.wallpaper_brand_name as 'Бренд',
		manufacturers.manufacturer_name as 'Производитель',
		types_wallpaper.type_wallpaper as 'Тип',
		colors_wallpaper.color_wallpaper as 'Цвет',
		appearances_wallpaper.appearance_wallpaper  as 'Вид',
		products.price as 'Цена'		
from products
join wallpaper_collections on (wallpaper_collection_id = wallpaper_collections.id)
join wallpaper_brands on (wallpaper_brand_id = wallpaper_brands.id)
join manufacturers on (manufacturer_id = manufacturers.id)
join types_wallpaper on (type_wallpaper_id = types_wallpaper.id)
join colors_wallpaper on (color_wallpaper_id = colors_wallpaper.id)
join appearances_wallpaper on (appearance_wallpaper_id = appearances_wallpaper.id)
where catalog_id = 1 and
		type_wallpaper_id = 2 and
		color_wallpaper_id = 5 and 
		appearance_wallpaper_id = 10
order by price;

-- 2. Посчитаем сколько артикулов обоев каждого цвета находится в базе данных и отсортируем по названию цвета.

select count(products.id) as 'Количество',
		colors_wallpaper.color_wallpaper as 'Цвет обоев'
from products
join colors_wallpaper on(color_wallpaper_id = colors_wallpaper.id)
where catalog_id =1
group by colors_wallpaper.color_wallpaper
order by colors_wallpaper.color_wallpaper;

-- 3. Подберем самые дорогие розовые обои в детскую комнату. Обои должны быть виниловые с вензилями, а также производства итальянских фабрик.
 
select products.product_article as 'Артикул',
		wallpaper_collections.wallpaper_collection_name as 'Коллекция',
		wallpaper_brands.wallpaper_brand_name as 'Бренд',
		manufacturers.manufacturer_name as 'Производитель',
		countries.country_name as 'Страна производства',
		types_wallpaper.type_wallpaper as 'Тип',
		colors_wallpaper.color_wallpaper as 'Цвет',
		appearances_wallpaper.appearance_wallpaper  as 'Вид',
		products.price as 'Цена'		
from products
join wallpaper_collections on (wallpaper_collection_id = wallpaper_collections.id)
join wallpaper_brands on (wallpaper_brand_id = wallpaper_brands.id)
join manufacturers on (manufacturer_id = manufacturers.id)
join countries on (country_id = countries.id)
join types_wallpaper on (type_wallpaper_id = types_wallpaper.id)
join colors_wallpaper on (color_wallpaper_id = colors_wallpaper.id)
join appearances_wallpaper on (appearance_wallpaper_id = appearances_wallpaper.id)
where catalog_id = 1 and
		type_wallpaper_id = 3 and
		color_wallpaper_id = 9 and 
		appearance_wallpaper_id = 11 and
		disign_wallpaper_id = 3
order by price desc;

-- 4. Выведем 3 города в которых больше всего пользователям нравятся обои бренда VICTORIA STENOVA.
-- Отсортируем по убыванию

select count(user_id) as 'Количество пользователей',
		users.hometown as 'Город'
from likes
join users on (users.id = likes.user_id)		
where product_id in (select products.id from products where products.wallpaper_brand_id = 1)
group by users.hometown
order by count(user_id) desc
limit 3;

-- 5. Выведем остатки по складу (Каких обоев, сколько, по какой цене и на какую сумму находится на складе)

select products.product_article as 'Артикул',
		storehause.quantity as 'Количество',
		storehause.price as 'Цена',
		(storehause.quantity * storehause.price) as 'Сумма'
from storehause
join products on (storehause.product_id = products.id);

-- 6. Посчитаем общую сумму остатка товара на складе

select sum(quantity * price) as 'Сумма остатка товара на складе'
from storehause;

-- 7. Выведем все покупки пользователя с id = 301 и отсортируем по дате покупки

select products.product_article as 'Артикул',
		manufacturers.manufacturer_name as 'Производитель',
		basket.quantity as 'Количество',
		basket.price  as 'Цена',
		(basket.quantity * basket.price) as 'Сумма',
		basket.created_at as 'Дата покупки'
from basket
join storehause on (storehause_id = storehause.id)
join products on (storehause.product_id = products.id )
join manufacturers on (manufacturer_id = manufacturers.id)
where basket.id in (select basket_id from orders where user_id = 301)
order by basket.created_at ;

-- 8. Выведем все фотографии по запросу пользователя 
-- (обои в виде фресок серого цвета, обои могут быть флизелиновые, виниловые или бумажные)

select products.product_article as 'Артикул',
		manufacturers.manufacturer_name as 'Производитель',
		types_wallpaper.type_wallpaper as 'Тип',
		colors_wallpaper.color_wallpaper as 'Цвет',
		appearances_wallpaper.appearance_wallpaper  as 'Вид',
		photos.filename as 'Название файла'
from products
join manufacturers on (manufacturer_id = manufacturers.id)
join types_wallpaper on (type_wallpaper_id = types_wallpaper.id)
join colors_wallpaper on (color_wallpaper_id = colors_wallpaper.id)
join appearances_wallpaper on (appearance_wallpaper_id = appearances_wallpaper.id)
join photos on (photo_id = photos.id)
where type_wallpaper_id in (1, 2, 3) and
		color_wallpaper_id = 10 and 
		appearance_wallpaper_id = 12	
order by types_wallpaper.type_wallpaper;

-- 8. Сделаем максимальный запрос по всем свойствам обоев
-- Пользователь ищет обои итальянской фабрики Emiliana Parati, а именно один из брендов этой фабрики Decory@Decory.
-- Он знает, что есть коллекция sicilia. Обои он хочет только флизелиновые со структурой или узорами в итальянском стиле.
-- Цвет он выбирает между бежевым, желтым или розовым так как планирует обновить свою спальню.

select products.product_article as 'Артикул',
		wallpaper_collections.wallpaper_collection_name as 'Коллекция',
		wallpaper_brands.wallpaper_brand_name as 'Бренд',
		manufacturers.manufacturer_name as 'Производитель',
		countries.country_name as 'Страна',
		types_wallpaper.type_wallpaper as 'Тип',
		colors_wallpaper.color_wallpaper as 'Цвет',
		appearances_wallpaper.appearance_wallpaper  as 'Вид',
		styles_wallpaper.style_wallpaper as 'Стиль',
		disigns_wallpaper.disign_wallpaper as 'Дизайн',
		products.price as 'Цена'		
from products
join wallpaper_collections on (wallpaper_collection_id = wallpaper_collections.id)
join wallpaper_brands on (wallpaper_brand_id = wallpaper_brands.id)
join manufacturers on (manufacturer_id = manufacturers.id)
join countries on (country_id = countries.id)
join types_wallpaper on (type_wallpaper_id = types_wallpaper.id)
join colors_wallpaper on (color_wallpaper_id = colors_wallpaper.id)
join appearances_wallpaper on (appearance_wallpaper_id = appearances_wallpaper.id)
join styles_wallpaper on (style_wallpaper_id = styles_wallpaper.id)
join disigns_wallpaper on (disign_wallpaper_id = disigns_wallpaper.id)

where wallpaper_collection_id = 2 and 
		wallpaper_brand_id = 3 and
		manufacturer_id = 9 and 
		type_wallpaper_id = 2 and
		color_wallpaper_id in (1, 4, 9) and 
		appearance_wallpaper_id in (3, 9) and
		style_wallpaper_id = 11 and
		disign_wallpaper_id = 1
order by price;

-- 9. Посмотрим средний возраст наших пользователей, зарегистрированных в разные года

select year(users.created_at) as 'Год',
		round(avg (year(users.created_at) - year (users.birthday))) as 'Средний возраст'
from users
group by year(users.created_at)
order by year(users.created_at);
-- Получилось много лет где средний возраст со знаком '-' Это из-за данных полученных автозаполнением базы данных
-- У многих пользователей дата регистрации меньше даты рождения.

-- 10. Выведем 10 лет в которые больше всего зарегистрировалось пользователей на нашем сайте

select year(users.created_at) as 'Год',
		count(*) as 'Количество пользователей'
from users 
group by year(users.created_at)
order by count(*) desc
limit 10;

