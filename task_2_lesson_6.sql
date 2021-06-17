-- ������� �2
-- ����� ����� ��������� ������������. 
-- �� ���� ������ ����� ������������ ������� ��������, ������� ������ ���� ������� � ����� �������������

use vk;

-- ������ ������ � ������� messeges ��� �����������
update messages 
set from_user_id = 506
where id > 19 and id < 31;

update messages 
set to_user_id = 504
where id > 19 and id < 31;

-- ����� ������� ��� - ����� ����� ��������, ������� ������ ���� ������� ��������� ��������� ������������ (�������� id=504)
-- status �� ������� friend_requests �� ���� �������������
-- ������� id � ���������� ��������� ��������� �����
select count(*) messages, friend
from (select body,from_user_id as friend from messages where to_user_id = 504) as history
group by friend
order by messages desc
limit 1;

