-- 4.(�� �������) �� ������� users ���������� ������� �������������, ���������� � �������
-- � ���. ������ ������ � ���� ������ ���������� �������� (may, august)

use shop;

-- ��������� �� ���� ������ �������������
select * from users;

-- ������� ������ ������������� �������� ��������� �������
-- ������� 1
select name, birthday_at from users where DATE_FORMAT(birthday_at, '%M') = 'may' or DATE_FORMAT(birthday_at, '%M') = 'august';

-- ������� 2
select name, birthday_at from users where DATE_FORMAT(birthday_at, '%M') in ('may', 'august');

