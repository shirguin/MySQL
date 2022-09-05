-- � ���� ����� ������� ����������� �������.

use wallpaper_shop;

-- 1. ������� ��� ������������ ���� �������� ����� � ������ ������ � ����������� �� ����

select products.product_article as '�������',
		wallpaper_collections.wallpaper_collection_name as '���������',
		wallpaper_brands.wallpaper_brand_name as '�����',
		manufacturers.manufacturer_name as '�������������',
		types_wallpaper.type_wallpaper as '���',
		colors_wallpaper.color_wallpaper as '����',
		appearances_wallpaper.appearance_wallpaper  as '���',
		products.price as '����'		
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

-- 2. ��������� ������� ��������� ����� ������� ����� ��������� � ���� ������ � ����������� �� �������� �����.

select count(products.id) as '����������',
		colors_wallpaper.color_wallpaper as '���� �����'
from products
join colors_wallpaper on(color_wallpaper_id = colors_wallpaper.id)
where catalog_id =1
group by colors_wallpaper.color_wallpaper
order by colors_wallpaper.color_wallpaper;

-- 3. �������� ����� ������� ������� ���� � ������� �������. ���� ������ ���� ��������� � ���������, � ����� ������������ ����������� ������.
 
select products.product_article as '�������',
		wallpaper_collections.wallpaper_collection_name as '���������',
		wallpaper_brands.wallpaper_brand_name as '�����',
		manufacturers.manufacturer_name as '�������������',
		countries.country_name as '������ ������������',
		types_wallpaper.type_wallpaper as '���',
		colors_wallpaper.color_wallpaper as '����',
		appearances_wallpaper.appearance_wallpaper  as '���',
		products.price as '����'		
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

-- 4. ������� 3 ������ � ������� ������ ����� ������������� �������� ���� ������ VICTORIA STENOVA.
-- ����������� �� ��������

select count(user_id) as '���������� �������������',
		users.hometown as '�����'
from likes
join users on (users.id = likes.user_id)		
where product_id in (select products.id from products where products.wallpaper_brand_id = 1)
group by users.hometown
order by count(user_id) desc
limit 3;

-- 5. ������� ������� �� ������ (����� �����, �������, �� ����� ���� � �� ����� ����� ��������� �� ������)

select products.product_article as '�������',
		storehause.quantity as '����������',
		storehause.price as '����',
		(storehause.quantity * storehause.price) as '�����'
from storehause
join products on (storehause.product_id = products.id);

-- 6. ��������� ����� ����� ������� ������ �� ������

select sum(quantity * price) as '����� ������� ������ �� ������'
from storehause;

-- 7. ������� ��� ������� ������������ � id = 301 � ����������� �� ���� �������

select products.product_article as '�������',
		manufacturers.manufacturer_name as '�������������',
		basket.quantity as '����������',
		basket.price  as '����',
		(basket.quantity * basket.price) as '�����',
		basket.created_at as '���� �������'
from basket
join storehause on (storehause_id = storehause.id)
join products on (storehause.product_id = products.id )
join manufacturers on (manufacturer_id = manufacturers.id)
where basket.id in (select basket_id from orders where user_id = 301)
order by basket.created_at ;

-- 8. ������� ��� ���������� �� ������� ������������ 
-- (���� � ���� ������ ������ �����, ���� ����� ���� ������������, ��������� ��� ��������)

select products.product_article as '�������',
		manufacturers.manufacturer_name as '�������������',
		types_wallpaper.type_wallpaper as '���',
		colors_wallpaper.color_wallpaper as '����',
		appearances_wallpaper.appearance_wallpaper  as '���',
		photos.filename as '�������� �����'
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

-- 8. ������� ������������ ������ �� ���� ��������� �����
-- ������������ ���� ���� ����������� ������� Emiliana Parati, � ������ ���� �� ������� ���� ������� Decory@Decory.
-- �� �����, ��� ���� ��������� sicilia. ���� �� ����� ������ ������������ �� ���������� ��� ������� � ����������� �����.
-- ���� �� �������� ����� �������, ������ ��� ������� ��� ��� ��������� �������� ���� �������.

select products.product_article as '�������',
		wallpaper_collections.wallpaper_collection_name as '���������',
		wallpaper_brands.wallpaper_brand_name as '�����',
		manufacturers.manufacturer_name as '�������������',
		countries.country_name as '������',
		types_wallpaper.type_wallpaper as '���',
		colors_wallpaper.color_wallpaper as '����',
		appearances_wallpaper.appearance_wallpaper  as '���',
		styles_wallpaper.style_wallpaper as '�����',
		disigns_wallpaper.disign_wallpaper as '������',
		products.price as '����'		
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

-- 9. ��������� ������� ������� ����� �������������, ������������������ � ������ ����

select year(users.created_at) as '���',
		round(avg (year(users.created_at) - year (users.birthday))) as '������� �������'
from users
group by year(users.created_at)
order by year(users.created_at);
-- ���������� ����� ��� ��� ������� ������� �� ������ '-' ��� ��-�� ������ ���������� ��������������� ���� ������
-- � ������ ������������� ���� ����������� ������ ���� ��������.

-- 10. ������� 10 ��� � ������� ������ ����� ������������������ ������������� �� ����� �����

select year(users.created_at) as '���',
		count(*) as '���������� �������������'
from users 
group by year(users.created_at)
order by count(*) desc
limit 10;

