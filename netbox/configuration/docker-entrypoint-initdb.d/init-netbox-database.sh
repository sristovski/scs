#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE USER netbox WITH PASSWORD 'password';
  CREATE DATABASE netbox;
  GRANT ALL PRIVILEGES ON DATABASE netbox TO netbox;
  ALTER DATABASE netbox OWNER TO netbox;
EOSQL

if [[ -e /docker-entrypoint-initdb.d/init.sql.osism ]]; then
    cat /docker-entrypoint-initdb.d/init.sql.osism | psql -v ON_ERROR_STOP=1 --username netbox --dbname netbox
fi
