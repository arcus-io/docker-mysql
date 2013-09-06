# MySQL

MySQL 5.5

* `docker build -t mysql .`
* `docker run mysql .`

Ports

* 3306 (mysql)

Environment Variables

* `ADMIN_PASS`: root account password (default: mysql)
* `MYSQL_CFG_URL`: custom MySQL config (my.cnf) that will be downloaded from url
* `DATA_DIR`: MySQL data dir (default: /var/lib/mysql)
* `MYSQL_OPTS`: Additional options passed to `mysqld`
