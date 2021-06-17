-- Задание №1
-- Проанализировать запросы, которые выполнялись на занятии, определить возможные
-- корректировки и/или улучшения (JOIN пока не применять).

use vk;

-- Выводим всю информацию из таблицы users только для одного пользователя
select * from users limit 1;

-- Выводим информацию для пользователя у которого id=504
select * from  users where  id = 504; 

-- Выводим только имя и фамилию для пользователя с id=501
select firstname, lastname from  users where  id = 501;

-- Учимся использовать заглушки при написании запросов
select 
	firstname ,
	lastname ,
	'city' ,
	'main_photo'
from 
	users
where 
	id = 504;

-- Выводим имя, фамилию, город, название файла фото пользователя с id=505
select 
	firstname, 
	lastname, 
	(select hometown from profiles where  user_id = 505) as city,
	(select filename from media where id = 
	    (select photo_id from profiles where user_id = 505)
	) as main_photo
from users 
where id = 505;

-- Меняем данные в таблице media_types
update media_types set name = 'photo' where id = 1;
update media_types set name = 'video' where id = 2;
update media_types set name = 'audio' where id = 3;

-- Пробуем использовать оператор LIKE
select * from media_types where name like 'phoTo';
select * from media_types where name like 'p%';
select * from media_types where name like '_____';

-- Выводим все названия файлов с фото пользователя с id=501
select filename from media 
  where user_id = 501
    and media_type_id = (
      select id from media_types where name like 'photo'
    ); 

-- Выводим все названия файлов с фото пользователя у которого email = 'felix.fadel@example.org'
select filename from media 
where user_id = (select id from users where email = 'felix.fadel@example.org')
    and media_type_id = (
      select id from media_types where name like 'photo' 
     ); 

-- Выводим все медиа файлы пользователя с id=501
select * 
from  media 
where  user_id = 501;

-- Выводим название всех видеофайлов пользователя с id=504
select filename from media 
	where user_id = 504
  and media_type_id = (
    select id from media_types where name like 'video' limit 1
);

-- Считаем количество фото пользователя с Id=501 
select COUNT(*) from media 
	where user_id = 501
  and media_type_id = (
    select id from media_types where name like 'photo'
);

-- Считаем количество медиафайлов размещенное в каждый из месяцев года(без учета конкретного года)
-- и сортируем от большего к меньшему
select COUNT(id) as media, MONTHNAME(created_at) as month_name 
from media
group by month_name
order by media desc; 

-- Считаем количество файлов для каждого пользователя
select COUNT(id) as news_count, user_id
  from media
  group by user_id;

-- Выводим все запросы на дружбу пользователя с id=501
select * from friend_requests 
where 
	initiator_user_id = 501
	or target_user_id = 501
;

-- Выводим только одобренные запросы на дружбу пользователя с id=504
select * from friend_requests 
where (initiator_user_id = 504 or target_user_id = 504)
	and status = 'approved'
;

-- выводим все медиафайлы пользователей, состоящих в заданном списке
select * from media where user_id in (501, 504, 506, 512, 516, 518);

-- Используем оператор union для объединения набора запросов
select * from media where user_id in (
  select initiator_user_id from friend_requests where (target_user_id = 504) and status='approved'
  union
  select target_user_id from friend_requests where (initiator_user_id = 504) and status='approved' 
);

-- Посчитаем количество лайков на контент пользователя с id=504
select media_id, COUNT(*)
from likes 
where media_id in (select id from media where user_id = 504)
group by media_id;

-- Выведем все сообщения (полученные и отправленные)пользователя с id=506
select * from messages
  where from_user_id = 506 or to_user_id = 506
  order by created_at desc;

-- Выводим пол и возраст всех друзей пользователя с id=504
select user_id,
    case (gender)
         when 'm' then 'male'
         when 'f' then 'female'
    end as gender, 
    TIMESTAMPDIFF(YEAR, birthday, NOW()) as age
from profiles
where user_id in (
	  select initiator_user_id from friend_requests where (target_user_id = 504) and status='approved'
	  union
	  select target_user_id from friend_requests where (initiator_user_id = 504) and status='approved'
  );

-- Задаем значение переменным
set @user_id = 520;
set @community_id = 5;

