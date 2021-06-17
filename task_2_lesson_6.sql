-- Задание №2
-- Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем

use vk;

-- меняем данные в таблице messeges для наглядности
update messages 
set from_user_id = 506
where id > 19 and id < 31;

update messages 
set to_user_id = 504
where id > 19 and id < 31;

-- Понял задание так - нужно найти человека, который больше всех написал сообщений заданному пользователю (например id=504)
-- status из таблицы friend_requests не стал задействовать
-- Выводим id и количество сообщений активного друга
select count(*) messages, friend
from (select body,from_user_id as friend from messages where to_user_id = 504) as history
group by friend
order by messages desc
limit 1;

