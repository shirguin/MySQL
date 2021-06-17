-- ������� �4
-- ���������� ��� ������ �������� ������ (�����) - ������� ��� �������?

use vk;

-- ������� �������� ����� ������������� � ������� users
select count(*) as users
from users;

-- ������� ������� ����� ������������� � ������� profiles
select count(*) as users
from profiles;

-- ������� �������� ������ � ������
select count(*) as female from profiles where gender = 'f';
select count(*) as female from profiles where gender = 'm';
-- ����� �������� � ����� ����������� ������������� � ������� profiles

-- ������� ������� ����� � ��� ������
select count(*) as total_likes
from likes;

-- ������� ����� - �������� ������ � ������
select 'f' as gender, count(*) as total_likes
from likes
where user_id in (select user_id from profiles where gender = 'f')
union 
select 'm' as gender, count(*) as total_likes
from likes
where user_id in (select user_id from profiles where gender = 'm')
order by total_likes desc;
-- limit 1;

-- ����� ������ ������ � ������ �� �������� � ����� ������ ������
-- ����� ���� � ���, ��� ���������� ������������� � ������� users � profiles ������
