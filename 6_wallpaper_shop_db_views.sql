-- � ���� ����� ������� �������������.

use wallpaper_shop;

-- VIEW �������� �������� (�������/�������������/�����/���������)

create or replace view list_wallpaper_properties as 
	select products.product_article as '�������',
		manufacturers.manufacturer_name as '�������������',
		wallpaper_brands.wallpaper_brand_name as '�����',
		wallpaper_collections.wallpaper_collection_name as '���������'		
	from products
	join manufacturers on (manufacturer_id = manufacturers.id)
	join wallpaper_brands on (wallpaper_brand_id = wallpaper_brands.id)
	join wallpaper_collections on (wallpaper_collection_id = wallpaper_collections.id)
	order by manufacturers.manufacturer_name;

-- ���������

select *
from list_wallpaper_properties;

-- VIEW ������ �� ������� �������������

create or replace view users_data as 
	select users.firstname  as '���',
		users.lastname as '�������',
		users.hometown as '�����',
		discounts.discount as '������ �������'
	from users
	join discounts on (users.id = discounts.user_id)
	order by users.lastname;

-- ���������

select *
from users_data;
		
-- VIEW ������ �� �������� ������

create or replace view balans_storehause as 
	select products.product_article as '�������',
		manufacturers.manufacturer_name as '�������������',
		storehause.quantity as '����������',
		storehause.price as '����',
		(storehause.quantity * storehause.price) as '�����'
from storehause
join products on (storehause.product_id = products.id)
join manufacturers on (manufacturer_id = manufacturers.id)
order by products.product_article;

-- ���������

select *
from balans_storehause;

