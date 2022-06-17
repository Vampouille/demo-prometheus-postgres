#!/bin/bash

while [ $(pg_isready -q; echo $?) != 0 ]; do
  echo "Waiting for cluster to start..."
  sleep 1
done

pgbench -i --foreign-keys -s 10

while [ true ]; do
  pgbench -T 2 -c 10
  sleep 3
  psql -c 'INSERT INTO data (data) SELECT g.id FROM generate_series(1, 50000) AS g (id)' organisme
  psql -c 'BEGIN; INSERT INTO data (data) SELECT g.id FROM generate_series(1, 50000) AS g (id); SELECT pg_sleep(10); COMMIT;' organisme
done
