mysqldump -u root -p example > bsample.sql;
create database sample;
mysql -u root -p sample < bsample.sql;
/*�� ���� ������ ��� �� ������ � ��������. DBeaver �������� � ������ �� ��������.
 ����� ���� mysqldump �������� ������ � �������? � ������� ��� ���������� */

