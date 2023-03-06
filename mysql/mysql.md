# MySQL Commands

## Connect as root

```sh
mysql -u root -p
```

## Create new database and user

```sql
CREATE USER 'my_user'@'%' IDENTIFIED BY 'my_secret_password';

CREATE DATABASE my_database;
GRANT ALL PRIVILEGES ON my_database.* TO 'my_user'@'%';
FLUSH PRIVILEGES;
EXIT;
```

## Backup and restore

```sh
mysqldump --databases DATABASE > dump.sql

mysql -u user -p DATABASE < dump.sql
```
