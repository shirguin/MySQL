-- ������� �5
-- ����� 10 �������������, ������� ��������� ���������� ���������� � ������������� ���������� ����.

use vk;

SELECT id, SUM(activite) as total_activite FROM (
	SELECT * FROM (
		(SELECT id,0 as activite FROM users WHERE id NOT IN (SELECT user_id FROM media GROUP by user_id))
		UNION
		(SELECT user_id as id, COUNT(*) as activite FROM media as m GROUP by user_id)
	) as tmp_media
	UNION ALL
	SELECT * FROM (
		(SELECT id,0 as activite FROM users WHERE id NOT IN (SELECT from_user_id FROM messages GROUP by from_user_id))
		UNION
		(SELECT from_user_id as id, COUNT(*) as activite FROM messages GROUP by from_user_id)
	) as tmp_messages
	UNION ALL
	SELECT * FROM (
		(SELECT id,0 as activite FROM users WHERE id NOT IN (SELECT user_id FROM posts GROUP by user_id))
		UNION
		(SELECT user_id as id, COUNT(*) as activite FROM posts GROUP by user_id)	
	) as tmp_posts
	UNION ALL
	SELECT * FROM (
		(SELECT id,0 as activite FROM users WHERE id NOT IN (SELECT user_id FROM likes GROUP by user_id))
		UNION
		(SELECT user_id as id, COUNT(*) as activite FROM likes GROUP by user_id)
	) as tmp_likes	
) as tmp_table
GROUP by id
ORDER by total_activite;
LIMIT 10
;

-- ������� ���������� ����������� ��� ������� ������������
(select id,0 as counter from users where id not in (select user_id from media))
union
(select user_id as id, COUNT(*) as counter from  media group  by user_id)
;

-- ������� ���������� ���������� ��������� ������ �������������
(select id,0 as counter from users where id not in (select from_user_id from messages))
union
(select from_user_id as id, COUNT(*) as counter from messages group by from_user_id)
;

-- ������� ���������� ������ ��� ������� ������������
(select id,0 as counter from users where id not in (select user_id from likes))
union
(select user_id as id, COUNT(*) as counter from likes group by user_id)
;

-- ��������� ��� ������. ��� ����������� ����� ������������ union all, ��� �� �� �������� ����� ������
select id, SUM(counter) as activity from (
	select * from  (
		(select id,0 as counter from users where id not in (select user_id from media))
		union
		(select user_id as id, COUNT(*) as counter from  media group  by user_id)
	) as media
	union all
	select * from (
		(select id,0 as counter from users where id not in (select from_user_id from messages))
		union
		(select from_user_id as id, COUNT(*) as counter from messages group by from_user_id)	
	) as messenges
	union all
	select * from (
		(select id,0 as counter from users where id not in (select user_id from likes))
		union
		(select user_id as id, COUNT(*) as counter from likes group by user_id)	
	) as likes
	) as result_table
group by id
order by activity
LIMIT 10;

-- ������� ������ ����� ������������� �������������, ����� �������� �� ����� ���� �������� ������
-- � ��������� � ������������� VK
select firstname, lastname, email
from users
where id in (select id from (
	select id, SUM(counter) as activity from (
		select * from  (
			(select id,0 as counter from users where id not in (select user_id from media))
			union
			(select user_id as id, COUNT(*) as counter from  media group  by user_id)
		) as media
		union all
		select * from (
			(select id,0 as counter from users where id not in (select from_user_id from messages))
			union
			(select from_user_id as id, COUNT(*) as counter from messages group by from_user_id)	
		) as messenges
		union all
		select * from (
			(select id,0 as counter from users where id not in (select user_id from likes))
			union
			(select user_id as id, COUNT(*) as counter from likes group by user_id)	
		) as likes
		) as result_table
	group by id
	order by activity
	limit 10
		) as final_table
	);
-- ���������� ����� ��������, �� ��� ��������	

