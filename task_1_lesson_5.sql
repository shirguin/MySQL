-- ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.

use shop;

-- ������� ��� ��������� � �������� created_at � updated_at
select * from users;

-- �������� ��� ������� ��� ���� ����� ������� �����
update users set users.created_at = now();
update users set users.updated_at = now();

-- ��������� ���������
select * from users;