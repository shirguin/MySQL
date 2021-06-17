-- ������� �3
-- ���������� ����� ���������� ������, ������� �������� 10 ����� ������� �������������.

use vk;

-- ������� id 10 ����� ������� �������������
SELECT user_id 
FROM profiles 
ORDER by birthday DESC LIMIT 10;


-- ������� id ����� �������� 10 ����� ������� �������������
select id 
from media
where user_id in (SELECT user_id FROM (SELECT user_id from profiles ORDER by birthday DESC LIMIT 10) as user_id);


-- ������� ����� �� ���� ������� 10 ����� ������� �������������
select count(*) as total_likes
from likes
where media_id in (select media_id from (select user_id from (select user_id from profiles order by birthday desc limit 10) as user_id) as media_id);

-- ���������� ������� ��������, �� ����� ��� ��������