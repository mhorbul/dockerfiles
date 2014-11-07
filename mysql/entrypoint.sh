#!/bin/bash
set -e

TEMP_FILE='/tmp/mysql-first-time.sql'

if [ -z "$(ls -A /var/lib/mysql)" -a "${1%_safe}" = 'mysqld' ]; then
  /usr/bin/mysql_install_db --user=mysql --datadir=/var/lib/mysql
  if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
    echo >&2 'error: database is uninitialized and MYSQL_ROOT_PASSWORD not set'
    echo >&2 '  Did you forget to add -e MYSQL_ROOT_PASSWORD=... ?'
    exit 1
  fi

  cat > "$TEMP_FILE" <<EOSQL
    DELETE FROM mysql.user ;
    CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
    GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
    DROP DATABASE IF EXISTS test ;
EOSQL
fi

if [ "${1%_safe}" == 'mysqld' ]; then

    if [ "$MYSQL_DATABASE" ]; then
        echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE ;" >> "$TEMP_FILE"
    fi

    if [ "$MYSQL_USER" -a "$MYSQL_PASSWORD" ]; then
        echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> "$TEMP_FILE"

        if [ "$MYSQL_DATABASE" ]; then
            echo "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' ;" >> "$TEMP_FILE"
        fi
    fi

    echo 'FLUSH PRIVILEGES ;' >> "$TEMP_FILE"

    set -- "$@" --init-file="$TEMP_FILE"
fi

chown -R mysql:mysql /var/lib/mysql
exec "$@"
