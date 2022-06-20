#!/bin/bash

export PGUSER=postgres
export PGPASSWORD=pgpass
export PGHOST=postgres

while [ $(pg_isready -q; echo $?) != 0 ]; do
  echo "Waiting for primary..."
  sleep 1
done

pg_ctl -D "$PGDATA" -m fast -w stop
rm -fr $PGDATA/*
pg_basebackup -R -D $PGDATA -v -P -X stream -w --checkpoint=fast
pg_ctl -D "$PGDATA" -w start
