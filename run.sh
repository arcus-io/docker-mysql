#!/bin/bash
ADMIN_PASS=${ADMIN_PASS:-mysql}
MYSQL_CFG_URL=${MYSQL_CFG_URL:-}
DATA_DIR=${DATA_DIR:-/var/lib/mysql}
MYSQL_OPTS=${MYSQL_OPTS:-}

if [ ! -z "$MYSQL_CFG_URL" ] ; then
    wget $MYSQL_CFG_URL -O /etc/mysql/my.cnf
fi

sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/my.cnf

if [ ! -e "$DATA_DIR/mysql" ] ; then
    mysql_install_db --datadir=$DATA_DIR
fi

# create user
mysqld --datadir=$DATA_DIR --verbose &
sleep 3
echo "* Setting privileges..."
echo "grant all privileges on *.* to root@'%' identified by \"$ADMIN_PASS\" with grant option;" | mysql -u root
echo "* Setting password..."
mysqladmin -u root password "$ADMIN_PASS"

killall mysqld
sleep 2

mysqld --datadir=$DATA_DIR --verbose $OPTS
