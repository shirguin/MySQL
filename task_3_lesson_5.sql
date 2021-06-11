-- � ������� ��������� ������� storehouses_products � ���� value ����� ����������� �����
-- ������ �����: 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������.
-- ���������� ������������� ������ ����� �������, ����� ��� ���������� � �������
-- ���������� �������� value. ������ ������� ������ ������ ���������� � �����, ����� ���� �������.

use shop;

-- ��� ������� �������� ������� tbl � �������� ��

DROP TABLE IF EXISTS tbl;
CREATE TABLE tbl (
  id INT NOT NULL,
  value INT DEFAULT NULL
);
INSERT INTO tbl VALUES (1, 230);
INSERT INTO tbl VALUES (2, 0);
INSERT INTO tbl VALUES (3, 405);
INSERT INTO tbl VALUES (4, 0);
INSERT INTO tbl VALUES (5, 2500);
INSERT INTO tbl VALUES (6, 1);

-- ��������� ���������
select * from tbl;

-- ��������� ������ � �������� ������ ���������
select value from tbl order by case when value = 0 then 1 else 0 end, value;