-- �������� ���� ������ �������� ��������, ������������������� �� ������� �����
drop database if exists wallpaper_shop;
create database wallpaper_shop character set 'utf8mb4';
use wallpaper_shop;

-- ������� ������� ������������
drop table if exists users;
create table users (
  id serial primary key,
  firstname varchar(50) comment '��� ������������',
  lastname varchar(50) comment '������� ������������',
  birthday date comment '���� ��������',
  email varchar(120) unique comment '����� ����������� �����',
  phone bigint unsigned unique comment '����� �������� ������������',
  hometown varchar(100) comment '����� ���������� ������������',
  password_hash varchar(100) comment '������ ������������',
  created_at datetime default current_timestamp,
  updated_at datetime default current_timestamp on update current_timestamp
  
);

-- ������� ������� �������� �������
drop table if exists catalogs;
create table catalogs (
  id serial primary key,
  group_name varchar(255) unique comment '�������� ������ ������'
);

-- ������� ������� ���������� �����
drop table if exists countries;
create table countries (
  id serial primary key,
  country_name varchar(255) unique comment '�������� ������'
);

-- ������� ������� ������������� ������
drop table if exists manufacturers;
create table manufacturers (
  id serial primary key,
  manufacturer_name varchar (255) unique comment '�������� ������������� ������',
  country_id bigint unsigned comment 'id �������� ������',
  
  foreign key (country_id) references countries(id)
);

-- ������� ������� ����� (����������� ��������� ������)
drop table if exists videos;
create table videos (
  id serial primary key,
  filename varchar (255) comment '��� ����� �����'
);

-- ������� ������� � ���������� ��������� �����
drop table if exists wallpaper_collections;
create table wallpaper_collections (
  id serial primary key,
  wallpaper_collection_name varchar (255) unique comment '�������� ��������� �����',
  video_id bigint unsigned comment '����� ����������� ��������� �����',
  
 foreign key (video_id) references videos(id)
);

-- ������� ������� � ���������� ������� �����
drop table if exists wallpaper_brands;
create table wallpaper_brands (
  id serial primary key,
  wallpaper_brand_name varchar (255) unique comment '�������� ������ �����'
);

-- ������� ������� ����� �����
drop table if exists types_wallpaper;
create table types_wallpaper (
  id serial primary key,
  type_wallpaper varchar (255) unique comment '��� �����'
);

-- ��������
-- ������������
-- ��������� ����
-- ��������� ����
-- ����������� ����
-- ����������
-- ����������� ����
-- ������������� ����
-- ������ ����

-- ������� ������� ����� �����
drop table if exists appearances_wallpaper;
create table appearances_wallpaper (
  id serial primary key,
  appearance_wallpaper varchar (255) unique comment '��� �����'
);

-- ������� ������� ������ �����
drop table if exists styles_wallpaper;
create table styles_wallpaper (
  id serial primary key,
  style_wallpaper varchar (255) unique comment '����� �����'
);

-- ������� ������� ������ �����
drop table if exists colors_wallpaper;
create table colors_wallpaper (
  id serial primary key,
  color_wallpaper varchar (255) unique comment '���� �����'
);

-- ������� ������� �������� �����
drop table if exists disigns_wallpaper;
create table disigns_wallpaper (
  id serial primary key,
  disign_wallpaper varchar (255) unique comment '������ �����'
);

-- ������� ������� ���� ������
drop table if exists photos;
create table photos (
  id serial primary key,
  filename varchar (255) comment '��� ����� ����'
);

-- ������� ������� ������
drop table if exists products;
create table products (
  id serial primary key,
  catalog_id bigint unsigned comment '�������� ������ ������',
  product_article varchar(20) not null unique comment '������� ������',
  price decimal (11,2) comment '���� ������',
  manufacturer_id bigint unsigned comment '�������� ������������� ������',
  wallpaper_brand_id bigint unsigned comment '�������� ������ �����',
  wallpaper_collection_id bigint unsigned comment '�������� ��������� �����',
  type_wallpaper_id bigint unsigned comment '��� �����',
  appearance_wallpaper_id bigint unsigned comment '��� �����',
  style_wallpaper_id bigint unsigned comment '����� �����',
  color_wallpaper_id bigint unsigned comment '����� �����',
  disign_wallpaper_id bigint unsigned comment '������ �����',
  photo_id bigint unsigned comment '���������� �����',
  created_at datetime default current_timestamp,
  updated_at datetime default current_timestamp on update current_timestamp,
  
  
 foreign key (catalog_id) references catalogs(id),
 foreign key (manufacturer_id) references manufacturers(id),
 foreign key (wallpaper_brand_id) references wallpaper_brands(id),
 foreign key (wallpaper_collection_id) references wallpaper_collections(id),
 foreign key (type_wallpaper_id) references types_wallpaper(id),
 foreign key (appearance_wallpaper_id) references appearances_wallpaper(id),
 foreign key (style_wallpaper_id) references styles_wallpaper(id),
 foreign key (color_wallpaper_id) references colors_wallpaper(id),
 foreign key (disign_wallpaper_id) references disigns_wallpaper(id),
 foreign key (photo_id) references photos(id)
);

-- ������� ������� ������, �������� ������������ ����� �������� ������������� �����
drop table if exists likes;
create table likes (
  id serial primary key,
  user_id bigint unsigned comment 'id ������������',
  product_id bigint unsigned comment 'id ������',
  created_at datetime default current_timestamp,
  
  foreign key (user_id) references users(id),
  foreign key (product_id) references products(id)
  );
 
--  ������� ������� �����, � ������� ����� ����� ���� ������� ������
drop table if exists storehause;
create table storehause (
  id serial primary key,
  product_id bigint unsigned comment 'id ������',
  quantity int unsigned comment '���������� ������',
  price decimal (11,2) comment '���� ������',
  created_at datetime default current_timestamp,
  updated_at datetime default current_timestamp on update current_timestamp,
  
  foreign key (product_id) references products(id)
  );
 
 -- ������� ������� ������
drop table if exists discounts;
create table discounts (
  id serial primary key,
  user_id bigint unsigned comment 'id ������������',
  product_id bigint unsigned comment 'id ������',
  discount float unsigned comment '������',
  started_at datetime comment '������ �������� ������',
  finished_at datetime comment '����� �������� ������',
  created_at datetime default current_timestamp,
  updated_at datetime default current_timestamp on update current_timestamp,
  
  foreign key (user_id) references users(id),
  foreign key (product_id) references products(id)
  );
 
  
 -- ������� ������� �������, � ����� ����� ����������� ����� ������������
drop table if exists basket;
create table basket (
  id serial primary key,
  storehause_id bigint unsigned comment 'id ������ �� ������',
  quantity int unsigned comment '���������� ������',
  price decimal (11,2) comment '���� ������',
  amount decimal (11,2) comment '�����',
  discount_id bigint unsigned comment '������',
  created_at datetime default current_timestamp,
  updated_at datetime default current_timestamp on update current_timestamp,
  
  foreign key (storehause_id) references storehause(id),
  foreign key (discount_id) references discounts(id)
  );
  
 -- ������� ������� �������, ��� ����� ��������� ��� ���� �������.
drop table if exists orders;
create table orders (
  id serial primary key,
  user_id bigint unsigned comment 'id ������������',
  basket_id bigint unsigned comment 'id ������ � ������� ������������',
  created_at datetime default current_timestamp,
  updated_at datetime default current_timestamp on update current_timestamp,
  
  foreign key (user_id) references users(id),
  foreign key (basket_id) references basket(id)
  );
  