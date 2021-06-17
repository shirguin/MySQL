-- ������� �1
-- ���������������� �������, ������� ����������� �� �������, ���������� ���������
-- ������������� �/��� ��������� (JOIN ���� �� ���������).

use vk;

-- ������� ��� ���������� �� ������� users ������ ��� ������ ������������
select * from users limit 1;

-- ������� ���������� ��� ������������ � �������� id=504
select * from  users where  id = 504; 

-- ������� ������ ��� � ������� ��� ������������ � id=501
select firstname, lastname from  users where  id = 501;

-- ������ ������������ �������� ��� ��������� ��������
select 
	firstname ,
	lastname ,
	'city' ,
	'main_photo'
from 
	users
where 
	id = 504;

-- ������� ���, �������, �����, �������� ����� ���� ������������ � id=505
select 
	firstname, 
	lastname, 
	(select hometown from profiles where  user_id = 505) as city,
	(select filename from media where id = 
	    (select photo_id from profiles where user_id = 505)
	) as main_photo
from users 
where id = 505;

-- ������ ������ � ������� media_types
update media_types set name = 'photo' where id = 1;
update media_types set name = 'video' where id = 2;
update media_types set name = 'audio' where id = 3;

-- ������� ������������ �������� LIKE
select * from media_types where name like 'phoTo';
select * from media_types where name like 'p%';
select * from media_types where name like '_____';

-- ������� ��� �������� ������ � ���� ������������ � id=501
select filename from media 
  where user_id = 501
    and media_type_id = (
      select id from media_types where name like 'photo'
    ); 

-- ������� ��� �������� ������ � ���� ������������ � �������� email = 'felix.fadel@example.org'
select filename from media 
where user_id = (select id from users where email = 'felix.fadel@example.org')
    and media_type_id = (
      select id from media_types where name like 'photo' 
     ); 

-- ������� ��� ����� ����� ������������ � id=501
select * 
from  media 
where  user_id = 501;

-- ������� �������� ���� ����������� ������������ � id=504
select filename from media 
	where user_id = 504
  and media_type_id = (
    select id from media_types where name like 'video' limit 1
);

-- ������� ���������� ���� ������������ � Id=501 
select COUNT(*) from media 
	where user_id = 501
  and media_type_id = (
    select id from media_types where name like 'photo'
);

-- ������� ���������� ����������� ����������� � ������ �� ������� ����(��� ����� ����������� ����)
-- � ��������� �� �������� � ��������
select COUNT(id) as media, MONTHNAME(created_at) as month_name 
from media
group by month_name
order by media desc; 

-- ������� ���������� ������ ��� ������� ������������
select COUNT(id) as news_count, user_id
  from media
  group by user_id;

-- ������� ��� ������� �� ������ ������������ � id=501
select * from friend_requests 
where 
	initiator_user_id = 501
	or target_user_id = 501
;

-- ������� ������ ���������� ������� �� ������ ������������ � id=504
select * from friend_requests 
where (initiator_user_id = 504 or target_user_id = 504)
	and status = 'approved'
;

-- ������� ��� ���������� �������������, ��������� � �������� ������
select * from media where user_id in (501, 504, 506, 512, 516, 518);

-- ���������� �������� union ��� ����������� ������ ��������
select * from media where user_id in (
  select initiator_user_id from friend_requests where (target_user_id = 504) and status='approved'
  union
  select target_user_id from friend_requests where (initiator_user_id = 504) and status='approved' 
);

-- ��������� ���������� ������ �� ������� ������������ � id=504
select media_id, COUNT(*)
from likes 
where media_id in (select id from media where user_id = 504)
group by media_id;

-- ������� ��� ��������� (���������� � ������������)������������ � id=506
select * from messages
  where from_user_id = 506 or to_user_id = 506
  order by created_at desc;

-- ������� ��� � ������� ���� ������ ������������ � id=504
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

-- ������ �������� ����������
set @user_id = 520;
set @community_id = 5;

