-- «адание є3
-- ѕодсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

use vk;

-- Ќаходим id 10 самых молодых пользователей
SELECT user_id 
FROM profiles 
ORDER by birthday DESC LIMIT 10;


-- ¬ыводим id всего контента 10 самых молодых пользователей
select id 
from media
where user_id in (SELECT user_id FROM (SELECT user_id from profiles ORDER by birthday DESC LIMIT 10) as user_id);


-- считаем лайки на весь контент 10 самых молодых пользователей
select count(*) as total_likes
from likes
where media_id in (select media_id from (select user_id from (select user_id from profiles order by birthday desc limit 10) as user_id) as media_id);

-- ѕолучилось слишком громозко, но вроде все работает