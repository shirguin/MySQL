-- ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������
-- ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� 20.10.2017 8:10.
-- ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.

use shop;

-- ������ ��� ������ �� varchar, ��� �� ���� ��� � �������
alter table users modify created_at varchar(20);
alter table users modify updated_at varchar(20);

-- ������� ��� ��������� � �������� created_at � updated_at
select * from users;

-- ������� �������������� ������� � ����� DATETIME
alter table users
  add (created_at_dt DATETIME,
       updated_at_dt DATETIME);
      
-- ��������� ���������
select * from users;

-- ��������� ������ � ����� ������� � ������ �������
update users set created_at_dt=STR_TO_DATE(created_at, '%Y-%m-%d %H:%i:%s');
update users set updated_at_dt=STR_TO_DATE(updated_at, '%Y-%m-%d %H:%i:%s');

-- ��������� ���������
select * from users;

-- ������� �������, ��� ���� � ����� ���� � ������� varchar, � ����� ���������������
alter table users
  drop column created_at,
  drop column updated_at,
  rename column created_at_dt to created_at,
  rename column updated_at_dt to updated_at;
  
-- ��������� ���������
select * from users;
