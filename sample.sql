mysqldump -u root -p example > bsample.sql;
create database sample;
mysql -u root -p sample < bsample.sql;
/*Не смог понять что за ошибка в синтаксе. DBeaver ругается и скрипт не работает.
 Может быть mysqldump работает только в консоле? В консоле все получилось */

