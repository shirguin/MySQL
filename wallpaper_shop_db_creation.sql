-- Создание базы данных интернет магазина, специализирующегося на продаже обоев
drop database if exists wallpaper_shop;
create database wallpaper_shop character set 'utf8mb4';
use wallpaper_shop;

-- Создаем таблицу пользователи
drop table if exists users;
create table users (
  id serial primary key,
  firstname varchar(50) comment 'Имя пользователя',
  lastname varchar(50) comment 'Фамилия пользователя',
  birthday date comment 'Дата рождения',
  email varchar(120) unique comment 'Адрес электронной почты',
  phone bigint unsigned unique comment 'Номер телефона пользователя',
  hometown varchar(100) comment 'Город проживания пользователя',
  password_hash varchar(100) comment 'Пароль пользователя',
  created_at datetime default current_timestamp,
  updated_at datetime default current_timestamp on update current_timestamp
  
);

-- Создаем таблицу каталога товаров
drop table if exists catalogs;
create table catalogs (
  id serial primary key,
  group_name varchar(255) unique comment 'Название группы товара'
);

-- Создаем таблицу справочник стран
drop table if exists countries;
create table countries (
  id serial primary key,
  country_name varchar(255) unique comment 'Название страны'
);

-- Создаем таблицу производители товара
drop table if exists manufacturers;
create table manufacturers (
  id serial primary key,
  manufacturer_name varchar (255) unique comment 'Название производителя товара',
  country_id bigint unsigned comment 'id Названия страны',
  
  foreign key (country_id) references countries(id)
);

-- Создаем таблицу видео (презентации коллекций товара)
drop table if exists videos;
create table videos (
  id serial primary key,
  filename varchar (255) comment 'Имя файла видео'
);

-- Создаем таблицу с названиями коллекций обоев
drop table if exists wallpaper_collections;
create table wallpaper_collections (
  id serial primary key,
  wallpaper_collection_name varchar (255) unique comment 'Название коллекции обоев',
  video_id bigint unsigned comment 'Видео презентации коллекции обоев',
  
 foreign key (video_id) references videos(id)
);

-- Создаем таблицу с названиями брендов обоев
drop table if exists wallpaper_brands;
create table wallpaper_brands (
  id serial primary key,
  wallpaper_brand_name varchar (255) unique comment 'Название бренда обоев'
);

-- Создаем таблицу типов обоев
drop table if exists types_wallpaper;
create table types_wallpaper (
  id serial primary key,
  type_wallpaper varchar (255) unique comment 'Тип обоев'
);

-- бумажные
-- флезилиновые
-- виниловые обои
-- акриловые обои
-- натуральные обои
-- стеклообои
-- текстильные обои
-- металлические обои
-- жидкие обои

-- Создаем таблицу видов обоев
drop table if exists appearances_wallpaper;
create table appearances_wallpaper (
  id serial primary key,
  appearance_wallpaper varchar (255) unique comment 'Вид обоев'
);

-- Создаем таблицу стилей обоев
drop table if exists styles_wallpaper;
create table styles_wallpaper (
  id serial primary key,
  style_wallpaper varchar (255) unique comment 'Стиль обоев'
);

-- Создаем таблицу цветов обоев
drop table if exists colors_wallpaper;
create table colors_wallpaper (
  id serial primary key,
  color_wallpaper varchar (255) unique comment 'Цвет обоев'
);

-- Создаем таблицу дизайнов обоев
drop table if exists disigns_wallpaper;
create table disigns_wallpaper (
  id serial primary key,
  disign_wallpaper varchar (255) unique comment 'Дизайн обоев'
);

-- Создаем таблицу фото товара
drop table if exists photos;
create table photos (
  id serial primary key,
  filename varchar (255) comment 'Имя файла фото'
);

-- Создаем таблицу товара
drop table if exists products;
create table products (
  id serial primary key,
  catalog_id bigint unsigned comment 'Название группы товара',
  product_article varchar(20) not null unique comment 'артикул товара',
  price decimal (11,2) comment 'Цена товара',
  manufacturer_id bigint unsigned comment 'Название производителя товара',
  wallpaper_brand_id bigint unsigned comment 'Название бренда обоев',
  wallpaper_collection_id bigint unsigned comment 'Название коллекции обоев',
  type_wallpaper_id bigint unsigned comment 'Тип обоев',
  appearance_wallpaper_id bigint unsigned comment 'Вид обоев',
  style_wallpaper_id bigint unsigned comment 'Стиль обоев',
  color_wallpaper_id bigint unsigned comment 'Цвета обоев',
  disign_wallpaper_id bigint unsigned comment 'Дизайн обоев',
  photo_id bigint unsigned comment 'фотография обоев',
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

-- Создаем таблицу лайков, которыми пользователь будет помечать понравившийся товар
drop table if exists likes;
create table likes (
  id serial primary key,
  user_id bigint unsigned comment 'id Пользователя',
  product_id bigint unsigned comment 'id товара',
  created_at datetime default current_timestamp,
  
  foreign key (user_id) references users(id),
  foreign key (product_id) references products(id)
  );
 
--  Создаем таблицу склад, в которой будем вести учет наличия товара
drop table if exists storehause;
create table storehause (
  id serial primary key,
  product_id bigint unsigned comment 'id товара',
  quantity int unsigned comment 'Количество товара',
  price decimal (11,2) comment 'Цена товара',
  created_at datetime default current_timestamp,
  updated_at datetime default current_timestamp on update current_timestamp,
  
  foreign key (product_id) references products(id)
  );
 
 -- Создаем таблицу скидки
drop table if exists discounts;
create table discounts (
  id serial primary key,
  user_id bigint unsigned comment 'id Пользователя',
  product_id bigint unsigned comment 'id товара',
  discount float unsigned comment 'Скидка',
  started_at datetime comment 'Начало действия скидки',
  finished_at datetime comment 'Конец действия скидки',
  created_at datetime default current_timestamp,
  updated_at datetime default current_timestamp on update current_timestamp,
  
  foreign key (user_id) references users(id),
  foreign key (product_id) references products(id)
  );
 
  
 -- Создаем таблицу корзина, в корой будем формировать заказ пользователя
drop table if exists basket;
create table basket (
  id serial primary key,
  storehause_id bigint unsigned comment 'id товара на складе',
  quantity int unsigned comment 'Количество товара',
  price decimal (11,2) comment 'Цена товара',
  amount decimal (11,2) comment 'Сумма',
  discount_id bigint unsigned comment 'скидка',
  created_at datetime default current_timestamp,
  updated_at datetime default current_timestamp on update current_timestamp,
  
  foreign key (storehause_id) references storehause(id),
  foreign key (discount_id) references discounts(id)
  );
  
 -- Создаем таблицу продажи, где будут храниться все наши продажи.
drop table if exists orders;
create table orders (
  id serial primary key,
  user_id bigint unsigned comment 'id Пользователя',
  basket_id bigint unsigned comment 'id заказа в корзине пользователя',
  created_at datetime default current_timestamp,
  updated_at datetime default current_timestamp on update current_timestamp,
  
  foreign key (user_id) references users(id),
  foreign key (basket_id) references basket(id)
  );
  