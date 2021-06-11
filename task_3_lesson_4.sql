-- ��������� ��� �������� CRUD.
-- �������� ���� � ������, � ����� ���������� ������ ������� ����� � 1 � 2 ������� 

-- �������� ��������� ��������
use vk;
-- ������� ���� ������������� ������
select users.firstname, users.lastname from users where id in (select user_id from profiles where gender = 'm');

-- ������� ���� ������������� � ������� ����� ...@example.org
select * from users where email like '%@example.org';

-- ������� ���, ������� � ����� ��.����� �������������, ���������� � 2003 ����
select users.firstname, users.lastname, users.email from users where id in (select user_id from profiles where birthday between '2003-01-01' and '2003-12-31');

-- ��������, ���� ��� ��� ������������ � id ������ 1000
select * from users where id = 1000;

-- ������ � ������� ������ ������������ � id=1000
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('1000', '�����', '�������', 'mariy@yandex.ru', '28��9dc1b248a��b66388cfc3bc2c6f968f28b0d', '7777777777');

-- ������� ������ �� ������������ � id=1000
select * from users where id = 1000;

-- ������� ������� ������������ � id=1000
update users set users.lastname = '�������' where id = 1000;

-- ��������� ���������
select * from users where id = 1000;

-- ������� ������������ � id = 1000
delete from users where id = 1000;

-- ��������� ���������
select * from users where id = 1000;

