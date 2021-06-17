-- Задание №4
-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

use vk;

-- Смотрим сколькко всего пользователей в таблице users
select count(*) as users
from users;

-- Смотрим сколько всего пользователей в таблице profiles
select count(*) as users
from profiles;

-- Считаем отдельно женщин и мужчин
select count(*) as female from profiles where gender = 'f';
select count(*) as female from profiles where gender = 'm';
-- Сумма сходится с общим количеством пользователей в таблице profiles

-- Смотрим сколько всего у нас лайков
select count(*) as total_likes
from likes;

-- Считаем лайки - отдельно женщин и мужчин
select 'f' as gender, count(*) as total_likes
from likes
where user_id in (select user_id from profiles where gender = 'f')
union 
select 'm' as gender, count(*) as total_likes
from likes
where user_id in (select user_id from profiles where gender = 'm')
order by total_likes desc;
-- limit 1;

-- Сумма лайков мужчин и женщин не сходится с общей суммой лайков
-- Думаю дело в том, что количество пользователей в таблице users и profiles разное
