drop database if exists example;
create database if not exists example character set 'utf8mb4';
use example;
/*�������� �������*/
create table users (
  id SERIAL primary KEY,
  name VARCHAR(50) COMMENT '��� ������������'
);
/*���������� �������*/
insert into users values
  (default, '�������'),
  (default, '����'),
  (default, '����'),
  (default, '������');
/*�������� ������ �� ������� �� �������*/
delete from users where  id > 2 limit 1;
/*���������� ������ � �������*/
insert into users values (default, '������');
/*����� ���� ������ �� �������*/
select * from example.users;
